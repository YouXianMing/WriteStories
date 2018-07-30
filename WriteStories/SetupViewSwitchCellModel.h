//
//  SetupViewSwitchCellModel.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/1.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetupViewSwitchCellModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic) BOOL              switchOn;
@property (nonatomic) BOOL              switchEnable;

+ (instancetype)modelWithTitle:(NSString *)title
                      subTitle:(NSString *)subTitle
                      switchOn:(BOOL)switchOn
                  switchEnable:(BOOL)switchEnable;

@end
