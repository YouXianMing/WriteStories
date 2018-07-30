//
//  Block_title_picture_1.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/18.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseBlockItem.h"

@interface Block_title_picture_1 : BaseBlockItem

@property (nonatomic, strong) EncodeImageObject *image;
@property (nonatomic, strong) NSNumber          *topGap;
@property (nonatomic, strong) NSNumber          *bottomGap;

@property (nonatomic, strong) NSString *coverHexColor;
@property (nonatomic, strong) NSNumber *coverHexColorAlpha;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *titleFontName;
@property (nonatomic, strong) NSString *titleHexColor;
@property (nonatomic, strong) NSString *titleAlign;
@property (nonatomic, strong) NSNumber *titleFontSize;
@property (nonatomic, strong) NSNumber *titleBottomGap;

@end
