//
//  AboutViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/31.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "AboutViewController.h"
#import "UIView+SetRect.h"
#import "UIView+GlowView.h"
#import "HexColors.h"
#import "GCD.h"

@interface AboutViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *redImageView;

@property (nonatomic, strong) UIImageView *author;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.imageView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coffce"]];
    self.imageView.center = CGPointMake(Width / 2.f, self.contentView.middleY - 50.f);
    [self.contentView addSubview:self.imageView];
    
    self.redImageView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coffce-red"]];
    self.redImageView.center = self.imageView.center;
    [self.contentView addSubview:self.redImageView];
    
    // Start glow.
    self.redImageView.glowRadius            = @(2.f);
    self.redImageView.glowOpacity           = @(1.f);
    self.redImageView.glowColor             = [[UIColor colorWithHexString:@"#00A3DA"] colorWithAlphaComponent:0.95f];

    self.redImageView.glowDuration          = @(1.f);
    self.redImageView.hideDuration          = @(3.f);
    self.redImageView.glowAnimationDuration = @(2.f);

    [self.redImageView createGlowLayer];
    [self.redImageView insertGlowLayer];

    [GCDQueue executeInMainQueue:^{

        [self.redImageView startGlowLoop];

    } afterDelaySecs:2.f];
    
    self.author         = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"author"]];
    self.author.centerX = Width / 2.f;
    self.author.top     = self.redImageView.bottom + 20.f;
    [self.contentView addSubview:self.author];
}

@end
