//
//  ItemsEditManager.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/17.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemsHeader.h"

@interface ItemsStyleEditManager : NSObject

@property (nonatomic, weak)   NSObject *weakObject;
@property (nonatomic, strong) NSMutableArray <ItemsHeader *> *headers;

+ (instancetype)managerWithWeakObject:(NSObject *)weakObject;

@end
