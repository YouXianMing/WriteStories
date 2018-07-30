//
//  BackgroundStyle_PatternImage_Cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BackgroundStyle_PatternImage_Cell.h"
#import "PatternImageView.h"

@interface BackgroundStyle_PatternImage_Cell ()

@property (nonatomic, strong) PatternImageView *imageView;

@end

@implementation BackgroundStyle_PatternImage_Cell

- (void)buildSubview {
    
    [super buildSubview];
    
    self.imageView = [[PatternImageView alloc] initWithFrame:self.bounds];
    [self.areaView addSubview:self.imageView];
    
    self.imageView.imageName = @"1_052.gif";
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(0, 0, 0, 0))];
    imageView.image = [UIImage imageNamed:@"平铺图案_cover"];
    [self.areaView addSubview:imageView];
}

@end
