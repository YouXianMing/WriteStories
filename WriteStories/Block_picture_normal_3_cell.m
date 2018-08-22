//
//  Block_picture_normal_3_cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/18.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Block_picture_normal_3_cell.h"
#import "Block_picture_normal_3.h"

@interface Block_picture_normal_3_cell ()

@property (nonatomic, strong) UIImageView *pictureView;

@end

@implementation Block_picture_normal_3_cell

- (void)buildSubview {
    
    [super buildSubview];
    
    self.pictureView               = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5.f + 20.f, Width - 30.f, 150.f)];
    self.pictureView.contentMode   = UIViewContentModeScaleAspectFill;
    self.pictureView.image         = [UIImage imageNamed:@"styles_jpeg"];
    self.pictureView.clipsToBounds = YES;
    [self.contentView addSubview:self.pictureView];
    
    UILabel *label      = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, Width, 15)];
    label.text          = @"图片描述信息";
    label.textAlignment = NSTextAlignmentCenter;
    label.font          = [UIFont PingFangSC_Thin_WithFontSize:12.f];
    [self.contentView addSubview:label];
}

- (void)loadContent {
    
    [super loadContent];
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    return  180.f;
}

- (BaseBlockItem *)blockItem {
    
    return [Block_picture_normal_3 defalutObject];
}

@end
