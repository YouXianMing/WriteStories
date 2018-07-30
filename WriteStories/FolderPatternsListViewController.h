//
//  FolderPatternsListViewController.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "NormalTitleViewController.h"
#import "BaseFolderItem.h"

typedef enum : NSUInteger {
    
    FolderPatternsListViewControllerType_AddNewFolder,  // 创建文件夹
    FolderPatternsListViewControllerType_ReplaceFolder, // 替换文件夹
    
} FolderPatternsListViewControllerType;

@interface FolderPatternsListViewController : NormalTitleViewController

@property (nonatomic) FolderPatternsListViewControllerType controllerType;

/**
 文件夹文件(在type为FolderPatternsListViewControllerType_ReplaceFolder的时候需要对这个属性赋值)
 */
@property (nonatomic, strong) BaseFolderItem *folderItem;

/**
 首页元素的分类
 */
@property (nonatomic, strong) NSNumber *type;

@end
