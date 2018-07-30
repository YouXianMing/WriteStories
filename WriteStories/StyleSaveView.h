//
//  StyleSaveView.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/21.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StyleSaveView;

typedef void(^StyleSaveViewConfirmEventBlock_t)(NSString *text);

@protocol StyleSaveViewDelegate <NSObject>

- (void)styleSaveViewWillShow:(StyleSaveView *)styleSaveView;
- (void)styleSaveViewDidShow:(StyleSaveView *)styleSaveView;
- (void)styleSaveViewWillHide:(StyleSaveView *)styleSaveView;
- (void)styleSaveViewDidHide:(StyleSaveView *)styleSaveView;

@end

@interface StyleSaveView : UIView

@property (nonatomic, copy)   StyleSaveViewConfirmEventBlock_t confirmEvent;
@property (nonatomic, weak)   id <StyleSaveViewDelegate> delegate;
@property (nonatomic, strong) NSString *inputText; // 初始字符串

- (void)show;
- (void)hide;

+ (void)styleSaveViewShowWithText:(NSString *)text
                         delegate:(id <StyleSaveViewDelegate>)delegate
                     confirmEvent:(StyleSaveViewConfirmEventBlock_t)confirmEvent;

@end
