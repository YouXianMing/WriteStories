//
//  Decorate_3.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/25.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Decorate_3.h"

@implementation Decorate_3

- (void)config_js_WithOutterAndInnerDivs:(OutterAndInnerDivs *)divs {
    
    divs.out_1_class = @"pa h_100 w_100 z_1 pen brn bs_100_a bgpt";
    divs.out_1_style = @"background-image: url(../../../images/decorateImages/点缀2.png); top: 0px;";
}

- (void)config_htmlString_WithOutterAndInnerDivs:(OutterAndInnerDivs *)divs {
    
    divs.out_1 = FmtStr(@"<div %@ %@ %@></div>",
                        _html_id(@"out_1"),
                        _html_class(@"pa h_100 w_100 z_1 pen brn bs_100_a bgpt"),
                        _html_style(@"background-image: url(../../../images/decorateImages/点缀2.png); top: 0px;"));
}

@end
