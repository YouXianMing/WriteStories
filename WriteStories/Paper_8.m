//
//  Paper_8.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/23.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Paper_8.h"

@implementation Paper_8

- (void)config_js_WithOutterAndInnerDivs:(OutterAndInnerDivs *)divs {
    
    divs.inner_2_class = @"pa h_100 w_100 z_n2 bsbb bss";
    divs.inner_2_style = @"-webkit-border-image: url(../../../images/edgePatternImages/典雅8.png) 328 280 304 240 repeat; border-width: 164px 140px 152px 120px;";
}

- (void)config_htmlString_WithOutterAndInnerDivs:(OutterAndInnerDivs *)divs {
    
    divs.inner_2 = FmtStr(@"<div %@ %@ %@></div>",
                          _html_id(@"inner_2"),
                          _html_class(@"pa h_100 w_100 z_n2 bsbb bss"),
                          _html_style(@"-webkit-border-image: url(../../../images/edgePatternImages/典雅8.png) 328 280 304 240 repeat; border-width: 164px 140px 152px 120px;"));
}

- (NSString *)inner_1_backgroundColorHex {
    
    return @"#ffffff";
}

@end
