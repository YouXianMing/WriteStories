//
//  MarkSortViewViewController.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/19.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "NormalTitleViewController.h"
#import "BaseMarkItem.h"

@interface MarkSortViewViewController : NormalTitleViewController

@property (nonatomic, strong) NSArray <BaseMarkItem *> *markItems;

@end
