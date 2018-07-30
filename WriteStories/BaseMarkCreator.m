//
//  BaseMarkCreator.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/19.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseMarkCreator.h"
#import "FoldersManager.h"
#import "BaseMarkItem.h"
#import "NSString+Path.h"
#import "Table_Mark_List.h"
#import "NSString+RandomString.h"
#import "GCD.h"
#import "VersionManager.h"
#import "BlocksManager.h"
#import "Animation_Set.h"

@interface BaseMarkCreator ()

@property (nonatomic) BaseMarkCreatorType type;

@end

@implementation BaseMarkCreator

- (void)startCreateWithPatternMarkItem:(BaseMarkItem *)markItem folderItem:(BaseFolderItem *)folderItem {
    
    self.type = BaseMarkCreatorTypeAdd;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseMarkCreatorDidStartCreateMark:)]) {
        
        [self.delegate baseMarkCreatorDidStartCreateMark:self];
    }
    
    [GCDQueue executeInGlobalQueue:^{
        
        // 获取随机文件夹名字
        NSString *string     = NSString.UniqueString;
        NSArray  *strings    = [string componentsSeparatedByString:@"-"];
        NSString *folderName = [NSString stringWithFormat:@"%@-%@", strings.firstObject, strings.lastObject];
        
        // 创建文件夹
        NSString *folderNamePath  = [FoldersManager.ArticleList addPathComponent:folderName]; // ~/Documents/.datafolder/article-list/文件夹名字
        NSString *contentPath     = [folderNamePath addPathComponent:@"content"];             // ~/Documents/.datafolder/article-list/文件夹名字/content
        NSString *htmlPath        = [contentPath addPathComponent:@"html"];                   // ~/Documents/.datafolder/article-list/文件夹名字/html
        NSString *titlePath       = [contentPath addPathComponent:@"title"];                  // ~/Documents/.datafolder/article-list/文件夹名字/content/title
        NSString *titleImagesPath = [titlePath addPathComponent:@"images"];                   // ~/Documents/.datafolder/article-list/文件夹名字/content/title/images
    
        createDirectoryIfNotExistAtAbsoluteFilePath(folderNamePath);
        createDirectoryIfNotExistAtAbsoluteFilePath(contentPath);
        createDirectoryIfNotExistAtAbsoluteFilePath(htmlPath);
        createDirectoryIfNotExistAtAbsoluteFilePath(titlePath);
        createDirectoryIfNotExistAtAbsoluteFilePath(titleImagesPath);
        
        // 创建文章起始默认数据
        [BlocksManager createDefaultValueWithHtmlFolderPath:htmlPath];
        
        // 创建动画设置默认文件
        [Animation_Set.defalutObject.encodeData writeToFile:FmtStr(@"%@/animationSet.data", htmlPath) atomically:YES];
        
        // 复制样式并设置标题
        BaseMarkItem *item = [BaseMarkItem decodeWithData:markItem.encodeData];
        
        // 复制图片
        [item.imageObjects enumerateObjectsUsingBlock:^(EncodeImageObject *imageObject, NSUInteger idx, BOOL * _Nonnull stop) {
            
            // 拷贝文件
            NSString *source = [FoldersManager.DefaultImages addPathComponent:imageObject.imageName];
            NSString *dist   = [titleImagesPath addPathComponent:imageObject.imageName];
            
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
        [data writeToFile:[titlePath addPathComponent:@"title.data"] atomically:YES];
        
        // 更新数据库
        [Table_Mark_List storeData:data
                              type:folderItem.type
                          folderId:folderItem.folder_id
                             title:item.title
                          markName:folderName
                         sortIndex:[Table_Mark_List maxSortIndexWithFolderId:folderItem.folder_id] + 1];
        
        // 从数据库获取带id的数据
        BaseMarkItem *newItem = [Table_Mark_List itemWithFolderName:folderName];
        
        [GCDQueue executeInMainQueue:^{
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(baseMarkCreatorDidEndCreateMark:markItem:)]) {
                
                [self.delegate baseMarkCreatorDidEndCreateMark:self markItem:newItem];
            }
        }];
    }];
}

- (void)startUpdateWithOldMarkItem:(BaseMarkItem *)oldItem patternFolderItem:(BaseMarkItem *)markItem {
    
    self.type = BaseMarkCreatorTypeReplace;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseMarkCreatorDidStartCreateMark:)]) {
        
        [self.delegate baseMarkCreatorDidStartCreateMark:self];
    }
    
    [GCDQueue executeInGlobalQueue:^{
        
        // 删除title文件夹
        NSString *filePath = [NSString stringWithFormat:@"%@/%@/content/title", FoldersManager.ArticleList, oldItem.mark_name];
        NSError  *error    = nil;
        [[NSFileManager defaultManager] removeItemAtURL:[NSURL fileURLWithPath:filePath] error:&error];
        if (error) {
            
            NSLog(@"%@", error);
        }
        
        // 重新创建title文件夹
        NSString *titlePath       = [NSString stringWithFormat:@"%@/%@/content/title", FoldersManager.ArticleList, oldItem.mark_name];
        NSString *titleImagesPath = [titlePath addPathComponent:@"images"];
        
        createDirectoryIfNotExistAtAbsoluteFilePath(titlePath);
        createDirectoryIfNotExistAtAbsoluteFilePath(titleImagesPath);
        
        // 复制样式后,将元数据的数据库值复制过来(如folder_id等)
        BaseMarkItem *newItem = [BaseMarkItem decodeWithData:markItem.encodeData];
        newItem.mark_id       = oldItem.mark_id;
        newItem.folder_id     = oldItem.folder_id;
        newItem.mark_name     = oldItem.mark_name;
        newItem.type          = oldItem.type;
        newItem.sort_index    = oldItem.sort_index;
        
        // 将标题复制过来
        newItem.title = oldItem.title;
        
        // 复制图片
        [newItem.imageObjects enumerateObjectsUsingBlock:^(EncodeImageObject *imageObject, NSUInteger idx, BOOL * _Nonnull stop) {
            
            // 拷贝文件
            NSString *source = [FoldersManager.DefaultImages addPathComponent:imageObject.imageName];
            NSString *dist   = [titleImagesPath addPathComponent:imageObject.imageName];
            
            NSError *error = nil;
            [[NSFileManager defaultManager] copyItemAtPath:source toPath:dist error:&error];
            if (error) {
                
                NSLog(@"%@", error);
            }
            
            // 切换图片源头
            imageObject.source = EncodeImageObjectSourceFolder;
        }];
        
        // 将文件存储在指定文件夹
        [newItem.encodeData writeToFile:[titlePath addPathComponent:@"title.data"] atomically:YES];
        
        // 更新数据库
        [Table_Mark_List updateData:newItem.encodeData markId:newItem.mark_id title:newItem.title sortIndex:newItem.sort_index];
        
        [GCDQueue executeInMainQueue:^{
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(baseMarkCreatorDidEndCreateMark:markItem:)]) {
                
                [self.delegate baseMarkCreatorDidEndCreateMark:self markItem:newItem];
            }
        }];
    }];
}

@end
