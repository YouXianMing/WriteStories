//
//  JavaScriptModel.m
//  LoadHTMLdemo
//
//  Created by YouXianMing on 2018/3/5.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "JavaScriptModel.h"

static NSDictionary *_string_function = nil;
static NSDictionary *_function_string = nil;

@interface JavaScriptModel ()

@property (nonatomic) JavaScriptModelFunction       function;
@property (nonatomic, strong) NSArray <NSString *> *parameters;

@end

@implementation JavaScriptModel

+ (void)initialize {
    
    if (self == [JavaScriptModel class]) {
        
        _function_string = @{@(Function_IsShowDebugFrame)  : @"APP_CALL_THIS_isShowDebugFrame",
                             @(Function_SetShowDebugFrame) : @"APP_CALL_THIS_setShowDebugFrame",
                             @(Function_GetDivInfoById)    : @"APP_CALL_THIS_getDivInfoById",
                             @(Function_SetDivInfoById)    : @"APP_CALL_THIS_setDivInfoById",
                             @(Function_SetBodyInfo)       : @"APP_CALL_THIS_setBodyInfo"};
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [_function_string enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            dic[obj] = key;
        }];
        
        _string_function = [NSDictionary dictionaryWithDictionary:dic];
    }
}

- (NSString *)js {
    
    NSMutableString *longString = [NSMutableString string];
    [longString appendFormat:@"%@(", _function_string[@(self.function)]];
    
    [self.parameters enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx == self.parameters.count - 1) {
            
            [longString appendFormat:@"%@", str];
            
        } else {
            
            [longString appendFormat:@"%@, ", str];
        }
    }];
    
    [longString appendString:@")"];
    
    return longString;
}

+ (NSString *)stringByModelFunction:(JavaScriptModelFunction)function {
    
    return _function_string[@(function)];
}

+ (JavaScriptModelFunction)modelFunctionByString:(NSString *)string {
    
    return [_string_function[string] integerValue];
}

@end

@implementation WKWebView (JavaScriptModel)

- (void)showDebugFrame:(BOOL)show completion:(void (^)(NSError *error))completion {
    
    JavaScriptModel *model = [JavaScriptModel new];
    model.function         = Function_SetShowDebugFrame;
    model.parameters       = @[[NSString stringWithFormat:@"%@", show ? @"true" : @"false"]];
    
    [self evaluateJavaScript:model.js completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        
        if (completion) {
            
            completion(error);
        }
    }];
}

- (void)isShowDebugFrame {
    
    JavaScriptModel *model = [JavaScriptModel new];
    model.function         = Function_IsShowDebugFrame;
    model.parameters       = @[];
    
    [self evaluateJavaScript:model.js completionHandler:nil];
}

- (void)getDivInfoById:(NSString *)elementId completion:(void (^)(NSError *error))completion {
    
    JavaScriptModel *model = [JavaScriptModel new];
    model.function         = Function_GetDivInfoById;
    model.parameters       = @[[NSString stringWithFormat:@"'%@'", elementId]];
    
    [self evaluateJavaScript:model.js completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        
        if (completion) {
            
            completion(error);
        }
    }];
}

- (void)setDivInfoById:(NSString *)elementId json:(NSString *)json completion:(void (^)(NSError *error))completion {
    
    JavaScriptModel *model = [JavaScriptModel new];
    model.function         = Function_SetDivInfoById;
    model.parameters       = @[[NSString stringWithFormat:@"'%@'", elementId],
                               [NSString stringWithFormat:@"'%@'", json]];
    
    [self evaluateJavaScript:model.js completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        
        if (completion) {
            
            completion(error);
        }
    }];
}

- (void)setBodyInfoWithJson:(NSString *)json completion:(void (^)(NSError *error))completion {
    
    JavaScriptModel *model = [JavaScriptModel new];
    model.function         = Function_SetBodyInfo;
    model.parameters       = @[[NSString stringWithFormat:@"'%@'", json]];
    
    [self evaluateJavaScript:model.js completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        
        if (completion) {
            
            completion(error);
        }
    }];
}

@end
