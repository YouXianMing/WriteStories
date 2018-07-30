//
//  PopMenuObject.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/15.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseWindowMenuView.h"
#import "PopMenuButton.h"

@interface PopMenuObject : NSObject <MenuViewObject>

@property (nonatomic)         PopMenuButtonTitleType titleType;
@property (nonatomic)         PopMenuButtonIconType  iconType;

@property (nonatomic, strong) NSString *menuViewTitleName;
@property (nonatomic)         NSInteger menuViewTitleIndex;

+ (instancetype)popMenuObjectWithIcon:(PopMenuButtonIconType)icon type:(PopMenuButtonTitleType)type index:(NSInteger)index title:(NSString *)title;

@end
