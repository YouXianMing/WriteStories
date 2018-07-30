//
//  BaseStoreCollectionView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/5.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseStoreCollectionView.h"

@implementation BaseStoreCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
    
        [self buildCollectionView];
        [self configDataSource];
    }
    
    return self;
}

- (void)buildCollectionView {
    
}

- (void)configDataSource {
    
}

- (void)reloadData {
    
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.adapters.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter *adapter       = self.adapters[indexPath.row];
    BaseCustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:adapter.cellReuseIdentifier forIndexPath:indexPath];
    cell.indexPath                 = indexPath;
    cell.dataAdapter               = adapter;
    cell.data                      = adapter.data;
    [cell loadContent];
    
    NSLog(@"%@", adapter.cellReuseIdentifier);
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
