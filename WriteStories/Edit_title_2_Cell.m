//
//  Edit_title_2_Cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/18.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Edit_title_2_Cell.h"
#import "BaseBlockItem.h"

@interface Edit_title_2_Cell ()

@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UIImageView *contentImageView;

@end

@implementation Edit_title_2_Cell

- (void)buildSubview {
    
    [super buildSubview];
    
    self.contentImageView                   = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, 140.f)];
    self.contentImageView.contentMode       = UIViewContentModeScaleAspectFill;
    self.contentImageView.clipsToBounds     = YES;
    [self.contentView addSubview:self.contentImageView];
    
    UIView *maskView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 140.f)];
    maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.65f];
    [self.contentView addSubview:maskView];
    
    self.titleLabel               = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, Width - 80.f, [Edit_title_2_Cell cellHeightWithData:nil])];
    self.titleLabel.font          = [UIFont PingFangSC_Semibold_WithFontSize:25.f];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.textColor     = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
}

- (void)loadContent {
    
    [super loadContent];
    
    self.edgeLabel.hidden          = YES;
    self.deleteButton.hidden       = YES;
    self.rightView.backgroundColor = UIColor.clearColor;
    
    id <ArticleEditObjectProtocol> object = self.data;
    self.titleLabel.text = object.cell_text;
    
    NSLog(@"%@", object.cell_image);
    
    BaseBlockItem *blockItem    = self.data;
    self.contentImageView.image = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@/block/%@",
                                                                           blockItem.htmlFolderName, blockItem.folderName, object.cell_image.imageName]];
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    return 140.f;
}

@end
