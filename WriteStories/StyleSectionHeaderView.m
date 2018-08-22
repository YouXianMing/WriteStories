//
//  StyleSectionHeaderView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "StyleSectionHeaderView.h"
#import "UIColor+Project.h"
#import "UIFont+Project.h"
#import "UIView+SetRect.h"
#import "HexColors.h"
#import "StyleSectionObject.h"

@interface StyleSectionHeaderView ()

@property (nonatomic, strong) UIView  *leftLineView;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation StyleSectionHeaderView

- (void)setupHeaderFooterView {
    
    [self setHeaderFooterViewBackgroundColor:UIColor.BackgroundColor];
}

- (void)buildSubview {
    
    self.leftLineView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3.5f, 13.f)];
    self.leftLineView.backgroundColor = [UIColor colorWithHexString:@"#c6c6c5"];
    self.leftLineView.centerY         = 15.f;
    [self.contentView addSubview:self.leftLineView];
    
    self.contentLabel           = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, 200, 30.f)];
    self.contentLabel.font      = [UIFont PingFangSC_Regular_WithFontSize:13.f];
    self.contentLabel.textColor = [UIColor colorWithHexString:@"#303030"];
    [self.contentView addSubview:self.contentLabel];
    
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 29.5f, Width, 0.5f)];
    line.backgroundColor = UIColor.LineColor;
    [self.contentView addSubview:line];
}

- (void)loadContent {

    StyleSectionObject *object = self.data;
    self.contentLabel.text     = object.title;
}

@end
