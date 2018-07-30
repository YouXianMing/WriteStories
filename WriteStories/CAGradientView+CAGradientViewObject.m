//
//  CAGradientView+CAGradientViewObject.m
//  GradientView
//
//  Created by YouXianMing on 2018/1/23.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "CAGradientView+CAGradientViewObject.h"
#import "HexColors.h"

@implementation CAGradientView (CAGradientViewObject)

- (void)configWithObject:(CAGradientViewObject *)object {
    
    UIColor *color_1 = [[UIColor colorWithHexString:object.gradientHexColor_1] colorWithAlphaComponent:object.gradientColor_1_alpha.floatValue];
    UIColor *color_2 = [[UIColor colorWithHexString:object.gradientHexColor_2] colorWithAlphaComponent:object.gradientColor_2_alpha.floatValue];
    
    self.colors     = @[color_1, color_2];
    self.locations  = @[object.gradientColor_1_location, object.gradientColor_2_location];
    self.startPoint = [object.startPoint CGPointValue];
    self.endPoint   = [object.endPoint CGPointValue];
}

- (CAGradientViewObject *)configObject {
    
    CAGradientViewObject *object = [CAGradientViewObject new];
    
    NSArray *color_1_info        = [self.colors[0] representValuesInHex];
    object.gradientHexColor_1    = color_1_info[1];
    object.gradientColor_1_alpha = color_1_info[0];
    
    NSArray *color_2_info        = [self.colors[1] representValuesInHex];
    object.gradientHexColor_2    = color_2_info[1];
    object.gradientColor_2_alpha = color_2_info[0];
    
    object.gradientColor_1_location = self.locations[0];
    object.gradientColor_2_location = self.locations[1];
    
    object.startPoint = [NSValue valueWithCGPoint:self.startPoint];
    object.endPoint   = [NSValue valueWithCGPoint:self.endPoint];
    
    return object;
}

@end
