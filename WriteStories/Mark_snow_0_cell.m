//
//  Mark_snow_0_cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/7.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Mark_snow_0_cell.h"
#import "Mark_snow_0.h"
#import "CAEmitterView.h"

@interface Mark_snow_0_cell ()

@property (nonatomic, strong) CAEmitterView *emitterView;
@property (nonatomic, strong) UILabel       *titleLabel;

@end

@implementation Mark_snow_0_cell

- (void)setupCell {
    
    [super setupCell];
}

- (void)buildSubview {
    
    [super buildSubview];
    
    self.titleLabel               = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.width - 40.f, self.height)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 2;
    [self.contentView addSubview:self.titleLabel];
    
    self.emitterView                 = [[CAEmitterView alloc] initWithFrame:self.bounds];
    self.emitterView.seed            = arc4random();
    self.emitterView.emitterShape    = kCAEmitterLayerLine;
    self.emitterView.emitterMode     = kCAEmitterLayerVolume;
    self.emitterView.emitterPosition = CGPointMake(self.middleX, -8);
    self.emitterView.emitterSize     = CGSizeMake(self.width, 1.f);
    self.emitterView.clipsToBounds   = YES;
    [self.contentView addSubview:self.emitterView];
}

- (void)loadContent {
    
    [super loadContent];
    
    Mark_snow_0 *data         = self.data;
    self.titleLabel.alpha     = data.titleAlpha.floatValue;
    self.titleLabel.text      = data.title;
    self.titleLabel.font      = [UIFont fontWithName:data.titleFontFamily size:data.titleFontSize.floatValue];
    self.titleLabel.textColor = [UIColor colorWithHexString:data.titleColorHex];
}

- (void)loadCAEmitterCellContent {
    
    CAEmitterCell *cell           = [CAEmitterCell emitterCell];
    cell.birthRate                = 5;
    cell.velocity                 = 30.f; // 初速度
    cell.velocityRange            = 5.f;
    cell.lifetime                 = (self.emitterView.height + 8) / (cell.velocity - cell.velocityRange);  // 生命周期
    cell.emissionLongitude        = M_PI;
    cell.scaleRange               = 0.2f;
    cell.scale                    = 0.8f;
    cell.contents                 = (id)[UIImage imageNamed:@"snow"].CGImage;
    
    Mark_snow_0 *data = self.dataAdapter.data;
    
    // 设定透明度
    self.emitterView.alpha = data.emitterAlpha.floatValue;
    
    if /* 纯色 */ (data.emitterMixColorType.integerValue == 0) {
        
        cell.color = [UIColor colorWithHexString:data.emitterPureColor].CGColor;
        
    } /* 混合颜色 */ else {
        
        cell.color      = [UIColor whiteColor].CGColor;
        cell.redRange   = 0.85f;
        cell.greenRange = 0.85f;
        cell.blueRange  = 0.85f;
    }
    
    self.emitterView.emitterCells = @[cell];
}

@end
