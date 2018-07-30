//
//  Decorate_2.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/24.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Decorate_2.h"

@implementation Decorate_2

- (void)config_js_WithOutterAndInnerDivs:(OutterAndInnerDivs *)divs {
 
    divs.out_1_class = @"pa h_100 w_100 z_1 pen brn bs_100_a";
    divs.out_1_style = @"background-image: url(../../../images/decorateImages/点缀1.png); top: 0px;";
}

- (void)config_htmlString_WithOutterAndInnerDivs:(OutterAndInnerDivs *)divs {
    
    divs.out_1 = FmtStr(@"<div %@ %@ %@></div>",
                        _html_id(@"out_1"),
                        _html_class(@"pa h_100 w_100 z_1 pen brn bs_100_a"),
                        _html_style(@"background-image: url(../../../images/decorateImages/点缀1.png); top: 0px;"));
}

@end
