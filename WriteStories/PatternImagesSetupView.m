//
//  PatternImagesSetupView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/13.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "PatternImagesSetupView.h"
#import "PatternImagesSetupViewCell.h"
#import "FoldersManager.h"
#import "PatternImageModel.h"

@interface PatternImagesSetupView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray <PatternImageModel *> *models;
@property (nonatomic, strong) UICollectionView                     *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout           *layout;

@property (nonatomic) NSInteger selectedIndex;

@end

@implementation PatternImagesSetupView

- (void)buildSubViews {
    
    // 初始值
    NSString *selectedImage = self.inputValues.firstObject;
    
    // 数据源
    self.models = [NSMutableArray array];
    [FoldersManager.PatternImagesArray enumerateObjectsUsingBlock:^(NSString * imageName, NSUInteger idx, BOOL * _Nonnull stop) {
        
        PatternImageModel *model = [PatternImageModel new];
        model.patternImageName   = imageName;
        [self.models addObject:model];
        
        if ([imageName isEqualToString:selectedImage]) {
            
            model.selected     = YES;
            self.selectedIndex = idx;
            
        } else {
            
            model.selected = NO;
        }
    }];
    
    // 布局
    CGFloat gap     = 2.f;
    CGFloat vtCount = 3.f;
    CGFloat hrCount = 3.f;
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
    [PatternImagesSetupViewCell registerToCollectionView:self.collectionView];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionCenteredVertically
                                        animated:NO];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.models.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseCustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PatternImagesSetupViewCell" forIndexPath:indexPath];
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
        
        [self.delegate itemSetupView:self updateValues:@[self.models[newSelectedIndex].patternImageName]];
    }
    
    NSLog(@"%@", self.models[newSelectedIndex].patternImageName);
}

@end
