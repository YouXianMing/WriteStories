//
//  PopMenuButton.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/15.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    
    PopMenuButtonIconTypeAdd = 1000,
    PopMenuButtonIconTypeSort,
    PopMenuButtonIconTypeChange,
    PopMenuButtonIconTypeLoadFile,
    PopMenuButtonIconTypeBackgroundAdjust,
    PopMenuButtonIconTypeBackgroundManager,
    PopMenuButtonIconTypeAnimationSet,
    
} PopMenuButtonIconType;

typedef enum : NSUInteger {
    
    PopMenuButtonTitleTypeNormal = 2000,
    PopMenuButtonTitleTypeCyanBold,
    
} PopMenuButtonTitleType;

@interface PopMenuButton : UIButton

- (instancetype)initWithFrame:(CGRect)frame icon:(PopMenuButtonIconType)icon titleType:(PopMenuButtonTitleType)titleType title:(NSString *)title;

@property (nonatomic, weak) id weakObject;

@property (nonatomic, readonly) CGFloat effectiveWidth;

@end
