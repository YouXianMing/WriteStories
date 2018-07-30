//
//  ArticleSortViewController.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "NormalTitleViewController.h"
#import "BaseBlockItem.h"

@interface ArticleSortViewController : NormalTitleViewController

@property (nonatomic, strong) NSMutableArray <BaseBlockItem *> *blockItems;

@end
