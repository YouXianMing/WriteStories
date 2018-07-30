//
//  FontsManager.h
//  FamousQuotes
//
//  Created by YouXianMing on 2018/1/8.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleSelectedProtocol.h"

typedef enum : NSUInteger {
    
    FontInfoObjectRegionSC, // 简体中文
    FontInfoObjectRegionTC, // 繁体中文
    FontInfoObjectRegionEN, // 英文
    
} FontInfoObjectRegion;

@interface FontInfoObject : NSObject <SingleSelectedProtocol>

@property (nonatomic, strong) UIFont              *font;
@property (nonatomic, strong) NSString            *fontDescription;
@property (nonatomic)         BOOL                 selected;
@property (nonatomic)         FontInfoObjectRegion region;

+ (instancetype)fontInfoObjectWithFont:(UIFont *)font fontDescription:(NSString *)fontDescription;
+ (instancetype)fontInfoObjectWithFont:(UIFont *)font fontDescription:(NSString *)fontDescription region:(FontInfoObjectRegion)region;
- (BOOL)containTheFont:(UIFont *)font;

@end

@interface FontsManager : NSObject

+ (void)prepare;
+ (NSArray <FontInfoObject *> *)fontInfos;
+ (FontInfoObject *)fontObjectByFont:(UIFont *)font;

@end
