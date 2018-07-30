//
//  JavaScriptModel.h
//  LoadHTMLdemo
//
//  Created by YouXianMing on 2018/3/5.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

typedef enum : NSUInteger {
    
    // 当前是否显示debugFrame出来,有布尔返回值
    Function_IsShowDebugFrame = 1000,
    
    // 设置是否显示
    Function_SetShowDebugFrame,
    
    // 根据id获取div的配置信息
    Function_GetDivInfoById,
    
    // 根据id设置div的配置信息
    Function_SetDivInfoById,
    
    // 设置body的信息
    Function_SetBodyInfo,
    
} JavaScriptModelFunction;

@interface JavaScriptModel : NSObject

+ (NSString *)stringByModelFunction:(JavaScriptModelFunction)function;
+ (JavaScriptModelFunction)modelFunctionByString:(NSString *)string;

@end

@interface WKWebView (JavaScriptModel)

/**
 APP_CALL_THIS_setShowDebugFrame 设置是否显示debug框框
 
 @param show Yes or No.
 @param completion 回调.
 */
- (void)showDebugFrame:(BOOL)show completion:(void (^)(NSError *error))completion;

/**
 Function_IsShowDebugFrame 是否显示debug框
 */
- (void)isShowDebugFrame;

/**
 Function_GetDivInfoById 根据元素id获取div的配置信息

 @param elementId 元素id
 @param completion 回调
 */
- (void)getDivInfoById:(NSString *)elementId completion:(void (^)(NSError *error))completion;

/**
 Function_SetDivInfoById 根据元素id设置div的配置信息

 @param elementId elementId 元素id
 @param json json配置字符串
 @param completion 回调
 */
- (void)setDivInfoById:(NSString *)elementId json:(NSString *)json completion:(void (^)(NSError *error))completion;

/**
 Function_SetBodyInfo 设置body的信息

 @param json json配置字符串
 @param completion 回调
 */
- (void)setBodyInfoWithJson:(NSString *)json completion:(void (^)(NSError *error))completion;

@end
