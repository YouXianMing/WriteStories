//
//  TwoItemRectDragView.h
//  DragAndCrop
//
//  Created by YouXianMing on 2018/1/25.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TwoItemRectDragView;

@protocol TwoItemRectDragViewDelegate <NSObject>

@required

- (void)twoItemRectDragView:(TwoItemRectDragView *)dragView startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end

@interface TwoItemRectDragView : UIView

@property (nonatomic, weak) id <TwoItemRectDragViewDelegate> delegate;

- (void)setupWithGap:(CGFloat)gap itemSize:(CGSize)itemSize startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end
