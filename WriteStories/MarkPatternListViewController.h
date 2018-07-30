//
//  MarkPatternListViewController.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/19.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "NormalTitleViewController.h"
#import "BaseFolderItem.h"
#import "BaseMarkItem.h"

typedef enum : NSUInteger {
    
    MarkPatternListViewController_AddNewMark,  // 创建文章
    MarkPatternListViewController_ReplacMark,  // 替换文章
    
} MarkPatternListViewControllerType;

@interface MarkPatternListViewController : NormalTitleViewController

@property (nonatomic) MarkPatternListViewControllerType type;
@property (nonatomic, strong) BaseMarkItem *markItem;

@property (nonatomic, strong) BaseFolderItem *folderItem;

@end
