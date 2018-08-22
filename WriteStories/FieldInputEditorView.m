//
//  TextInputEditorView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/20.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "FieldInputEditorView.h"

@interface FieldInputEditorView () <UITextFieldDelegate>

@property (nonatomic, strong) UIView      *contentView;
@property (nonatomic, strong) UITextField *field;

@end

@implementation FieldInputEditorView

- (void)buildSubViews {
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.class.titleHeight, Width, 50.f)];
    [self addSubview:self.contentView];
    
    self.field          = [[UITextField alloc] initWithFrame:CGRectMake(10.f, 5, Width - 20.f, 40.f)];
    self.field.font     = [UIFont PingFangSC_Medium_WithFontSize:19.f];
    self.field.delegate = self;
    [self.contentView addSubview:self.field];
    
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(10, self.field.bottom, self.field.width, 0.5f)];
    line.backgroundColor = UIColor.LineColor;
    [self.contentView addSubview:line];
}

- (void)setInputEdior:(InputEditor *)inputEdior {
    
    [super setInputEdior:inputEdior];
    
    // 标题
    self.label.text = self.inputEdior.title;
    
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"请输入%@", inputEdior.title]
                                                                 attributes:@{NSFontAttributeName : [UIFont PingFangSC_Light_WithFontSize:19.f],
                                                                              NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#b9b9b9"]
                                                                              }];
    self.field.attributedPlaceholder = string;
    self.field.text = [self.inputEdior valueWithObject:self.weakObject];
    [self.field addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)updateViewHeight {
    
    self.height = self.contentView.bottom;
}

- (BOOL)isOK {
    
    if (self.field.text.length <= 0) {
        
        return NO;
        
    } else {
        
        return YES;
    }
}

- (NSString *)errorMessage {
    
    return [NSString stringWithFormat:@"%@不能为空!", self.inputEdior.title];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Other

- (void)textFieldChanged:(UITextField *)field {
    
    NSLog(@"%@", field.text);
    [self.inputEdior setObject:self.weakObject value:field.text];
}

- (void)dealloc {
    
    [self.field removeTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}

@end
