//
//  CAGradientViewObject.m
//  GradientView
//
//  Created by YouXianMing on 2018/1/23.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "CAGradientViewObject.h"

@implementation CAGradientViewObject

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:self.gradientHexColor_1 forKey:@"gradientHexColor_1"];
    [aCoder encodeObject:self.gradientHexColor_2 forKey:@"gradientHexColor_2"];
    [aCoder encodeObject:self.gradientColor_1_alpha forKey:@"gradientColor_1_alpha"];
    [aCoder encodeObject:self.gradientColor_2_alpha forKey:@"gradientColor_2_alpha"];
    
    [aCoder encodeObject:self.gradientColor_1_location forKey:@"gradientColor_1_location"];
    [aCoder encodeObject:self.gradientColor_2_location forKey:@"gradientColor_2_location"];
    
    [aCoder encodeObject:self.startPoint forKey:@"startPoint"];
    [aCoder encodeObject:self.endPoint   forKey:@"endPoint"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        self.gradientHexColor_1    = [aDecoder decodeObjectForKey:@"gradientHexColor_1"];
        self.gradientHexColor_2    = [aDecoder decodeObjectForKey:@"gradientHexColor_2"];
        self.gradientColor_1_alpha = [aDecoder decodeObjectForKey:@"gradientColor_1_alpha"];
        self.gradientColor_2_alpha = [aDecoder decodeObjectForKey:@"gradientColor_2_alpha"];
        
        self.gradientColor_1_location = [aDecoder decodeObjectForKey:@"gradientColor_1_location"];
        self.gradientColor_2_location = [aDecoder decodeObjectForKey:@"gradientColor_2_location"];
        
        self.startPoint = [aDecoder decodeObjectForKey:@"startPoint"];
        self.endPoint   = [aDecoder decodeObjectForKey:@"endPoint"];
    }
    
    return self;
}

@end
