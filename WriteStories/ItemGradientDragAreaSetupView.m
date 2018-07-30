//
//  ItemGradientDragAreaSetupView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/18.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ItemGradientDragAreaSetupView.h"
#import "CAGradientViewObject.h"
#import "TwoItemRectDragView.h"
#import "TwoItemVtDragView.h"

@interface ItemGradientDragAreaSetupView () <TwoItemVtDragViewDelegate, TwoItemRectDragViewDelegate>

@property (nonatomic, weak)   CAGradientViewObject *object;
@property (nonatomic, strong) TwoItemRectDragView  *rectDragView;
@property (nonatomic, strong) TwoItemVtDragView    *vtDragView;

@end

@implementation ItemGradientDragAreaSetupView

- (void)buildSubViews {
    
    [super buildSubViews];
    
    CAGradientViewObject *object = self.inputValues.firstObject;
    self.object                  = object;
    
    self.rectDragView          = [[TwoItemRectDragView alloc] initWithFrame:CGRectMake(20, 10, self.width - 80.f, self.height - 20.f)];
    self.rectDragView.delegate = self;
    [self.rectDragView setupWithGap:17.5f itemSize:CGSizeMake(35.f, 35.f) startPoint:object.startPoint.CGPointValue endPoint:object.endPoint.CGPointValue];
    [self addSubview:self.rectDragView];
    
    self.vtDragView          = [[TwoItemVtDragView alloc] initWithFrame:CGRectMake(self.rectDragView.right - 10.f, 10,
                                                                                   self.width - self.rectDragView.right, self.height - 20.f)];
    self.vtDragView.delegate = self;
    [self.vtDragView setupWithGap:17.5f
                         itemSize:CGSizeMake(35.f, 35.f)
                    startLocation:object.gradientColor_1_location.floatValue
                      endLocation:object.gradientColor_2_location.floatValue];
    [self addSubview:self.vtDragView];
}

- (void)twoItemRectDragView:(TwoItemRectDragView *)dragView startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {

    self.object.startPoint = [NSValue valueWithCGPoint:startPoint];
    self.object.endPoint   = [NSValue valueWithCGPoint:endPoint];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemSetupView:updateValues:)]) {
        
        [self.delegate itemSetupView:self updateValues:@[self.object]];
    }
}

- (void)twoItemVtDragView:(TwoItemVtDragView *)dragView startLocation:(CGFloat)startLocation endLocation:(CGFloat)endLocation {

    self.object.gradientColor_1_location = @(startLocation);
    self.object.gradientColor_2_location = @(endLocation);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemSetupView:updateValues:)]) {
        
        [self.delegate itemSetupView:self updateValues:@[self.object]];
    }
}

@end
