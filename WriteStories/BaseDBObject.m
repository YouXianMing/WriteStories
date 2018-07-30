//
//  BaseDBObject.m
//  FamousQuotes
//
//  Created by YouXianMing on 2018/1/16.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseDBObject.h"

@implementation BaseDBObject

+ (NSString *)table {
    
    return [NSString stringWithFormat:@"%@", NSStringFromClass([self class])];
}

+ (NSDictionary <NSString *, NSString *> *)keysAndTypes {
    
    return nil;
}

+ (void)createTable {
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
    
        NSMutableString *keyNames = [NSMutableString string];
        [[self keysAndTypes] enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
            
            [keyNames appendFormat:@"%@ %@,", key, obj];
        }];
        
        NSString *createTableString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@);",
                                       [[self class] table],
                                       [keyNames substringWithRange:NSMakeRange(0, keyNames.length - 1)]];
        
        [db executeUpdate:createTableString];
        
        NSLog(@" ==[DB]== %@", createTableString);
    }];
}

+ (void)updateTable {
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        // 获取所有列的名字
        NSMutableArray *keys = [NSMutableArray array];
        FMResultSet    *rs   = [db executeQuery:[NSString stringWithFormat:@"PRAGMA table_info (%@);", [[self class] table]]];
        while ([rs next]) {
            
            NSString *name = [rs stringForColumn:@"name"];
            [keys addObject:name];
        }
        
        // 删除掉重复的
        NSMutableArray *allKeys = [NSMutableArray arrayWithArray:[[self class] keysAndTypes].allKeys];
        [allKeys removeObjectsInArray:keys];
        
        // 如果有多出来的key值,则更新表
        if (allKeys.count) {
            
            [allKeys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSString *alterString = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ %@;", [[self class] table], key, [[self class] keysAndTypes][key]];
                [db executeUpdate:alterString];
                
                NSLog(@" ==[DB]== %@", alterString);
            }];
        }
    }];
}

@end
