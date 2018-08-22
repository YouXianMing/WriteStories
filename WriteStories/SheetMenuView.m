//
//  SheetMenuView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/15.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "SheetMenuView.h"
#import "SheetMenuButton.h"
#import "DeviceInfo.h"
#import "UIColor+Project.h"
#import "UIView+SetRect.h"
#import "UIButton+Inits.h"
#import "UIFont+Project.h"
#import "YXEasing.h"

@interface SheetMenuView ()

@property (nonatomic, strong) UIView          *contentView;
@property (nonatomic, weak)   SheetMenuButton *tapedButton;

@end

@implementation SheetMenuView

- (void)buildSubViews {
    
    CGFloat itemHeight = 60.f;
    
    self.contentView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 15 + itemHeight + 15 + itemHeight * self.datas.count)];
    self.contentView.top             = Height;
    [self addSubview:self.contentView];
    
    UIButton *cancelButton           = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.frame               = CGRectMake(15.f, 0, Width - 30.f, itemHeight);
    cancelButton.backgroundColor     = [UIColor whiteColor];
    cancelButton.layer.cornerRadius  = 10.f;
    cancelButton.layer.masksToBounds = YES;
    cancelButton.tintColor           = [UIColor redColor];
    cancelButton.normalTitle         = @"取消";
    cancelButton.titleLabel.font     = [UIFont PingFangSC_Medium_WithFontSize:22.f];
    [cancelButton addTarget:self action:@selector(hide)];
    [self.contentView addSubview:cancelButton];
    
    UIView *whiteView             = [[UIView alloc] initWithFrame:CGRectMake(15.f, 0, Width - 30.f, self.datas.count * itemHeight)];
    whiteView.backgroundColor     = [UIColor whiteColor];
    whiteView.bottom              = self.contentView.height - 15 - itemHeight - 15.f;
    whiteView.layer.cornerRadius  = 10.f;
    whiteView.layer.masksToBounds = YES;
    [self.contentView addSubview:whiteView];
    
    [self.datas enumerateObjectsUsingBlock:^(id<MenuViewObject>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        SheetMenuButton *button = [[SheetMenuButton alloc] initWithFrame:CGRectMake(0, idx * itemHeight, whiteView.width, itemHeight)];
        button.title            = obj.menuViewTitleName;
        button.weakObject       = obj;
        [button addTarget:self action:@selector(buttonsEvent:)];
        [whiteView addSubview:button];
    }];
    
    cancelButton.bottom = self.contentView.height - 15.f;
}

- (void)buttonsEvent:(SheetMenuButton *)button {
    
    [self hide];
    self.tapedButton = button;
}

- (void)startManualShowAnimation {
    
    CGFloat safeBottom = 0;
    if (DeviceInfo.isFringeScreen) {
        
        safeBottom = DeviceInfo.fringeScreenBottomSafeHeight;
    }
    
    // 配置view动画
    CGPoint toPoint                   = CGPointMake(self.middleX, Height - self.contentView.height / 2.f - safeBottom);
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
    keyAnimation.keyPath              = @"position";
    keyAnimation.duration             = self.class.ShowAnimationTime;
    keyAnimation.values               = [YXEasing calculateFrameFromPoint:self.contentView.center
                                                                  toPoint:toPoint
                                                                     func:ExponentialEaseOut
                                                               frameCount:self.class.ShowAnimationTime * 60];
    self.contentView.layer.position = toPoint;
    [self.contentView.layer addAnimation:keyAnimation forKey:nil];
}

- (void)startSystemShowAnimation {
    
}

- (void)didCompleteShowAnimation {
    
}

- (void)startManualHideAnimation {
    
}

- (void)startSystemHideAnimation {
    
    self.contentView.top  += 10.f;
    self.contentView.alpha = 0.f;
}

- (void)didCompleteHideAnimation {
    
    if (self.tapedButton && self.delegate && [self.delegate respondsToSelector:@selector(windowMenuView:didSelectedIndex:selectedData:)]) {
        
        id <MenuViewObject> data = self.tapedButton.weakObject;
        [self.delegate windowMenuView:self didSelectedIndex:data.menuViewTitleIndex selectedData:data];
    }
}

@end
