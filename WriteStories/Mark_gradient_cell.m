//
//  Mark_gradient_cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/3.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Mark_gradient_cell.h"
#import "Mark_gradient.h"
#import "CAGradientView.h"
#import "CAGradientView+CAGradientViewObject.h"

@interface Mark_gradient_cell ()

@property (nonatomic, strong) CAGradientView *gradientView;

@property (nonatomic, strong) UIView      *showContentView;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *subTitleLabel;
@property (nonatomic, strong) UIView      *lineView;

@end

@implementation Mark_gradient_cell

- (void)setupCell {
    
    [super setupCell];
}

- (void)buildSubview {
    
    [super buildSubview];
    
    self.showContentView               = [[UIView alloc] initWithFrame:self.bounds];
    self.showContentView.clipsToBounds = YES;
    [self.contentView addSubview:self.showContentView];
    
    self.bgImageView             = [[UIImageView alloc] initWithFrame:self.bounds];
    self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.showContentView addSubview:self.bgImageView];
    
    self.gradientView = [[CAGradientView alloc] initWithFrame:self.bounds];
    [self.showContentView addSubview:self.gradientView];
    
    self.lineView                 = [[UIView alloc] init];
    self.lineView.backgroundColor = [UIColor whiteColor];
    [self.showContentView addSubview:self.lineView];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.showContentView addSubview:self.titleLabel];
    
    self.subTitleLabel = [[UILabel alloc] init];
    [self.showContentView addSubview:self.subTitleLabel];
}

- (void)loadContent {
    
    [super loadContent];
    
    Mark_gradient *model   = self.data;
    NSString *imagePath = nil;
    
    self.gradientView.alpha = model.gradientObjectAlpha.floatValue;
    [self.gradientView configWithObject:model.gradientObject];
    
    if (model.image.source == EncodeImageObjectSourceDefault) {
        
        imagePath = [FoldersManager.DefaultImages addPathComponent:model.image.imageName];
        
    } else if (model.image.source == EncodeImageObjectSourceFolder) {
        
        imagePath = [NSString stringWithFormat:@"%@/%@/content/title/images/%@", FoldersManager.ArticleList, model.mark_name, model.image.imageName];
    }
    
    // 背景图
    self.bgImageView.image = [[UIImage alloc] initWithContentsOfFile:imagePath];
    
    // 标题
    self.titleLabel.text      = model.title;
    self.titleLabel.alpha     = model.titleAlpha.floatValue;
    self.titleLabel.font      = [UIFont fontWithName:model.titleFontFamily size:model.titleFontSize.floatValue];
    self.titleLabel.textColor = [UIColor colorWithHexString:model.titleColorHex];
    
    // 副标题
    self.subTitleLabel.text      = model.subTitle;
    self.subTitleLabel.alpha     = model.subTitleAlpha.floatValue;
    self.subTitleLabel.font      = [UIFont fontWithName:model.subTitleFontFamily size:model.subTitleFontSize.floatValue];
    self.subTitleLabel.textColor = [UIColor colorWithHexString:model.subTitleColorHex];
    
    // 线条
    self.lineView.alpha           = model.lineAlpha.floatValue;
    self.lineView.backgroundColor = [UIColor colorWithHexString:model.lineColorHex];
    
    [self.titleLabel sizeToFit];
    [self.subTitleLabel sizeToFit];
    
    if (model.styleType.integerValue == 1) {
        
        self.titleLabel.top  = 10.f;
        self.titleLabel.left = 10.f;
        
        self.lineView.height = 1.f;
        self.lineView.width  = MAX(self.subTitleLabel.width, self.titleLabel.width);
        self.lineView.top    = self.titleLabel.bottom + 5.f;
        self.lineView.left   = 10.f;
        
        self.subTitleLabel.left = 10.f;
        self.subTitleLabel.top  = self.lineView.bottom + 5.f;
        
    } else if (model.styleType.integerValue == 2) {
        
        self.titleLabel.top   = 10.f;
        self.titleLabel.right = self.width - 10.f;
        
        self.lineView.height = 1.f;
        self.lineView.width  = MAX(self.subTitleLabel.width, self.titleLabel.width);
        self.lineView.top    = self.titleLabel.bottom + 5.f;
        self.lineView.right  = self.width - 10.f;
        
        self.subTitleLabel.right = self.width - 10.f;
        self.subTitleLabel.top   = self.lineView.bottom + 5.f;
        
    } else if (model.styleType.integerValue == 3) {
        
        self.subTitleLabel.bottom = self.height - 10.f;
        self.subTitleLabel.left   = 10.f;
        
        self.lineView.height = 1.f;
        self.lineView.width  = MAX(self.subTitleLabel.width, self.titleLabel.width);
        self.lineView.left   = 10.f;
        self.lineView.bottom = self.subTitleLabel.top - 5.f;
        
        self.titleLabel.left   = 10.f;
        self.titleLabel.bottom = self.lineView.top - 5.f;
        
    } else if (model.styleType.integerValue == 4) {
        
        self.subTitleLabel.bottom = self.height - 10.f;
        self.subTitleLabel.right  = self.width - 10.f;
        
        self.lineView.height = 1.f;
        self.lineView.width  = MAX(self.subTitleLabel.width, self.titleLabel.width);
        self.lineView.right  = self.width - 10.f;
        self.lineView.bottom = self.subTitleLabel.top - 5.f;
        
        self.titleLabel.right  = self.width - 10.f;
        self.titleLabel.bottom = self.lineView.top - 5.f;
        
    } else if (model.styleType.integerValue == 5) {
        
        self.lineView.height = 1.f;
        self.lineView.width  = MAX(self.subTitleLabel.width, self.titleLabel.width);
        self.lineView.center = self.middlePoint;
        
        self.titleLabel.center = self.middlePoint;
        self.titleLabel.bottom = self.lineView.top - 5.f;
        
        self.subTitleLabel.center = self.middlePoint;
        self.subTitleLabel.top    = self.lineView.bottom + 5.f;
        
    } else if (model.styleType.integerValue == 6) {
        
        self.titleLabel.top  = 10.f;
        self.titleLabel.left = 5.f + 10.f;
        
        self.lineView.height  = self.titleLabel.height - 8.f;
        self.lineView.width   = 5.f;
        self.lineView.left    = 0.f;
        self.lineView.centerY = self.titleLabel.centerY;
        
        self.subTitleLabel.left = self.titleLabel.left;
        self.subTitleLabel.top  = self.titleLabel.bottom + 5.f;
        
    } else if (model.styleType.integerValue == 7) {
        
        self.titleLabel.top   = 10.f;
        self.titleLabel.right = self.width - (5.f + 10.f);
        
        self.lineView.height  = self.titleLabel.height - 8.f;
        self.lineView.width   = 5.f;
        self.lineView.right   = self.width;
        self.lineView.centerY = self.titleLabel.centerY;
        
        self.subTitleLabel.right = self.titleLabel.right;
        self.subTitleLabel.top   = self.titleLabel.bottom + 5.f;
        
    } else if (model.styleType.integerValue == 8) {
        
        self.titleLabel.top   = 10.f;
        self.titleLabel.right = self.width - (5.f + 10.f);
        
        self.lineView.height  = self.titleLabel.height - 8.f;
        self.lineView.width   = 5.f;
        self.lineView.right   = self.width;
        self.lineView.centerY = self.titleLabel.centerY;
        
        self.subTitleLabel.right  = self.width - 10.f;
        self.subTitleLabel.bottom = self.height - 10.f;
        
    } else if (model.styleType.integerValue == 9) {
        
        self.titleLabel.top   = 10.f;
        self.titleLabel.right = self.width - (5.f + 10.f);
        
        self.lineView.height  = self.titleLabel.height - 8.f;
        self.lineView.width   = 5.f;
        self.lineView.right   = self.width;
        self.lineView.centerY = self.titleLabel.centerY;
        
        self.subTitleLabel.left   = 10.f;
        self.subTitleLabel.bottom = self.height - 10.f;
        
    } else if (model.styleType.integerValue == 10) {
        
        self.titleLabel.top  = 10.f;
        self.titleLabel.left = 5.f + 10.f;
        
        self.lineView.height  = self.titleLabel.height - 8.f;
        self.lineView.width   = 5.f;
        self.lineView.left    = 0.f;
        self.lineView.centerY = self.titleLabel.centerY;
        
        self.subTitleLabel.left   = 10.f;
        self.subTitleLabel.bottom = self.height - 10.f;
        
    } else if (model.styleType.integerValue == 11) {
        
        self.titleLabel.top  = 10.f;
        self.titleLabel.left = 5.f + 10.f;
        
        self.lineView.height  = self.titleLabel.height - 8.f;
        self.lineView.width   = 5.f;
        self.lineView.left    = 0.f;
        self.lineView.centerY = self.titleLabel.centerY;
        
        self.subTitleLabel.right  = self.width - 10.f;
        self.subTitleLabel.bottom = self.height - 10.f;
        
    } else if (model.styleType.integerValue == 12) {
        
        self.titleLabel.top  = 15.f;
        self.titleLabel.left = 5.f;
        
        self.lineView.height  = self.titleLabel.height + 4.f;
        self.lineView.width   = self.titleLabel.right + 10.f;
        self.lineView.left    = 0.f;
        self.lineView.centerY = self.titleLabel.centerY;
        
        self.subTitleLabel.left = self.titleLabel.left;
        self.subTitleLabel.top  = self.titleLabel.bottom + 10.f;
        
    } else if (model.styleType.integerValue == 13) {
        
        self.titleLabel.top   = 15.f;
        self.titleLabel.right = self.width - 5.f;
        
        self.lineView.height  = self.titleLabel.height + 4.f;
        self.lineView.width   = self.width - self.titleLabel.left + 10.f;
        self.lineView.right   = self.width;
        self.lineView.centerY = self.titleLabel.centerY;
        
        self.subTitleLabel.right = self.titleLabel.right;
        self.subTitleLabel.top   = self.titleLabel.bottom + 10.f;
    }
}

@end
