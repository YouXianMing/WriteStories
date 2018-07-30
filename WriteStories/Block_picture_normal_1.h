//
//  Block_picture_normal_1.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/28.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseBlockItem.h"

@interface Block_picture_normal_1 : BaseBlockItem

@property (nonatomic, strong) EncodeImageObject *image;
@property (nonatomic, strong) NSNumber          *topGap;
@property (nonatomic, strong) NSNumber          *bottomGap;
@property (nonatomic, strong) NSNumber          *widthPercent; // 宽度比例

@property (nonatomic, strong) NSNumber *borderWidth;
@property (nonatomic, strong) NSString *borderStyle;
@property (nonatomic, strong) NSString *borderColorHex;
@property (nonatomic, strong) NSNumber *borderColorAlpha;
@property (nonatomic, strong) NSNumber *borderRadius;

@end
