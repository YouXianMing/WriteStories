//
//  BaseBlockItem.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "WriteStoriesBaseItemObject.h"
#import "ArticleEditObjectProtocol.h"
#import "BlockImageInputEditorView.h"
#import "JSConfigManager.h"
#import "NSDictionary+JSONData.h"
#import "Values.h"
#import "ItemColorSetupView.h"
#import "FontsPickerSetupView.h"
#import "ValuesPickerSetupView.h"

@interface BaseBlockItem : WriteStoriesBaseItemObject <ArticleEditObjectProtocol>

/**
 html文件夹名字
 */
@property (nonatomic, strong) NSString *htmlFolderName;

/**
 cell排序用
 */
@property (nonatomic) CGFloat cellHeight;

/**
 选择图片比例
 */
@property (nonatomic, readonly) NSDictionary <NSString *, NSArray <EncodeImageObject *> *> *key_imageObjects;

#pragma mark - ArticleEditObjectProtocol协议方法

@property (nonatomic, readonly) ArticleEditObjectType  cellType;
@property (nonatomic, readonly) NSString              *typeText;

#pragma mark - encode

@property (nonatomic, strong) NSNumber *itemId;

#pragma mark - ItemIdString

@property (nonatomic, readonly) NSString *itemIdString;

#pragma mark - other

@property (nonatomic, readonly) NSString *folderName;

#pragma mark - html

@property (nonatomic, readonly) NSString *htmlString;

- (NSString *)jsonConfigWithDebug:(BOOL)debug;

@end
