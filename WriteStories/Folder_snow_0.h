//
//  Folder_snow_0.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/6.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseFolderItem.h"

@interface Folder_snow_0 : BaseFolderItem

@property (nonatomic, strong) NSNumber *styleType;
@property (nonatomic, strong) NSString *contentBackgroundColorHex;
@property (nonatomic, strong) NSString *contentLabelColorHex;
@property (nonatomic, strong) NSString *contentLabelFontFamily;

@property (nonatomic, strong) NSString *emitterPureColor;    // 纯色
@property (nonatomic, strong) NSNumber *emitterMixColorType; // 多彩颜色 (无, 多彩1, 多彩2)

@end
