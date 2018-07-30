//
//  ImageCropView.m
//  ImageCropDemo
//
//  Created by YouXianMing on 2018/6/7.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ImageCropView.h"
#import "UIView+SetRect.h"
#import "Math.h"
#import "UIImage+ImageEffects.h"

@interface ImageCropView () <UIScrollViewDelegate> {
    
    UIView *_topView;
    UIView *_bottomView;
    UIView *_leftView;
    UIView *_rightView;
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView  *imageView;
@property (nonatomic, strong) UIImageView  *gridImageView;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic)         CGSize   transparentSize;

@end

@implementation ImageCropView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.scrollView          = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.delegate = self;
        [self addSubview:self.scrollView];
        
        if (@available(iOS 11.0, *)) {
        
            self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        self.imageView = [[UIImageView alloc] init];
        [self.scrollView addSubview:self.imageView];
    }
    
    return self;
}

- (void)loadImage:(UIImage *)image transparentSize:(CGSize)transparentSize maskColor:(UIColor *)color {
    
    self.image           = image;
    self.transparentSize = transparentSize;
    
    CGFloat vtGap    = (self.height - transparentSize.height) / 2.f;
    CGFloat hrGap    = (self.width - transparentSize.width) / 2.f;
    CGFloat minScale = 0;
    
    // Image
    self.gridImageView                        = [[UIImageView alloc] init];
    self.gridImageView.userInteractionEnabled = NO;
    self.gridImageView.alpha                  = 0.5f;
    self.gridImageView.image                  = [[UIImage imageNamed:@"grid-red"] resizableImageWithCapInsets:UIEdgeInsetsMake(30, 30, 30, 30)];
    self.gridImageView.viewSize               = transparentSize;
    self.gridImageView.center                 = self.middlePoint;
    [self addSubview:self.gridImageView];
    
    self.scrollView.contentInset = UIEdgeInsetsMake(vtGap, hrGap, vtGap, hrGap);
    if (image.size.width / image.size.height <= transparentSize.width / transparentSize.height) {
        
        if (image.size.width <= transparentSize.width) {
            
            CGSize imageViewSize    = [Math resetFromSize:image.size withFixedWidth:transparentSize.width];
            self.imageView.viewSize = imageViewSize;
            minScale                = 1.f;
            self.imageView.image    = image;

        } else {
            
            minScale                = transparentSize.width / image.size.width;
            self.imageView.viewSize = image.size;
            self.imageView.image    = image;
        }
        
    } else {
        
        if (image.size.height <= transparentSize.height) {
            
            CGSize imageViewSize    = [Math resetFromSize:image.size withFixedHeight:transparentSize.height];
            self.imageView.viewSize = imageViewSize;
            minScale                = 1.f;
            self.imageView.image    = image;
            
        } else {
            
            minScale                = transparentSize.height / image.size.height;
            self.imageView.viewSize = image.size;
            self.imageView.image    = image;
        }
    }
    
    self.scrollView.contentSize      = self.imageView.viewSize;
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = minScale * 8.f;
    
    self.scrollView.zoomScale = minScale;    
    if (image.size.width / image.size.height <= transparentSize.width / transparentSize.height) {
        
        CGFloat offsetY = (self.imageView.height * minScale - transparentSize.height) / 2.f;
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentOffset.y + offsetY);
        
    } else {

        CGFloat offsetX = (self.imageView.width * minScale - transparentSize.width) / 2.f;
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x + offsetX, self.scrollView.contentOffset.y);
    }
    
    {
        _topView                        = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, vtGap)];
        _topView.userInteractionEnabled = NO;
        [self addSubview:_topView];
        
        _bottomView                        = [[UIView alloc] initWithFrame:_topView.bounds];
        _bottomView.userInteractionEnabled = NO;
        _bottomView.bottom                 = self.height;
        [self addSubview:_bottomView];
        
        _leftView                        = [[UIView alloc] initWithFrame:CGRectMake(0, vtGap, hrGap, transparentSize.height)];
        _leftView.userInteractionEnabled = NO;
        [self addSubview:_leftView];
        
        _rightView                        = [[UIView alloc] initWithFrame:CGRectMake(0, vtGap, hrGap, transparentSize.height)];
        _rightView.userInteractionEnabled = NO;
        _rightView.right                  = self.width;
        [self addSubview:_rightView];
        
        _topView.backgroundColor    = color;
        _bottomView.backgroundColor = color;
        _leftView.backgroundColor   = color;
        _rightView.backgroundColor  = color;
    }
}

- (UIImage *)cropImage {
    
    UIImage *image = nil;
    
    CGRect rect        = self.gridImageView.frame;
    CGFloat x          = (rect.origin.x + self.scrollView.contentOffset.x) / self.scrollView.zoomScale;
    CGFloat y          = (rect.origin.y + self.scrollView.contentOffset.y) / self.scrollView.zoomScale;
    CGFloat width      = rect.size.width / self.scrollView.zoomScale;
    CGFloat height     = rect.size.height / self.scrollView.zoomScale;
    CGFloat scaleRatio = self.imageView.image.size.width / self.imageView.width;
    
    CGImageRef cgImageRef = CGImageCreateWithImageInRect(self.imageView.image.CGImage, CGRectMake(x * scaleRatio, y * scaleRatio, width * scaleRatio, height * scaleRatio));
    image                 = [UIImage imageWithCGImage:cgImageRef];
    CGImageRelease(cgImageRef);
    
    return image;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageCropViewDidDidZoom:)]) {
        
        [self.delegate imageCropViewDidDidZoom:self];
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {

    if (self.delegate && [self.delegate respondsToSelector:@selector(imageCropViewDidEndZooming:)]) {
        
        [self.delegate imageCropViewDidEndZooming:self];
    }
}

@end
