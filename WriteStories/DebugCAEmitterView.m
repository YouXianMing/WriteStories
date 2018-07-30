//
//  DebugCAEmitterView.m
//  GradientView
//
//  Created by YouXianMing on 2018/1/18.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "DebugCAEmitterView.h"
#import "UIView+SetRect.h"

@interface DebugCAEmitterView () {
    
    CAEmitterLayer * _emitterLayer;
}

@property (nonatomic, strong) UIView  *debugSizeView;
@property (nonatomic, strong) UIView  *debugPositionView;
@property (nonatomic, strong) UILabel *shapeLabel;
@property (nonatomic, strong) UILabel *modeLabel;

@end

@implementation DebugCAEmitterView

+ (Class)layerClass {
    
    return [CAEmitterLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _emitterLayer             = (CAEmitterLayer *)self.layer;
        _emitterLayer.borderWidth = 0.5f;
        _emitterLayer.borderColor = [UIColor redColor].CGColor;
        
        self.debugSizeView                        = [UIView new];
        self.debugSizeView.userInteractionEnabled = NO;
        self.debugSizeView.layer.borderWidth      = 0.5f;
        self.debugSizeView.layer.borderColor      = [UIColor greenColor].CGColor;
        self.debugSizeView.backgroundColor        = [[UIColor greenColor] colorWithAlphaComponent:0.1f];
        [self addSubview:self.debugSizeView];
        
        self.debugPositionView                        = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 4)];
        self.debugPositionView.userInteractionEnabled = NO;
        self.debugPositionView.clipsToBounds          = YES;
        self.debugPositionView.layer.cornerRadius     = 2.f;
        self.debugPositionView.backgroundColor        = [UIColor redColor];
        [self addSubview:self.debugPositionView];
        
        self.shapeLabel       = [UILabel new];
        self.shapeLabel.alpha = 0.1f;
        self.shapeLabel.font  = [UIFont fontWithName:@"GillSans-Italic" size:15.f];
        [self addSubview:self.shapeLabel];
        
        self.modeLabel       = [UILabel new];
        self.modeLabel.alpha = 0.1f;
        self.modeLabel.font  = [UIFont fontWithName:@"GillSans-Italic" size:15.f];
        [self addSubview:self.modeLabel];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self withShapeText:[self emitterShape]];
    [self withModeText:[self emitterMode]];
}

- (void)withShapeText:(NSString *)text {
    
    self.shapeLabel.text = [NSString stringWithFormat:@"Shape : %@", text];
    [self.shapeLabel sizeToFit];
    self.shapeLabel.left   = 4;
    self.shapeLabel.bottom = self.height - 20.f;
}

- (void)withModeText:(NSString *)text {
    
    self.modeLabel.text = [NSString stringWithFormat:@"Mode  : %@", text];
    [self.modeLabel sizeToFit];
    self.modeLabel.left   = 4;
    self.modeLabel.bottom = self.height - 3.f;
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
    [self withModeText:emitterMode];
}

- (NSString *)emitterMode {
    
    return _emitterLayer.emitterMode;
}

- (void)setEmitterShape:(NSString *)emitterShape {
    
    _emitterLayer.emitterShape = emitterShape;
    [self withShapeText:emitterShape];
}

- (NSString *)emitterShape {
    
    return _emitterLayer.emitterShape;
}

- (void)setEmitterSize:(CGSize)emitterSize {
    
    _emitterLayer.emitterSize = emitterSize;
    _debugSizeView.bounds     = CGRectMake(0, 0, emitterSize.width, emitterSize.height);
}

- (CGSize)emitterSize {
    
    return _emitterLayer.emitterSize;
}

- (void)setEmitterPosition:(CGPoint)emitterPosition {
    
    _emitterLayer.emitterPosition = emitterPosition;
    _debugPositionView.center     = emitterPosition;
    _debugSizeView.center         = emitterPosition;
}

- (CGPoint)emitterPosition {
    
    return _emitterLayer.emitterPosition;
}

- (CAEmitterLayer *)emitterLayer {
    
    return _emitterLayer;
}

@end
