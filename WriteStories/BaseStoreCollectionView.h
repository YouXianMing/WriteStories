//
//  BaseStoreCollectionView.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/5.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SetRect.h"
#import "BaseCustomCollectionCell.h"
#import "Math.h"
@class BaseStoreCollectionView;

@protocol BaseStoreCollectionViewDelegate <NSObject>

- (void)baseStoreCollectionView:(BaseStoreCollectionView *)collectionView didSelectedItemId:(NSString *)itemId;

@end

@interface BaseStoreCollectionView : UIView <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) id <BaseStoreCollectionViewDelegate> delegate;

@property (nonatomic, strong) UICollectionView                   *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout         *layout;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

- (void)buildCollectionView;

- (void)configDataSource;

- (void)reloadData;

@end
