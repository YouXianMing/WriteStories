//
//  BaseAnimationView.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAEmitterView.h"
#import "UIView+SetRect.h"
#import "Math.h"

@interface BaseAnimationView : UIView

+ (BaseAnimationView *)defaultView;

/**
 子类重写
 */
- (void)buildSubViews;

/**
 子类重写
 */
- (void)didUpdateFrame;

@end
