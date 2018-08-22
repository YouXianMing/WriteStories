//
//  Animation_4.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/28.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Animation_4.h"

@interface Animation_4 ()

@property (nonatomic, strong) CAEmitterView *emitterView;

@end

@implementation Animation_4

- (void)buildSubViews {
    
    self.emitterView                 = [[CAEmitterView alloc] initWithFrame:CGRectMake(0, 0, Width, 450.f)];
    self.emitterView.seed            = arc4random();
    self.emitterView.emitterShape    = kCAEmitterLayerLine;
    self.emitterView.emitterMode     = kCAEmitterLayerVolume;
    self.emitterView.emitterPosition = CGPointMake(self.emitterView.middleX, -8);
    self.emitterView.emitterSize     = CGSizeMake(self.emitterView.width, 1.f);
    self.emitterView.clipsToBounds   = YES;
    [self addSubview:self.emitterView];
    
    UIImageView *imageView    = [[UIImageView alloc] initWithFrame:self.emitterView.bounds];
    imageView.image           = [UIImage imageNamed:@"mask-snow"];
    self.emitterView.maskView = imageView;
    
    NSMutableArray *array = [NSMutableArray array];
    
    {
        CAEmitterCell *cell           = [CAEmitterCell emitterCell];
        cell.birthRate                = 50.f;
        cell.velocity                 = 450.f; // 初速度
        cell.velocityRange            = 5.f;
        cell.lifetime                 = (self.emitterView.height + 8) / (cell.velocity - cell.velocityRange);  // 生命周期
        cell.emissionLongitude        = M_PI;
        cell.scaleRange               = 0.05f;
        cell.scale                    = 0.45f;
        cell.alphaRange               = 0.75f;
        cell.contents                 = (id)[UIImage imageNamed:@"rain"].CGImage;
        cell.color                    = [UIColor whiteColor].CGColor;
        
        [array addObject:cell];
    }
    
    self.emitterView.emitterCells = array;
}

- (void)didUpdateFrame {
    
    NSLog(@"%@", NSStringFromCGRect(self.superview.frame));
}

@end
