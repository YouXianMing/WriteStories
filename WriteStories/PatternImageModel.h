//
//  PatternImageModel.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/13.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleSelectedProtocol.h"

@interface PatternImageModel : NSObject <SingleSelectedProtocol>

@property (nonatomic, strong) NSString *patternImageName;
@property (nonatomic) BOOL              selected;

@end
