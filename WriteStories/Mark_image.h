//
//  Mark_image.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/24.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseMarkItem.h"

@interface Mark_image : BaseMarkItem

@property (nonatomic, strong) NSNumber *styleType;

@property (nonatomic, strong) EncodeImageObject *image;

@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *subTitleFontFamily;
@property (nonatomic, strong) NSString *subTitleColorHex;
@property (nonatomic, strong) NSNumber *subTitleFontSize;
@property (nonatomic, strong) NSNumber *subTitleAlpha;

@property (nonatomic, strong) NSString *coverViewColorHex;
@property (nonatomic, strong) NSNumber *coverViewAlpha;

@property (nonatomic, strong) NSString *lineColorHex;
@property (nonatomic, strong) NSNumber *lineAlpha;

@end
