//
//  CAEmitterView.m
//  GradientView
//
//  Created by YouXianMing on 2018/1/18.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "CAEmitterView.h"

@interface CAEmitterView () {
    
    CAEmitterLayer * _emitterLayer;
}

@end

@implementation CAEmitterView

+ (Class)layerClass {
    
    return [CAEmitterLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
    
        _emitterLayer = (CAEmitterLayer *)self.layer;
    }
    
    return self;
}

#pragma mark - Setter & Getter

- (void)setSeed:(unsigned int)seed {
    
    _emitterLayer.seed = seed;
}

- (unsigned int)seed {
    
    return _emitterLayer.seed;
}

- (void)setEmitterCells:(NSArray<CAEmitterCell *> *)emitterCells {
    
    _emitterLayer.emitterCells = emitterCells;
}

- (NSArray<CAEmitterCell *> *)emitterCells {
    
    return _emitterLayer.emitterCells;
}

- (void)setEmitterMode:(NSString *)emitterMode {
    
    _emitterLayer.emitterMode = emitterMode;
}

- (NSString *)emitterMode {
    
    return _emitterLayer.emitterMode;
}

- (void)setEmitterShape:(NSString *)emitterShape {
    
    _emitterLayer.emitterShape = emitterShape;
}

- (NSString *)emitterShape {
    
    return _emitterLayer.emitterShape;
}

- (void)setEmitterSize:(CGSize)emitterSize {
    
    _emitterLayer.emitterSize = emitterSize;
}

- (CGSize)emitterSize {
    
    return _emitterLayer.emitterSize;
}

- (void)setEmitterPosition:(CGPoint)emitterPosition {
    
    _emitterLayer.emitterPosition = emitterPosition;
}

- (CGPoint)emitterPosition {
    
    return _emitterLayer.emitterPosition;
}

- (CAEmitterLayer *)emitterLayer {
    
    return _emitterLayer;
}

@end
