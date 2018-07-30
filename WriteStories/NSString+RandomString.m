//
//  NSString+RandomString.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "NSString+RandomString.h"

@implementation NSString (RandomString)

+ (NSString *)UniqueString {
    
    return [[NSProcessInfo processInfo] globallyUniqueString];
}

@end
