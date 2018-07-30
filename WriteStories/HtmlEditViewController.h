//
//  HtmlEditViewController.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/28.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "FullContentViewController.h"
#import "BaseBlockItem.h"

@interface HtmlEditViewController : FullContentViewController

@property (nonatomic, strong) NSArray <BaseBlockItem *> *blockItems;
@property (nonatomic, strong) NSString                  *htmlFolder;

@end
