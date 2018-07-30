//
//  PasswordKeyboard.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/1.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PasswordKeyboard;

@protocol PasswordKeyboardDelegate <NSObject>

- (void)passwordKeyboardDelete:(PasswordKeyboard *)keyboard;
- (void)passwordKeyboard:(PasswordKeyboard *)keyboard selectedNumber:(NSNumber *)number;

@end

@interface PasswordKeyboard : UIView

@property (nonatomic, weak) id <PasswordKeyboardDelegate> delegate;

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIFont  *numberFont;
@property (nonatomic)         CGFloat  itemHeight;

/**
 开始构建按钮
 */
- (void)buildButtons;

@end
