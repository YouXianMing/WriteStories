//
//  BaseWindowMenuView.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/24.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseWindowMenuView;

@protocol MenuViewObject <NSObject>

// @property (nonatomic, strong) NSString *menuViewTitleName;
// @property (nonatomic)         NSInteger menuViewTitleIndex;

- (void)setMenuViewTitleName:(NSString *)titleName;
- (NSString *)menuViewTitleName;

- (void)setMenuViewTitleIndex:(NSInteger)index;
- (NSInteger)menuViewTitleIndex;

@end

@protocol BaseWindowMenuViewDelegate <NSObject>

@optional

- (void)windowMenuViewWillShow:(BaseWindowMenuView *)windowMenuView;
- (void)windowMenuViewDidShow:(BaseWindowMenuView *)windowMenuView;
- (void)windowMenuViewWillHide:(BaseWindowMenuView *)windowMenuView;
- (void)windowMenuViewDidHide:(BaseWindowMenuView *)windowMenuView;
- (void)windowMenuView:(BaseWindowMenuView *)windowMenuView didSelectedIndex:(NSInteger)index selectedData:(id <MenuViewObject>)data;

@end

@interface BaseWindowMenuView : UIView

/**
 代理
 */
@property (nonatomic, weak) id <BaseWindowMenuViewDelegate> delegate;

/**
 携带对象
 */
@property (nonatomic, weak) id weakObject;

/**
 显示的数据
 */
@property (nonatomic, strong) NSArray <id <MenuViewObject>> *datas;

/**
 显示
 */
- (void)show;

/**
 显示
 */
- (void)showAtPoint:(CGPoint)point;

/**
 隐藏
 */
- (void)hide;

#pragma mark - 类属性

/**
 [子类可返回新数值] 是否激活背景取消按钮,默认开启
 */
@property (class, readonly) BOOL    IsEnableBackgroundButton;

/**
 [子类可返回新数值] 显示动画时间,默认值为0.45
 */
@property (class, readonly) CGFloat ShowAnimationTime;

/**
 [子类可返回新数值] 隐藏动画时间,默认值为0.15
 */
@property (class, readonly) CGFloat HideAnimationTime;

#pragma mark - 子类重写的方法

/**
 构建子view
 */
- (void)buildSubViews;

/**
 手动构建的动画,比如POP动画,缓动函数动画
 */
- (void)startManualShowAnimation;

/**
 系统动画,已提供block
 */
- (void)startSystemShowAnimation;

/**
 动画结束时候的回调
 */
- (void)didCompleteShowAnimation;

/**
 手动构建的动画,比如POP动画,缓动函数动画
 */
- (void)startManualHideAnimation;

/**
 系统动画,已提供block
 */
- (void)startSystemHideAnimation;

/**
 动画结束时候的回调
 */
- (void)didCompleteHideAnimation;

#pragma mark - 便利构造器

+ (instancetype)menuViewWithDelegate:(id <BaseWindowMenuViewDelegate>)delegate weakObject:(id)weakObject datas:(NSArray <id <MenuViewObject>> *)datas;
+ (instancetype)menuViewWithDelegate:(id <BaseWindowMenuViewDelegate>)delegate datas:(NSArray <id <MenuViewObject>> *)datas;

@end
