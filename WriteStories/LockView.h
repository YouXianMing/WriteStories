//
//  LockView.h
//  LockButton
//
//  Created by YouXianMing on 2018/1/16.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    
    ELockViewStateUnlock,
    ELockViewStateLock,
    
} ELockViewState;

@interface LockView : UIView

- (void)changeToState:(ELockViewState)state animated:(BOOL)animated;

@end
