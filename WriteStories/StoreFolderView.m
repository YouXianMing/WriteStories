//
//  StoreFolderView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/5.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "StoreFolderView.h"

#import "Folder_normal_0.h"
#import "Folder_image_0.h"
#import "Folder_landscape.h"
#import "Folder_city.h"
#import "Folder_gradientImage.h"
#import "Folder_iconfont_0.h"
#import "PaymentsManager.h"

@implementation StoreFolderView

- (void)buildCollectionView {
    
    CGFloat gap       = 15.f;
    CGFloat itemWidth = (Width - gap * 3) / 2.f;
    
    self.layout = [UICollectionViewFlowLayout new];
    self.layout.minimumLineSpacing      = gap;
    self.layout.minimumInteritemSpacing = gap;
    self.layout.itemSize                = CGSizeMake(itemWidth, 40 + itemWidth);
    
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
        BaseFolderItem *item = [Folder_gradientImage defalutObject];
        item.title           = @"模板";
        item.paymentState    = [manager didPayByItemID:item.paymentID] ?
        WriteStoriesBaseItemObjectPaymantStateDidPay :
        WriteStoriesBaseItemObjectPaymantStateNotPay;
        [item registerToCollectionView:self.collectionView];
        [self.adapters addObject:item.collectionViewAdapter];
    }
    
    {
        BaseFolderItem *item = [Folder_iconfont_0 defalutObject];
        item.title           = @"模板";
        item.paymentState    = [manager didPayByItemID:item.paymentID] ?
        WriteStoriesBaseItemObjectPaymantStateDidPay :
        WriteStoriesBaseItemObjectPaymantStateNotPay;
        [item registerToCollectionView:self.collectionView];
        [self.adapters addObject:item.collectionViewAdapter];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseStoreCollectionView:didSelectedItemId:)]) {
        
        BaseFolderItem *item = self.adapters[indexPath.row].data;
        [self.delegate baseStoreCollectionView:self didSelectedItemId:item.paymentID];
    }
}

- (void)reloadData {
    
    PaymentsManager *manager = PaymentsManager.defaultManager;
    
    [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BaseFolderItem *item = obj.data;
        item.paymentState    = [manager didPayByItemID:item.paymentID] ?
        WriteStoriesBaseItemObjectPaymantStateDidPay :
        WriteStoriesBaseItemObjectPaymantStateNotPay;
    }];

    [self.collectionView reloadData];
}

@end
