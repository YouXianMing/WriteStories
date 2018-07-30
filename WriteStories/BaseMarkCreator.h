//
//  BaseMarkCreator.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/19.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseMarkItem.h"
#import "BaseFolderItem.h"
@class BaseMarkCreator;

typedef enum : NSUInteger {
    
    BaseMarkCreatorTypeAdd,
    BaseMarkCreatorTypeReplace,
    
} BaseMarkCreatorType;

@protocol BaseMarkCreatorDelegate <NSObject>

@required

- (void)baseMarkCreatorDidStartCreateMark:(BaseMarkCreator *)creator;
- (void)baseMarkCreatorDidEndCreateMark:(BaseMarkCreator *)creator markItem:(BaseMarkItem *)markItem;

@end

@interface BaseMarkCreator : NSObject

@property (nonatomic, readonly) BaseMarkCreatorType type;

/**
 代理
 */
@property (nonatomic, weak) id <BaseMarkCreatorDelegate> delegate;

/**
 创建新的标签文件

 @param markItem 标签对象
 @param folderItem 文件夹对象
 */
- (void)startCreateWithPatternMarkItem:(BaseMarkItem *)markItem folderItem:(BaseFolderItem *)folderItem;

/**
 更新标签文件

 @param oldItem 旧的标签文件
 @param markItem 模板标签文件
 */
- (void)startUpdateWithOldMarkItem:(BaseMarkItem *)oldItem patternFolderItem:(BaseMarkItem *)markItem;

@end
