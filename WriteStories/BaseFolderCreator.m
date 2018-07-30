//
//  BaseFolderCreator.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseFolderCreator.h"
#import "NSString+RandomString.h"
#import "NSString+Path.h"
#import "FoldersManager.h"
#import "GCDQueue.h"
#import "Table_Folder_List.h"
#import "VersionManager.h"

@interface BaseFolderCreator ()

@property (nonatomic) BaseFolderCreatorType type;

@end

@implementation BaseFolderCreator

- (void)startCreateWithPatternFolderItem:(BaseFolderItem *)folderItem folderType:(NSNumber *)folderType {
    
    self.type = BaseFolderCreatorTypeAdd;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseFolderCreatorDidStartCreateFolder:)]) {
        
        [self.delegate baseFolderCreatorDidStartCreateFolder:self];
    }
    
    [GCDQueue executeInGlobalQueue:^{
        
        // 获取随机文件夹名字
        NSString *string     = NSString.UniqueString;
        NSArray  *strings    = [string componentsSeparatedByString:@"-"];
        NSString *folderName = [NSString stringWithFormat:@"%@-%@", strings.firstObject, strings.lastObject];
        
        // 创建文件夹
        NSString *folderNamePath = [FoldersManager.FolderList addPathComponent:folderName];
        NSString *contentPath    = [folderNamePath addPathComponent:@"content"];
        NSString *imagePath      = [contentPath addPathComponent:@"images"];
        
        createDirectoryIfNotExistAtAbsoluteFilePath(folderNamePath);
        createDirectoryIfNotExistAtAbsoluteFilePath(contentPath);
        createDirectoryIfNotExistAtAbsoluteFilePath(imagePath);
        
        // 复制样式并设置标题
        BaseFolderItem *item = [BaseFolderItem decodeWithData:folderItem.encodeData];
        item.title           = @"文件夹";
        
        // 复制图片
        [item.imageObjects enumerateObjectsUsingBlock:^(EncodeImageObject *imageObject, NSUInteger idx, BOOL * _Nonnull stop) {
            
            // 拷贝文件
            NSString *source = [FoldersManager.DefaultImages addPathComponent:imageObject.imageName];
            NSString *dist   = [imagePath addPathComponent:imageObject.imageName];
            
            NSError *error = nil;
            [[NSFileManager defaultManager] copyItemAtPath:source toPath:dist error:&error];
            if (error) {
                
                NSLog(@"%@", error);
            }
            
            // 切换图片源头
            imageObject.source = EncodeImageObjectSourceFolder;
        }];
        
        // 将文件存储在指定文件夹
        NSData *data = item.encodeData;
        [data writeToFile:[contentPath addPathComponent:@"folder.data"] atomically:YES];
        
        // 将文件写进数据库
        [Table_Folder_List storeData:data
                                type:folderType.integerValue
                               title:item.title
                          folderName:folderName
                           sortIndex:[Table_Folder_List maxSortIndexWithType:folderType.integerValue] + 1];
        
        // 从数据库获取带id的数据
        BaseFolderItem *newItem = [Table_Folder_List itemWithFolderName:folderName type:folderType.integerValue];
        
        [GCDQueue executeInMainQueue:^{
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(baseFolderCreatorDidEndCreateFolder:folderItem:)]) {
                
                [self.delegate baseFolderCreatorDidEndCreateFolder:self folderItem:newItem];
            }
        }];
    }];
}

- (void)startUpdateWithOldFolderItem:(BaseFolderItem *)oldItem patternFolderItem:(BaseFolderItem *)folderItem {
    
    self.type = BaseFolderCreatorTypeReplace;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseFolderCreatorDidStartCreateFolder:)]) {
        
        [self.delegate baseFolderCreatorDidStartCreateFolder:self];
    }
    
    [GCDQueue executeInGlobalQueue:^{
        
        NSString *folderName = oldItem.folder_name;
        
        // 删除文件夹以及里面所有的数据
        NSString *filePath = [FoldersManager.FolderList addPathComponent:folderName];
        NSError  *error    = nil;
        [[NSFileManager defaultManager] removeItemAtURL:[NSURL fileURLWithPath:filePath] error:&error];
        if (error) {
            
            NSLog(@"%@", error);
        }
        
        // 重新创建文件夹
        NSString *folderNamePath = [FoldersManager.FolderList addPathComponent:folderName];
        NSString *contentPath    = [folderNamePath addPathComponent:@"content"];
        NSString *imagePath      = [contentPath addPathComponent:@"images"];
        
        createDirectoryIfNotExistAtAbsoluteFilePath(folderNamePath);
        createDirectoryIfNotExistAtAbsoluteFilePath(contentPath);
        createDirectoryIfNotExistAtAbsoluteFilePath(imagePath);
        
        // 复制样式后,将元数据的数据库值复制过来(如folder_id等)
        BaseFolderItem *newItem = [BaseFolderItem decodeWithData:folderItem.encodeData];
        newItem.folder_id       = oldItem.folder_id;
        newItem.folder_name     = oldItem.folder_name;
        newItem.type            = oldItem.type;
        newItem.sort_index      = oldItem.sort_index;
        newItem.articleCount    = oldItem.articleCount;
        
        // 将标题复制过来
        newItem.title = oldItem.title;
        
        // 复制图片
        [newItem.imageObjects enumerateObjectsUsingBlock:^(EncodeImageObject *imageObject, NSUInteger idx, BOOL * _Nonnull stop) {
            
            // 拷贝文件
            NSString *source = [FoldersManager.DefaultImages addPathComponent:imageObject.imageName];
            NSString *dist   = [imagePath addPathComponent:imageObject.imageName];
            
            NSError *error = nil;
            [[NSFileManager defaultManager] copyItemAtPath:source toPath:dist error:&error];
            if (error) {
                
                NSLog(@"%@", error);
            }
            
            // 切换图片源头
            imageObject.source = EncodeImageObjectSourceFolder;
        }];
        
        // 将文件存储在指定文件夹
        [newItem.encodeData writeToFile:[contentPath addPathComponent:@"folder.data"] atomically:YES];
        
        // 更新数据库中的该条记录
        [Table_Folder_List updateData:newItem.encodeData folderId:newItem.folder_id title:newItem.title sortIndex:newItem.sort_index];
        
        [GCDQueue executeInMainQueue:^{
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(baseFolderCreatorDidEndCreateFolder:folderItem:)]) {
                
                [self.delegate baseFolderCreatorDidEndCreateFolder:self folderItem:newItem];
            }
        }];
    }];
}


@end
