//
//  CropMaskView.h
//  CropImageContentView
//
//  Created by YouXianMing on 2018/1/15.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MoveMaskView;

@protocol MoveMaskViewDelegate <NSObject>

@optional

- (void)moveMaskView:(MoveMaskView *)moveMaskView moveFrame:(CGRect)frame;

@end

@interface MoveMaskView : UIView

@property (nonatomic, strong, readonly) UIView                    *maskContentView;
@property (nonatomic, strong, readonly) UIView                    *transparentView;
@property (nonatomic, weak)             id <MoveMaskViewDelegate>  delegate;
@property (nonatomic)                   CGSize                     transparentSize;

@end
