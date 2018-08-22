//
//  IconFontCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/30.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "IconFontCell.h"
#import "IconFontsManager.h"
#import "NSString+HexUnicode.h"
#import "UIView+SetRect.h"
#import "UIColor+Project.h"

@interface IconFontCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation IconFontCell

- (void)buildSubview {
 
    self.label               = [[UILabel alloc] initWithFrame:self.bounds];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.label];
    
    UIView *rightLine         = [[UIView alloc] initWithFrame:CGRectMake(self.width - 0.5f, 0, 0.5f, self.height)];
    rightLine.backgroundColor = UIColor.LineColor;
    [self.contentView addSubview:rightLine];
    
    UIView *bottomLine         = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 0.5f, self.width, 0.5f)];
    bottomLine.backgroundColor = UIColor.LineColor;
    [self.contentView addSubview:bottomLine];
}

- (void)loadContent {
    
    IconFontModel *model = self.data;
    
    self.label.font = [UIFont fontWithName:model.fontName size:28];
    self.label.text = [NSString unicodeWithHexString:model.icon];
    
    if (model.selected) {
        
        self.contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1f];
        
    } else {
        
        self.contentView.backgroundColor = [UIColor clearColor];
    }
}

@end
