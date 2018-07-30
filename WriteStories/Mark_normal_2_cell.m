//
//  Mark_normal_2_cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/2.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Mark_normal_2_cell.h"
#import "Mark_normal_2.h"

@interface Mark_normal_2_cell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

@end

@implementation Mark_normal_2_cell

- (void)setupCell {
    
    [super setupCell];
}

- (void)buildSubview {
    
    [super buildSubview];
    
    self.titleLabel               = [UILabel new];
    self.titleLabel.numberOfLines = 1;
    [self.contentView addSubview:self.titleLabel];
    
    self.subTitleLabel               = [UILabel new];
    self.subTitleLabel.numberOfLines = 1;
    [self.contentView addSubview:self.subTitleLabel];
}

- (void)loadContent {
    
    [super loadContent];
    
    Mark_normal_2 *data = self.data;
    
    self.titleLabel.alpha     = data.titleAlpha.floatValue;
    self.titleLabel.text      = data.title;
    self.titleLabel.font      = [UIFont fontWithName:data.titleFontFamily size:data.titleFontSize.floatValue];
    self.titleLabel.textColor = [UIColor colorWithHexString:data.titleColorHex];
    
    self.subTitleLabel.alpha     = data.subTitleAlpha.floatValue;
    self.subTitleLabel.text      = data.subTitle;
    self.subTitleLabel.font      = [UIFont fontWithName:data.subTitleFontFamily size:data.subTitleFontSize.floatValue];
    self.subTitleLabel.textColor = [UIColor colorWithHexString:data.subTitleColorHex];

    [self.titleLabel sizeToFit];
    self.titleLabel.width = self.contentView.width - 20.f;
    
    [self.subTitleLabel sizeToFit];
    self.subTitleLabel.width = self.contentView.width - 20.f;
    
    if (data.styleType.integerValue == 1) {
     
        CGFloat gap = 10.f;
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.centerX       = self.middleX;
        
        self.subTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.subTitleLabel.centerX       = self.middleX;
        
        CGFloat px = (self.contentView.height - gap - self.titleLabel.height - self.subTitleLabel.height) / 2.f;
        self.titleLabel.top       = px;
        self.subTitleLabel.bottom = self.height - px;
        
    } else if (data.styleType.integerValue == 2) {

        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.left          = 10.f;
        self.titleLabel.top           = 10.f;
        
        self.subTitleLabel.textAlignment = NSTextAlignmentLeft;
        self.subTitleLabel.left          = 10.f;
        self.subTitleLabel.top           = self.titleLabel.bottom + 10.f;
        
    } else if (data.styleType.integerValue == 3) {
        
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.titleLabel.right         = self.width - 10.f;
        self.titleLabel.top           = 10.f;
        
        self.subTitleLabel.textAlignment = NSTextAlignmentRight;
        self.subTitleLabel.right         = self.width - 10.f;
        self.subTitleLabel.top           = self.titleLabel.bottom + 10.f;
        
    } else if (data.styleType.integerValue == 4) {
        
        self.subTitleLabel.textAlignment = NSTextAlignmentLeft;
        self.subTitleLabel.left          = 10.f;
        self.subTitleLabel.bottom        = self.height - 10.f;
        
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.left          = 10.f;
        self.titleLabel.bottom        = self.subTitleLabel.top - 10.f;
        
    } else if (data.styleType.integerValue == 5) {
        
        self.subTitleLabel.textAlignment = NSTextAlignmentRight;
        self.subTitleLabel.right         = self.width - 10.f;
        self.subTitleLabel.bottom        = self.height - 10.f;
        
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.titleLabel.right         = self.width - 10.f;
        self.titleLabel.bottom        = self.subTitleLabel.top - 10.f;
    }
}

@end
