//
//  MoveFolderToCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/16.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "MoveFolderToCell.h"
#import "UIColor+Project.h"
#import "UIFont+Project.h"
#import "UIView+SetRect.h"
#import "MoveFolderToCellModel.h"
#import "HexColors.h"

@interface MoveFolderToCell ()

@property (nonatomic, strong) UIView  *whiteView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation MoveFolderToCell

- (void)setupCell {
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)buildSubview {
    
    self.whiteView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 75.f)];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.whiteView];
    
    self.titleLabel      = [[UILabel alloc] initWithFrame:CGRectMake(15.f, 0, Width - 70.f, 75)];
    self.titleLabel.font = [UIFont PingFangSC_Regular_WithFontSize:25.f];
    [self.whiteView addSubview:self.titleLabel];
    
    self.countLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 75.f)];
    self.countLabel.right         = Width - 17.f;
    self.countLabel.textAlignment = NSTextAlignmentRight;
    [self.whiteView addSubview:self.countLabel];
    
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 74.5, Width, 0.5f)];
    line.backgroundColor = UIColor.LineColor;
    [self.whiteView addSubview:line];
}

- (void)loadContent {
    
    MoveFolderToCellModel *model = self.data;
    self.titleLabel.text         = model.name;
    
    if (model.currentFoldersCount >= 50) {
        
        self.countLabel.text      = @"50/50";
        self.countLabel.font      = [UIFont PingFangSC_Medium_WithFontSize:21.f];
        self.countLabel.textColor = [UIColor redColor];
        self.whiteView.alpha      = 0.4f;
        
    } else {
        
        self.countLabel.text      = [NSString stringWithFormat:@"%ld/50", (long)model.currentFoldersCount];
        self.countLabel.font      = [UIFont PingFangSC_Regular_WithFontSize:21.f];
        self.countLabel.textColor = [UIColor colorWithHexString:@"#6a6a6a"];
        self.whiteView.alpha      = 1.f;
    }
}

@end
