//
//  CropImageContentView.h
//  CropImageContentView
//
//  Created by YouXianMing on 2018/1/15.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CropImageContentView;

@protocol CropImageContentViewDelegate <NSObject>

@optional

- (void)cropImageContentViewDidDidZoom:(CropImageContentView *)cropImageContentView;
- (void)cropImageContentViewDidEndZooming:(CropImageContentView *)cropImageContentView;

@end

@interface CropImageContentView : UIView

@property (nonatomic, weak)   id        <CropImageContentViewDelegate> delegate;
@property (nonatomic)         CGSize    transparentSize;
@property (nonatomic, strong) UIImage  *image;

- (UIImage *)cropImage;

@end
