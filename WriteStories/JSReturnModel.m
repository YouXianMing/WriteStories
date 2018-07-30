//
//  JSReturnData.m
//  LoadHTMLdemo
//
//  Created by YouXianMing on 2018/3/5.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "JSReturnModel.h"

@implementation JSReturnModel

+ (instancetype)modelWithBody:(id)body {
    
    JSReturnModel *data = [JSReturnModel new];
    
    data.function   = [JavaScriptModel modelFunctionByString:body[@"function"]];
    data.parameters = body[@"parameters"];
    data.data       = body[@"data"];
    
    return data;
}

@end
