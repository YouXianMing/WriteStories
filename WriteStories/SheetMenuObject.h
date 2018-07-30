//
//  SheetMenuObject.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/15.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseWindowMenuView.h"

@interface SheetMenuObject : NSObject <MenuViewObject>

@property (nonatomic, strong) NSString *menuViewTitleName;
@property (nonatomic)         NSInteger menuViewTitleIndex;

+ (instancetype)sheetMenuObjectWithIndex:(NSInteger)index title:(NSString *)title;

@end
