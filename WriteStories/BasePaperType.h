//
//  BasePaperType.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/22.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OutterAndInnerDivs.h"
#import "WriteStoriesBaseItemObject.h"

@interface BasePaperType : NSObject

@property (nonatomic, strong) NSString *inner_1_backgroundColorHex;

/**
 处理 inner_2 ~ inner_6

 @param divs div配置
 */
- (void)config_js_WithOutterAndInnerDivs:(OutterAndInnerDivs *)divs;

/**
 处理 inner_2 ~ inner_6
 
 @param divs div配置
 */
- (void)config_htmlString_WithOutterAndInnerDivs:(OutterAndInnerDivs *)divs;

@end
