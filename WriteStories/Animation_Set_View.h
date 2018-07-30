//
//  Animation_Set_View.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animation_Set.h"

@interface Animation_Set_View : UIView

@property (nonatomic, weak) UIScrollView *scrollView;

- (void)startObserveValue;

- (void)firstTimeLoadAnimation_Set:(Animation_Set *)set;

- (void)loadAnimation_Set:(Animation_Set *)set;

@end
