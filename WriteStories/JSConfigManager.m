//
//  JSConfigManager.m
//  FamousQuotes
//
//  Created by YouXianMing on 2018/3/29.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "JSConfigManager.h"

@implementation JSConfigManager

- (instancetype)init {
    
    if (self = [super init]) {
    
        self.subs = [NSMutableArray array];
    }
    
    return self;
}

+ (instancetype)managerWithClassName:(NSString *)className style:(NSString *)style {
    
    JSConfigManager *manager = [JSConfigManager new];
    manager.className        = className;
    manager.style            = style;
    
    return manager;
}

- (NSDictionary *)config {
    
    NSMutableDictionary *configDic = [NSMutableDictionary dictionary];
    [self.subs enumerateObjectsUsingBlock:^(JSConfig *config, NSUInteger idx, BOOL * _Nonnull stop) {
        
        configDic[config.tagName] = @{@"style" : config.style,
                                      @"tag"   : config.tagName,
                                      @"class" : config.classList};
    }];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"class"]            = self.className;
    dic[@"style"]            = self.style;
    dic[@"sub"]              = configDic;
    
    return dic;
}

@end
