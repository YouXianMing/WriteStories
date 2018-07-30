//
//  Values.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/15.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Values.h"
#import "NSData+CommonCrypto.h"

static NSDictionary *_TextAlign      = nil;
static NSDictionary *_DecorationLine = nil;
static NSDictionary *_Italic         = nil;
static NSDictionary *_BolderStyle    = nil;

static NSDictionary *_FolderType     = nil;
static NSDictionary *_FolderName     = nil;

@implementation Values

+ (NSString *)Noti_RootMenuViewControllerUpdateCountNumber {
    
    return @"Noti_RootMenuViewControllerUpdateCountNumber";
}

+ (NSString *)Noti_FolderListViewControllerUpdateCountNumber {
    
    return @"Noti_FolderListViewControllerUpdateCountNumber";
}

+ (NSString *)Noti_FolderListViewControllerUpdateAllFoldersCountNumber {
    
    return @"Noti_FolderListViewControllerUpdateAllFoldersCountNumber";
}

+ (void)setTextAlign:(NSDictionary *)TextAlign {
    
    _TextAlign = TextAlign;
}

+ (NSDictionary *)TextAlign {
    
    return _TextAlign;
}

+ (void)setDecorationLine:(NSDictionary<NSString *,NSArray *> *)DecorationLine {
    
    _DecorationLine = DecorationLine;
}

+ (NSDictionary<NSString *,NSArray *> *)DecorationLine {
    
    return _DecorationLine;
}

+ (NSDictionary<NSString *,NSArray *> *)Italic {
    
    return _Italic;
}

+ (void)setItalic:(NSDictionary<NSString *,NSArray *> *)Italic {
    
    _Italic = Italic;
}

+ (NSDictionary<NSString *,NSArray *> *)BolderStyle {
    
    return _BolderStyle;
}

+ (void)setBolderStyle:(NSDictionary<NSString *,NSArray *> *)BolderStyle {
    
    _BolderStyle = BolderStyle;
}

+ (void)setFolderType:(NSDictionary<NSString *,NSNumber *> *)FolderType {
    
    _FolderType = FolderType;
}

+ (NSDictionary<NSString *,NSNumber *> *)FolderType {
    
    return _FolderType;
}

+ (void)setFolderName:(NSDictionary<NSNumber *,NSString *> *)FolderName {
    
    _FolderName = FolderName;
}

+ (NSDictionary<NSNumber *,NSString *> *)FolderName {
    
    return _FolderName;
}

+ (NSArray<NSNumber *> *)AlphaValueRanges {
    
    return @[@(0.00), @(0.05), @(0.10), @(0.15), @(0.20), @(0.25), @(0.30), @(0.35), @(0.40), @(0.45), @(0.50),
             @(0.55), @(0.60), @(0.65), @(0.70), @(0.75), @(0.80), @(0.85), @(0.90), @(0.95), @(1.00)];
}

+ (NSArray<NSNumber *> *)ScaleValueRanges {
    
    return @[@(0.50), @(0.55), @(0.60), @(0.65), @(0.70), @(0.75), @(0.80), @(0.85), @(0.90), @(0.95), @(1.00)];
}

+ (NSArray<NSString *> *)AlphaValueRangeStrings {
    
    NSMutableArray *strings = [NSMutableArray array];
    [[self.class AlphaValueRanges] enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [strings addObject:[NSString stringWithFormat:@"%.f%%", obj.floatValue * 100]];
    }];
    
    return strings;
}

+ (NSArray<NSString *> *)ScaleValueRangeStrings {
    
    NSMutableArray *strings = [NSMutableArray array];
    [[self.class ScaleValueRanges] enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [strings addObject:[NSString stringWithFormat:@"%.f%%", obj.floatValue * 100]];
    }];
    
    return strings;
}

+ (NSArray <NSNumber *> *)valuesFrom:(NSInteger)from to:(NSInteger)to {

    NSMutableArray *array = [NSMutableArray array];
    
    for (NSInteger i = from; i <= to; i++) {
        
        [array addObject:@(i)];
    }
    
    return array;
}

+ (NSArray <NSString *> *)stringsFrom:(NSInteger)from to:(NSInteger)to {
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSInteger i = from; i <= to; i++) {
        
        [array addObject:[NSString stringWithFormat:@"%ld", (long)i]];
    }
    
    return array;
}

+ (NSArray <NSString *> *)percentStringsFrom:(NSInteger)from to:(NSInteger)to {
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSInteger i = from; i <= to; i++) {
        
        [array addObject:[NSString stringWithFormat:@"%ld%%", (long)i]];
    }
    
    return array;
}

+ (void)setPreviewMode:(BOOL)PreviewMode {
    
    [NSUserDefaults.standardUserDefaults setBool:PreviewMode forKey:@"PreviewMode"];
}

+ (BOOL)PreviewMode {
    
    return [NSUserDefaults.standardUserDefaults boolForKey:@"PreviewMode"];
}

+ (void)setPasswords:(NSArray<NSNumber *> *)Passwords {
    
    NSMutableString *string = [NSMutableString string];
    
    [Passwords enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (Passwords.count - 1 == idx) {
            
            [string appendFormat:@"%ld", (long)obj.integerValue];
            
        } else {
            
            [string appendFormat:@"%ld_", (long)obj.integerValue];
        }
    }];
    
    if (string.length) {
        
        // 加密
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        data         = [data AES256EncryptedDataUsingKey:@"you.xian.ming" error:nil];
        [NSUserDefaults.standardUserDefaults setObject:data forKey:@"Passwords"];
        
    } else {
        
        [NSUserDefaults.standardUserDefaults setObject:nil forKey:@"Passwords"];
    }
}

+ (NSArray<NSNumber *> *)Passwords {
    
    NSData   *data   = [NSUserDefaults.standardUserDefaults objectForKey:@"Passwords"];
    NSString *string = nil;
    
    if (data) {
        
        // 解密
        data   = [data decryptedAES256DataUsingKey:@"you.xian.ming" error:nil];
        string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    NSMutableArray *numbers = [NSMutableArray array];
    
    if (string.length) {
        
        [[string componentsSeparatedByString:@"_"] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [numbers addObject:@(obj.integerValue)];
        }];
    }
    
    return numbers;
}

@end
