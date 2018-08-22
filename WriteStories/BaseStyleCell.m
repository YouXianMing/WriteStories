//
//  BaseStyleCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseStyleCell.h"

@interface BaseStyleCell ()

@property (nonatomic, strong) UIView *lineView;

@end

@implementation BaseStyleCell

- (void)buildSubview {
    
    self.lineView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0.5f)];
    self.lineView.backgroundColor = UIColor.LineColor;
    [self.contentView addSubview:self.lineView];
}

- (void)loadContent {

    self.lineView.bottom = self.dataAdapter.cellHeight;
}

@end
