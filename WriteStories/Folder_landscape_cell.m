//
//  Folder_landscape_cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Folder_landscape_cell.h"
#import "Folder_landscape.h"
#import "UIView+AnimationProperty.h"
#import "UIButton+Inits.h"

@interface Folder_landscape_cell ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation Folder_landscape_cell

- (void)buildSubview {
    
    [super buildSubview];
    
    self.button                        = [[UIButton alloc] initWithFrame:CGRectMake(0, self.height - self.width, self.width, self.width)];
    self.button.userInteractionEnabled = NO;
    [self.bottomContentView addSubview:self.button];
}

- (void)loadContent {
    
    [super loadContent];
    
    Folder_landscape *data  = self.data;
    self.button.normalImage = [UIImage imageNamed:FmtStr(@"landscape-%@", data.styleType)];
}

@end
