//
//  OutterAndInnerDivs.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/16.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OutterAndInnerDivs : NSObject

@property (nonatomic, strong) NSString *body;

@property (nonatomic, strong) NSString *out_1;
@property (nonatomic, strong) NSString *out_2;
@property (nonatomic, strong) NSString *out_3;
@property (nonatomic, strong) NSString *out_4;
@property (nonatomic, strong) NSString *out_5;
@property (nonatomic, strong) NSString *out_6;

@property (nonatomic, strong) NSString *container;

@property (nonatomic, strong) NSString *inner_1;
@property (nonatomic, strong) NSString *inner_2;
@property (nonatomic, strong) NSString *inner_3;
@property (nonatomic, strong) NSString *inner_4;
@property (nonatomic, strong) NSString *inner_5;
@property (nonatomic, strong) NSString *inner_6;

- (NSString *)htmlString;

@property (nonatomic, strong) NSString *body_class;

@property (nonatomic, strong) NSString *out_1_class;
@property (nonatomic, strong) NSString *out_2_class;
@property (nonatomic, strong) NSString *out_3_class;
@property (nonatomic, strong) NSString *out_4_class;
@property (nonatomic, strong) NSString *out_5_class;
@property (nonatomic, strong) NSString *out_6_class;

@property (nonatomic, strong) NSString *container_class;

@property (nonatomic, strong) NSString *inner_1_class;
@property (nonatomic, strong) NSString *inner_2_class;
@property (nonatomic, strong) NSString *inner_3_class;
@property (nonatomic, strong) NSString *inner_4_class;
@property (nonatomic, strong) NSString *inner_5_class;
@property (nonatomic, strong) NSString *inner_6_class;

@property (nonatomic, strong) NSString *body_style;

@property (nonatomic, strong) NSString *out_1_style;
@property (nonatomic, strong) NSString *out_2_style;
@property (nonatomic, strong) NSString *out_3_style;
@property (nonatomic, strong) NSString *out_4_style;
@property (nonatomic, strong) NSString *out_5_style;
@property (nonatomic, strong) NSString *out_6_style;

@property (nonatomic, strong) NSString *container_style;

@property (nonatomic, strong) NSString *inner_1_style;
@property (nonatomic, strong) NSString *inner_2_style;
@property (nonatomic, strong) NSString *inner_3_style;
@property (nonatomic, strong) NSString *inner_4_style;
@property (nonatomic, strong) NSString *inner_5_style;
@property (nonatomic, strong) NSString *inner_6_style;

- (NSString *)jsConfig;

@end
