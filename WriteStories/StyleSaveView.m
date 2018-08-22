//
//  StyleSaveView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/21.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "StyleSaveView.h"
#import "UIView+SetRect.h"
#import "UIFont+Project.h"
#import "UIColor+Project.h"
#import "GCD.h"

#pragma mark - StyleSaveViewButton

@interface StyleSaveViewButton : UIButton

@end

@implementation StyleSaveViewButton

- (void)setHighlighted:(BOOL)highlighted {
    
    [super setHighlighted:highlighted];
    
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.alpha = highlighted ? 0.5f : 1.f;
        
    } completion:nil];
}

- (void)setEnabled:(BOOL)enabled {
    
    [super setEnabled:enabled];
    
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.alpha = enabled ? 1.f : 0.5f;
        
    } completion:nil];
}

@end

#pragma mark - StyleSaveView

typedef enum : NSUInteger {
    
    Button_Cancel = 1000,
    Button_OK,
    
} EButtonEvents;

@interface StyleSaveView () <UITextFieldDelegate> {
    
    UIButton *_rightButton;
}

@property (nonatomic, weak)   UIWindow    *keyWindow;
@property (nonatomic, strong) UIView      *backgroundView;

@property (nonatomic, strong) UIView      *contentView;
@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UILabel     *countLabel;
@property (nonatomic, strong) UITextField *field;

@end

@implementation StyleSaveView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self.keyWindow = [UIApplication sharedApplication].keyWindow;
    
    if (self = [super initWithFrame:self.keyWindow.bounds]) {
        
        self.backgroundView                 = [[UIView alloc] initWithFrame:self.keyWindow.bounds];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backgroundView];
    }
    
    return self;
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    // 动画的持续时间 + 键盘frame值
    // double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    double duration = 0.25;
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:duration delay:0.f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        if (keyboardF.origin.y == Height) {
            
            self.contentView.center = self.keyWindow.middlePoint;
            
        } else {
            
            self.contentView.top = 120.f;
        }
        
    } completion:nil];
}

- (void)show {
    
    [self.keyWindow addSubview:self];
    
    self.contentView        = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width - 125.f, 190)];
    self.contentView.alpha  = 0.f;
    self.contentView.center = self.middlePoint;
    [self addSubview:self.contentView];
    
    // 彩色背景
    self.bgImageView         = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    self.bgImageView.image   = [[UIImage imageNamed:@"alert-white"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    self.bgImageView.width  += 3.f;
    self.bgImageView.height += 3.f;
    [self.contentView addSubview:self.bgImageView];
    
    // 标题
    UILabel *titleLabel  = [[UILabel alloc] init];
    titleLabel.text      = @"样式标题";
    titleLabel.font      = [UIFont PingFangSC_Light_WithFontSize:16.f];
    [titleLabel sizeToFit];
    titleLabel.left     = 15.f;
    titleLabel.top      = 15.f;
    [self.contentView addSubview:titleLabel];
    
    // field
    self.field             = [[UITextField alloc] initWithFrame:CGRectMake(15.f, titleLabel.bottom + 10, self.contentView.width - 30.f, 45.f)];
    self.field.delegate    = self;
    self.field.placeholder = @"请输入样式标题";
    self.field.font        = [UIFont PingFangSC_Regular_WithFontSize:18.f];
    [self.field addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:self.field];
    
    // 添加键盘监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    // line
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(self.field.left, self.field.bottom, self.field.width, 0.5f)];
    line.backgroundColor = UIColor.LineColor;
    [self.contentView addSubview:line];
    
    // countLabel
    self.countLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    self.countLabel.right         = self.field.right;
    self.countLabel.top           = line.bottom;
    self.countLabel.font          = [UIFont PingFangSC_Thin_WithFontSize:12.f];
    self.countLabel.textAlignment = NSTextAlignmentRight;
    self.countLabel.text          = @"0/20";
    [self.contentView addSubview:self.countLabel];
    
    // 水平线
    UIImageView *hrLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, 2.f)];
    hrLine.image        = [UIImage imageNamed:@"alert-hr-line"];
    hrLine.top          = self.countLabel.bottom + 20.f;
    [self.contentView addSubview:hrLine];
    
    // 竖线
    UIImageView *vtLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alert-vt-line"]];
    vtLine.height       = 45.f;
    vtLine.top          = hrLine.bottom;
    vtLine.centerX      = self.contentView.middleX;
    [self.contentView addSubview:vtLine];
    
    // 左边按钮
    UIButton *leftButton       = [[StyleSaveViewButton alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width / 2.f, 45.f)];
    leftButton.top             = hrLine.bottom;
    leftButton.titleLabel.font = [UIFont PingFangSC_Regular_WithFontSize:18];
    leftButton.tag             = Button_Cancel;
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:leftButton];
    
    // 右边按钮
    _rightButton = [[StyleSaveViewButton alloc] initWithFrame:CGRectMake(self.contentView.width / 2.f, 0, self.contentView.width / 2.f, 45.f)];
    _rightButton.top             = hrLine.bottom;
    _rightButton.titleLabel.font = [UIFont PingFangSC_Regular_WithFontSize:18];
    _rightButton.tag             = Button_OK;
    [_rightButton setTitle:@"确定" forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_rightButton];
    
    // 更新一下
    [self textFieldChanged:self.field];
    
    // 将要显示
    if (self.delegate && [self.delegate respondsToSelector:@selector(styleSaveViewWillShow:)]) {
        
        [self.delegate styleSaveViewWillShow:self];
    }
    
    [UIView animateWithDuration:0.45f animations:^{
        
        self.contentView.alpha              = 1.f;
        self.backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.15f];
        
    } completion:^(BOOL finished) {
        
        [self.field becomeFirstResponder];
        
        // 已经显示
        if (self.delegate && [self.delegate respondsToSelector:@selector(styleSaveViewDidShow:)]) {
            
            [self.delegate styleSaveViewDidShow:self];
        }
    }];
}

- (void)hide {
    
    [self.field resignFirstResponder];
    
    // 将要隐藏
    if (self.delegate && [self.delegate respondsToSelector:@selector(styleSaveViewWillHide:)]) {
        
        [self.delegate styleSaveViewWillHide:self];
    }
    
    [UIView animateWithDuration:0.25f animations:^{
        
        self.contentView.alpha              = 0.f;
        self.backgroundView.backgroundColor = [UIColor clearColor];
        
    } completion:^(BOOL finished) {
        
        // 已经隐藏
        if (self.delegate && [self.delegate respondsToSelector:@selector(styleSaveViewDidHide:)]) {
            
            [self.delegate styleSaveViewDidHide:self];
        }
        
        [self removeFromSuperview];
    }];
}

- (void)textFieldChanged:(UITextField *)field {
    
    self.countLabel.text = [NSString stringWithFormat:@"%ld/20", field.text.length];
    
    if (field.text.length <= 0 || field.text.length > 20) {
        
        _rightButton.enabled = NO;
        
    } else {
        
        _rightButton.enabled = YES;
    }
}

- (void)buttonsEvent:(UIButton *)button {
    
    if (button.tag == Button_Cancel) {
        
        [self hide];
        
    } else if (button.tag == Button_OK && button.enabled) {
        
        [self hide];
        
        [GCDQueue executeInMainQueue:^{
            
            if (self.confirmEvent) {
                
                self.confirmEvent(self.field.text);
            }
            
        } afterDelaySecs:0.25f];
    }
}

- (void)setInputText:(NSString *)inputText {
    
    self.field.text = inputText;
    [self textFieldChanged:self.field];
}

+ (void)styleSaveViewShowWithText:(NSString *)text
                         delegate:(id <StyleSaveViewDelegate>)delegate
                     confirmEvent:(StyleSaveViewConfirmEventBlock_t)confirmEvent {
    
    StyleSaveView *saveView = [StyleSaveView new];
    [saveView show];
    saveView.inputText    = text;
    saveView.confirmEvent = confirmEvent;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - dealloc

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    NSLog(@"%@ is dealloced.", NSStringFromClass(self.class));
}

@end
