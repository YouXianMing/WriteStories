//
//  BackgroundStyleObject.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WriteStoriesBaseItemObject.h"

@interface BackgroundStyleObject : NSObject

@property (nonatomic) WriteStoriesBaseItemObjectPaymantState paymentState;
@property (nonatomic, strong) NSString *paymentID;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desInfo;
@property (nonatomic) BOOL              selected;

+ (BackgroundStyleObject *)objectWithTitle:(NSString *)title
                                   desInfo:(NSString *)desInfo
                                  selected:(BOOL)selected;

@end
