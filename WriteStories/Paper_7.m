//
//  Paper_7.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/23.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Paper_7.h"

@implementation Paper_7

- (void)config_js_WithOutterAndInnerDivs:(OutterAndInnerDivs *)divs {
    
    divs.inner_2_class = @"pa h_100 w_100 z_n2 bsbb bss";
    divs.inner_2_style = @"-webkit-border-image: url(../../../images/edgePatternImages/典雅7.png) 250 226 250 226 repeat; border-width: 125px 113px 125px 113px;";
}

- (void)config_htmlString_WithOutterAndInnerDivs:(OutterAndInnerDivs *)divs {
    
    divs.inner_2 = FmtStr(@"<div %@ %@ %@></div>",
                          _html_id(@"inner_2"),
                          _html_class(@"pa h_100 w_100 z_n2 bsbb bss"),
                          _html_style(@"-webkit-border-image: url(../../../images/edgePatternImages/典雅7.png) 250 226 250 226 repeat; border-width: 125px 113px 125px 113px;"));
}

- (NSString *)inner_1_backgroundColorHex {
    
    return @"#ffffff";
}

@end
