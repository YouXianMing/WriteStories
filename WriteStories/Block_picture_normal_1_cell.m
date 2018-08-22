//
//  Block_picture_normal_1_cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/28.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Block_picture_normal_1_cell.h"
#import "Block_picture_normal_1.h"

@interface Block_picture_normal_1_cell ()

@property (nonatomic, strong) UIImageView *pictureView;

@end

@implementation Block_picture_normal_1_cell

- (void)buildSubview {
    
    [super buildSubview];
    
    self.pictureView               = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5.f, Width - 30.f, 150.f)];
    self.pictureView.contentMode   = UIViewContentModeScaleAspectFill;
    self.pictureView.image         = [UIImage imageNamed:@"styles_jpeg"];
    self.pictureView.clipsToBounds = YES;
    [self.contentView addSubview:self.pictureView];
}

- (void)loadContent {
    
    [super loadContent];
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    return  160.f;
}

- (BaseBlockItem *)blockItem {
    
    return [Block_picture_normal_1 defalutObject];
}

@end
