//
//  ItemsHeader.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/17.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StyleEditor.h"

@interface ItemsHeader : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSMutableArray <StyleEditor *> *editors;

+ (instancetype)headerWithTitle:(NSString *)title;

@end
