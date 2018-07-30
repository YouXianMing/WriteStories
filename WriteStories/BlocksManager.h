//
//  BlocksManager.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseEncodeObject.h"
#import "BlockMessage.h"
#import "BaseBlockItem.h"

@interface BlocksManager : BaseEncodeObject

+ (void)createDefaultValueWithHtmlFolderPath:(NSString *)htmlFolderPath;

/**
 获取当前元素中最大的id值

 @return 最大id值
 */
- (NSInteger)currentMaxItemId;

+ (instancetype)blocksManagerWithHtmlFolderPath:(NSString *)htmlFolderPath;

- (NSArray <NSString *> *)blocksPaths;

- (void)addBaseBlockItem:(BaseBlockItem *)blockItem;

#pragma mark - coder

@property (nonatomic, strong) NSMutableArray <BlockMessage *> *blocks;

- (void)store;

@end
