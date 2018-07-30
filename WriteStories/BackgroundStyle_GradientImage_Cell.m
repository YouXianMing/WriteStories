//
//  BackgroundStyle_GradientImage_Cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/16.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BackgroundStyle_GradientImage_Cell.h"
#import "Math.h"
#import "PatternImageView.h"
#import "HexColors.h"
#import "UIView+SetRect.h"

@interface BackgroundStyle_GradientImage_Cell ()

@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation BackgroundStyle_GradientImage_Cell

- (void)buildSubview {
    
    [super buildSubview];
    
    UIImage *image = [UIImage imageNamed:@"flower_4_bg.png"];
    CGSize   size  = [Math resetFromSize:image.size withFixedWidth:self.width];
    
    self.bgImageView                 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    self.bgImageView.image           = image;
    self.areaView.backgroundColor    = [UIColor colorWithHexString:@"#faf9fe"];
    [self.areaView addSubview:_bgImageView];
}

@end
