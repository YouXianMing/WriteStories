//
//  Folder_snow_0_cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/6.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Folder_snow_0_cell.h"
#import "Folder_snow_0.h"
#import "UIView+AnimationProperty.h"
#import "CAEmitterView.h"
#import "DebugCAEmitterView.h"

@interface Folder_snow_0_cell ()

@property (nonatomic, strong) UIView  *bgContentView;
@property (nonatomic, strong) UILabel *bgLabel;

@property (nonatomic, strong) CAEmitterView *emitterView;

@end

@implementation Folder_snow_0_cell

- (void)buildSubview {
    
    [super buildSubview];
    
    self.bgContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 40.f, self.width, self.height - 40.f)];
    [self.bottomContentView addSubview:self.bgContentView];
    
    self.bgLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, 40.f, self.width, self.height - 40.f)];
    self.bgLabel.numberOfLines = 2;
    self.bgLabel.textAlignment = NSTextAlignmentCenter;
    [self.bottomContentView addSubview:self.bgLabel];
    
    self.emitterView                 = [[CAEmitterView alloc] initWithFrame:CGRectMake(0, 40.f, self.width, self.height - 40.f)];
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
    
    Folder_snow_0 *data = self.dataAdapter.data;
    
    self.bgContentView.backgroundColor = [UIColor colorWithHexString:data.contentBackgroundColorHex];
    self.bgLabel.angle                 = M_PI_4;
    self.bgLabel.text                  = data.title;
    self.bgLabel.font                  = [UIFont fontWithName:data.contentLabelFontFamily size:28.f];
    self.bgLabel.textColor             = [UIColor colorWithHexString:data.contentLabelColorHex];
    
    if ([data.styleType isEqual:@(1)]) {
        
        self.bgLabel.angle = M_PI_4;
        
    } else if ([data.styleType isEqual:@(2)]) {
        
        self.bgLabel.angle = -M_PI_4;
    }
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

    Folder_snow_0 *data = self.dataAdapter.data;
    
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
