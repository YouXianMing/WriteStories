//
//  IconFontPickerSetupView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/30.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "IconFontSetupView.h"
#import "IconFontsManager.h"
#import "IconFontCell.h"

@interface IconFontSetupView () <UICollectionViewDelegate, UICollectionViewDataSource> {
    
    NSInteger _currentSelectedIndex;
}

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) UICollectionViewFlowLayout         *flowlayout;
@property (nonatomic, strong) UICollectionView                   *collectionView;

@end

@implementation IconFontSetupView

- (void)buildSubViews {
    
    self.flowlayout                         = [UICollectionViewFlowLayout new];
    self.flowlayout.minimumLineSpacing      = 0;
    self.flowlayout.minimumInteritemSpacing = 0;
    self.flowlayout.itemSize                = CGSizeMake(self.width / 5.f, self.height / 4.f);
    
    self.collectionView            = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowlayout];
    self.collectionView.delegate   = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.collectionView];
    
    [IconFontCell registerToCollectionView:self.collectionView];

    NSString *unicode = self.inputValues.lastObject;
    
    self.adapters = [NSMutableArray array];
    NSArray <IconFontModel *> *models = [IconFontsManager iconsWithBitMap:
                                         kWeatherIcons | kAwesome5BrandsIcons | kAwesome5FreeRegularIcons | Awesome5FreeSolidIcons];
    
    [models enumerateObjectsUsingBlock:^(IconFontModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([unicode isEqualToString:obj.icon]) {
            
            obj.selected                = YES;
            self->_currentSelectedIndex = idx;
        }
        
        [self.adapters addObject:[IconFontCell dataAdapterWithData:obj]];
    }];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentSelectedIndex inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.adapters.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter *adapter = self.adapters[indexPath.row];
    
    BaseCustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:adapter.cellReuseIdentifier forIndexPath:indexPath];
    cell.dataAdapter               = adapter;
    cell.data                      = adapter.data;
    cell.indexPath                 = indexPath;
    [cell loadContent];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == _currentSelectedIndex) {
        
        return;
    }
    
    IconFontModel *oldModel      = self.adapters[_currentSelectedIndex].data;
    IconFontModel *selectedModel = self.adapters[indexPath.row].data;
    _currentSelectedIndex        = indexPath.row;
    
    oldModel.selected      = NO;
    selectedModel.selected = YES;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemSetupView:updateValues:)]) {
        
        NSLog(@"%@", @[selectedModel.fontName, selectedModel.icon]);
        [self.delegate itemSetupView:self updateValues:@[selectedModel.fontName, selectedModel.icon]];
    }
    
    [collectionView reloadData];
}

@end
