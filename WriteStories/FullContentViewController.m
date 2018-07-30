//
//  FullContentViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/25.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "FullContentViewController.h"

@interface FullContentViewController ()

@end

@implementation FullContentViewController

#pragma mark - Overwrite.

- (void)makeViewsConfig:(NSMutableDictionary<NSString *,ControllerBaseViewConfig *> *)viewsConfig {
    
    {
        ControllerBaseViewConfig *config = viewsConfig[contentViewId];
        config.frame                     = self.view.bounds;
    }
    
    {
        ControllerBaseViewConfig *config = viewsConfig[titleViewId];
        config.exist                     = NO;
    }
    
    // 更新背景色
    {
        ControllerBaseViewConfig *config = viewsConfig[backgroundViewId];
        config.backgroundColor           = UIColor.BackgroundColor;
    }
}

@end
