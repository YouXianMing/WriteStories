//
//  BaseFolderCreator.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseFolderItem.h"
@class BaseFolderCreator;

typedef enum : NSUInteger {
    
    BaseFolderCreatorTypeAdd,
    BaseFolderCreatorTypeReplace,
    
} BaseFolderCreatorType;

@protocol BaseFolderCreatorDelegate <NSObject>

@required

- (void)baseFolderCreatorDidStartCreateFolder:(BaseFolderCreator *)creator;
- (void)baseFolderCreatorDidEndCreateFolder:(BaseFolderCreator *)creator folderItem:(BaseFolderItem *)folderItem;

@end

@interface BaseFolderCreator : NSObject

@property (nonatomic, weak) id <BaseFolderCreatorDelegate>  delegate;

@property (nonatomic, readonly) BaseFolderCreatorType type;

/**
 创建新的文件夹

 @param folderItem 文件夹模板类
 @param folderType 文件夹类型
 */
- (void)startCreateWithPatternFolderItem:(BaseFolderItem *)folderItem folderType:(NSNumber *)folderType;

/**
 更新文件夹

 @param oldItem 旧的文件夹文件
 @param folderItem 文件夹模板
 */
- (void)startUpdateWithOldFolderItem:(BaseFolderItem *)oldItem patternFolderItem:(BaseFolderItem *)folderItem;

@end
