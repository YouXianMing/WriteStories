//
//  ScaleSelectedView.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/1.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EncodeImageObject.h"

typedef void(^ScaleSelectedViewSelectedBlock_t)(EncodeImageObject *imageObject);

@interface ScaleSelectedView : UIView

@property (nonatomic, copy)   ScaleSelectedViewSelectedBlock_t  selectedBlock;
@property (nonatomic, strong) NSArray <EncodeImageObject *>    *imageObjects;

+ (void)scaleSelectedViewShowWithImageObjects:(NSArray <EncodeImageObject *> *)imageObjects
                                selectedBlock:(ScaleSelectedViewSelectedBlock_t)selectedBlock;

@end
