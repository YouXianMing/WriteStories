//
//  FolderListViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/24.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "FolderListViewController.h"
#import "SheetMenuView.h"
#import "SheetMenuObject.h"
#import "PopMenuView.h"
#import "PopMenuObject.h"
#import "UIView+ConvertRect.h"
#import "BaseFolderItemCell.h"
#import "BaseFolderItem.h"
#import "ArticleListViewController.h"
#import "FolderSortViewController.h"
#import "FolderPatternsListViewController.h"
#import "MoveFolderToViewController.h"
#import "FolderEditViewController.h"
#import "FolderImportViewController.h"
#import "Values.h"
#import "Table_Folder_List.h"
#import "Table_Mark_List.h"
#import "FoldersManager.h"
#import "DefaultNotificationCenter.h"
#import "GCD.h"
#import "NSString+Path.h"
#import "DefaultNotificationCenter.h"
#import "WSAlertView.h"
#import "SSZipArchive.h"
#import "DateFormatter.h"
#import "VersionManager.h"

@interface FolderListViewController () <BaseWindowMenuViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, CustomCollectionCellDelegate, CustomViewControllerDelegate, DefaultNotificationCenterDelegate> {
    
    BaseFolderItemCell *_currentEditCell;
}

@property (nonatomic, strong) DefaultNotificationCenter *notificationCenter;

@property (nonatomic, strong) UIImageView     *noDataImageView;
@property (nonatomic, strong) TitleMenuButton *setupButton;
@property (nonatomic, strong) NSLock          *lock;

@property (nonatomic, strong) UICollectionView                   *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout         *layout;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

@property (nonatomic, strong) SheetMenuView *menuView;

@end

@implementation FolderListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.lock = [NSLock new];
    
    self.notificationCenter = [DefaultNotificationCenter defaultNotificationCenterWithDelegate:self addNotificationNames:^(NSMutableArray<NSString *> *names) {
        
        [names addObject:Values.Noti_FolderListViewControllerUpdateCountNumber];
        [names addObject:Values.Noti_FolderListViewControllerUpdateAllFoldersCountNumber];
    }];
    
    self.noDataImageView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"noData"]];
    self.noDataImageView.alpha  = 0.f;
    self.noDataImageView.center = self.contentView.middlePoint;
    [self.contentView addSubview:self.noDataImageView];
    
    CGFloat gap       = 15.f;
    CGFloat itemWidth = (Width - gap * 3) / 2.f;
    
    self.layout = [UICollectionViewFlowLayout new];
    self.layout.minimumLineSpacing      = gap;
    self.layout.minimumInteritemSpacing = gap;
    self.layout.itemSize                = CGSizeMake(itemWidth, 40 + itemWidth);
    
    self.collectionView                 = [[UICollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:self.layout];
    self.collectionView.alpha           = 0.f;
    self.collectionView.delegate        = self;
    self.collectionView.dataSource      = self;
    self.collectionView.contentInset    = UIEdgeInsetsMake(gap, gap, gap, gap);
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.collectionView];
    
    self.adapters = [NSMutableArray array];
    
    [GCDQueue executeInGlobalQueue:^{
        
        // 从数据库获取文件
        NSArray <BaseFolderItem *> *items = [Table_Folder_List folderItemsWithType:self.type.integerValue];
        
        [GCDQueue executeInMainQueue:^{
            
            // 将获取的文件进行注册,并添加
            [items enumerateObjectsUsingBlock:^(BaseFolderItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSLog(@"排序值: %ld", (long)obj.sort_index);
                [obj registerToCollectionView:self.collectionView];
                if (self.canEdit) {
                    
                    [self.adapters addObject:[obj collectionViewAdapterWithCellType:WriteStoriesBaseItemObjectCellType_Normal]];
                    
                } else {
                    
                    [self.adapters addObject:[obj collectionViewAdapterWithCellType:WriteStoriesBaseItemObjectCellType_Disable]];
                }
            }];
            
            [self collectionViewReloadDataAnimated:YES];
        }];
    }];
}

- (void)collectionViewReloadDataAnimated:(BOOL)animated {
    
    [self.collectionView reloadData];
    
    [UIView animateWithDuration:animated ? 0.75f : 0.f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        if (self.adapters.count > 0) {
            
            self.noDataImageView.alpha = 0.f;
            self.collectionView.alpha  = 1.f;
            
        } else {
            
            self.noDataImageView.alpha = 1.f;
            self.collectionView.alpha  = 0.f;
        }
        
    } completion:nil];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.adapters.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter *adapter = self.adapters[indexPath.row];
    BaseFolderItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:adapter.cellReuseIdentifier forIndexPath:indexPath];
    cell.indexPath           = indexPath;
    cell.dataAdapter         = adapter;
    cell.data                = adapter.data;
    cell.delegate            = self;
    [cell loadContent];
    
    NSLog(@"%@", adapter.cellReuseIdentifier);
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseFolderItem *item = self.adapters[indexPath.row].data;
    
    ArticleListViewController *controller = [ArticleListViewController new];
    controller.title                      = item.title;
    controller.folderItem                 = item;
    controller.canEdit                    = self.canEdit;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - BaseCustomCollectionCellDelegate

- (void)customCollectionCell:(BaseCustomCollectionCell *)cell event:(id)event {
    
    if ([self.lock tryLock]) {
        
        self.menuView = [SheetMenuView menuViewWithDelegate:self datas:@[[SheetMenuObject sheetMenuObjectWithIndex:0 title:@"移动到..."],
                                                                         [SheetMenuObject sheetMenuObjectWithIndex:1 title:@"删除"],
                                                                         [SheetMenuObject sheetMenuObjectWithIndex:2 title:@"编辑"],
                                                                         [SheetMenuObject sheetMenuObjectWithIndex:3 title:@"更换模板"],
                                                                         [SheetMenuObject sheetMenuObjectWithIndex:4 title:@"备份"]]];
        self.menuView.weakObject = cell;
        [self.menuView show];
    }
}

#pragma mark - Buttons event.

- (void)buttonsEvent:(UIButton *)button {
    
    if ([self.lock tryLock]) {
        
        NSMutableArray *datas = [NSMutableArray array];
        [datas addObject:[PopMenuObject popMenuObjectWithIcon:PopMenuButtonIconTypeAdd
                                                         type:PopMenuButtonTitleTypeCyanBold
                                                        index:0
                                                        title:@"创建文件夹"]];
        
        [datas addObject:[PopMenuObject popMenuObjectWithIcon:PopMenuButtonIconTypeSort
                                                         type:PopMenuButtonTitleTypeNormal
                                                        index:1
                                                        title:@"文件夹排序"]];
        
        [datas addObject:[PopMenuObject popMenuObjectWithIcon:PopMenuButtonIconTypeLoadFile
                                                         type:PopMenuButtonTitleTypeNormal
                                                        index:1
                                                        title:@"导入备份"]];
        
        // 文件夹少于2个时,不显示文件夹排序
        if (self.adapters.count <= 1) {
            
            __block PopMenuObject *sortObject = nil;
            [datas enumerateObjectsUsingBlock:^(PopMenuObject *object, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (object.iconType == PopMenuButtonIconTypeSort) {
                    
                    sortObject = object;
                    *stop      = YES;
                }
            }];
            
            [datas removeObject:sortObject];
        }
        
        // 文件夹多于50个时，则不允许添加
        if (self.adapters.count >= 50) {
            
            __block PopMenuObject *sortObject = nil;
            [datas enumerateObjectsUsingBlock:^(PopMenuObject *object, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (object.iconType == PopMenuButtonIconTypeAdd) {
                    
                    sortObject = object;
                    *stop      = YES;
                }
            }];
            
            [datas removeObject:sortObject];
        }
        
        PopMenuView *menuView = [PopMenuView menuViewWithDelegate:self datas:datas];
        
        CGPoint point = [self.setupButton frameOriginFromView:[UIApplication sharedApplication].keyWindow];
        [menuView showAtPoint:CGPointMake(point.x + 71.f, point.y + 40.f)];
    }
}

#pragma mark - BaseWindowMenuViewDelegate

- (void)windowMenuViewWillShow:(BaseWindowMenuView *)windowMenuView {
    
}

- (void)windowMenuViewDidShow:(BaseWindowMenuView *)windowMenuView {
    
}

- (void)windowMenuViewWillHide:(BaseWindowMenuView *)windowMenuView {
    
}

- (void)windowMenuViewDidHide:(BaseWindowMenuView *)windowMenuView {
    
    [self.lock unlock];
}

- (void)windowMenuView:(BaseWindowMenuView *)windowMenuView didSelectedIndex:(NSInteger)index selectedData:(id <MenuViewObject>)data {
    
    if ([windowMenuView isKindOfClass:PopMenuView.class]) {
        
        if /* 文件夹排序 */ ([data.menuViewTitleName isEqualToString:@"文件夹排序"]) {
            
            NSMutableArray *folderItems = [NSMutableArray array];
            [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [folderItems addObject:obj.data];
            }];
            
            FolderSortViewController *controller = [FolderSortViewController new];
            controller.eventDelegate             = self;
            controller.title                     = @"文件夹排序";
            controller.folderItems               = folderItems;
            [self.navigationController pushViewController:controller animated:YES];
            
        } /* 创建文件夹 */ else if ([data.menuViewTitleName isEqualToString:@"创建文件夹"]) {
            
            FolderPatternsListViewController *controller = [FolderPatternsListViewController new];
            controller.controllerType                    = FolderPatternsListViewControllerType_AddNewFolder;
            controller.eventDelegate                     = self;
            controller.title                             = @"文件夹模板";
            controller.type                              = self.type;
            [self.navigationController pushViewController:controller animated:YES];
            
        } /* 导入备份 */ else if ([data.menuViewTitleName isEqualToString:@"导入备份"]) {
            
            FolderImportViewController *controller = [FolderImportViewController new];
            controller.title                       = @"文件夹导入";
            controller.eventDelegate               = self;
            controller.type                        = self.type;
            controller.currentFoldersCount         = self.adapters.count;
            [self.navigationController pushViewController:controller animated:YES];
        }
        
    } else if ([windowMenuView isKindOfClass:SheetMenuView.class]) {
        
        if /* 删除 */ ([data.menuViewTitleName isEqualToString:@"删除"]) {
            
            BaseCustomCollectionCell *cell = windowMenuView.weakObject;
            BaseFolderItem           *item = cell.dataAdapter.data;
            
            if (item.articleCount > 0) {
                
                [WSAlertView showAlertViewWithMessage:[NSString stringWithFormat:@"%@中有%ld篇文章，请处理完之后再进行删除操作！", item.title, (long)item.articleCount]
                                    messageBoldRanges:@[[NSValue valueWithRange:NSMakeRange(0, item.title.length)]]
                                          buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"我知道了")]
                                                 type:WSAlertViewTypeError delegate:nil weakObject:nil tag:0 selectedBlock:nil];
                
            } else {
                
                [WSAlertView showAlertViewWithMessage:[NSString stringWithFormat:@"您确定要删除%@？删除后将不可恢复！", item.title]
                                    messageBoldRanges:@[[NSValue valueWithRange:NSMakeRange(6, item.title.length)]]
                                          buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"取消"),
                                                        buttonInfo(WSAlertViewButtonTypeConfirm, @"确定")]
                                                 type:WSAlertViewTypeAlert delegate:nil weakObject:nil tag:0 selectedBlock:^(WSAlertViewButtonInfo *buttonInfo) {
                                                     
                                                     if (buttonInfo.type == WSAlertViewButtonTypeConfirm) {
                                                         
                                                         [self.collectionView performBatchUpdates:^{
                                                             
                                                             [self.adapters removeObject:cell.dataAdapter];
                                                             [self.collectionView deleteItemsAtIndexPaths:@[cell.indexPath]];
                                                             
                                                         } completion:^(BOOL finished) {
                                                             
                                                             // 重新加载数据
                                                             [self collectionViewReloadDataAnimated:YES];
                                                             
                                                             [GCDQueue executeInGlobalQueue:^{
                                                                 
                                                                 // 删除数据库记录
                                                                 [Table_Folder_List deleteItem:item];
                                                                 
                                                                 // 删除文件
                                                                 NSString *filePath = [FoldersManager.FolderList addPathComponent:item.folder_name];
                                                                 NSError  *error    = nil;
                                                                 [[NSFileManager defaultManager] removeItemAtURL:[NSURL fileURLWithPath:filePath] error:&error];
                                                                 if (error) {
                                                                     
                                                                     NSLog(@"%@", error);
                                                                 }
                                                             }];
                                                         }];
                                                     }
                                                 }];
            }
            
        } /* 更换模板 */ else if ([data.menuViewTitleName isEqualToString:@"更换模板"]) {
            
            BaseCustomCollectionCell *cell = windowMenuView.weakObject;
            BaseFolderItem           *item = cell.dataAdapter.data;
            
            FolderPatternsListViewController *controller = [FolderPatternsListViewController new];
            controller.controllerType                    = FolderPatternsListViewControllerType_ReplaceFolder;
            controller.eventDelegate                     = self;
            controller.folderItem                        = item;
            controller.title                             = @"文件夹模板";
            controller.type                              = self.type;
            [self.navigationController pushViewController:controller animated:YES];
            
        } /* 移动到 */ else if ([data.menuViewTitleName isEqualToString:@"移动到..."]) {
            
            BaseCustomCollectionCell *cell = windowMenuView.weakObject;
            BaseFolderItem           *item = cell.dataAdapter.data;
            
            MoveFolderToViewController *controller = [MoveFolderToViewController new];
            controller.eventDelegate               = self;
            controller.folderItem                  = item;
            controller.title                       = @"移动到";
            controller.type                        = self.type;
            [self.navigationController pushViewController:controller animated:YES];
            
        } /* 编辑 */ else if ([data.menuViewTitleName isEqualToString:@"编辑"]) {
            
            BaseFolderItemCell *cell = windowMenuView.weakObject;
            BaseFolderItem     *item = cell.dataAdapter.data;
            _currentEditCell         = cell;
            
            FolderEditViewController *controller = [FolderEditViewController new];
            controller.eventDelegate             = self;
            controller.folderItem                = item.dbCopyObject; // 复制的数据
            controller.title                     = @"文件夹编辑";
            [self.navigationController pushViewController:controller animated:YES];
            
        } /* 备份 */ else if ([data.menuViewTitleName isEqualToString:@"备份"]) {
            
            BaseCustomCollectionCell *cell = windowMenuView.weakObject;
            BaseFolderItem           *item = cell.dataAdapter.data;
            
            NSString *folderPath = [FoldersManager.FolderList addPathComponent:item.folder_name];
            NSString *time       = [DateFormatter dateStringFromDate:[NSDate date] outputDateStringFormatter:@"yyyy-MM-dd HH-mm-ss"];
            NSString *name       = [NSString stringWithFormat:@"%@/[%@] %@.folder", FoldersManager.FolderBackups, time, item.title];
            
            // 创建版本文件
            [VersionManager storeVersionDataWithFolder:[folderPath addPathComponent:@"content"]];
            
            [SSZipArchive createZipFileAtPath:name
                      withContentsOfDirectory:folderPath
                          keepParentDirectory:NO
                                 withPassword:@"write.stories.you.xian.ming.folder"
                           andProgressHandler:^(NSUInteger entryNumber, NSUInteger total) {
                               
                               NSLog(@"%lu %lu", (unsigned long)entryNumber, (unsigned long)total);
                           }];
            
            [WSAlertView showAlertViewWithMessage:[NSString stringWithFormat:@"%@备份成功！您可以在导入备份中进行备份的导入。", item.title]
                                messageBoldRanges:@[[NSValue valueWithRange:NSMakeRange(0, item.title.length)],
                                                    [NSValue valueWithRange:NSMakeRange(item.title.length + 9, 4)]]
                                      buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"我知道了")]
                                             type:WSAlertViewTypeSuccess
                                         delegate:nil
                                       weakObject:nil
                                              tag:0
                                    selectedBlock:nil];
        }
    }
    
    NSLog(@"%ld , %@", (long)data.menuViewTitleIndex, data.menuViewTitleName);
}

#pragma mark - CustomViewControllerDelegate

- (void)baseCustomViewController:(__kindof CustomViewController *)controller event:(id)event {
    
    if /* 文件夹排序 */ ([controller isKindOfClass:FolderSortViewController.class]) {
        
        // 进行排序
        NSArray <BaseFolderItem *> *datas = event;
        [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            // 更新adapter数据
            obj.data                = datas[idx];
            obj.cellReuseIdentifier = datas[idx].cellReuseId;
            
            // 更新排序值
            datas[idx].sort_index = idx + 1;
        }];
        
        // 更新数据库排序值
        [GCDQueue executeInGlobalQueue:^{
            
            [Table_Folder_List updateFolderItemsSortIndex:datas];
        }];
        
        [self.collectionView reloadData];
        
    } /* 文件夹模板 */ else if ([controller isKindOfClass:FolderPatternsListViewController.class]) {
        
        FolderPatternsListViewController *patternController = (FolderPatternsListViewController *)controller;
        
        if /* 创建文件夹 */ (patternController.controllerType == FolderPatternsListViewControllerType_AddNewFolder) {
            
            BaseFolderItem *item = event;
            [item registerToCollectionView:self.collectionView];
            [self.adapters addObject:item.collectionViewAdapter];
            [self collectionViewReloadDataAnimated:NO];
            
        } /* 替换文件夹 */ else if (patternController.controllerType == FolderPatternsListViewControllerType_ReplaceFolder) {
            
            BaseFolderItem          *item    = event;
            __block CellDataAdapter *adapter = nil;
            [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                BaseFolderItem *checkItem = obj.data;
                if (item.folder_id == checkItem.folder_id) {
                    
                    adapter = obj;
                    *stop   = YES;
                }
            }];
            
            [item registerToCollectionView:self.collectionView];
            adapter.cellReuseIdentifier = item.cellReuseId;
            adapter.data                = item;
            [self.collectionView reloadData];
        }
        
    } /* 移动到... */ else if ([controller isKindOfClass:MoveFolderToViewController.class]) {
        
        NSDictionary   *dic        = event;
        BaseFolderItem *item       = dic[@"folderItem"];
        NSNumber       *folderType = dic[@"folderType"];
        
        __block CellDataAdapter *adapter = nil;
        [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            BaseFolderItem *checkItem = obj.data;
            if (item.folder_id == checkItem.folder_id) {
                
                adapter = obj;
                *stop   = YES;
            }
        }];
        
        // 删除数据,重新加载
        [self.adapters removeObject:adapter];
        [self collectionViewReloadDataAnimated:NO];
        
        [GCDQueue executeInGlobalQueue:^{
            
            // 更新数据库,移动文件夹
            [Table_Folder_List moveFolderId:item.folder_id toType:folderType.integerValue];
        }];
        
    } /* 编辑 */ else if ([controller isKindOfClass:FolderEditViewController.class]) {
        
        // 更新adapter的数据
        _currentEditCell.dataAdapter.data = event;
        _currentEditCell.data             = event;
        [_currentEditCell loadContent];
        [_currentEditCell loadCAEmitterCellContent];
        
    } /* 文件夹导入 */ else if ([controller isKindOfClass:FolderImportViewController.class]) {
        
        NSArray <BaseFolderItem *> *items = event;
        [items enumerateObjectsUsingBlock:^(BaseFolderItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [item registerToCollectionView:self.collectionView];
            if (self.canEdit) {
                
                [self.adapters addObject:[item collectionViewAdapterWithCellType:WriteStoriesBaseItemObjectCellType_Normal]];
                
            } else {
                
                [self.adapters addObject:[item collectionViewAdapterWithCellType:WriteStoriesBaseItemObjectCellType_Disable]];
            }
        }];
        
        [self collectionViewReloadDataAnimated:NO];
    }
}

#pragma mark - DefaultNotificationCenterDelegate

- (void)defaultNotificationCenter:(DefaultNotificationCenter *)notification name:(NSString *)name object:(id)object {
    
    if ([name isEqualToString:Values.Noti_FolderListViewControllerUpdateCountNumber]) {
        
        NSInteger                folderId = [object integerValue];
        __block CellDataAdapter *adapter  = nil;
        
        [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            BaseFolderItem *item = obj.data;
            if (item.folder_id == folderId) {
                
                adapter = obj;
                *stop = YES;
            }
        }];
        
        BaseFolderItem *item = adapter.data;
        item.articleCount    = [Table_Mark_List markItemsCountWithFolderId:folderId];
        [self.collectionView reloadData];
        
    } else if ([name isEqualToString:Values.Noti_FolderListViewControllerUpdateAllFoldersCountNumber]) {
        
        NSArray <NSNumber *> *articleCounts = [Table_Folder_List folderItemsArticleCountWithType:self.type.integerValue];
        
        [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            BaseFolderItem *item = obj.data;
            item.articleCount    = articleCounts[idx].integerValue;
        }];
        [self.collectionView reloadData];
    }
}

#pragma mark - Overwrite

- (void)setupSubViews {
    
    [super setupSubViews];
    
    if (self.canEdit) {
        
        self.setupButton       = [[TitleMenuButton alloc] initWithFrame:CGRectMake(0, 0, 80, 64.f) type:TitleMenuButton_More];
        self.setupButton.right = self.titleContentView.width;
        [self.setupButton addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleContentView addSubview:self.setupButton];
    }
}

@end
