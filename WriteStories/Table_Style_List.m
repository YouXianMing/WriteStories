//
//  Table_Style_List.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/23.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Table_Style_List.h"

@implementation Table_Style_List

+ (NSDictionary<NSString *,NSString *> *)keysAndTypes {
    
    return @{@"style_id"     : @"INTEGER PRIMARY KEY AUTOINCREMENT",
             @"style_type"   : @"INTEGER",
             @"style_data"   : @"BLOB",
             @"style_name"   : @"TEXT"};
}

+ (void)storeStyleObject:(WriteStoriesBaseItemObject *)itemObject styleName:(NSString *)styleName {
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        BOOL success = [db executeUpdate:@"INSERT INTO Table_Style_List (style_data, style_name, style_type) VALUES (?, ?, ?);",
                        itemObject.currentStyleObject.encodeData,
                        styleName,
                        @([[itemObject class] ShowStyleType])];
        if (!success) {
            
            NSLog(@"error = %@", [db lastErrorMessage]);
        }
    }];
}

+ (NSArray <WriteStoriesBaseItemObject *> *)styleObjectsByShowStyleType:(NSInteger)type {
    
    NSMutableArray *objects = [NSMutableArray array];
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM Table_Style_List WHERE style_type = ?;", @(type)];
        while ([rs next]) {
            
            WriteStoriesBaseItemObject *item = [WriteStoriesBaseItemObject decodeWithData:[rs dataForColumn:@"style_data"]];
            [objects addObject:item];
            
            // 数据库属性
            item.styleName = [rs stringForColumn:@"style_name"];
            item.styleId   = [rs intForColumn:@"style_id"];
        }
    }];
    
    return [NSArray arrayWithArray:objects];
}

+ (void)deleteItemObject:(WriteStoriesBaseItemObject *)itemObject {
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        BOOL success = [db executeUpdate:@"DELETE FROM Table_Style_List WHERE style_id = ?;", @(itemObject.styleId)];
        if (success == NO) {
            
            NSLog(@"error = %@", [db lastErrorMessage]);
        }
    }];
}

+ (void)updateItemObject:(WriteStoriesBaseItemObject *)itemObject {
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        BOOL success = [db executeUpdate:@"UPDATE Table_Style_List SET style_name = ? WHERE style_id = ?;", itemObject.styleName, @(itemObject.styleId)];
        if (success == NO) {
            
            NSLog(@"error = %@", [db lastErrorMessage]);
        }
    }];
}

+ (NSInteger)styleCountsByItemObject:(WriteStoriesBaseItemObject *)itemObject {
    
    __block NSInteger count = 0;
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        count = [db intForQuery:@"SELECT COUNT(*) FROM Table_Style_List WHERE style_type = ?;", @([[itemObject class] ShowStyleType])];
    }];
    
    return count;
}

@end
