//
//  BaseFolderItemCell.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/15.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseCustomCollectionCell.h"
#import "UIView+SetRect.h"
#import "UIColor+Project.h"
#import "UIFont+Project.h"
#import "FoldersManager.h"
#import "NSString+Path.h"
#import "HexColors.h"

@interface BaseFolderItemCell : BaseCustomCollectionCell

@property (nonatomic, strong) NSLock *lock;              // 锁
@property (nonatomic, strong) UIView *coverContentView;  // 顶部的contentView(会覆盖标题)
@property (nonatomic, strong) UIView *bottomContentView; // 底部的contentView(不会覆盖标题)

/**
 粒子数据加载专用
 */
- (void)loadCAEmitterCellContent;

@end
