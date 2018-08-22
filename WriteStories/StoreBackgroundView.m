//
//  StoreBackgroundView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/5.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "StoreBackgroundView.h"

#import "BackgroundStyleObject.h"
#import "BackgroundStyle_PureColor_Cell.h"
#import "BackgroundStyle_PatternImage_Cell.h"
#import "BackgroundStyle_GradientImage_Cell.h"
#import "BackgroundStyle_ElegantStyle_Cell.h"

#import "PaymentsManager.h"

@implementation StoreBackgroundView

- (void)buildCollectionView {
    
    CGFloat gap       = 15.f;
    CGFloat itemWidth = (Width - gap * 3) / 2.f;
    
    self.layout = [UICollectionViewFlowLayout new];
    self.layout.minimumLineSpacing      = gap;
    self.layout.minimumInteritemSpacing = gap;
    self.layout.itemSize                = CGSizeMake(itemWidth, itemWidth * 1.5f);
    
    self.collectionView                 = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
    self.collectionView.delegate        = self;
    self.collectionView.dataSource      = self;
    self.collectionView.contentInset    = UIEdgeInsetsMake(gap, gap, gap, gap);
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.collectionView];
}

- (void)configDataSource {
    
    [BackgroundStyle_PureColor_Cell     registerToCollectionView:self.collectionView];
    [BackgroundStyle_PatternImage_Cell  registerToCollectionView:self.collectionView];
    [BackgroundStyle_GradientImage_Cell registerToCollectionView:self.collectionView];
    [BackgroundStyle_ElegantStyle_Cell  registerToCollectionView:self.collectionView];
    
    self.adapters = [NSMutableArray array];
    
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseStoreCollectionView:didSelectedItemId:)]) {
        
        BackgroundStyleObject *item = self.adapters[indexPath.row].data;
        [self.delegate baseStoreCollectionView:self didSelectedItemId:item.paymentID];
    }
}

- (void)reloadData {
    
    PaymentsManager *manager = PaymentsManager.defaultManager;
    
    [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BackgroundStyleObject *item = obj.data;
        item.paymentState           = [manager didPayByItemID:item.paymentID] ?
        WriteStoriesBaseItemObjectPaymantStateDidPay :
        WriteStoriesBaseItemObjectPaymantStateNotPay;
    }];
    
    [self.collectionView reloadData];
}

@end
