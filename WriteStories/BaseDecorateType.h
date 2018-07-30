//
//  BaseDecorateType.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/24.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OutterAndInnerDivs.h"
#import "WriteStoriesBaseItemObject.h"

@interface BaseDecorateType : NSObject

/**
 处理 outter_1 ~ outter_6
 
 @param divs div配置
 */
- (void)config_js_WithOutterAndInnerDivs:(OutterAndInnerDivs *)divs;

/**
 处理 outter_1 ~ outter_6
 
 @param divs div配置
 */
- (void)config_htmlString_WithOutterAndInnerDivs:(OutterAndInnerDivs *)divs;

@end
