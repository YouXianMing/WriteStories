//
//  Html_GradientImage.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/16.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseHtmlBodyItem.h"

@interface Html_GradientImage : BaseHtmlBodyItem

@property (nonatomic, strong) NSString *backgroundImageName; // 背景图名字
@property (nonatomic, strong) NSString *backgroundColorHex;  // 背景色

@property (nonatomic, strong) NSNumber *containerGapTop;    // 容器上边距
@property (nonatomic, strong) NSNumber *containerGapRight;  // 容器右边距
@property (nonatomic, strong) NSNumber *containerGapBottom; // 容器下边距
@property (nonatomic, strong) NSNumber *containerGapLeft;   // 容器左边距

@property (nonatomic, strong) NSNumber *containerHexColorAlpha; // 容器背景色透明度
@property (nonatomic, strong) NSString *containerHexColor;      // 容器背景色

@property (nonatomic, strong) NSNumber *containerCornerRadius; // 容器圆角

@property (nonatomic, strong) NSNumber *shadowOffsetX;
@property (nonatomic, strong) NSNumber *shadowOffsetY;
@property (nonatomic, strong) NSNumber *shadowBlur;
@property (nonatomic, strong) NSString *shadowHexColor;
@property (nonatomic, strong) NSNumber *shadowHexColorAlpha;

@property (nonatomic, strong) NSNumber *bottomGap;    // 底部长度

@end
