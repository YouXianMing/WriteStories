//
//  BackgroundStyle_PureColor_Cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BackgroundStyle_PureColor_Cell.h"
#import "HexColors.h"
#import "GCD.h"

@interface BackgroundStyle_PureColor_Cell ()

@property (nonatomic)         NSInteger currentIndex;
@property (nonatomic, strong) NSArray  <UIColor *> *colors;
@property (nonatomic, strong) GCDTimer *timer;

@end

@implementation BackgroundStyle_PureColor_Cell

- (void)buildSubview {
    
    [super buildSubview];
    
    self.colors = @[[UIColor colorWithHexString:@"#ffffff"],
                    [UIColor colorWithHexString:@"#bdedff"],
                    [UIColor colorWithHexString:@"#c3fdb8"],
                    [UIColor colorWithHexString:@"#FFFFC2"],
                    [UIColor colorWithHexString:@"#fcdfff"]];
    
    self.currentIndex = 0;
    
    self.timer = [[GCDTimer alloc] initInQueue:GCDQueue.mainQueue];
    
    __weak BackgroundStyle_PureColor_Cell *weakSelf = self;
    
    [self.timer event:^{
    
        [UIView animateWithDuration:1.25f animations:^{
            
            weakSelf.areaView.backgroundColor = weakSelf.colors[(weakSelf.currentIndex + 1) % weakSelf.colors.count];
            
        } completion:^(BOOL finished) {
            
            weakSelf.currentIndex += 1;
        }];
        
    } cancelEvent:^{
        
    } timeIntervalWithSecs:2.f delaySecs:2.f];
    
    [self.timer start];
}

- (void)dealloc {
    
    [self.timer destroy];
    self.timer = nil;
}

@end
