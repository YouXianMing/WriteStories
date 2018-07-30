//
//  PopMenuObject.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/15.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "PopMenuObject.h"

@implementation PopMenuObject

+ (instancetype)popMenuObjectWithIcon:(PopMenuButtonIconType)icon type:(PopMenuButtonTitleType)type index:(NSInteger)index title:(NSString *)title {
    
    PopMenuObject *object     = [PopMenuObject new];
    object.iconType           = icon;
    object.titleType          = type;
    object.menuViewTitleIndex = index;
    object.menuViewTitleName  = title;
    
    return object;
}

@end
