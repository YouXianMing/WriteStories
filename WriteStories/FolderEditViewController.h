//
//  FolderEditViewController.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/16.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "NormalTitleViewController.h"
#import "BaseFolderItem.h"

@interface FolderEditViewController : NormalTitleViewController

@property (nonatomic, strong) BaseFolderItem *folderItem; // 携带有数据库数据

@end
