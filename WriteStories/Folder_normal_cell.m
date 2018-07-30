//
//  Forlder_normal_0_cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/15.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Folder_normal_cell.h"
#import "Folder_normal_0.h"
#import "UIView+AnimationProperty.h"

@interface Folder_normal_cell ()

@property (nonatomic, strong) UIView  *bgContentView;
@property (nonatomic, strong) UILabel *bgLabel;

@end

@implementation Folder_normal_cell

- (void)buildSubview {
    
    [super buildSubview];
    
    self.bgContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 40.f, self.width, self.height - 40.f)];
    [self.bottomContentView addSubview:self.bgContentView];
    
    self.bgLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, 40.f, self.width, self.height - 40.f)];
    self.bgLabel.numberOfLines = 2;
    self.bgLabel.textAlignment = NSTextAlignmentCenter;
    [self.bottomContentView addSubview:self.bgLabel];
}

- (void)loadContent {
    
    [super loadContent];
    
    Folder_normal_0 *data = self.data;
    
    self.bgContentView.backgroundColor = [UIColor colorWithHexString:data.contentBackgroundColorHex];
    self.bgLabel.angle                 = M_PI_4;
    self.bgLabel.text                  = data.title;
    self.bgLabel.font                  = [UIFont fontWithName:data.contentLabelFontFamily size:28.f];
    self.bgLabel.textColor             = [UIColor colorWithHexString:data.contentLabelColorHex];
    
    if ([data.styleType isEqual:@(1)]) {
        
        self.bgLabel.angle = M_PI_4;
        
    } else if ([data.styleType isEqual:@(2)]) {
        
        self.bgLabel.angle = -M_PI_4;
    }
}

@end
