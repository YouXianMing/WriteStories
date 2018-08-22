//
//  StyleManagerEditView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/17.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "StyleManagerEditView.h"
#import "StyleManagerEditViewCell.h"
#import "Table_Style_List.h"
#import "StyleSaveView.h"
#import "DeviceInfo.h"

@interface StyleManagerEditView () <UICollectionViewDelegate, UICollectionViewDataSource, CustomCollectionCellDelegate>

@property (nonatomic, strong) UIView      *contentView;
@property (nonatomic, strong) UIImageView *noDataImageView;

@property (nonatomic, strong) UICollectionViewFlowLayout         *flowLayout;
@property (nonatomic, strong) UICollectionView                   *collectionView;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

@end

@implementation StyleManagerEditView

- (void)buildTitle {
    
    self.iconImageView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"styleManager"]];
    self.iconImageView.center = CGPointMake(25.f, 45 / 2.f);
    [self.areaView addSubview:self.iconImageView];
    
    self.label           = [[UILabel alloc] initWithFrame:CGRectMake(48.f, 0, 100, 45.f)];
    self.label.font      = [UIFont PingFangSC_Regular_WithFontSize:17.f];
    self.label.textColor = [UIColor colorWithHexString:@"#7e7e7e"];
    self.label.text      = @"样式管理";
    [self.areaView addSubview:self.label];
}

- (void)buildSubViews {
    
    [self buildTitle];
    
    CGFloat bottomSafeHeight = 0;
    if (DeviceInfo.isFringeScreen) {
        
        bottomSafeHeight += DeviceInfo.fringeScreenBottomSafeHeight;
    }
    
    // 容器view
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 45.f, Width, self.areaView.height - 45.f)];
    [self.areaView addSubview:self.contentView];
    
    // 布局
    CGFloat gap              = 10.f;
    CGFloat itemHeight       = (self.contentView.height - bottomSafeHeight - gap * 3.f) / 2.f;
    CGFloat itemWidth        = (self.width - gap * 3.f) / 2.f;
    self.flowLayout                         = [UICollectionViewFlowLayout new];
    self.flowLayout.itemSize                = CGSizeMake(itemWidth, itemHeight);
    self.flowLayout.minimumLineSpacing      = gap - 3.f;
    self.flowLayout.minimumInteritemSpacing = gap;
    
    self.noDataImageView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"noData"]];
    self.noDataImageView.alpha  = 0.f;
    self.noDataImageView.center = self.contentView.middlePoint;
    [self.contentView addSubview:self.noDataImageView];
    
    // collectionView
    self.collectionView                 = [[UICollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.contentInset    = UIEdgeInsetsMake(gap, gap, gap, gap);
    self.collectionView.delegate        = self;
    self.collectionView.dataSource      = self;
    self.collectionView.alpha           = 0.f;
    [self.contentView addSubview:self.collectionView];
    
    [StyleManagerEditViewCell registerToCollectionView:self.collectionView];
    
    self.adapters = [NSMutableArray array];
    [self.styles enumerateObjectsUsingBlock:^(WriteStoriesBaseItemObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.adapters addObject:[StyleManagerEditViewCell dataAdapterWithData:obj]];
    }];
    
    [self collectionViewReloadData];
}

- (void)collectionViewReloadData {
    
    [UIView animateWithDuration:0.15f animations:^{
        
        self.noDataImageView.alpha = self.adapters.count > 0 ? 0 : 1.f;
        self.collectionView.alpha  = self.adapters.count > 0 ? 1 : 0.f;
    }];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.adapters.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter *adapter = self.adapters[indexPath.row];
    
    BaseCustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:adapter.cellReuseIdentifier forIndexPath:indexPath];
    cell.indexPath                 = indexPath;
    cell.dataAdapter               = adapter;
    cell.data                      = adapter.data;
    cell.delegate                  = self;
    [cell loadContent];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseCustomCollectionCell *cell = (BaseCustomCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell selectedEvent];
}

#pragma mark - BaseCustomCollectionCellDelegate

- (void)customCollectionCell:(BaseCustomCollectionCell *)cell event:(id)event {
    
    NSInteger eventType = [event integerValue];
    
    if (eventType == StyleManagerEditViewCellSelect) {
        
        WriteStoriesBaseItemObject *itemObject = cell.dataAdapter.data;
        if (self.styleDelegate && [self.styleDelegate respondsToSelector:@selector(styleManagerEditView:selectedStyle:)]) {
            
            [self.styleDelegate styleManagerEditView:self selectedStyle:itemObject];
        }
        
    } else if (eventType == StyleManagerEditViewCellDelete) {
        
        [self.collectionView performBatchUpdates:^{

            [Table_Style_List deleteItemObject:cell.dataAdapter.data];
            [self.adapters removeObject:cell.dataAdapter];
            [self.collectionView deleteItemsAtIndexPaths:@[cell.indexPath]];

        } completion:^(BOOL finished) {

            [self.collectionView reloadData];
            [self collectionViewReloadData];
        }];
        
    } else if (eventType == StyleManagerEditViewCellEdit) {
        
        WriteStoriesBaseItemObject *itemObject = cell.dataAdapter.data;
        [StyleSaveView styleSaveViewShowWithText:itemObject.styleName delegate:nil confirmEvent:^(NSString *text) {
            
            itemObject.styleName = text;
            [Table_Style_List updateItemObject:itemObject];
            [self.collectionView reloadData];
        }];
    }
}

@end
