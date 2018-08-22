//
//  BaseFolderInputEditorView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/20.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseInputEditorView.h"

@interface BaseInputEditorView ()

@end

@implementation BaseInputEditorView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:CGRectMake(0, 0, Width, 0)]) {
        
        self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, self.class.titleHeight)];
        [self addSubview:self.titleView];

        UIView *leftLine         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3.f, 15.f)];
        leftLine.backgroundColor = [UIColor colorWithHexString:@"#676767"];
        leftLine.centerY         = self.titleView.middleY;
        [self.titleView addSubview:leftLine];
        
        self.label           = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 0, 300, self.titleView.height)];
        self.label.font      = [UIFont PingFangSC_Light_WithFontSize:15.f];
        self.label.textColor = [UIColor colorWithHexString:@"#303030"];
        [self.titleView addSubview:self.label];
    }
    
    return self;
}

+ (CGFloat)titleHeight {
    
    return 30.f;
}

- (void)buildSubViews {

}

- (void)updateViewHeight {
    
}

@end
