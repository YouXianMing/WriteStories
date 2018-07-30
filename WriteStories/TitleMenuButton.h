//
//  TitleMenuButton.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/24.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    
    TitleMenuButton_Back = 1000,
    TitleMenuButton_Close,
    TitleMenuButton_Setup,
    TitleMenuButton_More,
    TitleMenuButton_Save,
    TitleMenuButton_Wifi,
    
} TitleMenuButtonType;

@interface TitleMenuButton : UIButton

- (instancetype)initWithFrame:(CGRect)frame type:(TitleMenuButtonType)type;

@end
