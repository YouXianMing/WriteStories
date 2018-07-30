//
//  Block_picture_normal_2.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/10.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseBlockItem.h"

@interface Block_picture_normal_2 : BaseBlockItem

@property (nonatomic, strong) EncodeImageObject *image;
@property (nonatomic, strong) NSNumber          *topGap;
@property (nonatomic, strong) NSNumber          *bottomGap;
@property (nonatomic, strong) NSNumber          *widthPercent; // 宽度比例

@property (nonatomic, strong) NSNumber *borderWidth;
@property (nonatomic, strong) NSString *borderStyle;
@property (nonatomic, strong) NSString *borderColorHex;
@property (nonatomic, strong) NSNumber *borderColorAlpha;
@property (nonatomic, strong) NSNumber *borderRadius;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *titleAlign;
@property (nonatomic, strong) NSNumber *titleFontSize;
@property (nonatomic, strong) NSString *titleFontName;
@property (nonatomic, strong) NSString *titleHexColor;
@property (nonatomic, strong) NSNumber *titleHexColorAlpha;
@property (nonatomic, strong) NSNumber *gap; // 图片文字间距

@end
