//
//  ItemEditorCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/17.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ItemEditorCell.h"
#import "StyleEditor.h"
#import "StyleAdjustEditView.h"

@interface ItemEditorCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ItemEditorCell

- (void)buildSubview {
    
    CGFloat gap                   = 3.f;
    self.titleLabel               = [[UILabel alloc] initWithFrame:CGRectMake(gap, 0, StyleAdjustEditView.StyleAdjustEditViewLeftLineGap - gap * 2.f, 45.f)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.font          = [UIFont PingFangSC_Medium_WithFontSize:13.f];
    self.titleLabel.textColor     = [UIColor colorWithHexString:@"#7e7e7e"];
    [self.contentView addSubview:self.titleLabel];
    
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, StyleAdjustEditView.StyleAdjustEditViewLeftLineGap, 0.5f)];
    line.backgroundColor = UIColor.LineColor;
    [self.contentView addSubview:line];
}

- (void)loadContent {
    
    StyleEditor *editor               = self.data;    
    self.titleLabel.text             = editor.cellTitle;
    self.contentView.backgroundColor = editor.selected ? [UIColor colorWithHexString:@"#e9e9e9"] : [UIColor whiteColor];
}

@end
