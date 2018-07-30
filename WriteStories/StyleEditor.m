//
//  ItemEditor.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/17.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "StyleEditor.h"

@implementation StyleEditor

- (NSArray *)valuesWithObject:(NSObject *)object {
    
    NSMutableArray *array = [NSMutableArray array];
    
    [self.keys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [array addObject:[object valueForKeyPath:key]];
    }];
    
    return array;
}

- (void)setObject:(NSObject *)object values:(NSArray *)values {
    
    [self.keys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [object setValue:values[idx] forKeyPath:key];
    }];
}

@end
