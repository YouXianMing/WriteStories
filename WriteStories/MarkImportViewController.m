//
//  MarkImportViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/6.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "MarkImportViewController.h"
#import "FileManager.h"
#import "FoldersManager.h"
#import "DateFormatter.h"
#import "File+Property.h"
#import "FileCell.h"
#import "UIColor+Project.h"
#import "TapAlphaButton.h"
#import "LoadingView.h"
#import "SSZipArchive.h"
#import "GCD.h"
#import "NSString+RandomString.h"
#import "NSString+Path.h"
#import "BaseFolderItem.h"
#import "Table_Folder_List.h"
#import "Table_Mark_List.h"
#import "WSAlertView.h"
#import "MarkWifiViewController.h"
#import "BaseMarkItem.h"
#import "VersionManager.h"

typedef enum : NSUInteger {
    
    kButton_Import = 10000,
    
} ViewsEvent;

@interface MarkImportViewController () <UITableViewDelegate, UITableViewDataSource, CustomViewControllerDelegate>

@property (nonatomic, strong) UIImageView *noDataImageView;

@property (nonatomic, strong) NSMutableArray <File *> *files;
@property (nonatomic, strong) TitleMenuButton         *setupButton;
@property (nonatomic, strong) UITableView             *tableView;

@property (nonatomic, strong) LoadingView    *loadingView;
@property (nonatomic, strong) TapAlphaButton *importButton;
@property (nonatomic, strong) UILabel        *buttonLabel;

@end

@implementation MarkImportViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self reCreateData];
    
    CGFloat bottomHeight = 55.f;
    if (DeviceInfo.isFringeScreen) {
        
        bottomHeight += DeviceInfo.fringeScreenBottomSafeHeight;
    }
    
    // tableView
    self.tableView                 = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    self.tableView.dataSource      = self;
    self.tableView.delegate        = self;
    self.tableView.rowHeight       = 60.f;
    self.tableView.alpha           = 0.f;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset    = UIEdgeInsetsMake(0, 0, bottomHeight, 0);
    [self.contentView addSubview:self.tableView];
    [FileCell registerToTableView:self.tableView];
    
    // button
    self.importButton                 = [[TapAlphaButton alloc] initWithFrame:CGRectMake(0, self.contentView.height - bottomHeight, Width, bottomHeight)];
    self.importButton.backgroundColor = [UIColor colorWithHexString:@"#309ddc"];
    self.importButton.tag             = kButton_Import;
    [self.importButton addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.importButton];
    
    // buttonTitle
    self.titleLabel                        = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Width, 55.f)];
    self.titleLabel.font                   = [UIFont PingFangSC_Regular_WithFontSize:20.f];
    self.titleLabel.textColor              = [UIColor whiteColor];
    self.titleLabel.textAlignment          = NSTextAlignmentCenter;
    self.titleLabel.userInteractionEnabled = NO;
    [self.importButton addSubview:self.titleLabel];
    
    // noDataImageView
    self.noDataImageView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"noData"]];
    self.noDataImageView.alpha  = 0.f;
    self.noDataImageView.center = CGPointMake(Width / 2.f, (self.contentView.height - bottomHeight) / 2.f);
    [self.contentView addSubview:self.noDataImageView];
    
    [self updateTitleLabel];
    
    if (self.folderItem.articleCount >= 40) {
        
        [GCDQueue executeInMainQueue:^{
            
            [WSAlertView showAlertViewWithMessage:@"注意，每个文件夹中最多只能有40篇文章！"
                                messageBoldRanges:@[[NSValue valueWithRange:NSMakeRange(14, 2)]]
                                      buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"我知道了")]
                                             type:WSAlertViewTypeMessage
                                         delegate:nil
                                       weakObject:nil
                                              tag:0
                                    selectedBlock:nil];
            
        } afterDelaySecs:0.5f];
    }
}

- (void)reCreateData {
    
    [self.files removeAllObjects];
    
    // 获取数据源
    File *file = [FileManager scanRelativeFilePath:@"~/Documents/文章备份" maxTreeLevel:1];
    self.files = [NSMutableArray array];
    
    // 过滤数据
    [file.subFiles enumerateObjectsUsingBlock:^(File * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.isDirectory == NO &&
            obj.fileName.length >= 31 &&
            [obj.filenameExtension isEqualToString:@"article"] &&
            [[obj.fileName substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"["] &&
            [[obj.fileName substringWithRange:NSMakeRange(20, 2)] isEqualToString:@"] "]) {
            
            NSDate *date = [DateFormatter dateFormatterWithInputDateString:[obj.fileName substringWithRange:NSMakeRange(1, 19)]
                                                  inputDateStringFormatter:@"yyyy-MM-dd HH-mm-ss"];
            
            if (date) {
                
                obj.date         = date;
                obj.showName     = [obj.fileName substringWithRange:NSMakeRange(22, obj.fileName.length - 22 - 8)];
                obj.showTime     = [DateFormatter dateStringFromDate:date outputDateStringFormatter:@"yyyy.MM.dd HH:mm"];
                obj.showFileSize = [NSString stringWithFormat:@"%.1fkb", [obj.attributes[NSFileSize] floatValue] / 1024.f];
                obj.status       = FileImportStatusNormal;
                [self.files addObject:obj];
            }
        }
    }];
    
    // 进行排序
    [self.files sortUsingComparator:^NSComparisonResult(File *obj1, File *obj2) {
        
        return [obj1.date compare:obj2.date];
    }];
}

- (void)buttonsEvent:(UIButton *)button {
    
    if (button.tag == TitleMenuButton_Wifi) {
        
        NSLog(@"wifi");
        MarkWifiViewController *controller = [MarkWifiViewController new];
        controller.title                   = @"WIFI文件管理";
        controller.eventDelegate           = self;
        [self.navigationController presentViewController:controller animated:YES completion:nil];
        
    } else if (button.tag == kButton_Import) {
        
        self.loadingView = [LoadingView loadingViewStartLoadingInKeyWindow];
        
        NSMutableArray <BaseMarkItem *> *importItems = [NSMutableArray array];
        
        [GCDQueue executeInGlobalQueue:^{
            
            // 处理数据
            [self.files enumerateObjectsUsingBlock:^(File *file, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (file.selected) {
                    
                    file.selected = NO;
                    
                    if /* 有密码 */ ([SSZipArchive isFilePasswordProtectedAtPath:file.filePath]) {
                        
                        NSError *error = nil;
                        [SSZipArchive isPasswordValidForArchiveAtPath:file.filePath password:@"write.stories.you.xian.ming.article" error:&error];
                        
                        if /* 没有异常 */ (error == nil) {
                            
                            // 获取随机文件夹名字
                            NSString *string     = NSString.UniqueString;
                            NSArray  *strings    = [string componentsSeparatedByString:@"-"];
                            NSString *folderName = [NSString stringWithFormat:@"%@-%@", strings.firstObject, strings.lastObject];
                            
                            // 创建文件夹
                            NSString *folderPath = [FoldersManager.ArticleList addPathComponent:folderName];
                            [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
                            
                            // 解压文件
                            [SSZipArchive unzipFileAtPath:file.filePath
                                            toDestination:folderPath
                                                overwrite:YES
                                                 password:@"write.stories.you.xian.ming.article"
                                                    error:&error];
                            
                            if /* 解压正确 */ (error == nil) {
                                
                                // 获取二进制文件
                                NSData *data = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/content/title/title.data", folderPath]];
                                
                                if /* 文件版本检测成功 */ ([VersionManager checkVersionWithFolder:[NSString stringWithFormat:@"%@/content", folderPath]]) {
                                    
                                    BaseMarkItem *markItem = [BaseMarkItem decodeWithData:data];
                                    
                                    // 如果cellReuseId是不唯一的类型
                                    if (markItem.isEmitterType) {
                                        
                                        markItem.cellReuseId = NSString.UniqueString;
                                        data                 = markItem.encodeData;
                                    }
                                    
                                    // 更新文件状态
                                    file.status = FileImportStatusImportSuccess;
                                    
                                    // 存储数据库
                                    [Table_Mark_List storeData:data
                                                          type:self.folderItem.type
                                                      folderId:self.folderItem.folder_id
                                                         title:markItem.title
                                                      markName:folderName
                                                     sortIndex:[Table_Mark_List maxSortIndexWithFolderId:self.folderItem.folder_id] + 1];
                                    
                                    // 获取带有数据库信息的版本
                                    markItem = [Table_Mark_List itemWithFolderName:folderName];
                                    
                                    // 添加数据
                                    [importItems addObject:markItem];
                                    
                                    // 更新按钮计数
                                    // self.currentFoldersCount += 1;
                                    
                                } /* 文件版本检测失败 */ else {
                                    
                                    file.status = FileImportStatusFileVersionError;
                                    [[NSFileManager defaultManager] removeItemAtPath:folderPath error:nil];
                                }
                                
                            } /* 解压出错 */ else {
                                
                                file.status = FileImportStatusFileError;
                            }
                            
                        } /* 有异常 */ else {
                            
                            file.status = FileImportStatusFileError;
                        }
                        
                    } /* 无密码 */ else {
                        
                        file.status = FileImportStatusFileError;
                    }
                }
            }];
            
            [GCDQueue executeInMainQueue:^{
                
                if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(baseCustomViewController:event:)]) {
                    
                    [self.eventDelegate baseCustomViewController:self event:importItems];
                }
                
                [self.loadingView stopLoading];
                [self.tableView reloadData];
                [self updateTitleLabel];
                
                [WSAlertView showAlertViewWithMessage:@"操作完成！您可以通过左滑删除备份文件。"
                                    messageBoldRanges:@[[NSValue valueWithRange:NSMakeRange(10, 2)]]
                                          buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"我知道了")]
                                                 type:WSAlertViewTypeMessage
                                             delegate:nil
                                           weakObject:nil
                                                  tag:0
                                        selectedBlock:nil];
                
            } afterDelaySecs:1.f];
        }];
    }
}

- (void)updateTitleLabel {
    
    __block NSInteger count = 0;
    [self.files enumerateObjectsUsingBlock:^(File * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.selected) {
            
            count += 1;
        }
    }];
    
    self.titleLabel.text = [NSString stringWithFormat:@"导入 (%ld/%ld)", (long)count, (long)(40 - self.folderItem.articleCount)];
    
    if (count <= 0 || count > 40 - self.folderItem.articleCount) {
        
        self.importButton.enabled = NO;
        
    } else {
        
        self.importButton.enabled = YES;
    }
    
    [UIView animateWithDuration:0.15f animations:^{
        
        self.noDataImageView.alpha = (self.files.count <= 0 ? 1 : 0.f);
        self.tableView.alpha       = (self.files.count <= 0 ? 0 : 1);
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.files.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FileCell"];
    cell.data        = self.files[indexPath.row];
    [cell loadContent];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    File *file = self.files[indexPath.row];
    
    // 只有普通状态才可以点选
    if (file.status == FileImportStatusNormal) {
        
        file.selected = !file.selected;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        [self updateTitleLabel];
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // 删除文件
        File *file = self.files[indexPath.row];
        [[NSFileManager defaultManager] removeItemAtURL:file.fileUrl error:nil];
        
        [self.files removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        [self updateTitleLabel];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"删除";
}

#pragma mark - CustomViewControllerDelegate

- (void)baseCustomViewController:(__kindof CustomViewController *)controller event:(id)event {
    
    if ([controller isKindOfClass:MarkWifiViewController.class]) {
        
        NSLog(@"文件有修改");
        [WSAlertView showAlertViewWithMessage:@"文件有变动，是否重新加载？"
                            messageBoldRanges:nil
                                  buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"取消"),
                                                buttonInfo(WSAlertViewButtonTypeConfirm, @"确定")]
                                         type:WSAlertViewTypeMessage
                                     delegate:nil
                                   weakObject:nil
                                          tag:0
                                selectedBlock:^(WSAlertViewButtonInfo *buttonInfo) {
                                    
                                    if (buttonInfo.type == WSAlertViewButtonTypeConfirm) {
                                        
                                        [self reCreateData];
                                        [self.tableView reloadData];
                                        [self updateTitleLabel];
                                    }
                                }];
    }
}

#pragma mark - Overwrite

- (void)setupSubViews {
    
    [super setupSubViews];
    
    self.setupButton       = [[TitleMenuButton alloc] initWithFrame:CGRectMake(0, 0, 80, 64.f) type:TitleMenuButton_Wifi];
    self.setupButton.right = self.titleContentView.width;
    [self.setupButton addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleContentView addSubview:self.setupButton];
}

@end
