//
//  Table_Mark_List.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/19.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Table_Mark_List.h"

@implementation Table_Mark_List

+ (NSDictionary<NSString *,NSString *> *)keysAndTypes {
    
    return @{@"mark_id"     : @"INTEGER PRIMARY KEY AUTOINCREMENT",
             @"mark_name"   : @"TEXT",
             @"type"        : @"INTEGER",
             @"mark_data"   : @"BLOB",
             @"sort_index"  : @"INTEGER",
             @"folder_id"   : @"INTEGER",
             @"name"        : @"TEXT"};
}

+ (void)storeData:(NSData *)data type:(NSInteger)type folderId:(NSInteger)folderId title:(NSString *)title markName:(NSString *)markName sortIndex:(NSInteger)sortIndex {
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        BOOL success = [db executeUpdate:@"INSERT INTO Table_Mark_List (name, mark_name, type, mark_data, sort_index, folder_id) VALUES (?, ?, ?, ?, ?, ?);",
                        title,
                        markName,
                        @(type),
                        data,
                        @(sortIndex),
                        @(folderId)];
        if (!success) {
            
            NSLog(@"error = %@", [db lastErrorMessage]);
        }
    }];
    
    // 更新首页数据
    [self.class updateHomePage];
    
    // 更新指定文件夹数目
    [self.class updateFolderCountWithFolderId:folderId];
}

+ (void)updateData:(NSData *)data markId:(NSInteger)markId title:(NSString *)title sortIndex:(NSInteger)sortIndex {
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        BOOL success = [db executeUpdate:@"UPDATE Table_Mark_List SET mark_data = ?, name = ?, sort_index = ? WHERE mark_id = ?;",
                        data, title, @(sortIndex), @(markId)];
        if (!success) {
            
            NSLog(@"error = %@", [db lastErrorMessage]);
        }
    }];
}

+ (void)moveMarkId:(NSInteger)markId toFolderId:(NSInteger)folderId toType:(NSInteger)type {
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        NSInteger count = [db intForQuery:@"SELECT MAX(sort_index) FROM Table_Mark_List WHERE folder_id = ?;", @(folderId)];
        BOOL success = [db executeUpdate:@"UPDATE Table_Mark_List SET folder_id = ?, type = ?, sort_index = ? WHERE mark_id = ?;",
                        @(folderId), @(type), @(count + 1), @(markId)];
        if (!success) {
            
            NSLog(@"error = %@", [db lastErrorMessage]);
        }
    }];
    
    // 更新首页数据
    [self.class updateHomePage];
    
    // 更新所有的文件夹数目
    [self.class updateAllFoldersCount];
}

+ (NSInteger)maxSortIndexWithFolderId:(NSInteger)folderId {
    
    __block NSInteger count = 0;
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        count = [db intForQuery:@"SELECT MAX(sort_index) FROM Table_Mark_List WHERE folder_id = ?;", @(folderId)];
    }];
    
    return count;
}

+ (NSArray <BaseMarkItem *> *)markItemsWithFolderId:(NSInteger)folderId {
    
    NSMutableArray *objects = [NSMutableArray array];
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM Table_Mark_List WHERE folder_id = ? ORDER BY sort_index ASC LIMIT 0, 40;", @(folderId)];
        while ([rs next]) {
            
            BaseMarkItem *item = [BaseMarkItem decodeWithData:[rs dataForColumn:@"mark_data"]];
            [objects addObject:item];
            
            // 数据库属性
            item.mark_id     = [rs intForColumn:@"mark_id"];
            item.title       = [rs stringForColumn:@"name"];
            item.folder_id   = [rs intForColumn:@"folder_id"];
            item.mark_name   = [rs stringForColumn:@"mark_name"];
            item.type        = [rs intForColumn:@"type"];
            item.sort_index  = [rs intForColumn:@"sort_index"];
        }
    }];
    
    return [NSArray arrayWithArray:objects];
}

+ (void)deleteItem:(BaseMarkItem *)item {
    
    __weak BaseMarkItem *tmpItem = item;
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        BOOL success = [db executeUpdate:@"DELETE FROM Table_Mark_List WHERE mark_id = ?;", @(tmpItem.mark_id)];
        if (success == NO) {
            
            NSLog(@"error = %@", [db lastErrorMessage]);
        }
    }];
    
    // 更新首页数据
    [self.class updateHomePage];
    
    // 更新指定文件夹数目
    [self.class updateFolderCountWithFolderId:item.folder_id];
}

+ (NSInteger)markItemsCountWithFolderId:(NSInteger)folderId {
    
    __block NSInteger count = 0;
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        count = [db intForQuery:@"SELECT COUNT(*) FROM Table_Mark_List WHERE folder_id = ?;", @(folderId)];
    }];
    
    return count;
}

+ (BaseMarkItem *)itemWithFolderName:(NSString *)folderName {
    
    __block BaseMarkItem *item = nil;
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM Table_Mark_List WHERE mark_name = ?;", folderName];
        while ([rs next]) {
            
            item             = [BaseMarkItem decodeWithData:[rs dataForColumn:@"mark_data"]];
            item.mark_id     = [rs intForColumn:@"mark_id"];
            item.title       = [rs stringForColumn:@"name"];
            item.folder_id   = [rs intForColumn:@"folder_id"];
            item.mark_name   = [rs stringForColumn:@"mark_name"];
            item.type        = [rs intForColumn:@"type"];
            item.sort_index  = [rs intForColumn:@"sort_index"];
        }
    }];
    
    return item;
}

+ (BaseMarkItem *)itemWithFolderId:(NSInteger)folderId title:(NSString *)title {
    
    __block BaseMarkItem *item = nil;
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM Table_Mark_List WHERE folder_id = ? AND name = ?;", @(folderId), title];
        while ([rs next]) {
            
            item             = [BaseMarkItem decodeWithData:[rs dataForColumn:@"mark_data"]];
            item.mark_id     = [rs intForColumn:@"mark_id"];
            item.title       = [rs stringForColumn:@"name"];
            item.folder_id   = [rs intForColumn:@"folder_id"];
            item.mark_name   = [rs stringForColumn:@"mark_name"];
            item.type        = [rs intForColumn:@"type"];
            item.sort_index  = [rs intForColumn:@"sort_index"];
        }
    }];
    
    return item;
}

+ (void)updateMarkItemsSortIndex:(NSArray <BaseMarkItem *> *)items {
    
    __weak NSArray <BaseMarkItem *> *weakItems = items;
    
    [DBManager.queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        
        [weakItems enumerateObjectsUsingBlock:^(BaseMarkItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            BOOL success = [db executeUpdate:@"UPDATE Table_Mark_List SET sort_index = ? WHERE mark_id = ?;",
                            @(obj.sort_index), @(obj.mark_id)];
            
            if (success == NO) {
                
                NSLog(@"error = %@", [db lastErrorMessage]);
                *rollback = YES;
            }
        }];
    }];
}

@end
