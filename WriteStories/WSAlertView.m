//
//  WSAlertView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/20.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "WSAlertView.h"
#import "UIView+SetRect.h"
#import "UIFont+Project.h"
#import "WSAlertViewButton.h"
#import "GCD.h"

@interface WSAlertView ()

@property (nonatomic, weak)   UIWindow    *keyWindow;
@property (nonatomic, strong) UIView      *backgroundView;

@property (nonatomic, strong) UIView      *contentView;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel     *iconLabel;
@property (nonatomic, strong) UILabel     *messageLabel;

@end

@implementation WSAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self.keyWindow = [UIApplication sharedApplication].keyWindow;
    
    if (self = [super initWithFrame:self.keyWindow.bounds]) {
        
        self.backgroundView                 = [[UIView alloc] initWithFrame:self.keyWindow.bounds];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backgroundView];
    }
    
    return self;
}

- (void)showWithType:(WSAlertViewType)type {
    
    [self.keyWindow addSubview:self];
    
    self.contentView       = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width - 100.f, 0.f)];
    self.contentView.alpha = 0.f;
    [self addSubview:self.contentView];
    
    {
        // 彩色背景
        self.bgImageView         = [[UIImageView alloc] init];
        self.bgImageView.image   = [[UIImage imageNamed:@{@(WSAlertViewTypeAlert)   : @"alert-yellow",
                                                          @(WSAlertViewTypeSuccess) : @"alert-green",
                                                          @(WSAlertViewTypeError)   : @"alert-red",
                                                          @(WSAlertViewTypeMessage) : @"alert-blue"}[@(type)]]
                                    resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
        [self.contentView addSubview:self.bgImageView];
        
        // 图标
        self.iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@{@(WSAlertViewTypeAlert)   : @"alert-icon-alert",
                                                                                      @(WSAlertViewTypeSuccess) : @"alert-icon-success",
                                                                                      @(WSAlertViewTypeError)   : @"alert-icon-error",
                                                                                      @(WSAlertViewTypeMessage) : @"alert-icon-msg"}[@(type)]]];
        self.iconImageView.center = CGPointMake(30.f, 30.f);
        [self.contentView addSubview:self.iconImageView];
        
        // 图标文本
        self.iconLabel           = [[UILabel alloc] init];
        self.iconLabel.font      = [UIFont PingFangSC_Semibold_WithFontSize:21.f];
        self.iconLabel.textColor = [UIColor whiteColor];
        self.iconLabel.text      = @{@(WSAlertViewTypeAlert)   : @"警告",
                                     @(WSAlertViewTypeSuccess) : @"成功",
                                     @(WSAlertViewTypeError)   : @"错误",
                                     @(WSAlertViewTypeMessage) : @"提示"}[@(type)];
        [self.iconLabel sizeToFit];
        self.iconLabel.left    = 55.f;
        self.iconLabel.centerY = self.iconImageView.centerY;
        [self.contentView addSubview:self.iconLabel];
        
        UIFont *light  = [UIFont PingFangSC_Light_WithFontSize:18.f];
        UIFont *medium = [UIFont PingFangSC_Medium_WithFontSize:18.f];
        
        if (Width == 320.f) {
            
            light  = [UIFont PingFangSC_Light_WithFontSize:16.f];
            medium = [UIFont PingFangSC_Medium_WithFontSize:16.f];
        }
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.message attributes:@{NSFontAttributeName : light,
                                                                                                                                 NSForegroundColorAttributeName : [[UIColor whiteColor] colorWithAlphaComponent:0.95]
                                                                                                                                 }];
        [self.messageBoldRanges enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [attributeString addAttribute:NSFontAttributeName value:medium range:obj.rangeValue];
            [attributeString addAttribute:NSForegroundColorAttributeName value:UIColor.whiteColor range:obj.rangeValue];
            [attributeString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:obj.rangeValue];
        }];
        
        // 文本
        self.messageLabel                = [[UILabel alloc] init];
        self.messageLabel.numberOfLines  = 0;
        self.messageLabel.attributedText = attributeString;
        self.messageLabel.width          = self.contentView.width - 40.f;
        [self.messageLabel sizeToFit];
        self.messageLabel.left           = 20.f;
        self.messageLabel.top            = self.iconLabel.bottom + 17.f;
        [self.contentView addSubview:self.messageLabel];
        
        if (self.buttonInfos.count <= 0) {
            
            // 更新布局
            self.contentView.height = self.messageLabel.bottom + 20.f;
            self.contentView.center = self.middlePoint;
            self.bgImageView.frame  = self.contentView.bounds;
            self.bgImageView.width  += 3.f;
            self.bgImageView.height += 3.f;
            
        } else {
            
            // 水平线
            UIImageView *hrLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, 2.f)];
            hrLine.image        = [UIImage imageNamed:@"alert-hr-line"];
            hrLine.top          = self.messageLabel.bottom + 20.f;
            [self.contentView addSubview:hrLine];
            
            if (self.buttonInfos.count == 2) {
                
                CGFloat width = self.contentView.width / 2.f;
                
                WSAlertViewButton *button_left = [[WSAlertViewButton alloc] initWithFrame:CGRectMake(0, hrLine.bottom, width, 50.f)];
                [button_left use:self.buttonInfos.firstObject];
                [self.contentView addSubview:button_left];
                [button_left addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
                
                WSAlertViewButton *button_right = [[WSAlertViewButton alloc] initWithFrame:CGRectMake(width, hrLine.bottom, width, 50.f)];
                [button_right use:self.buttonInfos.lastObject];
                [self.contentView addSubview:button_right];
                [button_right addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
                
                UIImageView *vtLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alert-vt-line"]];
                vtLine.height       = 48.f;
                vtLine.top          = hrLine.bottom;
                vtLine.centerX      = self.contentView.middleX;
                [self.contentView addSubview:vtLine];
                
            } else {
                
                WSAlertViewButton *button_left = [[WSAlertViewButton alloc] initWithFrame:CGRectMake(0, hrLine.bottom, self.contentView.width, 50.f)];
                [button_left use:self.buttonInfos.firstObject];
                [self.contentView addSubview:button_left];
                [button_left addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            // 更新布局
            self.contentView.height = hrLine.bottom + 50.f;
            self.contentView.center = self.middlePoint;
            self.bgImageView.frame  = self.contentView.bounds;
            self.bgImageView.width  += 3.f;
            self.bgImageView.height += 3.f;
        }
    }
    
    // 将要显示
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertViewWillShow:)]) {
        
        [self.delegate alertViewWillShow:self];
    }
    
    self.contentView.top -= 20.f;
    
    [UIView animateWithDuration:0.45f animations:^{
        
        self.contentView.top               += 20.f;
        self.contentView.alpha              = 1.f;
        self.backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.15f];
        
    } completion:^(BOOL finished) {
        
        // 已经显示
        if (self.delegate && [self.delegate respondsToSelector:@selector(alertViewDidShow:)]) {
            
            [self.delegate alertViewDidShow:self];
        }
    }];
}

- (void)hide {
    
    // 将要隐藏
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertViewWillHide:)]) {
        
        [self.delegate alertViewWillHide:self];
    }
    
    [UIView animateWithDuration:0.25f animations:^{
        
        self.contentView.top               += 10.f;
        self.contentView.alpha              = 0.f;
        self.backgroundView.backgroundColor = [UIColor clearColor];
        
    } completion:^(BOOL finished) {
        
        // 已经隐藏
        if (self.delegate && [self.delegate respondsToSelector:@selector(alertViewDidHide:)]) {
            
            [self.delegate alertViewDidHide:self];
        }
        
        [self removeFromSuperview];
    }];
}

- (void)buttonsEvent:(WSAlertViewButton *)button {
    
    [self hide];
    
    [GCDQueue executeInMainQueue:^{
        
        if (self.selectedBlock) {
            
            self.selectedBlock(button.buttonInfo);
        }
        
        // 点击了
        if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:didSelected:)]) {
            
            [self.delegate alertView:self didSelected:button.buttonInfo];
        }
        
    } afterDelaySecs:0.25f];
}

+ (void)showAlertViewWithMessage:(NSString *)message
               messageBoldRanges:(NSArray <NSValue *> *)messageBoldRanges
                     buttonInfos:(NSArray  <WSAlertViewButtonInfo *> *)buttonInfos
                            type:(WSAlertViewType)type
                        delegate:(id <WSAlertViewDelegate>)delegate
                      weakObject:(id)weakObject
                             tag:(NSInteger)tag
                   selectedBlock:(WSAlertViewSelectedBlock_t)selectedBlock {
    
    WSAlertView *alertView      = [WSAlertView new];
    alertView.message           = message;
    alertView.messageBoldRanges = messageBoldRanges;
    alertView.buttonInfos       = buttonInfos;
    alertView.delegate          = delegate;
    alertView.weakObject        = weakObject;
    alertView.tag               = tag;
    alertView.selectedBlock     = selectedBlock;
    
    [alertView showWithType:type];
}

+ (void)showAutoHideAlertViewWithMessage:(NSString *)message
                       messageBoldRanges:(NSArray <NSValue *> *)messageBoldRanges
                                    type:(WSAlertViewType)type
                                delegate:(id <WSAlertViewDelegate>)delegate
                              weakObject:(id)weakObject
                                     tag:(NSInteger)tag {
    
    WSAlertView *alertView      = [WSAlertView new];
    alertView.message           = message;
    alertView.messageBoldRanges = messageBoldRanges;
    alertView.delegate          = delegate;
    alertView.weakObject        = weakObject;
    alertView.tag               = tag;
    
    [alertView showWithType:type];
    
    [GCDQueue executeInMainQueue:^{
        
        [alertView hide];
        
    } afterDelaySecs:4.5f];
}

- (void)dealloc {
    
    NSLog(@"'%@' is dealloced.", NSStringFromClass(self.class));
}

@end


@implementation WSAlertViewButtonInfo

@end


