//
//  FontPickerRowView.m
//  FamousQuotes
//
//  Created by YouXianMing on 2018/3/19.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "FontPickerRowView.h"
#import "UIView+SetRect.h"
#import "UIFont+Project.h"
#import "FontsManager.h"

@interface FontPickerRowView ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation FontPickerRowView

- (void)buildSubView {
    
    self.textLabel      = [[UILabel alloc] init];
    [self addSubview:self.textLabel];
}

- (void)loadContent {
    
    FontInfoObject *info = self.data;
    self.textLabel.font  = info.font;
    self.textLabel.text  = info.fontDescription;
    [self.textLabel sizeToFit];
    
    self.textLabel.center = self.middlePoint;
}

@end
