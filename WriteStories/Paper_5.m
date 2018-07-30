//
//  Paper_5.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/23.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Paper_5.h"

@implementation Paper_5

- (void)config_js_WithOutterAndInnerDivs:(OutterAndInnerDivs *)divs {
    
    divs.inner_2_class = @"pa h_100 w_100 z_n2 bsbb bss";
    divs.inner_2_style = @"-webkit-border-image: url(../../../images/edgePatternImages/典雅5.png) 224 224 224 224 repeat; border-width: 112px 112px 112px 112px;";
}

- (void)config_htmlString_WithOutterAndInnerDivs:(OutterAndInnerDivs *)divs {
    
    divs.inner_2 = FmtStr(@"<div %@ %@ %@></div>",
                          _html_id(@"inner_2"),
                          _html_class(@"pa h_100 w_100 z_n2 bsbb bss"),
                          _html_style(@"-webkit-border-image: url(../../../images/edgePatternImages/典雅5.png) 224 224 224 224 repeat; border-width: 112px 112px 112px 112px;"));
}

- (NSString *)inner_1_backgroundColorHex {
    
    return @"#ffffff";
}

@end
