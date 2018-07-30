//
//  BottomContentView.m
//  FamousQuotes
//
//  Created by YouXianMing on 2018/1/31.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "PointInsideView.h"

@implementation PointInsideView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    __block BOOL inside = NO;
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BOOL contain = CGRectContainsPoint(obj.frame, point);
        if (contain == YES) {
            
            inside = YES;
            *stop  = YES;
        }
    }];
    
    return inside;
}

@end
