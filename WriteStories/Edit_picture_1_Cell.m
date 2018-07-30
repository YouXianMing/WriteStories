//
//  Edit_picture_1_Cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/28.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Edit_picture_1_Cell.h"
#import "BaseBlockItem.h"

@interface Edit_picture_1_Cell ()

@property (nonatomic, strong) UILabel     *countLabel;
@property (nonatomic, strong) UILabel     *label;
@property (nonatomic, strong) UIImageView *contentImageView;

@end

@implementation Edit_picture_1_Cell

- (void)buildSubview {
    
    [super buildSubview];
    
    self.contentImageView                   = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 100.f, 75.f)];
    self.contentImageView.layer.borderWidth = 3.f;
    self.contentImageView.contentMode       = UIViewContentModeScaleAspectFill;
    self.contentImageView.clipsToBounds     = YES;
    self.contentImageView.layer.borderColor = [UIColor.LineColor colorWithAlphaComponent:0.5f].CGColor;
    [self.contentView addSubview:self.contentImageView];
    
    self.countLabel               = [[UILabel alloc] initWithFrame:CGRectMake(8, 8 + 75.f, 100.f, 100.f - (8 + 75.f))];
    self.countLabel.textAlignment = NSTextAlignmentCenter;
    self.countLabel.font          = [UIFont PingFangSC_Light_WithFontSize:8.f];
    [self.contentView addSubview:self.countLabel];
    
    self.label               = [UILabel new];
    self.label.numberOfLines = 4;
    self.label.font          = [UIFont PingFangSC_Light_WithFontSize:13.f];
    [self.contentView addSubview:self.label];
}

- (void)loadContent {
    
    [super loadContent];
    
    id <ArticleEditObjectProtocol> object = self.data;
    
    BaseBlockItem *blockItem    = self.data;
    self.contentImageView.image = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@/block/%@",
                                                                           blockItem.htmlFolderName, blockItem.folderName, object.cell_image.imageName]];
    
    self.countLabel.text = object.cell_image.scale;
    
    self.label.text  = object.cell_text;
    self.label.width = self.rightView.left - self.contentImageView.right - 8.f * 2.f;
    [self.label sizeToFit];
    self.label.left  = self.contentImageView.right + 8.f;
    self.label.top   = 8.f;
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    return 100;
}

@end
