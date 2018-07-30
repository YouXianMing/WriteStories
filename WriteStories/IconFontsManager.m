//
//  IconFontsManager.m
//  FamousQuotes
//
//  Created by YouXianMing on 2017/12/29.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import "IconFontsManager.h"
#import "NSData+JSONData.h"
#import "FileManager.h"
#import "NSString+HexUnicode.h"

static IconFontsManager *_sharedSingleton = nil;

@interface IconFontsManager ()

@property (nonatomic, strong) NSMutableDictionary *dics;

@end

@implementation IconFontsManager

- (instancetype)init {
    
    [NSException raise:@"IconFontsManager"
                format:@"Cannot instantiate singleton using init method, sharedInstance must be used."];
    
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    
    [NSException raise:@"IconFontsManager"
                format:@"Cannot copy singleton using copy method, sharedInstance must be used."];
    
    return nil;
}

+ (void)prepare {
    
    if (self != [IconFontsManager class]) {
        
        [NSException raise:@"IconFontsManager" format:@"Cannot use sharedInstance method from subclass."];
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedSingleton                                    = [[IconFontsManager alloc] initInstance];
        _sharedSingleton.dics                               = [NSMutableDictionary dictionary];
        _sharedSingleton.dics[@"WeatherAndTime"]            = [[NSData dataWithContentsOfFile:absoluteFilePathFrom(@"-/WeatherAndTime.json")] toListProperty];
        _sharedSingleton.dics[@"FontAwesome5BrandsRegular"] = [[NSData dataWithContentsOfFile:absoluteFilePathFrom(@"-/FontAwesome5BrandsRegular.json")] toListProperty];
        _sharedSingleton.dics[@"FontAwesome5FreeRegular"]   = [[NSData dataWithContentsOfFile:absoluteFilePathFrom(@"-/FontAwesome5FreeRegular.json")] toListProperty];
        _sharedSingleton.dics[@"FontAwesome5FreeSolid"]     = [[NSData dataWithContentsOfFile:absoluteFilePathFrom(@"-/FontAwesome5FreeSolid.json")] toListProperty];
    });
}

+ (NSArray *)weatherIcons {
    
    return _sharedSingleton.dics[@"WeatherAndTime"];
}

+ (NSArray *)fontAwesome5BrandsIcons {
    
    return _sharedSingleton.dics[@"FontAwesome5BrandsRegular"];
}

+ (NSArray *)fontAwesome5FreeRegularIcons {
    
    return _sharedSingleton.dics[@"FontAwesome5FreeRegular"];
}

+ (NSArray *)fontAwesome5FreeSolidIcons {
    
    return _sharedSingleton.dics[@"FontAwesome5FreeSolid"];
}

+ (NSArray<IconFontModel *> *)iconsWithBitMap:(IconFontsManagerBitMap)bitMap {
    
    NSMutableArray *array = [NSMutableArray array];
    
    if (bitMap & kWeatherIcons) {
        
        [IconFontsManager.weatherIcons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            IconFontModel *model = [IconFontModel iconFontModelWithDictionary:obj];
            [array addObject:model];
        }];
    }
    
    if (bitMap & kAwesome5BrandsIcons) {
        
        [IconFontsManager.fontAwesome5BrandsIcons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            IconFontModel *model = [IconFontModel iconFontModelWithDictionary:obj];
            [array addObject:model];
        }];
    }
    
    if (bitMap & kAwesome5FreeRegularIcons) {
        
        [IconFontsManager.fontAwesome5FreeRegularIcons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            IconFontModel *model = [IconFontModel iconFontModelWithDictionary:obj];
            [array addObject:model];
        }];
    }
    
    if (bitMap & Awesome5FreeSolidIcons) {
        
        [IconFontsManager.fontAwesome5FreeSolidIcons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            IconFontModel *model = [IconFontModel iconFontModelWithDictionary:obj];
            [array addObject:model];
        }];
    }
    
    return array;
}

#pragma mark - private method

- (id)initInstance {
    
    return [super init];
}

@end

@implementation IconFontModel

+ (instancetype)iconFontModelWithDictionary:(NSDictionary *)dictionary {
    
    IconFontModel *model = [IconFontModel new];
    model.fontName       = dictionary[@"name"];
    model.icon           = dictionary[@"hex"];
    
    return model;
}

@end
