//
//  BackgroundStyle_ElegantStyle_Cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/22.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BackgroundStyle_ElegantStyle_Cell.h"
#import "Math.h"
#import "PatternImageView.h"
#import "HexColors.h"
#import "UIView+SetRect.h"
#import "PatternImageView.h"

@interface BackgroundStyle_ElegantStyle_Cell ()

@property (nonatomic, strong) PatternImageView *imageView;

@end

@implementation BackgroundStyle_ElegantStyle_Cell

- (void)buildSubview {
    
    [super buildSubview];
    
    self.imageView = [[PatternImageView alloc] initWithFrame:self.bounds];
    [self.areaView addSubview:self.imageView];
    
    self.imageView.imageName = @"1_052.gif";
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(0, 0, 0, 0))];
    imageView.image = [UIImage imageNamed:@"典雅_cover"];
    [self.areaView addSubview:imageView];
}

@end
