//
//  Block_title_picture_1_cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/18.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Block_title_picture_1_cell.h"
#import "Block_title_picture_1.h"
#import "UIView+SetRect.h"

@interface Block_title_picture_1_cell ()

@property (nonatomic, strong) UIImageView *pictureView;
@property (nonatomic, strong) UILabel     *contentLabel;

@end

@implementation Block_title_picture_1_cell

- (void)buildSubview {
    
    [super buildSubview];
    
    self.pictureView               = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, 150.f)];
    self.pictureView.contentMode   = UIViewContentModeScaleAspectFill;
    self.pictureView.image         = [UIImage imageNamed:@"styles_jpeg"];
    self.pictureView.clipsToBounds = YES;
    [self.contentView addSubview:self.pictureView];
    
    UIView *maskView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 150.f)];
    maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.65f];
    [self.contentView addSubview:maskView];
    
    self.contentLabel               = [[UILabel alloc] init];
    self.contentLabel.text          = @"标题模板";
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textColor     = [UIColor whiteColor];
    self.contentLabel.font          = [UIFont PingFangSC_Medium_WithFontSize:30];
    [self.contentLabel sizeToFit];
    [self.contentView addSubview:self.contentLabel];
    
    self.contentLabel.center = CGPointMake(Width / 2.f, 150.f / 2.f);
}

- (void)loadContent {
    
    [super loadContent];
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    return  150.f;
}

- (BaseBlockItem *)blockItem {
    
    return [Block_title_picture_1 defalutObject];
}

@end
