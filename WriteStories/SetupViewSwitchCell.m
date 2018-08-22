//
//  SetupViewSwitchCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/1.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "SetupViewSwitchCell.h"
#import "UIView+SetRect.h"
#import "UIColor+Project.h"
#import "UIFont+Project.h"
#import "HexColors.h"
#import "SetupViewSwitchCellModel.h"

@interface SetupViewSwitchCell ()

@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UILabel  *subTitleLabel;
@property (nonatomic, strong) UISwitch *switchButton;

@end

@implementation SetupViewSwitchCell

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
}

- (void)buildSubview {
    
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 59.5f, Width, 0.5f)];
    line.backgroundColor = [UIColor.LineColor colorWithAlphaComponent:0.5];
    [self.contentView addSubview:line];
    
    self.titleLabel           = [UILabel new];
    self.titleLabel.font      = [UIFont PingFangSC_Regular_WithFontSize:20.f];
    self.titleLabel.textColor = UIColor.blackColor;
    [self.contentView addSubview:self.titleLabel];
    
    self.subTitleLabel           = [UILabel new];
    self.subTitleLabel.font      = [UIFont PingFangSC_Thin_WithFontSize:10.f];
    self.subTitleLabel.textColor = [UIColor colorWithHexString:@"#6e6e6e"];
    [self.contentView addSubview:self.subTitleLabel];
    
    self.switchButton             = [UISwitch new];
    self.switchButton.right       = Width - 15.f;
    self.switchButton.centerY     = 30.f;
    self.switchButton.onTintColor = [UIColor colorWithHexString:@"38a1dd"];
    [self.switchButton addTarget:self action:@selector(switchsEvent:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.switchButton];
}

- (void)switchsEvent:(UISwitch *)uiSwitch {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        
        [self.delegate customCell:self event:@(uiSwitch.on)];
    }
}

- (void)loadContent {
    
    SetupViewSwitchCellModel *model = self.dataAdapter.data;
    
    self.titleLabel.text = model.title;
    [self.titleLabel sizeToFit];
    
    self.titleLabel.left = 15.f;
    self.titleLabel.top  = 8.f;
    
    self.subTitleLabel.text = model.subTitle;
    [self.subTitleLabel sizeToFit];
    
    self.subTitleLabel.left   = 15.f;
    self.subTitleLabel.bottom = 60.f - 8.f;
    
    self.switchButton.on      = model.switchOn;
    self.switchButton.enabled = model.switchEnable;
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    return 60.f;
}

@end
