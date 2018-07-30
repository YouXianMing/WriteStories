//
//  ShowStyleTypeManager.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/28.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ShowStyleTypeManager.h"

#import "Folder_normal_0.h"
#import "Folder_image_0.h"
#import "Folder_gradientImage.h"
#import "Folder_iconfont_0.h"
#import "Folder_snow_0.h"
#import "Folder_landscape.h"
#import "Folder_city.h"

#import "Mark_normal.h"
#import "Mark_image.h"
#import "Mark_snow_0.h"
#import "Mark_normal_2.h"
#import "Mark_gradient.h"
#import "Mark_icon.h"
#import "Mark_time.h"

#import "Block_title_normal_1.h"
#import "Block_paragraph_normal.h"
#import "Block_paragraph_quote_1.h"
#import "Block_paragraph_quote_2.h"
#import "Block_subtitle_normal_1.h"
#import "Block_subtitle_colorblock_1.h"
#import "Block_subtitle_colorblock_2.h"
#import "Block_subtitle_colorblock_3.h"
#import "Block_picture_normal_1.h"
#import "Block_picture_normal_2.h"
#import "Block_picture_normal_3.h"
#import "Block_title_picture_1.h"

#import "Html_pureColor.h"
#import "Html_patternImage.h"
#import "Html_GradientImage.h"
#import "Html_ElegantStyle.h"

static NSDictionary *_keys;

@implementation ShowStyleTypeManager

+ (void)prepare {
    
    _keys = @{
              // 文件夹
              NSStringFromClass(Folder_normal_0.class)       :  @(1000),
              NSStringFromClass(Folder_image_0.class)        :  @(1001),
              NSStringFromClass(Folder_gradientImage.class)  :  @(1002),
              NSStringFromClass(Folder_iconfont_0.class)     :  @(1003),
              NSStringFromClass(Folder_snow_0.class)         :  @(1004),
              NSStringFromClass(Folder_landscape.class)      :  @(1005),
              NSStringFromClass(Folder_city.class)           :  @(1006),
              
              // 标签
              NSStringFromClass(Mark_normal.class)    :  @(2000),
              NSStringFromClass(Mark_image.class)     :  @(2001),
              NSStringFromClass(Mark_snow_0.class)    :  @(2002),
              NSStringFromClass(Mark_normal_2.class)  :  @(2003),
              NSStringFromClass(Mark_gradient.class)  :  @(2004),
              NSStringFromClass(Mark_icon.class)      :  @(2005),
              NSStringFromClass(Mark_time.class)      :  @(2006),
              
              // 文章
              NSStringFromClass(Block_title_normal_1.class)         :  @(3000),
              NSStringFromClass(Block_paragraph_normal.class)       :  @(3001),
              NSStringFromClass(Block_paragraph_quote_1.class)      :  @(3002),
              NSStringFromClass(Block_subtitle_normal_1.class)      :  @(3003),
              NSStringFromClass(Block_picture_normal_1.class)       :  @(3004),
              NSStringFromClass(Block_subtitle_colorblock_1.class)  :  @(3005),
              NSStringFromClass(Block_subtitle_colorblock_2.class)  :  @(3006),
              NSStringFromClass(Block_subtitle_colorblock_3.class)  :  @(3007),
              NSStringFromClass(Block_picture_normal_2.class)       :  @(3008),
              NSStringFromClass(Block_picture_normal_3.class)       :  @(3009),
              NSStringFromClass(Block_title_picture_1.class)        :  @(3010),
              NSStringFromClass(Block_paragraph_quote_2.class)      :  @(3011),
              
              // body
              NSStringFromClass(Html_pureColor.class)      :  @(4000),
              NSStringFromClass(Html_patternImage.class)   :  @(4001),
              NSStringFromClass(Html_GradientImage.class)  :  @(4002),
              NSStringFromClass(Html_ElegantStyle.class)   :  @(4003),
              };
}

+ (NSInteger)showStyleTypeValueBy:(Class)itemClass {
    
    NSInteger value = [_keys[NSStringFromClass(itemClass)] integerValue];
    
    if (value < 1000) {
        
        [NSException raise:@"错误" format:@"'%@'没有加入keys中", NSStringFromClass(itemClass)];
    }
    
    return value;
}

@end
