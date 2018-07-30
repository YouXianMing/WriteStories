//
//  Mark_icon.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/3.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseMarkItem.h"

@interface Mark_icon : BaseMarkItem

@property (nonatomic, strong) NSNumber *styleType;

@property (nonatomic, strong) NSString *iconFontUnicode;
@property (nonatomic, strong) NSString *iconFontName;
@property (nonatomic, strong) NSString *iconColorHex;
@property (nonatomic, strong) NSNumber *iconFontSize;
@property (nonatomic, strong) NSNumber *iconOpacity;

@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *subTitleFontFamily;
@property (nonatomic, strong) NSString *subTitleColorHex;
@property (nonatomic, strong) NSNumber *subTitleFontSize;
@property (nonatomic, strong) NSNumber *subTitleAlpha;

@property (nonatomic, strong) CAGradientViewObject *gradientObject;
@property (nonatomic, strong) NSNumber             *gradientObjectAlpha;

@end
