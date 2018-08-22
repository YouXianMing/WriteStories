//
//  MarkPatternListViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/19.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "MarkPatternListViewController.h"
#import "StoreViewController.h"
#import "LoadingView.h"
#import "BaseMarkItemCell.h"
#import "BaseMarkCreator.h"
#import "Math.h"
#import "GCD.h"
#import "PaymentsManager.h"
#import "WSAlertView.h"
#import "Mark_normal.h"
#import "Mark_normal_2.h"
#import "Mark_image.h"
#import "Mark_snow_0.h"
#import "Mark_gradient.h"
#import "Mark_icon.h"
#import "Mark_time.h"

@interface MarkPatternListViewController () <UICollectionViewDelegate, UICollectionViewDataSource, CustomCollectionCellDelegate, BaseMarkCreatorDelegate, CustomViewControllerDelegate>

@property (nonatomic, strong) BaseMarkCreator                    *creator;
@property (nonatomic, strong) LoadingView                        *loadingView;
@property (nonatomic, strong) UICollectionView                   *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout         *layout;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

@end

@implementation MarkPatternListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    CGFloat gap       = 15.f;
    CGFloat itemWidth = Width - gap * 2;
    
    self.layout = [UICollectionViewFlowLayout new];
    self.layout.minimumLineSpacing      = gap;
    self.layout.minimumInteritemSpacing = gap;
    self.layout.itemSize                = CGSizeMake(itemWidth, [Math resetFromSize:CGSizeMake(77.f, 30.f) withFixedWidth:itemWidth].height);
    
    self.collectionView                 = [[UICollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:self.layout];
    self.collectionView.delegate        = self;
    self.collectionView.dataSource      = self;
    self.collectionView.alpha           = 0.f;
    self.collectionView.contentInset    = UIEdgeInsetsMake(gap, gap, gap, gap);
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.collectionView];
    
    self.adapters = [NSMutableArray array];
    
    {
        BaseMarkItem *item = [Mark_normal defalutObject];
        [item registerToCollectionView:self.collectionView];
        [self.adapters addObject:item.collectionViewAdapter];
    }
    
    {
        BaseMarkItem *item = [Mark_snow_0 defalutObject];
        [item registerToCollectionView:self.collectionView];
        [self.adapters addObject:item.collectionViewAdapter];
    }
    
    {
        BaseMarkItem *item = [Mark_normal_2 defalutObject];
        [item registerToCollectionView:self.collectionView];
        [self.adapters addObject:item.collectionViewAdapter];
    }
    
    {
        BaseMarkItem *item = [Mark_time defalutObject];
        [item registerToCollectionView:self.collectionView];
        [self.adapters addObject:item.collectionViewAdapter];
    }
    
    {
        BaseMarkItem *item = [Mark_image defalutObject];
        [item registerToCollectionView:self.collectionView];
        [self.adapters addObject:item.collectionViewAdapter];
    }
    
    PaymentsManager *manager = PaymentsManager.defaultManager;
    
    {
        BaseMarkItem *item = [Mark_gradient defalutObject];
        item.paymentState  = [manager didPayByItemID:item.paymentID] ? WriteStoriesBaseItemObjectPaymantStateDidPay : WriteStoriesBaseItemObjectPaymantStateNotPay;
        [item registerToCollectionView:self.collectionView];
        [self.adapters addObject:item.collectionViewAdapter];
    }
    
    {
        BaseMarkItem *item = [Mark_icon defalutObject];
        item.paymentState  = [manager didPayByItemID:item.paymentID] ? WriteStoriesBaseItemObjectPaymantStateDidPay : WriteStoriesBaseItemObjectPaymantStateNotPay;
        [item registerToCollectionView:self.collectionView];
        [self.adapters addObject:item.collectionViewAdapter];
    }
    
//    {
//        BaseMarkItem *item = [Mark_gradient defalutObject];
//        [item registerToCollectionView:self.collectionView];
//        [self.adapters addObject:item.collectionViewAdapter];
//    }
//
//    {
//        BaseMarkItem *item = [Mark_icon defalutObject];
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
    
    BaseMarkItem *folderItem = self.adapters[indexPath.row].data;
    if (folderItem.paymentState == WriteStoriesBaseItemObjectPaymantStateNotPay) {
        
        StoreViewController *controller = [StoreViewController new];
        controller.title                = @"商店";
        controller.selectedItem         = StoreViewControllerSelectedItem_Article;
        controller.eventDelegate        = self;
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    
    if (self.type == MarkPatternListViewController_AddNewMark) {
        
        [self createMarkWith:self.adapters[indexPath.row].data];
        
    } else if (self.type == MarkPatternListViewController_ReplacMark) {
        
        [self replaceMarkWithOldItem:self.markItem patternItem:self.adapters[indexPath.row].data];
    }
}

#pragma mark - CustomCollectionCellDelegate

- (void)customCollectionCell:(BaseCustomCollectionCell *)cell event:(id)event {
    
    BaseMarkItem *folderItem = event;
    if (folderItem.paymentState == WriteStoriesBaseItemObjectPaymantStateNotPay) {
        
        StoreViewController *controller = [StoreViewController new];
        controller.title                = @"商店";
        controller.selectedItem         = StoreViewControllerSelectedItem_Article;
        controller.eventDelegate        = self;
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    
    if (self.type == MarkPatternListViewController_AddNewMark) {
        
        [self createMarkWith:event];
        
    } else if (self.type == MarkPatternListViewController_ReplacMark) {
        
        [self replaceMarkWithOldItem:self.markItem patternItem:event];
    }
}

#pragma mark - CustomViewControllerDelegate

- (void)baseCustomViewController:(__kindof CustomViewController *)controller event:(id)event {
    
    PaymentsManager *manager = PaymentsManager.defaultManager;
    
    [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BaseMarkItem *item = obj.data;
        if (item.paymentID.length) {
            
            item.paymentState = [manager didPayByItemID:item.paymentID] ? WriteStoriesBaseItemObjectPaymantStateDidPay : WriteStoriesBaseItemObjectPaymantStateNotPay;
        }
    }];
    
    [self.collectionView reloadData];
}

#pragma mark - BaseMarkCreatorDelegate

- (void)baseMarkCreatorDidStartCreateMark:(BaseMarkCreator *)creator {
    
    NSLog(@"baseMarkCreatorDidStartCreateMark");
}

- (void)baseMarkCreatorDidEndCreateMark:(BaseMarkCreator *)creator markItem:(BaseMarkItem *)markItem {
    
    if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(baseCustomViewController:event:)]) {
        
        [self.eventDelegate baseCustomViewController:self event:markItem];
    }
    
    // 延迟0.15s
    [self.loadingView stopLoading];
    [GCDQueue executeInMainQueue:^{
        
        if (creator.type == BaseMarkCreatorTypeAdd) {
            
            [WSAlertView showAlertViewWithMessage:@"文章标签创建成功，长按文章标签弹出选项单，您可以选择编辑进行修改！"
                                messageBoldRanges:@[[NSValue valueWithRange:NSMakeRange(9, 2)], [NSValue valueWithRange:NSMakeRange(26, 2)]]
                                      buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"我知道了")]
                                             type:WSAlertViewTypeSuccess delegate:nil weakObject:nil tag:0 selectedBlock:^(WSAlertViewButtonInfo *buttonInfo) {
                                                 
                                                 [self popViewControllerAnimated:YES];
                                             }];
            
        } else if (creator.type == BaseMarkCreatorTypeReplace) {
            
            [WSAlertView showAlertViewWithMessage:@"文章标签更新成功，长按文章标签弹出选项单，您可以选择编辑进行修改！"
                                messageBoldRanges:@[[NSValue valueWithRange:NSMakeRange(9, 2)], [NSValue valueWithRange:NSMakeRange(26, 2)]]
                                      buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"我知道了")]
                                             type:WSAlertViewTypeMessage delegate:nil weakObject:nil tag:0 selectedBlock:^(WSAlertViewButtonInfo *buttonInfo) {
                                                 
                                                 [self popViewControllerAnimated:YES];
                                             }];
        }
        
    } afterDelaySecs:0.15];
}

#pragma mark - Other

- (void)createMarkWith:(BaseMarkItem *)item {
    
    self.creator            = [BaseMarkCreator new];
    self.creator.delegate   = self;
    
    // 延迟1s
    self.loadingView = [LoadingView loadingViewStartLoadingInKeyWindow];
    [GCDQueue executeInMainQueue:^{
    
        [self.creator startCreateWithPatternMarkItem:item folderItem:self.folderItem];
        
    } afterDelaySecs:1.f];
}

- (void)replaceMarkWithOldItem:(BaseMarkItem *)item patternItem:(BaseMarkItem *)patternItem {
    
    self.creator            = [BaseMarkCreator new];
    self.creator.delegate   = self;
    
    // 延迟1s
    self.loadingView = [LoadingView loadingViewStartLoadingInKeyWindow];
    [GCDQueue executeInMainQueue:^{
        
        [self.creator startUpdateWithOldMarkItem:item patternFolderItem:patternItem];
        
    } afterDelaySecs:1.f];
}

@end
