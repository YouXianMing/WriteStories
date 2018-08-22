//
//  PopMenuView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/15.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "PopMenuView.h"
#import "UIView+SetRect.h"
#import "PopMenuButton.h"
#import "PopMenuObject.h"
#import "UIButton+Inits.h"
#import "UIColor+Project.h"
#import "UIView+AnimationProperty.h"

@interface PopMenuView ()

@property (nonatomic, weak)   PopMenuButton *tapedButton;
@property (nonatomic, strong) UIImageView   *bgImageView;
@property (nonatomic)         CGPoint        point;

@end

@implementation PopMenuView

- (void)showAtPoint:(CGPoint)point {
    
    self.point = point;
    [super showAtPoint:point];
}

- (void)buildSubViews {
    
    self.bgImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"popWhiteMenu"] resizableImageWithCapInsets:UIEdgeInsetsMake(25, 15, 10, 30.f)]];
    self.bgImageView.userInteractionEnabled = YES;
    [self addSubview:self.bgImageView];
    
    __block CGFloat maxWidth = 0;
    [self.datas enumerateObjectsUsingBlock:^(id<MenuViewObject>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        PopMenuObject *object = obj;
        
        PopMenuButton *button = [[PopMenuButton alloc] initWithFrame:CGRectMake(0, 5 + idx * 50.f, 300, 50)
                                                                icon:object.iconType
                                                           titleType:object.titleType
                                                               title:object.menuViewTitleName];
        button.weakObject = object;
        
        [button addTarget:self action:@selector(buttonsEvent:)];
        
        if (maxWidth <= button.effectiveWidth) {
            
            maxWidth = button.effectiveWidth;
        }
        
        [self.bgImageView addSubview:button];
    }];
    
    // 用于scale
    self.bgImageView.layer.anchorPoint = CGPointMake(1 - 20.f / maxWidth, 0);
    
    // 更新弹出框大小以及设置其位置
    self.bgImageView.viewSize = CGSizeMake(maxWidth, 5 + self.datas.count * 50.f);
    self.bgImageView.right    = self.point.x;
    self.bgImageView.top      = self.point.y;
    
    self.bgImageView.alpha = 0.f;
    self.bgImageView.top  -= 5.f;
    
    // 添加线条
    [self.datas enumerateObjectsUsingBlock:^(id<MenuViewObject>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (self.datas.count - 1 != idx) {
            
            UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(20.f, 5 + (idx + 1) * 50.f, maxWidth - 40.f, 1.f)];
            lineView.backgroundColor = UIColor.LineColor;
            [self.bgImageView addSubview:lineView];
        }
    }];
}

- (void)buttonsEvent:(PopMenuButton *)button {
    
    [self hide];
    self.tapedButton = button;
}

- (void)startManualShowAnimation {
    
}

- (void)startSystemShowAnimation {
    
    self.bgImageView.alpha = 1.f;
    self.bgImageView.top  += 5.f;
}

- (void)didCompleteShowAnimation {
    
}

- (void)startManualHideAnimation {
    
}

- (void)startSystemHideAnimation {
    
    self.bgImageView.alpha = 0.f;
    self.bgImageView.scale = 0.95f;
}

- (void)didCompleteHideAnimation {
    
    if (self.tapedButton && self.delegate && [self.delegate respondsToSelector:@selector(windowMenuView:didSelectedIndex:selectedData:)]) {
        
        id <MenuViewObject> data = self.tapedButton.weakObject;
        [self.delegate windowMenuView:self didSelectedIndex:data.menuViewTitleIndex selectedData:data];
    }
}

@end
