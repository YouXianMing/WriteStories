//
//  Folder_iconfont_0_cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/30.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Folder_iconfont_0_cell.h"
#import "Folder_iconfont_0.h"
#import "UIView+AnimationProperty.h"
#import "IconFontsManager.h"
#import "NSString+HexUnicode.h"

@interface Folder_iconfont_0_cell ()

@property (nonatomic, strong) UIView  *bgContentView;
@property (nonatomic, strong) UILabel *bgLabel;

@end

@implementation Folder_iconfont_0_cell

- (void)buildSubview {
    
    [super buildSubview];
    
    self.bgContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 40.f, self.width, self.height - 40.f)];
    [self.bottomContentView addSubview:self.bgContentView];
    
    self.bgLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, 40.f, self.width, self.height - 40.f)];
    self.bgLabel.textAlignment = NSTextAlignmentCenter;
    [self.bottomContentView addSubview:self.bgLabel];
}

- (void)loadContent {
    
    [super loadContent];
    
    Folder_iconfont_0 *data = self.data;
    self.bgContentView.backgroundColor = [UIColor colorWithHexString:data.contentBackgroundColorHex];
    
    self.bgLabel.font      = [UIFont fontWithName:data.iconFontName size:data.iconFontSize.floatValue];
    self.bgLabel.text      = [NSString unicodeWithHexString:data.iconFontUnicode];
    self.bgLabel.textColor = [UIColor colorWithHexString:data.iconColorHex];
    self.bgLabel.alpha     = data.iconOpacity.floatValue;
}

@end
