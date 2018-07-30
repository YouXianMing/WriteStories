//
//  BaseItemSetupView.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/17.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StyleEditor.h"
#import "UIView+SetRect.h"
@class BaseItemSetupView;

@protocol BaseItemSetupViewDelegate <NSObject>

- (void)itemSetupView:(BaseItemSetupView *)setupView updateValues:(NSArray *)values;

@end

@interface BaseItemSetupView : UIView

@property (nonatomic, strong) NSArray *inputValues;       // 初始值数组
@property (nonatomic, strong) id       extraInfo;         // 额外配置信息

@property (nonatomic, strong) NSArray *pickerViewValuesRanges;      // pickView各个初始值的取值范围组成的数组(根据需要可以为空)
@property (nonatomic, strong) NSArray *pickerViewValuesShowStrings; // pickView设置的键值对应的取值范围的字符串显示
@property (nonatomic, strong) NSArray *pickerViewTitles;            // pickView用的标题数组

@property (nonatomic, weak) id <BaseItemSetupViewDelegate> delegate;
@property (nonatomic, weak) StyleEditor *editor;

/**
 子类进行重写
 */
- (void)buildSubViews;

@end
