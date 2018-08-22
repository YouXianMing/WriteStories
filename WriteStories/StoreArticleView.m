//
//  StoreArticleView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/5.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "StoreArticleView.h"
#import "Mark_normal.h"
#import "Mark_snow_0.h"
#import "Mark_normal_2.h"
#import "Mark_time.h"
#import "Mark_image.h"
#import "Mark_gradient.h"
#import "Mark_icon.h"
#import "PaymentsManager.h"

@implementation StoreArticleView

- (void)buildCollectionView {
    
    CGFloat gap       = 15.f;
    CGFloat itemWidth = Width - gap * 2;
    
    self.layout = [UICollectionViewFlowLayout new];
    self.layout.minimumLineSpacing      = gap;
    self.layout.minimumInteritemSpacing = gap;
    self.layout.itemSize                = CGSizeMake(itemWidth, [Math resetFromSize:CGSizeMake(77.f, 30.f) withFixedWidth:itemWidth].height);
    
    self.collectionView                 = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
    self.collectionView.delegate        = self;
    self.collectionView.dataSource      = self;
    self.collectionView.contentInset    = UIEdgeInsetsMake(gap, gap, gap, gap);
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.collectionView];
}

- (void)configDataSource {
    
    self.adapters = [NSMutableArray array];
    
    PaymentsManager *manager = PaymentsManager.defaultManager;
    
    {
        BaseMarkItem *item = [Mark_gradient defalutObject];
        item.paymentState    = [manager didPayByItemID:item.paymentID] ?
        WriteStoriesBaseItemObjectPaymantStateDidPay :
        WriteStoriesBaseItemObjectPaymantStateNotPay;
        [item registerToCollectionView:self.collectionView];
        [self.adapters addObject:item.collectionViewAdapter];
    }
    
    {
        BaseMarkItem *item = [Mark_icon defalutObject];
        [item registerToCollectionView:self.collectionView];
        item.paymentState    = [manager didPayByItemID:item.paymentID] ?
        WriteStoriesBaseItemObjectPaymantStateDidPay :
        WriteStoriesBaseItemObjectPaymantStateNotPay;
        [self.adapters addObject:item.collectionViewAdapter];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseStoreCollectionView:didSelectedItemId:)]) {
        
        BaseMarkItem *item = self.adapters[indexPath.row].data;
        [self.delegate baseStoreCollectionView:self didSelectedItemId:item.paymentID];
    }
}

- (void)reloadData {
    
    PaymentsManager *manager = PaymentsManager.defaultManager;
    
    [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BaseMarkItem *item = obj.data;
        item.paymentState  = [manager didPayByItemID:item.paymentID] ?
        WriteStoriesBaseItemObjectPaymantStateDidPay :
        WriteStoriesBaseItemObjectPaymantStateNotPay;
    }];
    
    [self.collectionView reloadData];
}

@end
