//
//  CropMaskView.m
//  CropImageContentView
//
//  Created by YouXianMing on 2018/1/15.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "MoveMaskView.h"
#import "UIView+SetRect.h"

@interface MoveMaskView ()

@property (nonatomic, strong) UIView *transparentView;
@property (nonatomic, strong) UIView *maskContentView;
@property (nonatomic, strong) UIView *leftMask;
@property (nonatomic, strong) UIView *rightMask;
@property (nonatomic, strong) UIView *topMask;
@property (nonatomic, strong) UIView *bottomMask;

@end

@implementation MoveMaskView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        
        // TransparentView
        {
            self.transparentView                 = [[UIView alloc] init];
            self.transparentView.backgroundColor = [UIColor redColor];
            [self addSubview:self.transparentView];
            
            UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
            [self.transparentView addGestureRecognizer:recognizer];
        }
        
        // MaskView
        {
            self.maskContentView = [[UIView alloc] initWithFrame:self.bounds];
            self.maskView        = self.maskContentView;
            
            self.leftMask   = [UIView new];
            self.rightMask  = [UIView new];
            self.topMask    = [UIView new];
            self.bottomMask = [UIView new];
            
            self.leftMask.backgroundColor   = [UIColor whiteColor];
            self.rightMask.backgroundColor  = [UIColor whiteColor];
            self.topMask.backgroundColor    = [UIColor whiteColor];
            self.bottomMask.backgroundColor = [UIColor whiteColor];
            
            [self.maskContentView addSubview:self.leftMask];
            [self.maskContentView addSubview:self.rightMask];
            [self.maskContentView addSubview:self.topMask];
            [self.maskContentView addSubview:self.bottomMask];
        }
    }
    
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    return CGRectContainsPoint(self.transparentView.frame, point);
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    // 拖拽
    CGPoint translation = [recognizer translationInView:self];
    
    // 获取移动view的当前的中心点
    CGPoint currentViewCenter = CGPointMake(recognizer.view.center.x + translation.x,
                                            recognizer.view.center.y + translation.y);
    
    // 控制x轴不出界
    if (currentViewCenter.x < recognizer.view.width / 2.f) {
        
        currentViewCenter.x = recognizer.view.width / 2.f;
        
    } else if (currentViewCenter.x > self.width - recognizer.view.width / 2.f) {
        
        currentViewCenter.x = self.width - recognizer.view.width / 2.f;
    }
    
    // 控制y轴不出界
    if (currentViewCenter.y < recognizer.view.height / 2.f) {
        
        currentViewCenter.y = recognizer.view.height / 2.f;
        
    } else if (currentViewCenter.y > self.height - recognizer.view.height / 2.f) {
        
        currentViewCenter.y = self.height - recognizer.view.height / 2.f;
    }
    
    // 更新dragView位置
    recognizer.view.center = currentViewCenter;
    [recognizer setTranslation:CGPointMake(0, 0) inView:self];
    
    [self updateFrame];
}

- (void)updateFrame {
    
    CGFloat transparentView_left   = self.transparentView.left;
    CGFloat transparentView_right  = self.transparentView.right;
    CGFloat transparentView_bottom = self.transparentView.bottom;
    CGFloat transparentView_top    = self.transparentView.top;

    CGFloat self_width  = self.width;
    CGFloat self_height = self.height;
    
    self.leftMask.frame   = CGRectMake(0, 0, transparentView_left, self_height);
    self.rightMask.frame  = CGRectMake(transparentView_right, 0, self_width - transparentView_right, self_height);
    self.topMask.frame    = CGRectMake(0, 0, self_width, transparentView_top);
    self.bottomMask.frame = CGRectMake(0, transparentView_bottom, self_width, self_height - transparentView_bottom);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(moveMaskView:moveFrame:)]) {
        
        [self.delegate moveMaskView:self moveFrame:self.transparentView.frame];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.maskContentView.frame = self.bounds;
}

#pragma mark - Setter & Getter.

- (void)setTransparentSize:(CGSize)transparentSize {
    
    self.transparentView.viewSize = transparentSize;
    self.transparentView.center   = self.middlePoint;
    
    [self updateFrame];
}

- (CGSize)transparentSize {
    
    return self.transparentView.viewSize;
}

@end
