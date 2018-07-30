//
//  BaseWindowMenuView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/24.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseWindowMenuView.h"

@interface BaseWindowMenuView ()

@property (nonatomic, strong) UIButton  *backgroundButton;
@property (nonatomic, weak)   UIWindow  *keyWindow;

@end

@implementation BaseWindowMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self.keyWindow = [UIApplication sharedApplication].keyWindow;
    
    if (self = [super initWithFrame:self.keyWindow.bounds]) {
    
        self.backgroundButton                 = [[UIButton alloc] initWithFrame:self.keyWindow.bounds];
        self.backgroundButton.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backgroundButton];
    }
    
    return self;
}

- (void)show {
    
    [self.keyWindow addSubview:self];
    
    // willShow
    if (self.delegate && [self.delegate respondsToSelector:@selector(windowMenuViewWillShow:)]) {
        
        [self.delegate windowMenuViewWillShow:self];
    }
    
    // 构建子view
    [self buildSubViews];
    [self startManualShowAnimation];
    
    [UIView animateWithDuration:self.class.ShowAnimationTime animations:^{
        
        [self startSystemShowAnimation];
        self.backgroundButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.15];
        
    } completion:^(BOOL finished) {
        
        [self didCompleteShowAnimation];
        
        // didShow
        if (self.delegate && [self.delegate respondsToSelector:@selector(windowMenuViewDidShow:)]) {
            
            [self.delegate windowMenuViewDidShow:self];
        }
        
        if (self.class.IsEnableBackgroundButton) {
            
            [self.backgroundButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        }
    }];
}

- (void)showAtPoint:(CGPoint)point {
    
    [self show];
}

- (void)hide {
    
    // willHide
    if (self.delegate && [self.delegate respondsToSelector:@selector(windowMenuViewWillHide:)]) {
        
        [self.delegate windowMenuViewWillHide:self];
    }
    
    [self startManualHideAnimation];
    
    [UIView animateWithDuration:self.class.HideAnimationTime animations:^{
        
        [self startSystemHideAnimation];
        self.backgroundButton.backgroundColor = [UIColor clearColor];
        
    } completion:^(BOOL finished) {
        
        // didHide
        if (self.delegate && [self.delegate respondsToSelector:@selector(windowMenuViewDidHide:)]) {
            
            [self.delegate windowMenuViewDidHide:self];
        }
        
        [self didCompleteHideAnimation];
        
        [self removeFromSuperview];
    }];
}

#pragma mark - 类属性

+ (BOOL)IsEnableBackgroundButton {
    
    return YES;
}

+ (CGFloat)ShowAnimationTime {
    
    return 0.45f;
}

+ (CGFloat)HideAnimationTime {
    
    return 0.25f;
}

#pragma mark - 子类重写的方法

- (void)buildSubViews {
    
}

- (void)startManualShowAnimation {
    
}

- (void)startSystemShowAnimation {
    
}

- (void)didCompleteShowAnimation {
    
}

- (void)startManualHideAnimation {
    
}

- (void)startSystemHideAnimation {
    
}

- (void)didCompleteHideAnimation {
    
}

#pragma mark - 便利构造器

+ (instancetype)menuViewWithDelegate:(id <BaseWindowMenuViewDelegate>)delegate weakObject:(id)weakObject datas:(NSArray <MenuViewObject> *)datas {
    
    BaseWindowMenuView *menuView = [[self class] new];
    
    menuView.delegate   = delegate;
    menuView.weakObject = weakObject;
    menuView.datas      = datas;
    
    return menuView;
}

+ (instancetype)menuViewWithDelegate:(id <BaseWindowMenuViewDelegate>)delegate datas:(NSArray <MenuViewObject> *)datas {
    
    BaseWindowMenuView *menuView = [[self class] new];
    
    menuView.delegate = delegate;
    menuView.datas    = datas;
    
    return menuView;
}

#pragma mark - 其他

- (void)dealloc {
    
    NSLog(@"%@ dealloced.", NSStringFromClass(self.class));
}

@end
