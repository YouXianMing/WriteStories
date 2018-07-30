//
//  Decorate_4.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/25.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Decorate_4.h"

@implementation Decorate_4

- (void)config_js_WithOutterAndInnerDivs:(OutterAndInnerDivs *)divs {
    
    divs.out_1_class = @"pa h_100 w_100 z_n1 pen brn bs_100_a bgpt";
    divs.out_1_style = @"background-image: url(../../../images/decorateImages/点缀3-A.png); top: 0px;";
    
    divs.out_2_class = @"pa h_100 w_100 z_1 pen brn bs_100_a bgpt";
    divs.out_2_style = @"background-image: url(../../../images/decorateImages/点缀3-B.png); top: 0px;";
}

- (void)config_htmlString_WithOutterAndInnerDivs:(OutterAndInnerDivs *)divs {
    
    divs.out_1 = FmtStr(@"<div %@ %@ %@></div>",
                        _html_id(@"out_1"),
                        _html_class(@"pa h_100 w_100 z_n1 pen brn bs_100_a bgpt"),
                        _html_style(@"background-image: url(../../../images/decorateImages/点缀3-A.png); top: 0px;"));
    
    divs.out_2 = FmtStr(@"<div %@ %@ %@></div>",
                        _html_id(@"out_2"),
                        _html_class(@"pa h_100 w_100 z_1 pen brn bs_100_a bgpt"),
                        _html_style(@"background-image: url(../../../images/decorateImages/点缀3-B.png); top: 0px;"));
}

@end
