//
//  DBTablesManager.h
//  FamousQuotes
//
//  Created by YouXianMing on 2018/1/16.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBTablesManager : NSObject

/**
 创建table
 */
+ (void)createTables;

/**
 更新table的数据结构(增加新字段)
 */
+ (void)upateTableParams;

@end
