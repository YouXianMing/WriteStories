//
//  JSReturnData.h
//  LoadHTMLdemo
//
//  Created by YouXianMing on 2018/3/5.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JavaScriptModel.h"

@interface JSReturnModel : NSObject

@property (nonatomic) JavaScriptModelFunction  function;
@property (nonatomic, strong) NSArray         *parameters;
@property (nonatomic, strong) id               data;

+ (instancetype)modelWithBody:(id)body;

@end
