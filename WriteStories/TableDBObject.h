//
//  TableDBObject.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/16.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseDBObject.h"
#import "GCD.h"
#import "DefaultNotificationCenter.h"
#import "Values.h"

@interface TableDBObject : BaseDBObject

/**
 更新首页数据
 */
+ (void)updateHomePage;

/**
 更新文件夹列表文件夹数目

 @param folderId 文件夹id
 */
+ (void)updateFolderCountWithFolderId:(NSInteger)folderId;

/**
 更新所有的文件夹数目
 */
+ (void)updateAllFoldersCount;

@end
