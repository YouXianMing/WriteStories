//
//  FolderPatternsListViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "FolderPatternsListViewController.h"
#import "BaseFolderCreator.h"
#import "BaseFolderItemCell.h"
#import "LoadingView.h"
#import "WSAlertView.h"
#import "PaymentsManager.h"
#import "GCD.h"
#import "StoreViewController.h"

#import "Folder_normal_0.h"
#import "Folder_image_0.h"
#import "Folder_gradientImage.h"
#import "Folder_iconfont_0.h"
#import "Folder_snow_0.h"
#import "Folder_landscape.h"
#import "Folder_city.h"

@interface FolderPatternsListViewController () <UICollectionViewDelegate, UICollectionViewDataSource, CustomCollectionCellDelegate, BaseFolderCreatorDelegate, CustomViewControllerDelegate>

@property (nonatomic, strong) LoadingView                        *loadingView;
@property (nonatomic, strong) UICollectionView                   *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout         *layout;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

@property (nonatomic, strong) BaseFolderCreator *creator;

@end

@implementation FolderPatternsListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    CGFloat gap       = 15.f;
    CGFloat itemWidth = (Width - gap * 3) / 2.f;
    
    self.layout = [UICollectionViewFlowLayout new];
    self.layout.minimumLineSpacing      = gap;
    self.layout.minimumInteritemSpacing = gap;
    self.layout.itemSize                = CGSizeMake(itemWidth, 40 + itemWidth);
    
    self.collectionView                 = [[UICollectionView alloc] initWithFrame:self.contentView.bounds
                                                             collectionViewLayout:self.layout];
    self.collectionView.delegate        = self;
    self.collectionView.dataSource      = self;
    self.collectionView.alpha           = 0.f;
    self.collectionView.contentInset    = UIEdgeInsetsMake(gap, gap, gap, gap);
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.collectionView];
    
    self.adapters = [NSMutableArray array];
    
    {
        BaseFolderItem *item = [Folder_normal_0 defalutObject];
        [item registerToCollectionView:self.collectionView];
        [self.adapters addObject:item.collectionViewAdapter];
    }
    
    {
        BaseFolderItem *item = [Folder_image_0 defalutObject];
        [item registerToCollectionView:self.collectionView];
        [self.adapters addObject:item.collectionViewAdapter];
    }
    
    {
        BaseFolderItem *item = [Folder_landscape defalutObject];
        [item registerToCollectionView:self.collectionView];
        [self.adapters addObject:item.collectionViewAdapter];
    }
    
    {
        BaseFolderItem *item = [Folder_city defalutObject];
        [item registerToCollectionView:self.collectionView];
        [self.adapters addObject:item.collectionViewAdapter];
    }
    
    PaymentsManager *manager = PaymentsManager.defaultManager;
    
    {
        BaseFolderItem *item = [Folder_gradientImage defalutObject];
        item.paymentState    = [manager didPayByItemID:item.paymentID] ? WriteStoriesBaseItemObjectPaymantStateDidPay : WriteStoriesBaseItemObjectPaymantStateNotPay;
        [item registerToCollectionView:self.collectionView];
        [self.adapters addObject:item.collectionViewAdapter];
    }
    
    {
        BaseFolderItem *item = [Folder_iconfont_0 defalutObject];
        item.paymentState    = [manager didPayByItemID:item.paymentID] ? WriteStoriesBaseItemObjectPaymantStateDidPay : WriteStoriesBaseItemObjectPaymantStateNotPay;
        [item registerToCollectionView:self.collectionView];
        [self.adapters addObject:item.collectionViewAdapter];
    }
    
//    {
//        BaseFolderItem *item = [Folder_snow_0 defalutObject];
//        [item registerToCollectionView:self.collectionView];
//        [self.adapters addObject:item.collectionViewAdapter];
//    }
    
    [UIView animateWithDuration:0.75f animations:^{
        
        self.collectionView.alpha = 1.f;
    }];
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
    
    BaseFolderItem *folderItem = self.adapters[indexPath.row].data;
    if (folderItem.paymentState == WriteStoriesBaseItemObjectPaymantStateNotPay) {
        
        StoreViewController *controller = [StoreViewController new];
        controller.title                = @"商店";
        controller.selectedItem         = StoreViewControllerSelectedItem_Folder;
        controller.eventDelegate        = self;
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    
    if (self.controllerType == FolderPatternsListViewControllerType_AddNewFolder) {
        
        [self createFolderWith:self.adapters[indexPath.row].data];
        
    } else if (self.controllerType == FolderPatternsListViewControllerType_ReplaceFolder) {
        
        [self replaceFolderWithOldItem:self.folderItem patternItem:self.adapters[indexPath.row].data];
    }
}

#pragma mark - CustomViewControllerDelegate

- (void)baseCustomViewController:(__kindof CustomViewController *)controller event:(id)event {
    
    PaymentsManager *manager = PaymentsManager.defaultManager;
    
    [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BaseFolderItem *item = obj.data;
        if (item.paymentID.length) {
            
            item.paymentState = [manager didPayByItemID:item.paymentID] ? WriteStoriesBaseItemObjectPaymantStateDidPay : WriteStoriesBaseItemObjectPaymantStateNotPay;
        }
    }];
    
    [self.collectionView reloadData];
}

#pragma mark - CustomCollectionCellDelegate

- (void)customCollectionCell:(BaseCustomCollectionCell *)cell event:(id)event {

    BaseFolderItem *folderItem = event;
    if (folderItem.paymentState == WriteStoriesBaseItemObjectPaymantStateNotPay) {
        
        StoreViewController *controller = [StoreViewController new];
        controller.title                = @"商店";
        controller.selectedItem         = StoreViewControllerSelectedItem_Folder;
        controller.eventDelegate        = self;
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    
    if (self.controllerType == FolderPatternsListViewControllerType_AddNewFolder) {
    
        [self createFolderWith:event];
        
    } else if (self.controllerType == FolderPatternsListViewControllerType_ReplaceFolder) {
        
        [self replaceFolderWithOldItem:self.folderItem patternItem:event];
    }
}

#pragma mark - BaseFolderCreatorDelegate

- (void)baseFolderCreatorDidStartCreateFolder:(BaseFolderCreator *)creator {
    
    NSLog(@"baseFolderCreatorDidStartCreateFolder");
}

- (void)baseFolderCreatorDidEndCreateFolder:(BaseFolderCreator *)creator folderItem:(BaseFolderItem *)folderItem {
    
    if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(baseCustomViewController:event:)]) {
        
        [self.eventDelegate baseCustomViewController:self event:folderItem];
    }
    
    // 延迟0.15s
    [self.loadingView stopLoading];
    [GCDQueue executeInMainQueue:^{
        
        if (creator.type == BaseFolderCreatorTypeAdd) {
            
            [WSAlertView showAlertViewWithMessage:@"文件夹创建成功，长按文件夹弹出选项单，您可以选择编辑进行修改！"
                                messageBoldRanges:@[[NSValue valueWithRange:NSMakeRange(8, 2)], [NSValue valueWithRange:NSMakeRange(24, 2)]]
                                      buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"我知道了")]
                                             type:WSAlertViewTypeSuccess delegate:nil weakObject:nil tag:0 selectedBlock:^(WSAlertViewButtonInfo *buttonInfo) {
                                                 
                                                 [self popViewControllerAnimated:YES];
                                             }];
            
        } else if (creator.type == BaseFolderCreatorTypeReplace) {
            
            [WSAlertView showAlertViewWithMessage:@"文件夹更新成功，长按文件夹弹出选项单，您可以选择编辑进行修改！"
                                messageBoldRanges:@[[NSValue valueWithRange:NSMakeRange(8, 2)], [NSValue valueWithRange:NSMakeRange(24, 2)]]
                                      buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"我知道了")]
                                             type:WSAlertViewTypeMessage delegate:nil weakObject:nil tag:0 selectedBlock:^(WSAlertViewButtonInfo *buttonInfo) {
                                                 
                                                 [self popViewControllerAnimated:YES];
                                             }];
        }
        
    } afterDelaySecs:0.15];
}

#pragma mark - Other

- (void)createFolderWith:(BaseFolderItem *)item {
    
    self.creator            = [BaseFolderCreator new];
    self.creator.delegate   = self;
    
    // 延迟1s
    self.loadingView = [LoadingView loadingViewStartLoadingInKeyWindow];
    [GCDQueue executeInMainQueue:^{
    
        [self.creator startCreateWithPatternFolderItem:item folderType:self.type];
        
    } afterDelaySecs:1.f];
}

- (void)replaceFolderWithOldItem:(BaseFolderItem *)item patternItem:(BaseFolderItem *)patternItem {
    
    self.creator            = [BaseFolderCreator new];
    self.creator.delegate   = self;
    
    // 延迟1s
    self.loadingView = [LoadingView loadingViewStartLoadingInKeyWindow];
    [GCDQueue executeInMainQueue:^{
        
        [self.creator startUpdateWithOldFolderItem:item patternFolderItem:patternItem];
        
    } afterDelaySecs:1.f];
}

#pragma mark - store event

@end
