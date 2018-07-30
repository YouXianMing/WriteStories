//
//  SingleSelectedProtocol.h
//  FamousQuotes
//
//  Created by YouXianMing on 2018/2/4.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SingleSelectedProtocol <NSObject>

@required

- (void)setSelected:(BOOL)selected;
- (BOOL)selected;

@end

