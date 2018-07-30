//
//  Mark_icon_cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/3.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Mark_icon_cell.h"
#import "Mark_icon.h"
#import "NSString+HexUnicode.h"
#import "CAGradientView.h"
#import "CAGradientView+CAGradientViewObject.h"

@interface Mark_icon_cell ()

@property (nonatomic, strong) CAGradientView *gradientView;
@property (nonatomic, strong) UIView  *showContentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *bgLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

@end

@implementation Mark_icon_cell

- (void)setupCell {
    
    [super setupCell];
}

- (void)buildSubview {
    
    [super buildSubview];
    
    self.showContentView               = [[UIView alloc] initWithFrame:self.bounds];
    self.showContentView.clipsToBounds = YES;
    [self.contentView addSubview:self.showContentView];
    
    self.bgLabel = [[UILabel alloc] init];
    [self.showContentView addSubview:self.bgLabel];
    
    self.titleLabel               = [UILabel new];
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.showContentView addSubview:self.titleLabel];
    
    self.subTitleLabel               = [UILabel new];
    self.subTitleLabel.numberOfLines = 1;
    self.subTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.showContentView addSubview:self.subTitleLabel];
    
    self.gradientView = [[CAGradientView alloc] initWithFrame:self.bounds];
    [self.showContentView addSubview:self.gradientView];
}

- (void)loadContent {
    
    [super loadContent];
    
    Mark_icon *data = self.data;
    
    self.gradientView.alpha = data.gradientObjectAlpha.floatValue;
    [self.gradientView configWithObject:data.gradientObject];
    
    self.bgLabel.font      = [UIFont fontWithName:data.iconFontName size:data.iconFontSize.floatValue];
    self.bgLabel.text      = [NSString unicodeWithHexString:data.iconFontUnicode];
    self.bgLabel.textColor = [UIColor colorWithHexString:data.iconColorHex];
    self.bgLabel.alpha     = data.iconOpacity.floatValue;
    [self.bgLabel sizeToFit];
    self.bgLabel.centerX = self.middleX;
    self.bgLabel.top     = 8.f;
    
    self.titleLabel.alpha     = data.titleAlpha.floatValue;
    self.titleLabel.text      = data.title;
    self.titleLabel.font      = [UIFont fontWithName:data.titleFontFamily size:data.titleFontSize.floatValue];
    self.titleLabel.textColor = [UIColor colorWithHexString:data.titleColorHex];
    [self.titleLabel sizeToFit];
    self.titleLabel.width   = self.width - 20.f;
    self.titleLabel.centerX = self.middleX;
    self.titleLabel.top     = self.bgLabel.bottom + 8.f;
    
    self.subTitleLabel.alpha     = data.subTitleAlpha.floatValue;
    self.subTitleLabel.text      = data.subTitle;
    self.subTitleLabel.font      = [UIFont fontWithName:data.subTitleFontFamily size:data.subTitleFontSize.floatValue];
    self.subTitleLabel.textColor = [UIColor colorWithHexString:data.subTitleColorHex];
    [self.subTitleLabel sizeToFit];
    self.subTitleLabel.width   = self.width - 20.f;
    self.subTitleLabel.centerX = self.middleX;
    self.subTitleLabel.top     = self.titleLabel.bottom + 8.f;
}

@end
