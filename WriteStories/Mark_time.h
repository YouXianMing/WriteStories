//
//  Mark_time.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/3.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseMarkItem.h"

@interface Mark_time : BaseMarkItem

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

@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *timeFontFamily;
@property (nonatomic, strong) NSString *timeColorHex;
@property (nonatomic, strong) NSNumber *timeFontSize;
@property (nonatomic, strong) NSNumber *timeAlpha;

@property (nonatomic, strong) NSString *lineColorHex;
@property (nonatomic, strong) NSNumber *lineAlpha;

@end
