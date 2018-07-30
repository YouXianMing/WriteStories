//
//  BackgroundStyleObject.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BackgroundStyleObject.h"

@implementation BackgroundStyleObject

+ (BackgroundStyleObject *)objectWithTitle:(NSString *)title desInfo:(NSString *)desInfo selected:(BOOL)selected {
    
    BackgroundStyleObject *object = [BackgroundStyleObject new];
    object.title                  = title;
    object.desInfo                = desInfo;
    object.selected               = selected;
    
    return object;
}

@end
