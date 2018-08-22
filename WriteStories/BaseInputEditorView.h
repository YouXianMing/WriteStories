//
//  BaseFolderInputEditorView.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/20.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCustomViewController.h"
#import "InputEditor.h"
#import "UIView+SetRect.h"
#import "UIFont+Project.h"
#import "UIColor+Project.h"
#import "HexColors.h"

@interface BaseInputEditorView : UIView

@property (nonatomic, weak)   BaseCustomViewController *controller; // 控制器,子类可能会用上
@property (class, readonly)   CGFloat  titleHeight; // 标题高度,子类用
@property (nonatomic, strong) UILabel *label;       // 标题,子类用来赋值
@property (nonatomic, strong) UIView  *titleView;

#pragma mark - KVC

/*
 * InputEditor由weakObject提供,InputEditor含有weakObject的key,可以从weakObject进行取值,也可以进行值的设置
 */

@property (nonatomic, weak)   id weakObject;           // 被设置的对象
@property (nonatomic, strong) InputEditor *inputEdior; // 设置对象的相关信息

#pragma mark - 用以验证

@property (nonatomic, readonly) BOOL isOK;
@property (nonatomic, readonly) NSString *errorMessage;

- (void)buildSubViews;

- (void)updateViewHeight;

@end
