//
//  BaseMarkItemCell.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/19.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseCustomCollectionCell.h"
#import "UIView+SetRect.h"
#import "UIColor+Project.h"
#import "UIFont+Project.h"
#import "FoldersManager.h"
#import "NSString+Path.h"
#import "HexColors.h"

@interface BaseMarkItemCell : BaseCustomCollectionCell

@property (nonatomic, strong) UIView *contentBackgroundView;

@property (nonatomic, strong) NSLock *lock; // 锁

/**
 粒子数据加载专用
 */
- (void)loadCAEmitterCellContent;

@end
