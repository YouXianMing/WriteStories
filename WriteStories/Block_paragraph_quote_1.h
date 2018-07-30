//
//  Block_paragraph_quote_1.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseBlockItem.h"

@interface Block_paragraph_quote_1 : BaseBlockItem

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *textColorHex;
@property (nonatomic, strong) NSNumber *textFontSize;
@property (nonatomic, strong) NSString *textFontName;
@property (nonatomic, strong) NSString *textAlign;

@property (nonatomic, strong) NSNumber *lineWidth;
@property (nonatomic, strong) NSString *lineColorHex;
@property (nonatomic, strong) NSNumber *lineColorHexAlpha;

@property (nonatomic, strong) NSNumber *outerTopGap;
@property (nonatomic, strong) NSNumber *outerRightGap;
@property (nonatomic, strong) NSNumber *outerBottomGap;
@property (nonatomic, strong) NSNumber *outerLeftGap;

@property (nonatomic, strong) NSNumber *innerTopGap;
@property (nonatomic, strong) NSNumber *innerRightGap;
@property (nonatomic, strong) NSNumber *innerBottomGap;
@property (nonatomic, strong) NSNumber *innerLeftGap;

@property (nonatomic, strong) NSNumber *lineHeight;     // 行间距
@property (nonatomic, strong) NSNumber *paramHeight;    // 段落间距
@property (nonatomic, strong) NSNumber *textIndent;     // 首行缩进
@property (nonatomic, strong) NSString *italic;         // 是否斜体
@property (nonatomic, strong) NSString *decorationLine; // 线条类

@property (nonatomic, strong) NSString *backgroundColorHex;
@property (nonatomic, strong) NSNumber *backgroundColorHexAlpha;

@end
