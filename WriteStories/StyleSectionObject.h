//
//  StyleSectionObject.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomCell.h"

@interface StyleSectionObject : NSObject

@property (nonatomic, strong) NSString                           *title;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

@end
