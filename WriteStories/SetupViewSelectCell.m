//
//  SetupViewSelectCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/1.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "SetupViewSelectCell.h"
#import "UIFont+Project.h"
#import "UIColor+Project.h"
#import "UIView+SetRect.h"

@interface SetupViewSelectCell ()

@property (nonatomic, strong) UILabel  *titleLabel;

@end

@implementation SetupViewSelectCell

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
}

- (void)buildSubview {
    
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 54.5f, Width, 0.5f)];
    line.backgroundColor = [UIColor.LineColor colorWithAlphaComponent:0.5f];
    [self.contentView addSubview:line];
    
    self.titleLabel           = [[UILabel alloc] initWithFrame:CGRectMake(15.f, 0, 300.f, 55.f)];
    self.titleLabel.font      = [UIFont PingFangSC_Regular_WithFontSize:20.f];
    self.titleLabel.textColor = UIColor.blackColor;
    [self.contentView addSubview:self.titleLabel];
    
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"choose"]];
    arrow.right        = Width - 15.f;
    arrow.centerY      = 25.f;
    [self.contentView addSubview:arrow];
}

- (void)loadContent {
    
    self.titleLabel.text = self.data;
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    return 55.f;
}

@end
