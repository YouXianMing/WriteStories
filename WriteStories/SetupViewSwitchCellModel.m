//
//  SetupViewSwitchCellModel.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/1.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "SetupViewSwitchCellModel.h"

@implementation SetupViewSwitchCellModel

+ (instancetype)modelWithTitle:(NSString *)title
                      subTitle:(NSString *)subTitle
                      switchOn:(BOOL)switchOn
                  switchEnable:(BOOL)switchEnable {
    
    SetupViewSwitchCellModel *model = [SetupViewSwitchCellModel new];
    model.title                     = title;
    model.subTitle                  = subTitle;
    model.switchOn                  = switchOn;
    model.switchEnable              = switchEnable;
    
    return model;
}

@end
