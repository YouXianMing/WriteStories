//
//  CropImageContentView.m
//  CropImageContentView
//
//  Created by YouXianMing on 2018/1/15.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "CropImageContentView.h"
#import "MoveMaskView.h"
#import "LockView.h"
#import "UIView+SetRect.h"

@interface CropImageContentView () <MoveMaskViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView  *scrollImageView;

@property (nonatomic, strong) MoveMaskView *moveMaskView;
@property (nonatomic, strong) UIButton     *button;
@property (nonatomic, strong) UIImageView  *gridImageView;
@property (nonatomic, strong) LockView     *lockView;

@end

@implementation CropImageContentView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        
        // scrollView
        self.scrollView          = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.delegate = self;
        [self addSubview:self.scrollView];
        
        // image
        self.scrollImageView = [[UIImageView alloc] init];
        [self.scrollView addSubview:self.scrollImageView];
        
        // mask
        self.moveMaskView                        = [[MoveMaskView alloc] initWithFrame:self.bounds];
        self.moveMaskView.delegate               = self;
        self.moveMaskView.userInteractionEnabled = NO;
        [self addSubview:self.moveMaskView];
        
        // button
//        self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
//        [self.button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
//        [self.button setTitle:@"OFF" forState:UIControlStateNormal];
//        [self.button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
//        [self addSubview:self.button];
        
        // lock
//        self.lockView                        = [[LockView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//        self.lockView.userInteractionEnabled = NO;
//        [self.lockView changeToState:ELockViewStateLock animated:NO];
//        [self addSubview:self.lockView];
        
        // Image
        self.gridImageView                        = [[UIImageView alloc] init];
        self.gridImageView.userInteractionEnabled = NO;
        self.gridImageView.alpha                  = 0.2f;
        self.gridImageView.image                  = [[UIImage imageNamed:@"grid-red"] resizableImageWithCapInsets:UIEdgeInsetsMake(30, 30, 30, 30)];
        [self addSubview:self.gridImageView];
    }
    
    return self;
}

- (void)buttonEvent:(UIButton *)button {
    
    if ([[button titleForState:UIControlStateNormal] isEqualToString:@"ON"]) {
        
        [self.button setTitle:@"OFF" forState:UIControlStateNormal];
        self.moveMaskView.userInteractionEnabled = NO;
        [self.lockView changeToState:ELockViewStateLock animated:YES];
        
        [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            self.moveMaskView.maskContentView.alpha = 1.f;
            self.gridImageView.alpha                = 0.2f;
            
        } completion:nil];
        
    } else {
        
        [self.button setTitle:@"ON" forState:UIControlStateNormal];
        self.moveMaskView.userInteractionEnabled = YES;
        [self.lockView changeToState:ELockViewStateUnlock animated:YES];
        
        [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            self.moveMaskView.maskContentView.alpha = 0.5f;
            self.gridImageView.alpha                = 0.6f;
            
        } completion:nil];
    }
}

- (UIImage *)cropImage {
    
    UIImage *image = nil;
    
    CGRect rect    = self.moveMaskView.transparentView.frame;
    CGFloat x      = (rect.origin.x + self.scrollView.contentOffset.x) / self.scrollView.zoomScale;
    CGFloat y      = (rect.origin.y + self.scrollView.contentOffset.y) / self.scrollView.zoomScale;
    CGFloat width  = rect.size.width / self.scrollView.zoomScale;
    CGFloat height = rect.size.height / self.scrollView.zoomScale;

    CGImageRef cgImageRef = CGImageCreateWithImageInRect(self.scrollImageView.image.CGImage, CGRectMake(x, y, width, height));
    image                 = [UIImage imageWithCGImage:cgImageRef];
    CGImageRelease(cgImageRef);
    
    return image;
}

#pragma mark - MoveMaskViewDelegate

- (void)moveMaskView:(MoveMaskView *)moveMaskView moveFrame:(CGRect)frame {
    
    self.button.right  = frame.origin.x + frame.size.width;
    self.button.bottom = frame.origin.y + frame.size.height;
    
    self.lockView.right  = frame.origin.x + frame.size.width + 3.f;
    self.lockView.bottom = frame.origin.y + frame.size.height;
    
    self.gridImageView.frame = frame;
}

#pragma mark - layout reset subviews frame.

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.scrollView.frame   = self.bounds;
    self.moveMaskView.frame = self.bounds;
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.scrollImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGFloat offsetX = MAX((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0);
    CGFloat offsetY = MAX((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0);
    
    self.scrollImageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cropImageContentViewDidDidZoom:)]) {
        
        [self.delegate cropImageContentViewDidDidZoom:self];
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cropImageContentViewDidEndZooming:)]) {
        
        [self.delegate cropImageContentViewDidEndZooming:self];
    }
}

#pragma mark - Setter & getter.

- (void)setTransparentSize:(CGSize)transparentSize {
    
    self.moveMaskView.transparentSize = transparentSize;
    self.gridImageView.viewSize       = transparentSize;
    self.gridImageView.center         = self.middlePoint;
    
    CGFloat hGap = (self.width - transparentSize.width) / 2.f;
    CGFloat tGap = (self.height - transparentSize.height) / 2.f;
    self.scrollView.contentInset = UIEdgeInsetsMake(tGap, hGap, tGap, hGap);
}

- (CGSize)transparentSize {
    
    return self.moveMaskView.transparentSize;
}

- (void)setImage:(UIImage *)image {
        
    // 获取图片
    self.scrollImageView.image    = image;
    self.scrollView.zoomScale     = 1.f;
    self.scrollView.contentSize   = self.scrollImageView.image.size;
    
    // 设定图片frame值
    self.scrollImageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    
    // 设定缩放比例
    self.scrollView.minimumZoomScale = MAX(self.scrollView.width / image.size.width, self.scrollView.height / image.size.height);
    self.scrollView.zoomScale        = self.scrollView.minimumZoomScale;
    
    if (self.scrollView.minimumZoomScale <= 1) {
        
        self.scrollView.maximumZoomScale = 4.f;
        
    } else {
        
        self.scrollView.maximumZoomScale = self.scrollView.minimumZoomScale * 4.f;
    }
    
    NSLog(@"(%.2f:%.2f)%f,%f,%f", image.size.width, image.size.height,
          self.scrollView.minimumZoomScale,
          self.scrollView.maximumZoomScale,
          self.scrollView.zoomScale);
}

@end
