//
//  ItemColorSetupViewCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/17.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ItemColorSetupViewCell.h"
#import "ColorsModel.h"
#import "HexColors.h"
#import "UIColor+Project.h"
#import "UIFont+Project.h"
#import "EdgeInsetsLabel.h"
#import "UIView+SetRect.h"

@interface ItemColorSetupViewCell ()

@property (nonatomic, strong) EdgeInsetsLabel *label;
@property (nonatomic, strong) UIImageView     *selectedImageView;

@end

@implementation ItemColorSetupViewCell

- (void)setupCell {

    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = UIColor.LineColor.CGColor;
}

- (void)buildSubview {
    
    self.label                 = [EdgeInsetsLabel new];
    self.label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25f];
    self.label.textColor       = [UIColor whiteColor];
    self.label.font            = [UIFont PingFangSC_Regular_WithFontSize:8.f];
    self.label.edgeInsets      = UIEdgeInsetsMake(2, 5, 2, 5);
    [self.contentView addSubview:self.label];
    
    self.selectedImageView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"颜色选中"]];
    self.selectedImageView.right  = self.width;
    self.selectedImageView.bottom = self.height;
    [self.contentView addSubview:self.selectedImageView];
}

- (void)loadContent {
    
    ColorsModel *model               = self.data;
    self.contentView.backgroundColor = [UIColor colorWithHexString:model.hexString];
    
    [self.label sizeToFitWithText:[NSString stringWithFormat:@"%ld", model.index]];
    self.label.left = 0;
    self.label.top  = 0;
    
    self.selectedImageView.alpha = model.selected ? 1.f : 0.f;
}

@end
