//
//  BaseArticleEditCell.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/25.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "CustomCell.h"
#import "UIView+SetRect.h"
#import "UIColor+Project.h"
#import "UIFont+Project.h"
#import "HexColors.h"
#import "TapAlphaButton.h"
#import "EdgeInsetsLabel.h"
#import "ArticleEditObjectProtocol.h"
#import "NSString+LabelWidthAndHeight.h"

typedef enum : NSUInteger {
    
    BaseArticleEditCellAdapterTypeDelete = 2000,
    BaseArticleEditCellAdapterTypeEdit,
    
} BaseArticleEditCellAdapterType;

typedef enum : NSUInteger {
    
    BaseArticleEditCellEventDelete = 1000,
    BaseArticleEditCellEventEdit,
    
} BaseArticleEditCellEvent;

@interface BaseArticleEditCell : CustomCell

@property (class, readonly) CGFloat rightViewWidth;

@property (nonatomic, strong) EdgeInsetsLabel *edgeLabel;
@property (nonatomic, strong) TapAlphaButton  *deleteButton;
@property (nonatomic, strong) UIView          *rightView;

@property (nonatomic, strong) UIView *areaView; // 子类添加内容用

@end
