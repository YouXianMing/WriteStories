//
//  Table_Mark_List.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/19.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "TableDBObject.h"
#import "BaseMarkItem.h"

@interface Table_Mark_List : TableDBObject

/**
 存储文章标签

 @param data BaseMarkItem二进制文件
 @param type 大分类
 @param folderId 文件夹id
 @param title 标签标题
 @param markName 标签文件夹名字
 @param sortIndex 标签排序编号
 */
+ (void)storeData:(NSData *)data type:(NSInteger)type folderId:(NSInteger)folderId title:(NSString *)title markName:(NSString *)markName sortIndex:(NSInteger)sortIndex;

/**
 更新文章标签

 @param data BaseMarkItem二进制文件
 @param markId 标签id
 @param title 标签标题
 @param sortIndex 标签排序编号
 */
+ (void)updateData:(NSData *)data markId:(NSInteger)markId title:(NSString *)title sortIndex:(NSInteger)sortIndex;

/**
 将文章标签移动到指定的文件夹以及类型当中

 @param markId 标签id
 @param folderId 文件夹id
 @param type 大分类
 */
+ (void)moveMarkId:(NSInteger)markId toFolderId:(NSInteger)folderId toType:(NSInteger)type;

/**
 获取排序的最大值
 
 @param folderId 文件夹id
 @return 最大值
 */
+ (NSInteger)maxSortIndexWithFolderId:(NSInteger)folderId;

/**
 根据文件夹名字获取BaseMarkItem对象
 
 @param folderName 文件夹名字
 @return BaseMarkItem对象
 */
+ (BaseMarkItem *)itemWithFolderName:(NSString *)folderName;

/**
 根据文件夹id以及标题获取BaseMarkItem对象

 @param folderId 文件夹id
 @param title 标题
 @return BaseMarkItem对象
 */
+ (BaseMarkItem *)itemWithFolderId:(NSInteger)folderId title:(NSString *)title;

/**
 根据folderId来获取标签对象数组

 @param folderId 文件夹id
 @return BaseMarkItem对象数组
 */
+ (NSArray <BaseMarkItem *> *)markItemsWithFolderId:(NSInteger)folderId;

/**
 根据folderId来获取标签对象的个数

 @param folderId 文件夹id
 @return 标签对象个数
 */
+ (NSInteger)markItemsCountWithFolderId:(NSInteger)folderId;

/**
 删除BaseMarkItem对象

 @param item BaseMarkItem对象
 */
+ (void)deleteItem:(BaseMarkItem *)item;

/**
 更新BaseMarkItem的排序

 @param items BaseMarkItem数组
 */
+ (void)updateMarkItemsSortIndex:(NSArray <BaseMarkItem *> *)items;

@end
