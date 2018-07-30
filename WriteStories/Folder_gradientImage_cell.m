//
//  Folder_gradientImage_cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/18.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Folder_gradientImage_cell.h"
#import "Folder_gradientImage.h"
#import "CAGradientView.h"
#import "CAGradientView+CAGradientViewObject.h"

@interface Folder_gradientImage_cell ()

@property (nonatomic, strong) CAGradientView *gradientView;
@property (nonatomic, strong) UIImageView    *imageView;

@end

@implementation Folder_gradientImage_cell

- (void)buildSubview {
    
    [super buildSubview];
    
    self.imageView               = [[UIImageView alloc] initWithFrame:self.bounds];
    self.imageView.contentMode   = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    [self.bottomContentView addSubview:self.imageView];
    
    self.gradientView = [[CAGradientView alloc] initWithFrame:self.bounds];
    [self.bottomContentView addSubview:self.gradientView];
}

- (void)loadContent {
    
    [super loadContent];
    
    Folder_gradientImage *model = self.data;
    NSString *imagePath         = nil;
    
    if (model.image.source == EncodeImageObjectSourceDefault) {
        
        imagePath = [FoldersManager.DefaultImages addPathComponent:model.image.imageName];
        
    } else if (model.image.source == EncodeImageObjectSourceFolder) {
        
        imagePath = [FoldersManager image_FolderListWithFolderName:model.folder_name imageName:model.image.imageName];
    }
    
    self.imageView.image = [[UIImage alloc] initWithContentsOfFile:imagePath];
    
    self.gradientView.alpha = model.gradientObjectAlpha.floatValue;
    [self.gradientView configWithObject:model.gradientObject];
}

@end
