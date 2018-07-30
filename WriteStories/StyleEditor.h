//
//  ItemEditor.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/17.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StyleEditor : NSObject

#pragma mark - 用于cell显示的属性

@property (nonatomic)         BOOL      selected;  // 是否被选中
@property (nonatomic, strong) NSString *cellTitle; // 标题

#pragma mark - 设置值用的属性

@property (nonatomic)         Class    setupViewClass;    // 设置view的class

@property (nonatomic, strong) NSArray <NSString *> *keys; // 设置的键值
@property (nonatomic, strong) id       extraInfo;         // 额外配置信息

@property (nonatomic, strong) NSArray *pickerViewValuesRanges;      // 设置的键值对应的取值范围
@property (nonatomic, strong) NSArray *pickerViewValuesShowStrings; // 设置的键值对应的取值范围的字符串显示
@property (nonatomic, strong) NSArray *pickerViewTitles;            // pickView用的标题数组

/**
 从object中,根据keys来获取值

 @param object 被设置的object
 @return object对应的key的值
 */
- (NSArray *)valuesWithObject:(NSObject *)object;

/**
 用values给object设置值

 @param object 被设置的object
 @param values 设置的值
 */
- (void)setObject:(NSObject *)object values:(NSArray *)values;

@end
