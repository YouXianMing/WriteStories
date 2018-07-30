//
//  ColorsModel.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/17.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleSelectedProtocol.h"

@interface ColorsModel : NSObject <SingleSelectedProtocol>

@property (nonatomic) BOOL              selected;
@property (nonatomic) NSInteger         index;
@property (nonatomic, strong) NSString *hexString;

@end
