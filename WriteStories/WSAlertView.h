//
//  WSAlertView.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/20.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSAlertViewButtonInfo;
@class WSAlertView;

typedef void(^WSAlertViewSelectedBlock_t)(WSAlertViewButtonInfo *buttonInfo);

#pragma mark - WSAlertView

@protocol WSAlertViewDelegate <NSObject>

- (void)alertView:(WSAlertView *)alertView didSelected:(WSAlertViewButtonInfo *)buttonInfo;
- (void)alertViewWillShow:(WSAlertView *)alertView;
- (void)alertViewDidShow:(WSAlertView *)alertView;
- (void)alertViewWillHide:(WSAlertView *)alertView;
- (void)alertViewDidHide:(WSAlertView *)alertView;

@end

typedef enum : NSUInteger {
    
    WSAlertViewTypeAlert = 1000,
    WSAlertViewTypeSuccess,
    WSAlertViewTypeError,
    WSAlertViewTypeMessage,
    
} WSAlertViewType;

typedef enum : NSUInteger {
    
    WSAlertViewButtonTypeCancel = 2000,
    WSAlertViewButtonTypeConfirm,
    
} WSAlertViewButtonType;

@interface WSAlertView : UIView

@property (nonatomic, copy)   WSAlertViewSelectedBlock_t selectedBlock;
@property (nonatomic, weak)   id weakObject;
@property (nonatomic, weak)   id <WSAlertViewDelegate> delegate;
@property (nonatomic, strong) NSArray  <WSAlertViewButtonInfo *> *buttonInfos;
@property (nonatomic, strong) NSArray  <NSValue *> *messageBoldRanges;
@property (nonatomic, strong) NSString *message;

- (void)showWithType:(WSAlertViewType)type;
- (void)hide;

+ (void)showAlertViewWithMessage:(NSString *)message
               messageBoldRanges:(NSArray <NSValue *> *)messageBoldRanges
                     buttonInfos:(NSArray  <WSAlertViewButtonInfo *> *)buttonInfos
                            type:(WSAlertViewType)type
                        delegate:(id <WSAlertViewDelegate>)delegate
                      weakObject:(id)weakObject
                             tag:(NSInteger)tag
                   selectedBlock:(WSAlertViewSelectedBlock_t)selectedBlock;

+ (void)showAutoHideAlertViewWithMessage:(NSString *)message
                       messageBoldRanges:(NSArray <NSValue *> *)messageBoldRanges
                                    type:(WSAlertViewType)type
                                delegate:(id <WSAlertViewDelegate>)delegate
                              weakObject:(id)weakObject
                                     tag:(NSInteger)tag;

@end

#pragma mark - WSAlertViewButton

@interface WSAlertViewButtonInfo : NSObject

@property (nonatomic, strong) NSString      *title;
@property (nonatomic) WSAlertViewButtonType  type;

@end

NS_INLINE WSAlertViewButtonInfo *buttonInfo(WSAlertViewButtonType type, NSString *title) {
    
    WSAlertViewButtonInfo *button = [WSAlertViewButtonInfo new];
    button.type               = type;
    button.title              = title;
    
    return button;
}
