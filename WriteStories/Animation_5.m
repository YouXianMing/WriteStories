//
//  Animation_5.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/28.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Animation_5.h"
#import "DebugCAEmitterView.h"

@interface Animation_5 ()

@end

@implementation Animation_5

- (void)buildSubViews {
    
    {
        CAEmitterView *emitterView  = [[CAEmitterView alloc] initWithFrame:CGRectMake(-40, 0, Width + 80.f, 350.f)];
        emitterView.seed            = 4;
        emitterView.emitterShape    = kCAEmitterLayerRectangle;
        emitterView.emitterMode     = kCAEmitterLayerSurface;
        emitterView.emitterPosition = CGPointMake(-10.f, emitterView.height / 2.f);
        emitterView.emitterSize     = CGSizeMake(1, emitterView.height);
        emitterView.clipsToBounds   = YES;
        [self addSubview:emitterView];
        
        UIImageView *imageView    = [[UIImageView alloc] initWithFrame:emitterView.bounds];
        imageView.image           = [UIImage imageNamed:@"mask-snow"];
        emitterView.maskView      = imageView;
        
        NSMutableArray *array = [NSMutableArray array];
        
        {
            CAEmitterCell *cell           = [CAEmitterCell emitterCell];
            cell.birthRate                = 0.2f;
            cell.velocity                 = 20.f; // 初速度
            cell.velocityRange            = 10.f;
            cell.lifetime                 = (emitterView.width + 8) / (cell.velocity - cell.velocityRange);  // 生命周期
            cell.emissionRange            = [Math radianFromDegree:15.f];
            cell.scale                    = 0.5;
            cell.scaleRange               = 0.2f;
            cell.contents                 = (id)[UIImage imageNamed:@"光斑-1"].CGImage;
            cell.alphaRange               = 0.5f;
            
            [array addObject:cell];
        }
        
        {
            CAEmitterCell *cell           = [CAEmitterCell emitterCell];
            cell.birthRate                = 0.15f;
            cell.velocity                 = 15.f; // 初速度
            cell.velocityRange            = 10.f;
            cell.lifetime                 = (emitterView.width + 8) / (cell.velocity - cell.velocityRange);  // 生命周期
            cell.emissionRange            = [Math radianFromDegree:30.f];
            cell.scale                    = 0.2;
            cell.scaleRange               = 0.1;
            cell.scaleSpeed               = 0.025;
            cell.spin                     = [Math radianFromDegree:15.f];
            cell.spinRange                = [Math radianFromDegree:30.f];
            cell.contents                 = (id)[UIImage imageNamed:@"光斑-2"].CGImage;
            cell.color                    = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5f].CGColor;
            
            cell.alphaRange = 0.5f;
            cell.redRange   = 0.5;
            cell.blueRange  = 0.5;
            cell.greenRange = 0.5;
            
            cell.alphaSpeed = -2.f / cell.lifetime;
            
            [array addObject:cell];
        }
        
        {
            CAEmitterCell *cell           = [CAEmitterCell emitterCell];
            cell.birthRate                = 0.3f;
            cell.velocity                 = 60.f; // 初速度
            cell.velocityRange            = 10.f;
            cell.lifetime                 = (emitterView.width + 8) / (cell.velocity - cell.velocityRange);  // 生命周期
            cell.emissionRange            = [Math radianFromDegree:15.f];
            cell.scale                    = 0.5;
            cell.contents                 = (id)[UIImage imageNamed:@"光斑-3"].CGImage;
            
            cell.alphaRange = 0.5f;
            
            [array addObject:cell];
        }
        
        {
            CAEmitterCell *cell           = [CAEmitterCell emitterCell];
            cell.birthRate                = 0.3f;
            cell.velocity                 = 35.f; // 初速度
            cell.velocityRange            = 10.f;
            cell.lifetime                 = (emitterView.width + 8) / (cell.velocity - cell.velocityRange);  // 生命周期
            cell.emissionRange            = [Math radianFromDegree:25.f];
            cell.scale                    = 0.5;
            cell.contents                 = (id)[UIImage imageNamed:@"光斑-4"].CGImage;
            
            cell.alphaRange = 0.5f;
            
            [array addObject:cell];
        }
        
        
        {
            CAEmitterCell *cell           = [CAEmitterCell emitterCell];
            cell.birthRate                = 0.3f;
            cell.velocity                 = 35.f; // 初速度
            cell.velocityRange            = 10.f;
            cell.lifetime                 = (emitterView.width + 8) / (cell.velocity - cell.velocityRange);  // 生命周期
            cell.emissionRange            = [Math radianFromDegree:15.f];
            cell.scale                    = 0.5;
            cell.contents                 = (id)[UIImage imageNamed:@"光斑-5"].CGImage;
            
            cell.alphaRange = 0.5f;
            
            [array addObject:cell];
        }
        
        
        {
            CAEmitterCell *cell           = [CAEmitterCell emitterCell];
            cell.birthRate                = 0.3f;
            cell.velocity                 = 35.f; // 初速度
            cell.velocityRange            = 10.f;
            cell.lifetime                 = (emitterView.width + 8) / (cell.velocity - cell.velocityRange);  // 生命周期
            cell.emissionRange            = [Math radianFromDegree:15.f];
            cell.scale                    = 0.5;
            cell.spin                     = [Math radianFromDegree:15.f];
            cell.spinRange                = [Math radianFromDegree:30.f];
            cell.contents                 = (id)[UIImage imageNamed:@"光斑-6"].CGImage;
            
            cell.alphaRange = 0.5f;
            cell.alphaSpeed = - 2 / cell.lifetime;
            
            [array addObject:cell];
        }
        
        
        {
            CAEmitterCell *cell           = [CAEmitterCell emitterCell];
            cell.birthRate                = 0.4f;
            cell.velocity                 = 50.f; // 初速度
            cell.velocityRange            = 10.f;
            cell.lifetime                 = (emitterView.width + 8) / (cell.velocity - cell.velocityRange);  // 生命周期
            cell.emissionRange            = [Math radianFromDegree:15.f];
            cell.scale                    = 0.5;
            cell.contents                 = (id)[UIImage imageNamed:@"光斑-7"].CGImage;
            cell.color                    = UIColor.whiteColor.CGColor;
            
            cell.redRange = 1.f;
            cell.redSpeed = 2 / cell.lifetime;
            
            cell.blueRange = 1.f;
            cell.blueSpeed = 2 / cell.lifetime;
            
            cell.greenRange = 1.f;
            cell.greenSpeed = 2 / cell.lifetime;
            
            cell.alphaRange = 0.5f;
            cell.alphaSpeed = - 1 / cell.lifetime;
            
            [array addObject:cell];
        }
        
//        {
//            CAEmitterCell *cell           = [CAEmitterCell emitterCell];
//            cell.birthRate                = 1.f;
//            cell.velocity                 = 35.f; // 初速度
//            cell.velocityRange            = 10.f;
//            cell.lifetime                 = (emitterView.width + 8) / (cell.velocity - cell.velocityRange);  // 生命周期
//            // cell.emissionLongitude        = M_PI;
//            cell.scale                    = 0.5;
//            cell.scaleRange               = 0.1;
//            cell.contents                 = (id)[UIImage imageNamed:@"光斑"].CGImage;
//
//            cell.color = [[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.5f] CGColor];
//            cell.redRange = 1.0;
////            cell.redSpeed = 0.2;
//            cell.blueRange = 1.0;
////            cell.blueSpeed = 0.2;
//            cell.greenRange = 1.0;
////            cell.greenSpeed = 0.2;
//            // cell.alphaSpeed = -0.1;
//            cell.alphaRange = 0.5f;
//
//            NSLog(@"%@", UIColor.blackColor.CGColor);
//
//            [array addObject:cell];
//        }
        
        emitterView.emitterCells = array;
    }
}

- (void)didUpdateFrame {
    
    NSLog(@"%@", NSStringFromCGRect(self.superview.frame));
}

@end
