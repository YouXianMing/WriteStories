//
//  Folder_city_cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/4.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Folder_city_cell.h"
#import "Folder_city.h"
#import "UIView+AnimationProperty.h"
#import "UIButton+Inits.h"
#import "Math.h"
#import "UIView+SetRect.h"
#import "FileManager.h"

@interface Folder_city_cell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation Folder_city_cell

- (void)buildSubview {
    
    [super buildSubview];
    
    CGSize size           = [Math resetFromSize:CGSizeMake(217, 161) withFixedWidth:self.width - 20.f];
    self.imageView        = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    self.imageView.center = self.middlePoint;
    self.imageView.bottom = self.height - 20.f;
    [self.contentView addSubview:self.imageView];
}

- (void)loadContent {
    
    [super loadContent];
        
    Folder_city *data    = self.data;
    self.imageView.image = [UIImage imageNamed:FmtStr(@"city-%@", data.styleType)];
}

@end
