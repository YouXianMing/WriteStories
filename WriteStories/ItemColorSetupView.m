//
//  ItemColorSetupView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/17.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ItemColorSetupView.h"
#import "ColorsManager.h"
#import "ItemColorSetupViewCell.h"

@interface ItemColorSetupView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray <ColorsModel *> *models;

@property (nonatomic, strong) UICollectionView           *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic) NSInteger selectedIndex;

@end

@implementation ItemColorSetupView

- (void)buildSubViews {

    // 数据
    self.models = ColorsManager.colorModels;
    
    // 查询选中颜色
    [self.models enumerateObjectsUsingBlock:^(ColorsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj.hexString.uppercaseString isEqualToString:[self.inputValues.firstObject uppercaseString]]) {
            
            self.selectedIndex = idx;
            obj.selected       = YES;
            *stop              = YES;
        }
    }];
    
    // 布局
    CGFloat gap     = 2.f;
    CGFloat vtCount = 4.f;
    CGFloat hrCount = 5.f;
    self.layout     = [UICollectionViewFlowLayout new];
    self.layout.minimumLineSpacing      = gap;
    self.layout.minimumInteritemSpacing = 0.f;
    self.layout.itemSize                = CGSizeMake((self.width - (vtCount + 1) * gap) / vtCount, (self.height - (hrCount + 1) * gap) / hrCount);
    
    // collectionView
    self.collectionView                 = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
    self.collectionView.delegate        = self;
    self.collectionView.dataSource      = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.contentInset    = UIEdgeInsetsMake(gap, gap, gap, gap);
    [self addSubview:self.collectionView];
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    // 注册cell
    [ItemColorSetupViewCell registerToCollectionView:self.collectionView];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionCenteredVertically
                                        animated:NO];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.models.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseCustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ItemColorSetupViewCell" forIndexPath:indexPath];
    cell.data                      = self.models[indexPath.row];
    cell.indexPath                 = indexPath;
    [cell loadContent];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.selectedIndex == indexPath.row) {
        
        return;
    }
    
    NSInteger newSelectedIndex               = indexPath.row;
    self.models[newSelectedIndex].selected   = YES;
    self.models[self.selectedIndex].selected = NO;
    self.selectedIndex                       = newSelectedIndex;
    [self.collectionView reloadData];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemSetupView:updateValues:)]) {
        
        [self.delegate itemSetupView:self updateValues:@[self.models[newSelectedIndex].hexString]];
    }
    
    NSLog(@"%@", self.models[newSelectedIndex].hexString);
}

@end
