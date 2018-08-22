//
//  MarkImageInputEditorView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/24.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "MarkImageInputEditorView.h"
#import "EncodeImageObject.h"
#import "FoldersManager.h"
#import "NSString+Path.h"
#import "Math.h"
#import "UIImage+ImageEffects.h"
#import "ImageCropViewController.h"

@interface MarkImageInputEditorView () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, CustomViewControllerDelegate>

@property (nonatomic, strong) UIButton    *button;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MarkImageInputEditorView

- (BOOL)isOK {
    
    return YES;
}

- (void)buildSubViews {
    
}

- (void)updateViewHeight {
    
    self.height = self.imageView.bottom + 5;
}

- (void)setInputEdior:(InputEditor *)inputEdior {
    
    [super setInputEdior:inputEdior];
    
    EncodeImageObject *imageObject = [inputEdior valueWithObject:self.weakObject];
    
    // 标题
    self.label.text = [NSString stringWithFormat:@"%@（%@）", inputEdior.title, imageObject.scale];
    
    // 限定尺寸
    CGSize size = [Math resetFromSize:CGSizeMake(imageObject.width, imageObject.height) withFixedHeight:150];
    
    if (size.width >= Width - 20.f) {
        
        size = [Math resetFromSize:CGSizeMake(imageObject.width, imageObject.height) withFixedWidth:Width - 20.f];
    }
    
    NSString *imagePath          = [NSString stringWithFormat:@"%@/title/images/%@", FoldersManager.WorkShop, imageObject.imageName];
    self.imageView               = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.class.titleHeight + 5, size.width, size.height)];
    self.imageView.clipsToBounds = YES;
    self.imageView.contentMode   = UIViewContentModeScaleAspectFill;
    self.imageView.image = [[UIImage alloc] initWithContentsOfFile:imagePath];
    [self addSubview:self.imageView];
    
    self.imageView.layer.borderWidth = 0.5f;
    self.imageView.layer.borderColor = UIColor.LineColor.CGColor;
    
    UIButton *button = [[UIButton alloc] initWithFrame:self.imageView.frame];
    [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

- (void)buttonEvent:(UIButton *)button {
    
    UIImagePickerController *pickController = [[UIImagePickerController alloc] init];
    pickController.sourceType               = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    pickController.delegate                 = self;
    [self.controller presentViewController:pickController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        EncodeImageObject *imageObject = [self.inputEdior valueWithObject:self.weakObject];
        
        CGSize newSize = CGSizeZero;
        if (self.controller.contentView.height / self.controller.contentView.width >= imageObject.height / imageObject.width) {
            
            newSize = [Math resetFromSize:CGSizeMake(imageObject.width, imageObject.height) withFixedWidth:Width - 20.f];
            
        } else {
            
            newSize = [Math resetFromSize:CGSizeMake(imageObject.width, imageObject.height) withFixedHeight:self.controller.contentView.height - 20.f];
        }
        
        ImageCropViewController *controller = [ImageCropViewController new];
        controller.title                    = @"图片裁剪";
        controller.image                    = image;
        controller.transparentSize          = newSize;
        controller.eventDelegate            = self;
        [self.controller presentViewController:controller animated:YES completion:nil];
    }];
}

#pragma mark - CustomViewControllerDelegate

- (void)baseCustomViewController:(__kindof CustomViewController *)controller event:(id)event {
    
    UIImage *image       = event;
    self.imageView.image = image;
    
    EncodeImageObject *imageObject = [self.inputEdior valueWithObject:self.weakObject];
    NSString *imagePath            = [NSString stringWithFormat:@"%@/title/images/%@",
                                      FoldersManager.WorkShop,
                                      imageObject.imageName];
    
    // 保存图片PNG
    // [UIImagePNGRepresentation([image scaleWithFixedWidth:imageObject.width / 2.f]) writeToFile:imagePath atomically:YES];
    
    // 保存图片JPG
    NSData *data = UIImageJPEGRepresentation([image scaleWithFixedWidth:imageObject.width], 0.8);
    [data writeToFile:imagePath atomically:YES];
    NSLog(@"(%.fx%.f) %.2fkb", imageObject.width * UIScreen.mainScreen.scale, imageObject.height * UIScreen.mainScreen.scale, data.length / 1000.f);
}

@end
