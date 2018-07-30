//
//  ImageCropViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/21.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ImageCropViewController.h"
#import "TitleMenuButton.h"
#import "CropImageContentView.h"
#import "UIImage+ImageEffects.h"
#import "ImageCropView.h"

@interface ImageCropViewController () <ImageCropViewDelegate>

@property (nonatomic, strong) CropImageContentView *cropContentView;
@property (nonatomic, strong) TitleMenuButton      *setupButton;

@property (nonatomic, strong) ImageCropView *imageCropView;

@end

@implementation ImageCropViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.imageCropView                 = [[ImageCropView alloc] initWithFrame:self.contentView.bounds];
    self.imageCropView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.85f];
    
    [self.imageCropView loadImage:[UIImage fixOrientation:self.image] // 修复翻转图片
                  transparentSize:self.transparentSize
                        maskColor:[UIColor.blackColor colorWithAlphaComponent:0.5]];
    
    self.imageCropView.delegate = self;
    [self.contentView addSubview:self.imageCropView];
}

- (void)buttonsEvent:(UIButton *)button {
    
    if (button.tag == TitleMenuButton_Close) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else if (button.tag == TitleMenuButton_Save) {

        NSLog(@"%@", self.imageCropView.cropImage);
        
        if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(baseCustomViewController:event:)]) {

            [self.eventDelegate baseCustomViewController:self event:self.imageCropView.cropImage];
        }

        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - ImageCropViewDelegate

- (void)imageCropViewDidDidZoom:(ImageCropView *)cropImageContentView {
    
    self.setupButton.enabled = NO;
}

- (void)imageCropViewDidEndZooming:(ImageCropView *)cropImageContentView {
    
    self.setupButton.enabled = YES;
}

#pragma mark - Overwrite

- (void)setupSubViews {
    
    [super setupSubViews];
    
    [self.backButton removeFromSuperview];
    
    self.backButton = [[TitleMenuButton alloc] initWithFrame:CGRectMake(0, 0, 100, 64.f) type:TitleMenuButton_Close];
    [self.backButton addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleContentView addSubview:self.backButton];
    
    self.setupButton       = [[TitleMenuButton alloc] initWithFrame:CGRectMake(0, 0, 80, 64.f) type:TitleMenuButton_Save];
    self.setupButton.right = self.titleContentView.width;
    [self.setupButton addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleContentView addSubview:self.setupButton];
}

@end
