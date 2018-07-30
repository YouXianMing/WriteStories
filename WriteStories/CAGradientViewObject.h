//
//  CAGradientViewObject.h
//  GradientView
//
//  Created by YouXianMing on 2018/1/23.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseEncodeObject.h"

@interface CAGradientViewObject : BaseEncodeObject

// 颜色相关
@property (nonatomic, strong) NSString *gradientHexColor_1;
@property (nonatomic, strong) NSString *gradientHexColor_2;
@property (nonatomic, strong) NSNumber *gradientColor_1_alpha;
@property (nonatomic, strong) NSNumber *gradientColor_2_alpha;

// 位置相关
@property (nonatomic, strong) NSNumber *gradientColor_1_location;
@property (nonatomic, strong) NSNumber *gradientColor_2_location;

// 开始点,结束点
@property (nonatomic, strong) NSValue *startPoint;
@property (nonatomic, strong) NSValue *endPoint;

@end
