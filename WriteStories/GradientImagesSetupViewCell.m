//
//  GradientImagesSetupViewCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/17.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "GradientImagesSetupViewCell.h"
#import "FoldersManager.h"
#import "UIColor+Project.h"
#import "UIView+SetRect.h"

@interface GradientImagesSetupViewCell ()

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *selectedImageView;

@end

@implementation GradientImagesSetupViewCell

- (void)setupCell {
    
    [self showOutlineWithColor:UIColor.LineColor];
}

- (void)buildSubview {
    
    self.bgImageView               = [[UIImageView alloc] initWithFrame:self.bounds];
    self.bgImageView.contentMode   = UIViewContentModeScaleAspectFill;
    self.bgImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.bgImageView];
    
    self.selectedImageView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"颜色选中"]];
    self.selectedImageView.right  = self.width;
    self.selectedImageView.bottom = self.height;
    [self.contentView addSubview:self.selectedImageView];
}

- (void)loadContent {
    
    GradientImage *model     = self.data;
    NSString      *imagePath = [FoldersManager.GradientImages stringByAppendingPathComponent:model.imageName];
    self.bgImageView.image   = [[UIImage alloc] initWithContentsOfFile:imagePath];
    
    self.selectedImageView.alpha = model.selected ? 1.f : 0.f;
}

@end
