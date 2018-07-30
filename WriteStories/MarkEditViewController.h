//
//  MarkEditViewController.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/23.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "NormalTitleViewController.h"
#import "BaseMarkItem.h"

@interface MarkEditViewController : NormalTitleViewController

@property (nonatomic, strong) BaseMarkItem *markItem; // 携带有数据库数据

@end
