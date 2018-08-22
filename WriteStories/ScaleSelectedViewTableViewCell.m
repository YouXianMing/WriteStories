//
//  ScaleSelectedViewTableViewCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ScaleSelectedViewTableViewCell.h"
#import "EncodeImageObject.h"
#import "UIColor+Project.h"
#import "UIFont+Project.h"
#import "UIView+SetRect.h"

@interface ScaleSelectedViewTableViewCell ()

@property (nonatomic, strong) UILabel *contentlabel;

@end

@implementation ScaleSelectedViewTableViewCell

- (void)buildSubview {
 
    self.contentlabel               = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0, Width - 120.f, 50.f)];
    self.contentlabel.font          = [UIFont EN_LatoThinItalicWithFontSize:20.f];
    self.contentlabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.contentlabel];
    
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5f, Width - 10, 0.5f)];
    line.backgroundColor = UIColor.LineColor;
    [self.contentView addSubview:line];
}

- (void)loadContent {

    EncodeImageObject *object = self.data;
    self.contentlabel.text    = object.scale;
}

@end
