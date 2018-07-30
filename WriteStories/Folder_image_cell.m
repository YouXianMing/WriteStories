//
//  Folder_image_cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/17.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Folder_image_cell.h"
#import "Folder_image_0.h"

@interface Folder_image_cell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation Folder_image_cell

- (void)buildSubview {
    
    [super buildSubview];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40.f, self.width, self.width)];
    [self.bottomContentView addSubview:self.imageView];
}

- (void)loadContent {
    
    [super loadContent];
    
    Folder_image_0 *model = self.data;
    NSString *imagePath   = nil;
    
    if (model.image.source == EncodeImageObjectSourceDefault) {
        
        imagePath = [FoldersManager.DefaultImages addPathComponent:model.image.imageName];
        
    } else if (model.image.source == EncodeImageObjectSourceFolder) {
        
        imagePath = [FoldersManager image_FolderListWithFolderName:model.folder_name imageName:model.image.imageName];
    }
    
    self.imageView.image = [[UIImage alloc] initWithContentsOfFile:imagePath];
}

@end
