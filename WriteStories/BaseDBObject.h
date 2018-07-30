//
//  BaseDBObject.h
//  FamousQuotes
//
//  Created by YouXianMing on 2018/1/16.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBManager.h"

@interface BaseDBObject : NSObject

/**
 获取数据库表名

 @return 数据库表名字
 */
+ (NSString *)table;

/**
 创建表
 */
+ (void)createTable;

/**
 更新表
 */
+ (void)updateTable;

/**
 [子类重写] 声明键值对
 
 @return 声明的键值对
 */
+ (NSDictionary <NSString *, NSString *> *)keysAndTypes;

@end
