//
//  IconFontsManager.h
//  FamousQuotes
//
//  Created by YouXianMing on 2017/12/29.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleSelectedProtocol.h"
@class IconFontModel;

typedef enum : NSUInteger {
    
    kWeatherIcons             = 1 << 1,
    kAwesome5BrandsIcons      = 1 << 2,
    kAwesome5FreeRegularIcons = 1 << 3,
    Awesome5FreeSolidIcons    = 1 << 4,
    
} IconFontsManagerBitMap;

@interface IconFontsManager : NSObject

+ (void)prepare;

+ (NSArray *)weatherIcons;
+ (NSArray *)fontAwesome5BrandsIcons;
+ (NSArray *)fontAwesome5FreeRegularIcons;
+ (NSArray *)fontAwesome5FreeSolidIcons;

+ (NSArray <IconFontModel *> *)iconsWithBitMap:(IconFontsManagerBitMap)bitMap;

@end

@interface IconFontModel : NSObject <SingleSelectedProtocol>

@property (nonatomic, strong) NSString *fontName;
@property (nonatomic, strong) NSString *icon;

+ (instancetype)iconFontModelWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic) BOOL selected;

@end
