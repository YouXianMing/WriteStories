//
//  TitleIconButton.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/16.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    
    TitleIconButtonIconType_InfoEdit = 1000,
    TitleIconButtonIconType_StyleAdjust,
    TitleIconButtonIconType_StyleManager,
    
} TitleIconButtonIconType;

@interface TitleIconButton : UIButton

@property (nonatomic) TitleIconButtonIconType iconType;

- (instancetype)initWithFrame:(CGRect)frame iconType:(TitleIconButtonIconType)iconType;

@end
