//
//  SetupViewSpaceCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/1.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "SetupViewSpaceCell.h"
#import "UIColor+Project.h"
#import "UIView+SetRect.h"

@implementation SetupViewSpaceCell

- (void)setupCell {
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)buildSubview {
    
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 19.5f, Width, 0.5f)];
    line.backgroundColor = [UIColor.LineColor colorWithAlphaComponent:0.5];
    [self.contentView addSubview:line];
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    return 20.f;
}

@end
