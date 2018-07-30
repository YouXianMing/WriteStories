//
//  NumberPickerRowView.m
//  FamousQuotes
//
//  Created by YouXianMing on 2018/3/15.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "NumberPickerRowView.h"
#import "UIView+SetRect.h"
#import "UIFont+Project.h"

@interface NumberPickerRowView ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation NumberPickerRowView

- (void)buildSubView {
    
    self.textLabel      = [[UILabel alloc] init];
    self.textLabel.font = [UIFont PingFangSC_Thin_WithFontSize:20.f];
    [self addSubview:self.textLabel];
}

- (void)loadContent {
 
    self.textLabel.text = self.data;
    [self.textLabel sizeToFit];
    
    self.textLabel.center = self.middlePoint;
}

@end
