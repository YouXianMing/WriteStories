//
//  BaseHtmlBodyItem.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseHtmlBodyItem.h"

@implementation BaseHtmlBodyItem

- (NSString *)jsConfig {
    
    return nil;
}

- (NSString *)bodyString {
    
    return nil;
}

#pragma mark - Coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {

    }
    
    return self;
}

@end
