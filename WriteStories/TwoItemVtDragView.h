//
//  TwoItemVtDragView.h
//  DragAndCrop
//
//  Created by YouXianMing on 2018/1/25.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TwoItemVtDragView;

@protocol TwoItemVtDragViewDelegate <NSObject>

@required

- (void)twoItemVtDragView:(TwoItemVtDragView *)dragView startLocation:(CGFloat)startLocation endLocation:(CGFloat)endLocation;

@end

@interface TwoItemVtDragView : UIView

@property (nonatomic, weak) id <TwoItemVtDragViewDelegate> delegate;

- (void)setupWithGap:(CGFloat)gap itemSize:(CGSize)itemSize startLocation:(CGFloat)startLocation endLocation:(CGFloat)endLocation;

@end
