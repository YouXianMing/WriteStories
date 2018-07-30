//
//  DebugCAEmitterView.h
//  GradientView
//
//  Created by YouXianMing on 2018/1/18.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DebugCAEmitterView : UIView

@property (nonatomic, readonly) CAEmitterLayer *emitterLayer;

@property             unsigned int seed;
@property (nonatomic) CGPoint      emitterPosition;
@property (nonatomic) CGSize       emitterSize;

/**
 kCAEmitterLayerPoint
 kCAEmitterLayerLine
 kCAEmitterLayerRectangle
 kCAEmitterLayerCuboid
 kCAEmitterLayerCircle
 kCAEmitterLayerSphere
 */
@property (nonatomic) NSString *emitterShape;


/**
 kCAEmitterLayerPoints
 kCAEmitterLayerOutline
 kCAEmitterLayerSurface
 kCAEmitterLayerVolume
 */
@property (nonatomic) NSString *emitterMode;

@property (nonatomic) NSArray  <CAEmitterCell *> *emitterCells;

@end
