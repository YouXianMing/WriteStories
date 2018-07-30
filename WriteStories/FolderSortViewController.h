//
//  FolderSortViewController.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "NormalTitleViewController.h"
#import "BaseFolderItem.h"

@interface FolderSortViewController : NormalTitleViewController

@property (nonatomic, strong) NSArray <BaseFolderItem *> *folderItems;

@end
