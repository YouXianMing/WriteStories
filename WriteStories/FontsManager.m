//
//  FontsManager.m
//  FamousQuotes
//
//  Created by YouXianMing on 2018/1/8.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "FontsManager.h"
#import "UIFont+Project.h"

static FontsManager *_manager = nil;

@interface FontsManager ()

@end

@implementation FontsManager

- (instancetype)init {
    
    [NSException raise:@"FontsManager"
                format:@"Cannot instantiate singleton using init method, sharedInstance must be used."];
    
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    
    [NSException raise:@"FontsManager"
                format:@"Cannot copy singleton using copy method, sharedInstance must be used."];
    
    return nil;
}

+ (void)prepare {
    
    if (self != [FontsManager class]) {
        
        [NSException raise:@"FontsManager" format:@"Cannot use sharedInstance method from subclass."];
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _manager = [[FontsManager alloc] initInstance];
    });
}

+ (NSArray <FontInfoObject *> *)fontInfos {
    
    CGFloat fontSize = 15.f;
    
    return @[[FontInfoObject fontInfoObjectWithFont:[UIFont PingFangSC_Ultralight_WithFontSize:fontSize] fontDescription:@"苹方-超细" region:FontInfoObjectRegionSC],
             [FontInfoObject fontInfoObjectWithFont:[UIFont PingFangSC_Thin_WithFontSize:fontSize]       fontDescription:@"苹方-很细" region:FontInfoObjectRegionSC],
             [FontInfoObject fontInfoObjectWithFont:[UIFont PingFangSC_Light_WithFontSize:fontSize]      fontDescription:@"苹方-细"   region:FontInfoObjectRegionSC],
             [FontInfoObject fontInfoObjectWithFont:[UIFont PingFangSC_Regular_WithFontSize:fontSize]    fontDescription:@"苹方-普通" region:FontInfoObjectRegionSC],
             [FontInfoObject fontInfoObjectWithFont:[UIFont PingFangSC_Medium_WithFontSize:fontSize]     fontDescription:@"苹方-中等" region:FontInfoObjectRegionSC],
             [FontInfoObject fontInfoObjectWithFont:[UIFont PingFangSC_Semibold_WithFontSize:fontSize]   fontDescription:@"苹方-加粗" region:FontInfoObjectRegionSC],
             
             [FontInfoObject fontInfoObjectWithFont:[UIFont FZFSJW_WithFontSize:fontSize]                fontDescription:@"方正仿宋"      region:FontInfoObjectRegionSC],
             [FontInfoObject fontInfoObjectWithFont:[UIFont QXyingbikaiWithFontSize:fontSize]            fontDescription:@"硬笔楷书"      region:FontInfoObjectRegionSC],
             [FontInfoObject fontInfoObjectWithFont:[UIFont HappyZcool_KH_WithFontSize:fontSize]         fontDescription:@"站酷酷黑"      region:FontInfoObjectRegionSC],
             [FontInfoObject fontInfoObjectWithFont:[UIFont HappyZcool_2016_WithFontSize:fontSize]       fontDescription:@"站酷快乐体"    region:FontInfoObjectRegionSC],
             [FontInfoObject fontInfoObjectWithFont:[UIFont PangMenZhengDaoWithFontSize:fontSize]        fontDescription:@"庞门正道标题体" region:FontInfoObjectRegionSC],
             
             [FontInfoObject fontInfoObjectWithFont:[UIFont HYHeiZaiTiW_WithFontSize:fontSize]        fontDescription:@"黑仔体"
                                             region:FontInfoObjectRegionSC],
             
             [FontInfoObject fontInfoObjectWithFont:[UIFont AaFangMeng_WithFontSize:fontSize]        fontDescription:@"方萌体"
                                             region:FontInfoObjectRegionSC],
             
             [FontInfoObject fontInfoObjectWithFont:[UIFont LSSST_1498_WithFontSize:fontSize]        fontDescription:@"随手体"
                                             region:FontInfoObjectRegionSC],
             
             [FontInfoObject fontInfoObjectWithFont:[UIFont EN_LatoThinWithFontSize:fontSize]            fontDescription:@"Lato Thin"       region:FontInfoObjectRegionEN],
             [FontInfoObject fontInfoObjectWithFont:[UIFont EN_LatoThinItalicWithFontSize:fontSize]      fontDescription:@"Lato ThinItalic" region:FontInfoObjectRegionEN],
             [FontInfoObject fontInfoObjectWithFont:[UIFont EN_LatoLightWithFontSize:fontSize]           fontDescription:@"Lato Light"      region:FontInfoObjectRegionEN],
             [FontInfoObject fontInfoObjectWithFont:[UIFont EN_LatoRegularWithFontSize:fontSize]         fontDescription:@"Lato Regular"    region:FontInfoObjectRegionEN],
             [FontInfoObject fontInfoObjectWithFont:[UIFont EN_LatoBoldWithFontSize:fontSize]            fontDescription:@"Lato Bold"       region:FontInfoObjectRegionEN],
             
             [FontInfoObject fontInfoObjectWithFont:[UIFont EN_SnellRoundhandWithFontSize:fontSize]          fontDescription:@"Roundhand"       region:FontInfoObjectRegionEN],
             [FontInfoObject fontInfoObjectWithFont:[UIFont EN_SnellRoundhandBoldWithFontSize:fontSize - 2]  fontDescription:@"Roundhand Bold"  region:FontInfoObjectRegionEN],
             [FontInfoObject fontInfoObjectWithFont:[UIFont EN_SnellRoundhandBlackWithFontSize:fontSize - 3] fontDescription:@"Roundhand Black" region:FontInfoObjectRegionEN],
             
             [FontInfoObject fontInfoObjectWithFont:[UIFont EN_GillSansLightWithFontSize:fontSize]          fontDescription:@"GillSans L"       region:FontInfoObjectRegionEN],
             [FontInfoObject fontInfoObjectWithFont:[UIFont EN_GillSansLightItalicWithFontSize:fontSize]    fontDescription:@"GillSans LI"      region:FontInfoObjectRegionEN],
             [FontInfoObject fontInfoObjectWithFont:[UIFont EN_GillSansWithFontSize:fontSize]               fontDescription:@"GillSans"         region:FontInfoObjectRegionEN],
             [FontInfoObject fontInfoObjectWithFont:[UIFont EN_GillSansItalicWithFontSize:fontSize]         fontDescription:@"GillSans I"       region:FontInfoObjectRegionEN],
             [FontInfoObject fontInfoObjectWithFont:[UIFont EN_GillSansSemiBoldWithFontSize:fontSize]       fontDescription:@"GillSans Semi B"  region:FontInfoObjectRegionEN],
             [FontInfoObject fontInfoObjectWithFont:[UIFont EN_GillSansSemiBoldItalicWithFontSize:fontSize] fontDescription:@"GillSans Semi BI" region:FontInfoObjectRegionEN],
             [FontInfoObject fontInfoObjectWithFont:[UIFont EN_GillSansBoldWithFontSize:fontSize]           fontDescription:@"GillSans B"       region:FontInfoObjectRegionEN],
             [FontInfoObject fontInfoObjectWithFont:[UIFont EN_GillSansBoldItalicWithFontSize:fontSize]     fontDescription:@"GillSans BI"      region:FontInfoObjectRegionEN],
             [FontInfoObject fontInfoObjectWithFont:[UIFont EN_GillSansUltraBoldWithFontSize:fontSize - 3]  fontDescription:@"GillSans UltraB"  region:FontInfoObjectRegionEN],
             
             [FontInfoObject fontInfoObjectWithFont:[UIFont EN_GeorgiaWithFontSize:fontSize]            fontDescription:@"Georgia"    region:FontInfoObjectRegionEN],
             [FontInfoObject fontInfoObjectWithFont:[UIFont EN_GeorgiaItalicWithFontSize:fontSize]      fontDescription:@"Georgia I"  region:FontInfoObjectRegionEN],
             [FontInfoObject fontInfoObjectWithFont:[UIFont EN_GeorgiaBoldWithFontSize:fontSize]        fontDescription:@"Georgia B"  region:FontInfoObjectRegionEN],
             [FontInfoObject fontInfoObjectWithFont:[UIFont EN_GeorgiaBoldItalicWithFontSize:fontSize]  fontDescription:@"Georgia BI" region:FontInfoObjectRegionEN],
             ];
}

+ (FontInfoObject *)fontObjectByFont:(UIFont *)font {
    
    __block FontInfoObject *object = nil;
    
    [FontsManager.fontInfos enumerateObjectsUsingBlock:^(FontInfoObject *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj.font.fontName isEqualToString:font.fontName]) {
            
            object = obj;
            *stop  = YES;
        }
    }];
    
    return object;
}

#pragma mark - private method

- (id)initInstance {
    
    return [super init];
}

@end

@implementation FontInfoObject

- (BOOL)containTheFont:(UIFont *)font {
    
    return [self.font.fontName isEqualToString:font.fontName];
}

+ (instancetype)fontInfoObjectWithFont:(UIFont *)font fontDescription:(NSString *)fontDescription; {
    
    FontInfoObject *object = [FontInfoObject new];
    object.font            = font;
    object.fontDescription = fontDescription;
    
    return object;
}

+ (instancetype)fontInfoObjectWithFont:(UIFont *)font fontDescription:(NSString *)fontDescription region:(FontInfoObjectRegion)region {
    
    FontInfoObject *object = [FontInfoObject new];
    object.font            = font;
    object.fontDescription = fontDescription;
    object.region          = region;
    
    return object;
}

@end
