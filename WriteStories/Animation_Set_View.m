//
//  Animation_Set_View.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Animation_Set_View.h"
#import "BaseAnimationView.h"

@interface Animation_Set_View () {
    
    CGRect _currentFrame;
}

@property (nonatomic, strong) BaseAnimationView *currentAnimationView;

@end

@implementation Animation_Set_View

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
    
        self.userInteractionEnabled = NO;
    }
    
    return self;
}

- (void)startObserveValue {
    
    [self.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    CGSize size = [change[@"new"] CGSizeValue];
    
    if (CGRectEqualToRect(_currentFrame, CGRectMake(0, 0, Width, size.height)) == YES) {
        
        return;
    }
    
    self.frame    = CGRectMake(0, 0, Width, size.height);
    _currentFrame = self.frame;
    
    // 更新AnimationView的frame值
    self.currentAnimationView.frame = self.bounds;
    [self.currentAnimationView didUpdateFrame];
}

- (void)firstTimeLoadAnimation_Set:(Animation_Set *)aniSet {
    
    self.alpha                = aniSet.opacity.floatValue;
    self.currentAnimationView = [NSClassFromString(FmtStr(@"Animation_%@", aniSet.animationType)) defaultView];
    [self addSubview:self.currentAnimationView];
}

- (void)loadAnimation_Set:(Animation_Set *)aniSet {
    
    // 更新透明度
    self.alpha = aniSet.opacity.floatValue;
    
    if ([self.currentAnimationView isKindOfClass:NSClassFromString(FmtStr(@"Animation_%@", aniSet.animationType))]) {
      
        // 如果为同一个view,则不进行修改
        return;
        
    } else {
        
        // 移除之前的view
        [self.currentAnimationView removeFromSuperview];
        
        // 添加新view
        self.currentAnimationView = [NSClassFromString(FmtStr(@"Animation_%@", aniSet.animationType)) defaultView];
        [self addSubview:self.currentAnimationView];
    }
}

- (void)dealloc {
    
    [self.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

@end
