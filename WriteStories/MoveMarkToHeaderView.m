//
//  MoveMarkToHeaderView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/19.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "MoveMarkToHeaderView.h"
#import "Table_Folder_Object.h"
#import "UIColor+Project.h"
#import "UIFont+Project.h"
#import "HexColors.h"
#import "UIView+SetRect.h"

@interface MoveMarkToHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MoveMarkToHeaderView

- (void)setupHeaderFooterView {
    
    [self setHeaderFooterViewBackgroundColor:UIColor.BackgroundColor];
}

- (void)buildSubview {
    
    self.titleLabel           = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 0, 200, 30.f)];
    self.titleLabel.font      = [UIFont PingFangSC_Light_WithFontSize:14.f];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#303030"];
    [self.contentView addSubview:self.titleLabel];
    
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 29.5, Width, 0.5f)];
    line.backgroundColor = UIColor.LineColor;
    [self.contentView addSubview:line];
}

- (void)loadContent {

    Table_Folder_Type_Object *object = self.data;
    self.titleLabel.text             = object.typeName;
}

@end
