//
//  Block_paragraph_quote_2.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseBlockItem.h"

@interface Block_paragraph_quote_2 : BaseBlockItem

@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) NSString *textFontName;
@property (nonatomic, strong) NSString *textHexColor;
@property (nonatomic, strong) NSString *textAlign;
@property (nonatomic, strong) NSNumber *textFontSize;
@property (nonatomic, strong) NSNumber *textOpacity;

@property (nonatomic, strong) NSNumber *textTopGap;
@property (nonatomic, strong) NSNumber *textRightGap;
@property (nonatomic, strong) NSNumber *textBottomGap;
@property (nonatomic, strong) NSNumber *textLeftGap;

@property (nonatomic, strong) NSNumber *innerTopGap;
@property (nonatomic, strong) NSNumber *innerRightGap;
@property (nonatomic, strong) NSNumber *innerBottomGap;
@property (nonatomic, strong) NSNumber *innerLeftGap;

@property (nonatomic, strong) NSNumber *lineHeight;  // 行间距
@property (nonatomic, strong) NSNumber *paramHeight; // 段落间距
@property (nonatomic, strong) NSNumber *textIndent;  // 首行缩进
@property (nonatomic, strong) NSString *italic;      // 是否斜体

@property (nonatomic, strong) NSString *decorationLine;  // 线条类

@property (nonatomic, strong) NSNumber *quoteType;
@property (nonatomic, strong) NSNumber *quoteAlpha;
@property (nonatomic, strong) NSNumber *quoteScale;

@end
