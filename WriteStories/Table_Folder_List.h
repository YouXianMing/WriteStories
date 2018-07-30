//
//  Table_Folder_List.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "TableDBObject.h"
#import "BaseFolderItem.h"
#import "Table_Folder_Object.h"

@interface Table_Folder_List : TableDBObject

/**
 存储文件夹

 @param data BaseFolderItem的二进制文件
 @param type 大分类
 @param title 文件夹标题
 @param folderName 文件夹名字
 @param sortIndex 排序值
 */
+ (void)storeData:(NSData *)data type:(NSInteger)type title:(NSString *)title folderName:(NSString *)folderName sortIndex:(NSInteger)sortIndex;

/**
 替换文件夹

 @param data BaseFolderItem的二进制文件
 @param folderId 文件夹id
 @param title 文件夹标题
 @param sortIndex 排序号码
 */
+ (void)updateData:(NSData *)data folderId:(NSInteger)folderId title:(NSString *)title sortIndex:(NSInteger)sortIndex;

/**
 将文件夹移动到指定的类型中(更新了对应记录的sort_index值)

 @param folderId 文件夹id
 @param type 大分类
 */
+ (void)moveFolderId:(NSInteger)folderId toType:(NSInteger)type;

/**
 根据文件夹名字以及type获取BaseFolderItem对象

 @param folderName 文件夹名字
 @param type 大分类
 @return BaseFolderItem对象
 */
+ (BaseFolderItem *)itemWithFolderName:(NSString *)folderName type:(NSInteger)type;

/**
 根据文件夹标题以及type获取BaseFolderItem对象

 @param title 文件夹标题
 @param type 大分类
 @return BaseFolderItem对象
 */
+ (BaseFolderItem *)itemWithFolderTitle:(NSString *)title type:(NSInteger)type;

/**
 删除BaseFolderItem对象

 @param item BaseFolderItem对象
 */
+ (void)deleteItem:(BaseFolderItem *)item;

/**
 获取排序的最大值

 @param type 大分类
 @return 最大值
 */
+ (NSInteger)maxSortIndexWithType:(NSInteger)type;


/**
 获取文件夹数目

 @param type 大分类
 @return 数目
 */
+ (NSInteger)foldersCountWithType:(NSInteger)type;

/**
 获取文件夹列表

 @param type 大分类
 @return 文件夹列表
 */
+ (NSArray <BaseFolderItem *> *)folderItemsWithType:(NSInteger)type;

/**
 获取文件夹列表的文章数目

 @param type 大分类
 @return 每个文件夹的文章数目
 */
+ (NSArray <NSNumber *> *)folderItemsArticleCountWithType:(NSInteger)type;

/**
 更新文件夹列表的排序值

 @param items BaseFolderItem数组
 */
+ (void)updateFolderItemsSortIndex:(NSArray <BaseFolderItem *> *)items;

/**
 获取文件夹信息数组

 @return 文件夹信息数组
 */
+ (NSMutableArray <Table_Folder_Type_Object *> *)folderObjects;

@end
