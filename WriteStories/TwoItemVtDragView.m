//
//  TwoItemVtDragView.m
//  DragAndCrop
//
//  Created by YouXianMing on 2018/1/25.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "TwoItemVtDragView.h"
#import "UIView+SetRect.h"
#import "HexColors.h"

@interface TwoItemVtDragView () {
    
    CGFloat _gap;
    CGFloat _innerHeight;
}

@property (nonatomic, strong) UIView      *moveView_1;
@property (nonatomic, strong) UIView      *moveView_2;

@property (nonatomic, strong) UIImageView *imageView_1;
@property (nonatomic, strong) UIImageView *imageView_2;

@property (nonatomic, strong) UIImageView *centerImageView;

@end

@implementation TwoItemVtDragView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.centerImageView = [[UIImageView alloc] init];
        [self addSubview:self.centerImageView];
        
        self.moveView_1 = [[UIView alloc] init];
        // [self.moveView_1 showRandomColorOutline];
        [self addSubview:self.moveView_1];
        
        self.moveView_2 = [[UIView alloc] init];
        // [self.moveView_2 showRandomColorOutline];
        [self addSubview:self.moveView_2];
        
        {
            UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
            [self.moveView_1 addGestureRecognizer:recognizer];
        }
        
        {
            UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
            [self.moveView_2 addGestureRecognizer:recognizer];
        }
        
        self.imageView_1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"渐变色小块A"]];
        [self.moveView_1 addSubview:self.imageView_1];
        
        self.imageView_2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"渐变色小块B"]];
        [self.moveView_2 addSubview:self.imageView_2];
    }
    
    return self;
}

- (void)setupWithGap:(CGFloat)gap itemSize:(CGSize)itemSize startLocation:(CGFloat)startLocation endLocation:(CGFloat)endLocation {
    
    _gap         = gap;
    _innerHeight = self.height - 2 * gap;
    
    self.moveView_1.viewSize = itemSize;
    self.moveView_2.viewSize = itemSize;
    
    self.centerImageView.width               = 5.f;
    self.centerImageView.layer.cornerRadius  = 2.5f;
    self.centerImageView.layer.masksToBounds = YES;
    self.centerImageView.backgroundColor     = [UIColor colorWithHexString:@"#D2DFEC"];
    self.centerImageView.height              = self.height - 2 * _gap;
    self.centerImageView.center              = self.middlePoint;
    
    self.moveView_1.center = CGPointMake(self.width / 2.f, gap + _innerHeight * startLocation);
    self.moveView_2.center = CGPointMake(self.width / 2.f, gap + _innerHeight * endLocation);
    
    self.imageView_1.center = self.moveView_1.middlePoint;
    self.imageView_2.center = self.moveView_2.middlePoint;
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        

        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        if ([recognizer.view isEqual:self.moveView_1]) {
            
            // 拖拽
            CGPoint translation = [recognizer translationInView:self];
            
            // 获取移动view的当前的中心点
            CGPoint currentViewCenter = CGPointMake(recognizer.view.center.x + translation.x,
                                                    recognizer.view.center.y + translation.y);
            
            currentViewCenter.x = self.width / 2.f;
            
            // 控制y轴不出界
            if (currentViewCenter.y < _gap) {
                
                currentViewCenter.y = _gap;
                
            } else if (currentViewCenter.y > self.moveView_2.centerY) {
                
                currentViewCenter.y = self.moveView_2.centerY;
            }
            
            // 更新dragView位置
            recognizer.view.center = currentViewCenter;
            [recognizer setTranslation:CGPointMake(0, 0) inView:self];
            
        } else if ([recognizer.view isEqual:self.moveView_2]) {
            
            // 拖拽
            CGPoint translation = [recognizer translationInView:self];
            
            // 获取移动view的当前的中心点
            CGPoint currentViewCenter = CGPointMake(recognizer.view.center.x + translation.x,
                                                    recognizer.view.center.y + translation.y);
            
            currentViewCenter.x = self.width / 2.f;
            
            // 控制y轴不出界
            
            if (currentViewCenter.y < self.moveView_1.centerY) {
                
                if (currentViewCenter.y < _gap) {
                    
                    currentViewCenter.y = _gap;
                }
                
                self.moveView_1.centerY = currentViewCenter.y;
                
            } else if (currentViewCenter.y > _innerHeight + _gap) {
                
                currentViewCenter.y = _innerHeight + _gap;
            }
            
            // 更新dragView位置
            recognizer.view.center = currentViewCenter;
            [recognizer setTranslation:CGPointMake(0, 0) inView:self];
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(twoItemVtDragView:startLocation:endLocation:)]) {
            
            [self.delegate twoItemVtDragView:self
                               startLocation:(self.moveView_1.centerY - _gap) / _innerHeight
                                 endLocation:(self.moveView_2.centerY - _gap) / _innerHeight];
        }
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        
        
    }
}

@end
