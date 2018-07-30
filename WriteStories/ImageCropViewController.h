//
//  ImageCropViewController.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/21.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "NormalTitleViewController.h"

@interface ImageCropViewController : NormalTitleViewController

@property (nonatomic, strong) UIImage  *image;
@property (nonatomic)         CGSize    transparentSize;

@end
