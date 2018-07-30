//
//  ItemsEditManager.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/17.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ItemsStyleEditManager.h"

@implementation ItemsStyleEditManager

- (instancetype)init {
    
    if (self = [super init]) {
    
        self.headers = [NSMutableArray array];
    }
    
    return self;
}

+ (instancetype)managerWithWeakObject:(NSObject *)weakObject {
    
    ItemsStyleEditManager *manager = [ItemsStyleEditManager new];
    manager.weakObject        = weakObject;
    
    return manager;
}

@end
