//
//  FontCSSCreator.m
//  LoadHTMLdemo
//
//  Created by YouXianMing on 2018/3/10.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "FontCSSCreator.h"
#import "FileManager.h"

@implementation FontCSSCreator

+ (NSString *)creatorWithFontInfo:(NSDictionary <NSString *, NSString *> *)infos {
    
    NSMutableString *string = [NSMutableString string];
        
    [infos enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        
        [string appendString:[FontCSSCreator fontFamily:key fontFileName:obj]];
    }];
    
    return [NSString stringWithString:string];
}

+ (NSString *)fontFamily:(NSString *)fontFamily fontFileName:(NSString *)fontFileName {
    
    return [NSString stringWithFormat:@"\n@font-face {\nfont-family: '%@';\nsrc: url('%@');\n}\n", fontFamily, absoluteFilePathFrom([NSString stringWithFormat:@"-/%@", fontFileName])];
}

@end
