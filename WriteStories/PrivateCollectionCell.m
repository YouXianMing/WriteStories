//
//  PrivateCollectionCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "PrivateCollectionCell.h"
#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"
#import "FileManager.h"

@interface PrivateCollectionCell ()

@property (nonatomic, strong) FLAnimatedImageView *flImageView;

@end

@implementation PrivateCollectionCell

- (void)buildViewsOnAreaView:(UIView *)view {
    
    self.flImageView               = [[FLAnimatedImageView alloc] initWithFrame:view.bounds];
    self.flImageView.clipsToBounds = YES;
    [view addSubview:self.flImageView];
    
    self.flImageView.contentMode   = UIViewContentModeScaleAspectFill;
    self.flImageView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:absoluteFilePathFrom(@"-/pic_1_use.gif")]];
}

@end
