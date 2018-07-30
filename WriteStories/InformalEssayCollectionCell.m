//
//  InformalEssayCollectionCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "InformalEssayCollectionCell.h"
#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"
#import "FileManager.h"

@interface InformalEssayCollectionCell ()

@property (nonatomic, strong) FLAnimatedImageView *flImageView;

@end

@implementation InformalEssayCollectionCell

- (void)buildViewsOnAreaView:(UIView *)view {
    
    self.flImageView               = [[FLAnimatedImageView alloc] initWithFrame:view.bounds];
    self.flImageView.clipsToBounds = YES;
    [view addSubview:self.flImageView];
    
    self.flImageView.contentMode   = UIViewContentModeScaleAspectFill;
    self.flImageView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:absoluteFilePathFrom(@"-/pic_5_use.gif")]];
}

@end
