//
//  ItemsHeader.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/17.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ItemsHeader.h"

@implementation ItemsHeader

- (instancetype)init {
    
    if (self = [super init]) {
    
        self.editors = [NSMutableArray array];
    }
    
    return self;
}

+ (instancetype)headerWithTitle:(NSString *)title {
    
    ItemsHeader *header = [ItemsHeader new];
    header.title        = title;
    
    return header;
}

@end
