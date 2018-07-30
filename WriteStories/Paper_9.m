//
//  Paper_9.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/23.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Paper_9.h"

@implementation Paper_9

- (void)config_js_WithOutterAndInnerDivs:(OutterAndInnerDivs *)divs {
    
    divs.inner_2_class = @"pa h_100 w_100 z_n2 bs_100_a brn";
    divs.inner_2_style = @"background-image: url(../../../images/edgePatternImages/典雅9-A.png);";
    
    divs.inner_3_class = @"pa h_100 w_100 z_n2 bs_100_a brn bgpb";
    divs.inner_3_style = @"background-image: url(../../../images/edgePatternImages/典雅9-B.png);";
}

- (void)config_htmlString_WithOutterAndInnerDivs:(OutterAndInnerDivs *)divs {
    
    divs.inner_2 = FmtStr(@"<div %@ %@ %@></div>",
                          _html_id(@"inner_2"),
                          _html_class(@"pa h_100 w_100 z_n2 bs_100_a brn"),
                          _html_style(@"background-image: url(../../../images/edgePatternImages/典雅9-A.png);"));
    
    divs.inner_3 = FmtStr(@"<div %@ %@ %@></div>",
                          _html_id(@"inner_3"),
                          _html_class(@"pa h_100 w_100 z_n2 bs_100_a brn bgpb"),
                          _html_style(@"background-image: url(../../../images/edgePatternImages/典雅9-B.png);"));
}

- (NSString *)inner_1_backgroundColorHex {
    
    return @"#ffffff";
}

@end
