//
//  UIColor+Project.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/24.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "UIColor+Project.h"
#import "HexColors.h"

@implementation UIColor (Project)

+ (UIColor *)BackgroundColor {
    
    return [UIColor colorWithHexString:@"#f7f7f7"];
}

+ (UIColor *)TextMainColor {
    
    return [UIColor colorWithHexString:@"#303030"];
}

+ (UIColor *)LineColor {
    
    return [UIColor colorWithHexString:@"#d8d8d8"];
}

@end
