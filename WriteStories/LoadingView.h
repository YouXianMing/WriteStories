//
//  LoadingView.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/16.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoadingView;

@protocol LoadingViewDelegate <NSObject>

- (void)loadingViewWillShow:(LoadingView *)loadingView;
- (void)loadingViewDidShow:(LoadingView *)loadingView;
- (void)loadingViewWillHide:(LoadingView *)loadingView;
- (void)loadingViewDidHide:(LoadingView *)loadingView;

@end

@interface LoadingView : UIView

@property (nonatomic, weak) id <LoadingViewDelegate> delegate;

- (void)startLoading;

- (void)stopLoading;

+ (instancetype)loadingViewStartLoadingInKeyWindow;

@end
