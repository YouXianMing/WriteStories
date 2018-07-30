//
//  Mark_time_cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/3.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Mark_time_cell.h"
#import "Mark_time.h"
#import "NSString+HexUnicode.h"

@interface Mark_time_cell ()

@property (nonatomic, strong) UIView  *showContentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *bgLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation Mark_time_cell

- (void)setupCell {
    
    [super setupCell];
}

- (void)buildSubview {
    
    [super buildSubview];
    
    self.showContentView               = [[UIView alloc] initWithFrame:self.bounds];
    self.showContentView.clipsToBounds = YES;
    [self.contentView addSubview:self.showContentView];
    
    self.bgLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.height, self.height)];
    self.bgLabel.textAlignment = NSTextAlignmentCenter;
    [self.showContentView addSubview:self.bgLabel];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5f, self.height)];
    [self.showContentView addSubview:self.lineView];
    
    self.titleLabel               = [UILabel new];
    self.titleLabel.numberOfLines = 1;
    [self.showContentView addSubview:self.titleLabel];
    
    self.subTitleLabel               = [UILabel new];
    self.subTitleLabel.numberOfLines = 1;
    [self.showContentView addSubview:self.subTitleLabel];
    
    self.timeLabel               = [UILabel new];
    self.timeLabel.numberOfLines = 1;
    [self.showContentView addSubview:self.timeLabel];
}

- (void)loadContent {
    
    [super loadContent];
    
    Mark_time *data = self.data;
    
    self.bgLabel.font      = [UIFont fontWithName:data.iconFontName size:data.iconFontSize.floatValue];
    self.bgLabel.text      = [NSString unicodeWithHexString:data.iconFontUnicode];
    self.bgLabel.textColor = [UIColor colorWithHexString:data.iconColorHex];
    self.bgLabel.alpha     = data.iconOpacity.floatValue;
    
    self.lineView.alpha           = data.lineAlpha.floatValue;
    self.lineView.backgroundColor = [UIColor colorWithHexString:data.lineColorHex];
    
    self.titleLabel.alpha     = data.titleAlpha.floatValue;
    self.titleLabel.text      = data.title;
    self.titleLabel.font      = [UIFont fontWithName:data.titleFontFamily size:data.titleFontSize.floatValue];
    self.titleLabel.textColor = [UIColor colorWithHexString:data.titleColorHex];
    [self.titleLabel sizeToFit];
    self.titleLabel.width = self.width - self.height - 20.f;
    
    self.subTitleLabel.alpha     = data.subTitleAlpha.floatValue;
    self.subTitleLabel.text      = data.subTitle;
    self.subTitleLabel.font      = [UIFont fontWithName:data.subTitleFontFamily size:data.subTitleFontSize.floatValue];
    self.subTitleLabel.textColor = [UIColor colorWithHexString:data.subTitleColorHex];
    [self.subTitleLabel sizeToFit];
    self.subTitleLabel.width = self.width - self.height - 20.f;
    
    self.timeLabel.alpha     = data.timeAlpha.floatValue;
    self.timeLabel.text      = data.time;
    self.timeLabel.font      = [UIFont fontWithName:data.timeFontFamily size:data.timeFontSize.floatValue];
    self.timeLabel.textColor = [UIColor colorWithHexString:data.timeColorHex];
    [self.timeLabel sizeToFit];
    self.timeLabel.width = self.width - self.height - 20.f;
    
    if (data.styleType.integerValue == 1) {
        
        self.bgLabel.left  = 0.f;
        self.lineView.left = self.height;
        
        self.titleLabel.top           = 10.f;
        self.titleLabel.left          = self.bgLabel.right + 10.f;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.timeLabel.bottom        = self.height - 10.f;
        self.timeLabel.left          = self.bgLabel.right + 10.f;
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        
        self.subTitleLabel.bottom        = self.timeLabel.top - 8.f;
        self.subTitleLabel.left          = self.bgLabel.right + 10.f;
        self.subTitleLabel.textAlignment = NSTextAlignmentLeft;
        
    } else if (data.styleType.integerValue == 2) {
        
        self.bgLabel.left  = 0.f;
        self.lineView.left = self.height;
        
        self.titleLabel.top           = 10.f;
        self.titleLabel.left          = self.bgLabel.right + 10.f;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        
        self.timeLabel.bottom        = self.height - 10.f;
        self.timeLabel.left          = self.bgLabel.right + 10.f;
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        
        self.subTitleLabel.bottom        = self.timeLabel.top - 8.f;
        self.subTitleLabel.left          = self.bgLabel.right + 10.f;
        self.subTitleLabel.textAlignment = NSTextAlignmentRight;
        
    } else if (data.styleType.integerValue == 3) {
        
        self.bgLabel.left  = 0.f;
        self.lineView.left = self.height;
        
        self.titleLabel.top           = 10.f;
        self.titleLabel.left          = self.bgLabel.right + 10.f;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.subTitleLabel.bottom        = self.height - 10.f;
        self.subTitleLabel.left          = self.bgLabel.right + 10.f;
        self.subTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.timeLabel.bottom        = self.subTitleLabel.top - 8.f;
        self.timeLabel.left          = self.bgLabel.right + 10.f;
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        
    } else if (data.styleType.integerValue == 4) {
        
        self.bgLabel.left  = 0.f;
        self.lineView.left = self.height;
        
        self.titleLabel.top           = 10.f;
        self.titleLabel.left          = self.bgLabel.right + 10.f;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        
        self.subTitleLabel.bottom        = self.height - 10.f;
        self.subTitleLabel.left          = self.bgLabel.right + 10.f;
        self.subTitleLabel.textAlignment = NSTextAlignmentRight;
        
        self.timeLabel.bottom        = self.subTitleLabel.top - 8.f;
        self.timeLabel.left          = self.bgLabel.right + 10.f;
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        
    } else if (data.styleType.integerValue == 5) {
        
        self.bgLabel.left  = 0.f;
        self.lineView.left = self.height;
        
        self.timeLabel.top           = 8;
        self.timeLabel.right         = self.width - 8;
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        
        self.subTitleLabel.bottom        = self.height - 8.f;
        self.subTitleLabel.left          = self.bgLabel.right + 10.f;
        self.subTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.titleLabel.bottom        = self.subTitleLabel.top - 8.f;
        self.titleLabel.left          = self.bgLabel.right + 10.f;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        
    } else if (data.styleType.integerValue == 6) {
        
        self.bgLabel.left  = 0.f;
        self.lineView.left = self.height;
        
        self.timeLabel.top           = 8;
        self.timeLabel.right         = self.width - 8;
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        
        self.subTitleLabel.bottom        = self.height - 8.f;
        self.subTitleLabel.left          = self.bgLabel.right + 10.f;
        self.subTitleLabel.textAlignment = NSTextAlignmentRight;
        
        self.titleLabel.bottom        = self.subTitleLabel.top - 8.f;
        self.titleLabel.left          = self.bgLabel.right + 10.f;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        
    } else if (data.styleType.integerValue == 7) {
        
        self.bgLabel.right  = self.width;
        self.lineView.right = self.bgLabel.left;
        
        self.titleLabel.top           = 10.f;
        self.titleLabel.left          = 10.f;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.timeLabel.bottom        = self.height - 10.f;
        self.timeLabel.left          = 10.f;
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        
        self.subTitleLabel.bottom        = self.timeLabel.top - 8.f;
        self.subTitleLabel.left          = 10.f;
        self.subTitleLabel.textAlignment = NSTextAlignmentLeft;
        
    } else if (data.styleType.integerValue == 8) {
        
        self.bgLabel.right  = self.width;
        self.lineView.right = self.bgLabel.left;
        
        self.titleLabel.top           = 10.f;
        self.titleLabel.left          = 10.f;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        
        self.timeLabel.bottom        = self.height - 10.f;
        self.timeLabel.left          = 10.f;
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        
        self.subTitleLabel.bottom        = self.timeLabel.top - 8.f;
        self.subTitleLabel.left          = 10.f;
        self.subTitleLabel.textAlignment = NSTextAlignmentRight;
        
    } else if (data.styleType.integerValue == 9) {
        
        self.bgLabel.right  = self.width;
        self.lineView.right = self.bgLabel.left;
        
        self.titleLabel.top           = 10.f;
        self.titleLabel.left          = 10.f;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.subTitleLabel.bottom        = self.height - 10.f;
        self.subTitleLabel.left          = 10.f;
        self.subTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.timeLabel.bottom        = self.subTitleLabel.top - 8.f;
        self.timeLabel.left          = 10.f;
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        
    } else if (data.styleType.integerValue == 10) {
        
        self.bgLabel.right  = self.width;
        self.lineView.right = self.bgLabel.left;
        
        self.titleLabel.top           = 10.f;
        self.titleLabel.left          = 10.f;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        
        self.subTitleLabel.bottom        = self.height - 10.f;
        self.subTitleLabel.left          = 10.f;
        self.subTitleLabel.textAlignment = NSTextAlignmentRight;
        
        self.timeLabel.bottom        = self.subTitleLabel.top - 8.f;
        self.timeLabel.left          = 10.f;
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        
    } else if (data.styleType.integerValue == 11) {
        
        self.bgLabel.right  = self.width;
        self.lineView.right = self.bgLabel.left;
        
        self.timeLabel.top           = 8;
        self.timeLabel.left          = 8;
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        
        self.subTitleLabel.bottom        = self.height - 8.f;
        self.subTitleLabel.left          = 10.f;
        self.subTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.titleLabel.bottom        = self.subTitleLabel.top - 8.f;
        self.titleLabel.left          = 10.f;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        
    } else if (data.styleType.integerValue == 12) {
        
        self.bgLabel.right  = self.width;
        self.lineView.right = self.bgLabel.left;
        
        self.timeLabel.top           = 8;
        self.timeLabel.left          = 8;
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        
        self.subTitleLabel.bottom        = self.height - 8.f;
        self.subTitleLabel.left          = 10.f;
        self.subTitleLabel.textAlignment = NSTextAlignmentRight;
        
        self.titleLabel.bottom        = self.subTitleLabel.top - 8.f;
        self.titleLabel.left          = 10.f;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        
    }
}

@end
