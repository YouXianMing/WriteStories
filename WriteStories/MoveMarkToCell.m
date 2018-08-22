//
//  MoveMarkToCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/19.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "MoveMarkToCell.h"
#import "UIColor+Project.h"
#import "UIFont+Project.h"
#import "UIView+SetRect.h"
#import "Table_Folder_Object.h"
#import "HexColors.h"

@interface MoveMarkToCell ()

@property (nonatomic, strong) UIView  *whiteView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation MoveMarkToCell

- (void)setupCell {
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)buildSubview {
    
    self.whiteView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 75.f)];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.whiteView];
    
    self.titleLabel      = [[UILabel alloc] initWithFrame:CGRectMake(25.f, 0, Width - 110, 75)];
    self.titleLabel.font = [UIFont PingFangSC_Regular_WithFontSize:25.f];
    [self.whiteView addSubview:self.titleLabel];
    
    self.countLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 75.f)];
    self.countLabel.right         = Width - 17.f;
    self.countLabel.textAlignment = NSTextAlignmentRight;
    [self.whiteView addSubview:self.countLabel];
    
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 74.5, Width, 0.5f)];
    line.backgroundColor = UIColor.LineColor;
    [self.contentView addSubview:line];
}

- (void)loadContent {
    
    Table_Folder_Object *model = self.data;
    self.titleLabel.text       = model.name;
    
    if (model.fileCount >= 40) {
        
        self.countLabel.text      = @"40/40";
        self.countLabel.font      = [UIFont PingFangSC_Medium_WithFontSize:21.f];
        self.countLabel.textColor = [UIColor redColor];
        self.whiteView.alpha      = 0.4f;
        
    } else {
        
        self.countLabel.text      = [NSString stringWithFormat:@"%ld/40", (long)model.fileCount];
        self.countLabel.font      = [UIFont PingFangSC_Regular_WithFontSize:21.f];
        self.countLabel.textColor = [UIColor colorWithHexString:@"#6a6a6a"];
        self.whiteView.alpha      = 1.f;
    }
}

@end
