//
//  TextInputEditorView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "TextInputEditorView.h"
#import "UIView+SetRect.h"
#import "App.h"

@interface TextInputEditorView () <UITextViewDelegate>

@property (nonatomic, strong) UILabel     *countLabel;
@property (nonatomic, strong) UIView      *contentView;
@property (nonatomic, strong) UITextView  *textView;

@end

@implementation TextInputEditorView

- (void)buildSubViews {
    
    CGFloat textViewHeight = App.Height - StatusBarAndNavigationBarHeight - self.class.titleHeight;
    if (App.Device == Device_375x812 || App.Device == Device_Unknown) {
        
        textViewHeight -= App.TopSafeHeight;
    }
    
    self.countLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, self.class.titleHeight)];
    self.countLabel.textAlignment = NSTextAlignmentRight;
    self.countLabel.right         = App.Width - 10.f;
    self.countLabel.font          = [UIFont PingFangSC_Thin_WithFontSize:15.f];
    [self.titleView addSubview:self.countLabel];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.class.titleHeight, App.Width, textViewHeight)];
    [self addSubview:self.contentView];

    // textView
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.paragraphSpacing         = 15.f;
    style.lineSpacing              = 3.f;
    
    self.textView                  = [[UITextView alloc] initWithFrame:self.contentView.bounds];
    self.textView.contentInset     = UIEdgeInsetsMake(10, 10, 350.f, 10);
    self.textView.delegate         = self;
    self.textView.typingAttributes = @{NSFontAttributeName           : [UIFont PingFangSC_Light_WithFontSize:17.f],
                                       NSParagraphStyleAttributeName : style};
    [self.contentView addSubview:self.textView];
    
    UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, App.Width, 0.5f)];
    lineView.backgroundColor = UIColor.LineColor;
    [self.contentView addSubview:lineView];
}

- (void)setInputEdior:(InputEditor *)inputEdior {
    
    [super setInputEdior:inputEdior];
    
    // 标题
    self.label.text = self.inputEdior.title;

    // 文本
    self.textView.text = [self.inputEdior valueWithObject:self.weakObject];
    
    // 更新计数
    self.countLabel.text = [NSString stringWithFormat:@"%lu/5000", (unsigned long)self.textView.text.length];
}

- (void)updateViewHeight {
    
    self.height = self.contentView.bottom;
}

- (BOOL)isOK {
    
    if (self.textView.text.length <= 0 || self.textView.text.length > 5000) {
        
        return NO;
        
    } else {
        
        // 更新value的值
        [self.inputEdior setObject:self.weakObject value:self.textView.text];
        return YES;
    }
}

- (NSString *)errorMessage {
    
    if (self.textView.text.length <= 0) {
        
        return @"输入文本不能为空！";
        
    } else if (self.textView.text.length > 5000) {
        
        return @"输入文本不能超过5000字！";
        
    } else {
        
        return nil;
    }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
     
    // 更新计数
    self.countLabel.text = [NSString stringWithFormat:@"%ld/5000", textView.text.length];
}

@end
