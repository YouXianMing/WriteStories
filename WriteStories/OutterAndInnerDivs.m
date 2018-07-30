//
//  OutterAndInnerDivs.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/16.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "OutterAndInnerDivs.h"
#import "WriteStoriesBaseItemObject.h"
#import "NSDictionary+JSONData.h"

@implementation OutterAndInnerDivs

- (NSString *)htmlString {
    
    NSMutableString *string = [NSMutableString string];
    
    [string appendString: self.body.length ? self.body : FmtStr(@"<body %@ %@ %@>", _html_id(@"body"), _html_class(@" "), _html_style(@" "))];
    
    [string appendString: self.out_1.length ? self.out_1 : FmtStr(@"<div %@ %@ %@></div>", _html_id(@"out_1"), _html_class(@"pa"), _html_style(@"opacity: 0;"))];
    [string appendString: self.out_2.length ? self.out_2 : FmtStr(@"<div %@ %@ %@></div>", _html_id(@"out_2"), _html_class(@"pa"), _html_style(@"opacity: 0;"))];
    [string appendString: self.out_3.length ? self.out_3 : FmtStr(@"<div %@ %@ %@></div>", _html_id(@"out_3"), _html_class(@"pa"), _html_style(@"opacity: 0;"))];
    [string appendString: self.out_4.length ? self.out_4 : FmtStr(@"<div %@ %@ %@></div>", _html_id(@"out_4"), _html_class(@"pa"), _html_style(@"opacity: 0;"))];
    [string appendString: self.out_5.length ? self.out_5 : FmtStr(@"<div %@ %@ %@></div>", _html_id(@"out_5"), _html_class(@"pa"), _html_style(@"opacity: 0;"))];
    [string appendString: self.out_6.length ? self.out_6 : FmtStr(@"<div %@ %@ %@></div>", _html_id(@"out_6"), _html_class(@"pa"), _html_style(@"opacity: 0;"))];
    
    [string appendString: self.container.length ? self.container : FmtStr(@"<div %@ %@ %@>", _html_id(@"container"), _html_class(@" "), _html_style(@" "))];
    
    [string appendString: self.inner_1.length ? self.inner_1 : FmtStr(@"<div %@ %@ %@></div>", _html_id(@"inner_1"), _html_class(@"pa"), _html_style(@"opacity: 0;"))];
    [string appendString: self.inner_2.length ? self.inner_2 : FmtStr(@"<div %@ %@ %@></div>", _html_id(@"inner_2"), _html_class(@"pa"), _html_style(@"opacity: 0;"))];
    [string appendString: self.inner_3.length ? self.inner_3 : FmtStr(@"<div %@ %@ %@></div>", _html_id(@"inner_3"), _html_class(@"pa"), _html_style(@"opacity: 0;"))];
    [string appendString: self.inner_4.length ? self.inner_4 : FmtStr(@"<div %@ %@ %@></div>", _html_id(@"inner_4"), _html_class(@"pa"), _html_style(@"opacity: 0;"))];
    [string appendString: self.inner_5.length ? self.inner_5 : FmtStr(@"<div %@ %@ %@></div>", _html_id(@"inner_5"), _html_class(@"pa"), _html_style(@"opacity: 0;"))];
    [string appendString: self.inner_6.length ? self.inner_6 : FmtStr(@"<div %@ %@ %@></div>", _html_id(@"inner_6"), _html_class(@"pa"), _html_style(@"opacity: 0;"))];
    
    return string;
}

- (NSString *)jsConfig {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[@"body"] = @{@"class" : self.body_class.length ? self.body_class : @" ",
                     @"style" : self.body_style.length ? self.body_style : @" "};
    
    dic[@"out_1"] = @{@"class" : self.out_1_class.length ? self.out_1_class : @"pa",
                      @"style" : self.out_1_style.length ? self.out_1_style : @"opacity: 0;"};
    
    dic[@"out_2"] = @{@"class" : self.out_2_class.length ? self.out_2_class : @"pa",
                      @"style" : self.out_2_style.length ? self.out_2_style : @"opacity: 0;"};
    
    dic[@"out_3"] = @{@"class" : self.out_3_class.length ? self.out_3_class : @"pa",
                      @"style" : self.out_3_style.length ? self.out_3_style : @"opacity: 0;"};
    
    dic[@"out_4"] = @{@"class" : self.out_4_class.length ? self.out_4_class : @"pa",
                      @"style" : self.out_4_style.length ? self.out_4_style : @"opacity: 0;"};
    
    dic[@"out_5"] = @{@"class" : self.out_5_class.length ? self.out_5_class : @"pa",
                      @"style" : self.out_5_style.length ? self.out_5_style : @"opacity: 0;"};
    
    dic[@"out_6"] = @{@"class" : self.out_6_class.length ? self.out_6_class : @"pa",
                      @"style" : self.out_6_style.length ? self.out_6_style : @"opacity: 0;"};
    
    dic[@"container"] = @{@"class" : self.container_class.length ? self.container_class : @" ",
                          @"style" : self.container_style.length ? self.container_style : @" "};
    
    dic[@"inner_1"] = @{@"class" : self.inner_1_class.length ? self.inner_1_class : @"pa",
                        @"style" : self.inner_1_style.length ? self.inner_1_style : @"opacity: 0;"};
    
    dic[@"inner_2"] = @{@"class" : self.inner_2_class.length ? self.inner_2_class : @"pa",
                        @"style" : self.inner_2_style.length ? self.inner_2_style : @"opacity: 0;"};
    
    dic[@"inner_3"] = @{@"class" : self.inner_3_class.length ? self.inner_3_class : @"pa",
                        @"style" : self.inner_3_style.length ? self.inner_3_style : @"opacity: 0;"};
    
    dic[@"inner_4"] = @{@"class" : self.inner_4_class.length ? self.inner_4_class : @"pa",
                        @"style" : self.inner_4_style.length ? self.inner_4_style : @"opacity: 0;"};
    
    dic[@"inner_5"] = @{@"class" : self.inner_5_class.length ? self.inner_5_class : @"pa",
                        @"style" : self.inner_5_style.length ? self.inner_5_style : @"opacity: 0;"};
    
    dic[@"inner_6"] = @{@"class" : self.inner_6_class.length ? self.inner_6_class : @"pa",
                        @"style" : self.inner_6_style.length ? self.inner_6_style : @"opacity: 0;"};
    
    return dic.toJSONString;
}

@end
