//
//  PatternImageView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/14.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "PatternImageView.h"
#import "UIView+DrawRect.h"

@implementation PatternImageView

- (void)drawRect:(CGRect)rect {
 
    if (self.imageName.length) {
        
        [self drawImage:[UIImage imageNamed:self.imageName] asPatternInRect:rect];
    }
}

- (void)setImageName:(NSString *)imageName {
    
    _imageName = imageName;
    [self setNeedsDisplay];
}

@end
