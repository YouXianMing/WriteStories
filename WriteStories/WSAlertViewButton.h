//
//  WSAlertViewButton.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/20.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSAlertView.h"

@interface WSAlertViewButton : UIButton

@property (nonatomic, readonly) WSAlertViewButtonInfo *buttonInfo;

- (void)use:(WSAlertViewButtonInfo *)buttonInfo;

@end
