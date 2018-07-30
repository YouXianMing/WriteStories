//
//  ColorsManager.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/17.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ColorsModel.h"

@interface ColorsManager : NSObject

+ (void)prepare;

@property (class, readonly) NSArray <ColorsModel *> *colorModels;

@end
