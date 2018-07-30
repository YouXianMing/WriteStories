//
//  CircleIconButton.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/25.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    
    CircleIconButtonType_Back = 1000,
    CircleIconButtonType_Edit,
    CircleIconButtonType_More,
    CircleIconButtonType_See,
    CircleIconButtonType_Close,
    CircleIconButtonType_Background,
    
} CircleIconButtonType;

@interface CircleIconButton : UIButton

- (instancetype)initWithType:(CircleIconButtonType)type;

@end
