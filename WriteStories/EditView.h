//
//  EditView.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/16.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemsStyleEditManager.h"
#import "UIView+SetRect.h"
#import "UIFont+Project.h"
#import "UIColor+Project.h"
#import "HexColors.h"
@class EditView;

@protocol EditViewDelegate <NSObject>

- (void)editViewDidUpdateValues:(EditView *)editView;
- (void)editViewButtonEvent:(EditView *)editView;
- (void)editViewWillShow:(EditView *)editView;
- (void)editViewDidShow:(EditView *)editView;
- (void)editViewWillHide:(EditView *)editView;
- (void)editViewDidHide:(EditView *)editView;

@end

@interface EditView : UIView

@property (nonatomic, strong) ItemsStyleEditManager *editManager;

/**
 区间view
 */
@property (nonatomic, strong) UIView *areaView;

/**
 代理
 */
@property (nonatomic, weak) id <EditViewDelegate> delegate;

/**
 隐藏样式存储按钮
 */
@property (nonatomic) BOOL hideManagerSavedButton;

/**
 [子类重写] 构建subViews
 */
- (void)buildSubViews;

/**
 显示
 */
- (void)showInContentView:(UIView *)contentView;

/**
 隐藏
 */
- (void)hide;

@property (nonatomic, strong) UILabel     *label;
@property (nonatomic, strong) UIImageView *iconImageView;

@end
