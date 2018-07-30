//
//  Table_Folder_List.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Table_Folder_List.h"

@interface Table_Folder_List ()

@end

@implementation Table_Folder_List

+ (NSDictionary<NSString *,NSString *> *)keysAndTypes {
    
    return @{@"folder_id"   : @"INTEGER PRIMARY KEY AUTOINCREMENT",
             @"folder_name" : @"TEXT",
             @"type"        : @"INTEGER",
             @"folder_data" : @"BLOB",
             @"sort_index"  : @"INTEGER",
             @"name"        : @"TEXT"};
}

+ (void)storeData:(NSData *)data type:(NSInteger)type title:(NSString *)title folderName:(NSString *)folderName sortIndex:(NSInteger)sortIndex {
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        BOOL success = [db executeUpdate:@"INSERT INTO Table_Folder_List (name, folder_name, type, folder_data, sort_index) VALUES (?, ?, ?, ?, ?);",
                        title,
                        folderName,
                        @(type),
                        data,
                        @(sortIndex)];
        if (!success) {
            
            NSLog(@"error = %@", [db lastErrorMessage]);
        }
    }];
    
    // 更新首页数据
    [self.class updateHomePage];
}

+ (void)updateData:(NSData *)data folderId:(NSInteger)folderId title:(NSString *)title sortIndex:(NSInteger)sortIndex {
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        BOOL success = [db executeUpdate:@"UPDATE Table_Folder_List SET folder_data = ?, name = ?, sort_index = ? WHERE folder_id = ?;",
                        data, title, @(sortIndex), @(folderId)];
        if (!success) {
            
            NSLog(@"error = %@", [db lastErrorMessage]);
        }
    }];
}

+ (void)moveFolderId:(NSInteger)folderId toType:(NSInteger)type {
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        // 获取移动位置中元素的sort_index的最大值
        NSInteger count = [db intForQuery:@"SELECT MAX(sort_index) FROM Table_Folder_List WHERE type = ?;", @(type)];
        
        BOOL success = [db executeUpdate:@"UPDATE Table_Folder_List SET type = ?, sort_index = ? WHERE folder_id = ?;",
                        @(type), @(count + 1), @(folderId)];
        if (!success) {
            
            NSLog(@"error = %@", [db lastErrorMessage]);
        }
        
        // 更新文章的type
        [db executeUpdate:@"UPDATE Table_Mark_List SET type = ? WHERE folder_id = ?;", @(type), @(folderId)];
    }];
    
    // 更新首页数据
    [self.class updateHomePage];
}

+ (BaseFolderItem *)itemWithFolderName:(NSString *)folderName type:(NSInteger)type {
    
    __block BaseFolderItem *item = nil;
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM Table_Folder_List WHERE type = ? AND folder_name = ?;", @(type), folderName];
        while ([rs next]) {
            
            item             = [BaseFolderItem decodeWithData:[rs dataForColumn:@"folder_data"]];
            item.folder_id   = [rs intForColumn:@"folder_id"];
            item.folder_name = [rs stringForColumn:@"folder_name"];
            item.type        = [rs intForColumn:@"type"];
            item.sort_index  = [rs intForColumn:@"sort_index"];
        }
    }];
    
    return item;
}

+ (BaseFolderItem *)itemWithFolderTitle:(NSString *)title type:(NSInteger)type {
    
    __block BaseFolderItem *item = nil;
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM Table_Folder_List WHERE type = ? AND name = ?;", @(type), title];
        while ([rs next]) {
            
            item             = [BaseFolderItem decodeWithData:[rs dataForColumn:@"folder_data"]];
            item.folder_id   = [rs intForColumn:@"folder_id"];
            item.folder_name = [rs stringForColumn:@"folder_name"];
            item.type        = [rs intForColumn:@"type"];
            item.sort_index  = [rs intForColumn:@"sort_index"];
        }
    }];
    
    return item;
}

+ (void)deleteItem:(BaseFolderItem *)item {
    
    __weak BaseFolderItem *tmpItem = item;
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        BOOL success = [db executeUpdate:@"DELETE FROM Table_Folder_List WHERE folder_id = ?;", @(tmpItem.folder_id)];
        if (success == NO) {
            
            NSLog(@"error = %@", [db lastErrorMessage]);
        }
    }];
    
    // 更新首页数据
    [self.class updateHomePage];
}

+ (NSInteger)maxSortIndexWithType:(NSInteger)type {
    
    __block NSInteger count = 0;
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        count = [db intForQuery:@"SELECT MAX(sort_index) FROM Table_Folder_List WHERE type = ?;", @(type)];
    }];
    
    return count;
}

+ (NSArray <BaseFolderItem *> *)folderItemsWithType:(NSInteger)type {
    
    NSMutableArray *objects = [NSMutableArray array];
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM Table_Folder_List WHERE type = ? ORDER BY sort_index ASC;", @(type)];
        while ([rs next]) {
            
            BaseFolderItem *item = [BaseFolderItem decodeWithData:[rs dataForColumn:@"folder_data"]];
            [objects addObject:item];
            
            // 数据库属性
            item.folder_id    = [rs intForColumn:@"folder_id"];
            item.folder_name  = [rs stringForColumn:@"folder_name"];
            item.type         = [rs intForColumn:@"type"];
            item.sort_index   = [rs intForColumn:@"sort_index"];
            item.articleCount = [db intForQuery:@"SELECT COUNT(*) FROM Table_Mark_List WHERE folder_id = ?;", @(item.folder_id)];
        }
    }];
    
    return [NSArray arrayWithArray:objects];
}

+ (NSInteger)foldersCountWithType:(NSInteger)type {
    
    __block NSInteger count = 0;
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        count = [db intForQuery:@"SELECT COUNT(*) FROM Table_Folder_List WHERE type = ?;", @(type)];
    }];
    
    return count;
}

+ (NSArray <NSNumber *> *)folderItemsArticleCountWithType:(NSInteger)type {
    
    NSMutableArray *objects = [NSMutableArray array];
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        FMResultSet *rs = [db executeQuery:@"SELECT folder_id FROM Table_Folder_List WHERE type = ? ORDER BY sort_index ASC;", @(type)];
        while ([rs next]) {
            
            NSInteger count = [db intForQuery:@"SELECT COUNT(*) FROM Table_Mark_List WHERE folder_id = ?;", @([rs intForColumn:@"folder_id"])];
            [objects addObject:@(count)];
        }
    }];
    
    return [NSArray arrayWithArray:objects];
}

+ (void)updateFolderItemsSortIndex:(NSArray <BaseFolderItem *> *)items {
    
    __weak NSArray <BaseFolderItem *> *weakItems = items;
    
    [DBManager.queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        
        [weakItems enumerateObjectsUsingBlock:^(BaseFolderItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            BOOL success = [db executeUpdate:@"UPDATE Table_Folder_List SET sort_index = ? WHERE folder_id = ?;",
                            @(obj.sort_index), @(obj.folder_id)];
            
            if (success == NO) {
                
                NSLog(@"error = %@", [db lastErrorMessage]);
                *rollback = YES;
            }
        }];
    }];
}

+ (NSMutableArray <Table_Folder_Type_Object *> *)folderObjects {
    
    NSMutableArray *datas = [NSMutableArray array];
    
    [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        NSArray <NSNumber *> *numbers = @[@(1), @(2), @(3), @(4), @(5), @(6)];
        
        [numbers enumerateObjectsUsingBlock:^(NSNumber *type, NSUInteger idx, BOOL * _Nonnull stop) {
        
            Table_Folder_Type_Object *typeObject = [Table_Folder_Type_Object new];
            typeObject.type                      = type.integerValue;
            typeObject.typeName                  = Values.FolderName[type];
            [datas addObject:typeObject];
            
            FMResultSet *rs = [db executeQuery:@"SELECT folder_id, name FROM Table_Folder_List WHERE type = ? ORDER BY sort_index ASC;", type];
            while ([rs next]) {
                
                Table_Folder_Object *folder = [Table_Folder_Object new];
                folder.type                 = type.integerValue;
                folder.folderId             = [rs intForColumn:@"folder_id"];
                folder.fileCount            = [db intForQuery:@"SELECT COUNT(*) FROM Table_Mark_List WHERE folder_id = ?;", @(folder.folderId)];
                folder.name                 = [rs stringForColumn:@"name"];
                [typeObject.folderObjects addObject:folder];
            }
        }];
    }];
    
    return datas;
}

@end
