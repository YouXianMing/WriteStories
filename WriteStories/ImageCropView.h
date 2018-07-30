//
//  ImageCropView.h
//  ImageCropDemo
//
//  Created by YouXianMing on 2018/6/7.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ImageCropView;

@protocol ImageCropViewDelegate <NSObject>

@optional

- (void)imageCropViewDidDidZoom:(ImageCropView *)cropImageContentView;
- (void)imageCropViewDidEndZooming:(ImageCropView *)cropImageContentView;

@end

@interface ImageCropView : UIView

@property (nonatomic, weak)             id <ImageCropViewDelegate> delegate;
@property (nonatomic, strong, readonly) UIImage *image;
@property (nonatomic, readonly)         CGSize   transparentSize;
@property (nonatomic, readonly)         UIImage *cropImage;

- (void)loadImage:(UIImage *)image transparentSize:(CGSize)transparentSize maskColor:(UIColor *)color;

@end
