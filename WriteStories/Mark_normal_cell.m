//
//  Mark_normal_cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/19.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Mark_normal_cell.h"
#import "Mark_normal.h"

@interface Mark_normal_cell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation Mark_normal_cell

- (void)setupCell {
    
    [super setupCell];
}

- (void)buildSubview {
    
    [super buildSubview];
    
    self.titleLabel               = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.width - 40.f, self.height)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 2;
    [self.contentView addSubview:self.titleLabel];
}

- (void)loadContent {
    
    [super loadContent];
    
    Mark_normal *data         = self.data;
    self.titleLabel.alpha     = data.titleAlpha.floatValue;
    self.titleLabel.text      = data.title;
    self.titleLabel.font      = [UIFont fontWithName:data.titleFontFamily size:data.titleFontSize.floatValue];
    self.titleLabel.textColor = [UIColor colorWithHexString:data.titleColorHex];
}

@end
