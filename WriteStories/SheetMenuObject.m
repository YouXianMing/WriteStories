//
//  SheetMenuObject.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/15.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "SheetMenuObject.h"

@implementation SheetMenuObject

+ (instancetype)sheetMenuObjectWithIndex:(NSInteger)index title:(NSString *)title {
    
    SheetMenuObject *menuObject   = [SheetMenuObject new];
    menuObject.menuViewTitleName  = title;
    menuObject.menuViewTitleIndex = index;
    
    return menuObject;
}

@end
