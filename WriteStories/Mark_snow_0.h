//
//  Mark_snow_0.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/7.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseMarkItem.h"

@interface Mark_snow_0 : BaseMarkItem

@property (nonatomic, strong) NSNumber *styleType;

@property (nonatomic, strong) NSNumber *emitterAlpha;        // 透明度
@property (nonatomic, strong) NSString *emitterPureColor;    // 纯色
@property (nonatomic, strong) NSNumber *emitterMixColorType; // 多彩颜色 (无, 多彩1, 多彩2)

@end
