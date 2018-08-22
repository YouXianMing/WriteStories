//
//  NoticeInfoCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/30.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "NoticeInfoCell.h"
#import "UIView+SetRect.h"
#import "UIFont+Project.h"
#import "HexColors.h"
#import "DateFormatter.h"
#import "NSString+LabelWidthAndHeight.h"

@interface NoticeInfoCell ()

@property (nonatomic, strong) UILabel *infoLabel;

@end

@implementation NoticeInfoCell

- (void)setupCell {
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)buildSubview {
    
    self.infoLabel               = [[UILabel alloc] init];
    self.infoLabel.numberOfLines = 0;
    self.infoLabel.font          = [UIFont PingFangSC_Thin_WithFontSize:10.f];
    self.infoLabel.textColor     = [UIColor colorWithHexString:@"#6e6e6e"];
    [self.contentView addSubview:self.infoLabel];
}

- (void)loadContent {
    
    self.infoLabel.text  = self.data;
    self.infoLabel.width = Width - 30.f;
    [self.infoLabel sizeToFit];
    self.infoLabel.left  = 15.f;
    self.infoLabel.top   = 10.f;
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    NSString *text = data;
    return 10 + [text heightWithStringFont:[UIFont PingFangSC_Thin_WithFontSize:10.f] fixedWidth:Width - 30.f] + 10;
}

@end
