//
//  BackgroundStyleViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BackgroundStyleViewController.h"
#import "StoreViewController.h"
#import "BaseBackgroundStyleCell.h"
#import "BackgroundStyleObject.h"
#import "PaymentsManager.h"

#import "BackgroundStyle_PureColor_Cell.h"
#import "BackgroundStyle_PatternImage_Cell.h"
#import "BackgroundStyle_GradientImage_Cell.h"
#import "BackgroundStyle_ElegantStyle_Cell.h"

#import "Html_pureColor.h"
#import "Html_patternImage.h"
#import "Html_GradientImage.h"
#import "Html_ElegantStyle.h"

@interface BackgroundStyleViewController () <UICollectionViewDelegate, UICollectionViewDataSource, CustomViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) UICollectionViewFlowLayout         *layout;
@property (nonatomic, strong) UICollectionView                   *collectionView;

@end

@implementation BackgroundStyleViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    CGFloat gap       = 15.f;
    CGFloat itemWidth = (Width - gap * 3) / 2.f;
    
    self.layout = [UICollectionViewFlowLayout new];
    self.layout.minimumLineSpacing      = gap;
    self.layout.minimumInteritemSpacing = gap;
    self.layout.itemSize                = CGSizeMake(itemWidth, itemWidth * 1.5f);
    
    self.collectionView                 = [[UICollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:self.layout];
    self.collectionView.delegate        = self;
    self.collectionView.dataSource      = self;
    self.collectionView.contentInset    = UIEdgeInsetsMake(gap, gap, gap, gap);
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.collectionView];
    
    [BackgroundStyle_PureColor_Cell     registerToCollectionView:self.collectionView];
    [BackgroundStyle_PatternImage_Cell  registerToCollectionView:self.collectionView];
    [BackgroundStyle_GradientImage_Cell registerToCollectionView:self.collectionView];
    [BackgroundStyle_ElegantStyle_Cell  registerToCollectionView:self.collectionView];
    
    self.adapters = [NSMutableArray array];
    [self.adapters addObject:[BackgroundStyle_PureColor_Cell dataAdapterWithData:
                              [BackgroundStyleObject objectWithTitle:@"纯色"
                                                             desInfo:@"您可以通过选择颜色来更换背景颜色。"
                                                            selected:NO]]];
    
    [self.adapters addObject:[BackgroundStyle_PatternImage_Cell dataAdapterWithData:
                              [BackgroundStyleObject objectWithTitle:@"平铺图案"
                                                             desInfo:@"您可以通过选择内置的图案来更换背景。"
                                                            selected:NO]]];
    
    PaymentsManager *manager = PaymentsManager.defaultManager;
    
    {
        BackgroundStyleObject *object = [BackgroundStyleObject objectWithTitle:@"背景图"
                                                                       desInfo:@"您可以通过选择内置的图片来更换背景。"
                                                                      selected:NO];
        
        object.paymentID    = @"com.YouXianMing.WriteStories.BackgroundStyle_GradientImage";
        object.paymentState = [manager didPayByItemID:object.paymentID] ?
        WriteStoriesBaseItemObjectPaymantStateDidPay :
        WriteStoriesBaseItemObjectPaymantStateNotPay;
        
        [self.adapters addObject:[BackgroundStyle_GradientImage_Cell dataAdapterWithData:object]];
    }
    
    {
        BackgroundStyleObject *object = [BackgroundStyleObject objectWithTitle:@"纸张"
                                                                       desInfo:@"您可以通过选择内置的选项更新样式。"
                                                                      selected:NO];
        
        object.paymentID    = @"com.YouXianMing.WriteStories.BackgroundStyle_ElegantStyle";
        object.paymentState = [manager didPayByItemID:object.paymentID] ?
        WriteStoriesBaseItemObjectPaymantStateDidPay :
        WriteStoriesBaseItemObjectPaymantStateNotPay;
        
        [self.adapters addObject:[BackgroundStyle_ElegantStyle_Cell dataAdapterWithData:object]];
    }
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.adapters.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter        *adapter = self.adapters[indexPath.row];
    BaseBackgroundStyleCell *cell   = [collectionView dequeueReusableCellWithReuseIdentifier:adapter.cellReuseIdentifier forIndexPath:indexPath];
    cell.dataAdapter                = adapter;
    cell.data                       = adapter.data;
    [cell loadContent];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.collectionView.visibleCells enumerateObjectsUsingBlock:^(__kindof UICollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BaseCustomCollectionCell *cell = (BaseCustomCollectionCell *)obj;
        [cell contentOffset:scrollView.contentOffset];
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BackgroundStyleObject *object = self.adapters[indexPath.row].data;
    if (object.paymentState == WriteStoriesBaseItemObjectPaymantStateNotPay) {
        
        StoreViewController *controller = [StoreViewController new];
        controller.title                = @"商店";
        controller.selectedItem         = StoreViewControllerSelectedItem_Background;
        controller.eventDelegate        = self;
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    
    BaseCustomCollectionCell *cell = (BaseCustomCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if ([cell isKindOfClass:BackgroundStyle_PureColor_Cell.class]) {
        
        if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(baseCustomViewController:event:)]) {
            
            [self.eventDelegate baseCustomViewController:self event:Html_pureColor.defalutObject];
        }
        
        [self popViewControllerAnimated:YES];
        
    } else if ([cell isKindOfClass:BackgroundStyle_PatternImage_Cell.class]) {
        
        if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(baseCustomViewController:event:)]) {
            
            [self.eventDelegate baseCustomViewController:self event:Html_patternImage.defalutObject];
        }
        
        [self popViewControllerAnimated:YES];
        
    } else if ([cell isKindOfClass:BackgroundStyle_GradientImage_Cell.class]) {
        
        if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(baseCustomViewController:event:)]) {
            
            [self.eventDelegate baseCustomViewController:self event:Html_GradientImage.defalutObject];
        }
        
        [self popViewControllerAnimated:YES];
        
    } else if ([cell isKindOfClass:BackgroundStyle_ElegantStyle_Cell.class]) {
        
        if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(baseCustomViewController:event:)]) {
            
            [self.eventDelegate baseCustomViewController:self event:Html_ElegantStyle.defalutObject];
        }
        
        [self popViewControllerAnimated:YES];
    }
}

#pragma mark - CustomViewControllerDelegate

- (void)baseCustomViewController:(__kindof CustomViewController *)controller event:(id)event {
    
    PaymentsManager *manager = PaymentsManager.defaultManager;
    
    [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BackgroundStyleObject *item = obj.data;
        if (item.paymentID.length) {
            
            item.paymentState = [manager didPayByItemID:item.paymentID] ? WriteStoriesBaseItemObjectPaymantStateDidPay : WriteStoriesBaseItemObjectPaymantStateNotPay;
        }
    }];
    
    [self.collectionView reloadData];
}

@end
