//
//  ArticleListViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ArticleListViewController.h"
#import "SheetMenuView.h"
#import "SheetMenuObject.h"
#import "PopMenuView.h"
#import "PopMenuObject.h"
#import "UIView+ConvertRect.h"
#import "BaseMarkItemCell.h"
#import "BaseFolderItem.h"
#import "MarkPatternListViewController.h"
#import "Values.h"
#import "Table_Mark_List.h"
#import "FoldersManager.h"
#import "DefaultNotificationCenter.h"
#import "MarkSortViewViewController.h"
#import "MoveMarkToViewController.h"
#import "MarkEditViewController.h"
#import "ArticleDetailViewController.h"
#import "MarkImportViewController.h"
#import "GCD.h"
#import "BaseMarkItem.h"
#import "NSString+Path.h"
#import "Math.h"
#import "WSAlertView.h"
#import "DateFormatter.h"
#import "SSZipArchive.h"
#import "VersionManager.h"

@interface ArticleListViewController () <BaseWindowMenuViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, CustomCollectionCellDelegate, CustomViewControllerDelegate> {
    
    BaseMarkItemCell *_currentEditCell;
}

@property (nonatomic, strong) UIImageView     *noDataImageView;
@property (nonatomic, strong) TitleMenuButton *setupButton;
@property (nonatomic, strong) NSLock          *lock;

@property (nonatomic, strong) UICollectionView                   *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout         *layout;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

@property (nonatomic, strong) SheetMenuView *menuView;


@end

@implementation ArticleListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.lock = [NSLock new];
    
    self.noDataImageView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"noData"]];
    self.noDataImageView.alpha  = 0.f;
    self.noDataImageView.center = self.contentView.middlePoint;
    [self.contentView addSubview:self.noDataImageView];
    
    CGFloat gap       = 15.f;
    CGFloat itemWidth = Width - gap * 2;
    
    self.layout = [UICollectionViewFlowLayout new];
    self.layout.minimumLineSpacing      = gap;
    self.layout.minimumInteritemSpacing = gap;
    self.layout.itemSize                = CGSizeMake(itemWidth, [Math resetFromSize:CGSizeMake(77.f, 30.f) withFixedWidth:itemWidth].height);
    
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
        NSArray <BaseMarkItem *> *items = [Table_Mark_List markItemsWithFolderId:self.folderItem.folder_id];
        
        [GCDQueue executeInMainQueue:^{
            
            // 将获取的文件进行注册,并添加
            [items enumerateObjectsUsingBlock:^(BaseMarkItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
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
    
    CellDataAdapter  *adapter = self.adapters[indexPath.row];
    BaseMarkItemCell *cell    = [collectionView dequeueReusableCellWithReuseIdentifier:adapter.cellReuseIdentifier forIndexPath:indexPath];
    cell.indexPath            = indexPath;
    cell.dataAdapter          = adapter;
    cell.data                 = adapter.data;
    cell.delegate             = self;
    [cell loadContent];
    
    NSLog(@"%@", adapter.cellReuseIdentifier);
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseMarkItem *item                      = self.adapters[indexPath.row].data;
    ArticleDetailViewController *controller = [ArticleDetailViewController new];
    controller.htmlFolder                   = [NSString stringWithFormat:@"%@/%@/content/html", FoldersManager.ArticleList, item.mark_name];
    controller.canEdit                      = self.canEdit;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - BaseCustomCollectionCellDelegate

- (void)customCollectionCell:(BaseCustomCollectionCell *)cell event:(id)event {
    
    if ([self.lock tryLock]) {
        
        self.menuView = [SheetMenuView menuViewWithDelegate:self datas:@[[SheetMenuObject sheetMenuObjectWithIndex:0 title:@"移动到..."],
                                                                         [SheetMenuObject sheetMenuObjectWithIndex:1 title:@"删除"],
                                                                         [SheetMenuObject sheetMenuObjectWithIndex:2 title:@"编辑"],
                                                                         [SheetMenuObject sheetMenuObjectWithIndex:3 title:@"更换模板"],
                                                                         [SheetMenuObject sheetMenuObjectWithIndex:3 title:@"备份"]]];
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
                                                        title:@"创建文章"]];
        [datas addObject:[PopMenuObject popMenuObjectWithIcon:PopMenuButtonIconTypeSort
                                                         type:PopMenuButtonTitleTypeNormal
                                                        index:1
                                                        title:@"文章排序"]];
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
        
        // 如果文件超过40个,则不允许添加
        if (self.folderItem.articleCount >= 40) {
            
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
        
        if ([data.menuViewTitleName isEqualToString:@"文章排序"]) {
            
            NSMutableArray *markItems = [NSMutableArray array];
            [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [markItems addObject:obj.data];
            }];
            
            MarkSortViewViewController *controller = [MarkSortViewViewController new];
            controller.markItems                   = markItems;
            controller.eventDelegate               = self;
            controller.title                       = @"文章排序";
            [self.navigationController pushViewController:controller animated:YES];
            
        } else if ([data.menuViewTitleName isEqualToString:@"创建文章"]) {
            
            MarkPatternListViewController *controller = [MarkPatternListViewController new];
            controller.type                           = MarkPatternListViewController_AddNewMark;
            controller.title                          = @"文章标签模板";
            controller.folderItem                     = self.folderItem;
            controller.eventDelegate                  = self;
            [self.navigationController pushViewController:controller animated:YES];
            
        } else if ([data.menuViewTitleName isEqualToString:@"导入备份"]) {
            
            MarkImportViewController *controller = [MarkImportViewController new];
            controller.title                     = @"文章导入";
            controller.eventDelegate             = self;
            controller.folderItem                = self.folderItem;
            [self.navigationController pushViewController:controller animated:YES];
        }
        
    } else if ([windowMenuView isKindOfClass:SheetMenuView.class]) {
        
        if ([data.menuViewTitleName isEqualToString:@"删除"]) {
            
            BaseCustomCollectionCell *cell = windowMenuView.weakObject;
            BaseMarkItem             *item = cell.dataAdapter.data;
            NSLog(@"%@", item);

            [WSAlertView showAlertViewWithMessage:[NSString stringWithFormat:@"您确定要删除%@？删除之后不可恢复！", item.title]
                                messageBoldRanges:@[[NSValue valueWithRange:NSMakeRange(6, item.title.length)], [NSValue valueWithRange:NSMakeRange(6 + item.title.length + 5, 4)]]
                                      buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"取消"),
                                                    buttonInfo(WSAlertViewButtonTypeConfirm, @"确定")]
                                             type:WSAlertViewTypeAlert
                                         delegate:nil
                                       weakObject:nil
                                              tag:0
                                    selectedBlock:^(WSAlertViewButtonInfo *buttonInfo) {
                                        
                                        if (buttonInfo.type == WSAlertViewButtonTypeConfirm) {
                                            
                                            [self.collectionView performBatchUpdates:^{
                                                
                                                // 删除cell数据
                                                [self.adapters removeObject:cell.dataAdapter];
                                                [self.collectionView deleteItemsAtIndexPaths:@[cell.indexPath]];
                                                
                                            } completion:^(BOOL finished) {
                                                
                                                // 重新加载数据
                                                [self collectionViewReloadDataAnimated:YES];
                                                
                                                [GCDQueue executeInGlobalQueue:^{
                                                    
                                                    // 删除数据库记录
                                                    [Table_Mark_List deleteItem:item];
                                                    
                                                    // 删除文件
                                                    NSString *filePath = [FoldersManager.ArticleList addPathComponent:item.mark_name];
                                                    NSError  *error    = nil;
                                                    [[NSFileManager defaultManager] removeItemAtURL:[NSURL fileURLWithPath:filePath] error:&error];
                                                    if (error) {
                                                        
                                                        NSLog(@"%@", error);
                                                    }
                                                }];
                                            }];
                                        }
                                    }];

        } else if ([data.menuViewTitleName isEqualToString:@"更换模板"]) {
            
            BaseCustomCollectionCell *cell = windowMenuView.weakObject;
            BaseMarkItem             *item = cell.dataAdapter.data;
            
            MarkPatternListViewController *controller = [MarkPatternListViewController new];
            controller.type                           = MarkPatternListViewController_ReplacMark;
            controller.title                          = @"文章标签模板";
            controller.folderItem                     = self.folderItem;
            controller.markItem                       = item;
            controller.eventDelegate                  = self;
            [self.navigationController pushViewController:controller animated:YES];
            
        } else if ([data.menuViewTitleName isEqualToString:@"移动到..."]) {
            
            BaseCustomCollectionCell *cell = windowMenuView.weakObject;
            BaseMarkItem             *item = cell.dataAdapter.data;
            
            MoveMarkToViewController *controller = [MoveMarkToViewController new];
            controller.title                     = @"移动到";
            controller.markItem                  = item;
            controller.eventDelegate             = self;
            [self.navigationController pushViewController:controller animated:YES];
            
        } else if ([data.menuViewTitleName isEqualToString:@"编辑"]) {
            
            BaseMarkItemCell *cell = windowMenuView.weakObject;
            BaseMarkItem     *item = cell.dataAdapter.data;
            _currentEditCell       = cell;
            
            MarkEditViewController *controller = [MarkEditViewController new];
            controller.title                   = @"文章编辑";
            controller.markItem                = item.dbCopyObject;
            controller.eventDelegate           = self;
            [self.navigationController pushViewController:controller animated:YES];
            
        } else if ([data.menuViewTitleName isEqualToString:@"备份"]) {
            
            BaseCustomCollectionCell *cell = windowMenuView.weakObject;
            BaseMarkItem             *item = cell.dataAdapter.data;
            
            NSString *folderPath = [FoldersManager.ArticleList addPathComponent:item.mark_name];
            NSString *time       = [DateFormatter dateStringFromDate:[NSDate date] outputDateStringFormatter:@"yyyy-MM-dd HH-mm-ss"];
            NSString *name       = [NSString stringWithFormat:@"%@/[%@] %@.article", FoldersManager.ArticleBackups, time, item.title];
            
            // 创建版本文件
            [VersionManager storeVersionDataWithFolder:[folderPath addPathComponent:@"content"]];
            
            [SSZipArchive createZipFileAtPath:name
                      withContentsOfDirectory:folderPath
                          keepParentDirectory:NO
                                 withPassword:@"write.stories.you.xian.ming.article"
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
    
    if /* 文章模板 */ ([controller isKindOfClass:MarkPatternListViewController.class]) {
        
        MarkPatternListViewController *patternController = (MarkPatternListViewController *)controller;
        
        if (patternController.type == MarkPatternListViewController_AddNewMark) {
            
            BaseMarkItem *item = event;
            [item registerToCollectionView:self.collectionView];
            [self.adapters addObject:item.collectionViewAdapter];
            [self collectionViewReloadDataAnimated:NO];
            
        } else if (patternController.type == MarkPatternListViewController_ReplacMark) {
            
            BaseMarkItem            *item    = event;
            __block CellDataAdapter *adapter = nil;
            [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                BaseMarkItem *checkItem = obj.data;
                if (item.mark_id == checkItem.mark_id) {
                    
                    adapter = obj;
                    *stop   = YES;
                }
            }];
            
            [item registerToCollectionView:self.collectionView];
            adapter.cellReuseIdentifier = item.cellReuseId;
            adapter.data                = item;
            [self.collectionView reloadData];
        }
        
    } /* 文章排序 */ else if ([controller isKindOfClass:MarkSortViewViewController.class]) {
        
        // 进行排序
        NSArray <BaseMarkItem *> *datas = event;
        [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            // 更新adapter数据
            obj.data                = datas[idx];
            obj.cellReuseIdentifier = datas[idx].cellReuseId;
            
            // 更新排序值
            datas[idx].sort_index = idx + 1;
        }];
        
        // 更新数据库排序值
        [GCDQueue executeInGlobalQueue:^{
            
            [Table_Mark_List updateMarkItemsSortIndex:datas];
        }];
        
        [self.collectionView reloadData];
        
    } /* 移动到 */ else if ([controller isKindOfClass:MoveMarkToViewController.class]) {
        
        BaseMarkItem            *item    = event;
        __block CellDataAdapter *adapter = nil;
        
        [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj.data isEqual:item]) {
                
                adapter = obj;
                *stop   = YES;
            }
        }];
        
        [self.adapters removeObject:adapter];
        [self collectionViewReloadDataAnimated:NO];
        
    } /* 编辑 */ else if ([controller isKindOfClass:MarkEditViewController.class]) {
        
        // 更新adapter的数据
        _currentEditCell.dataAdapter.data = event;
        _currentEditCell.data             = event;
        [_currentEditCell loadContent];
        [_currentEditCell loadCAEmitterCellContent];
        
    } /* 文章导入 */ else if ([controller isKindOfClass:MarkImportViewController.class]) {
        
        NSArray <BaseMarkItem *> *items = event;
        [items enumerateObjectsUsingBlock:^(BaseMarkItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
            
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
