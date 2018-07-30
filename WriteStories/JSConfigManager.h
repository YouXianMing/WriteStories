//
//  JSConfigManager.h
//  FamousQuotes
//
//  Created by YouXianMing on 2018/3/29.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSConfig.h"

@interface JSConfigManager : NSObject

@property (nonatomic, strong) NSString                    *className;
@property (nonatomic, strong) NSString                    *style;
@property (nonatomic, strong) NSMutableArray <JSConfig *> *subs;

+ (instancetype)managerWithClassName:(NSString *)className style:(NSString *)style;

- (NSDictionary *)config;

@end
