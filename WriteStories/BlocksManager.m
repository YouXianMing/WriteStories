//
//  BlocksManager.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BlocksManager.h"
#import "NSString+Path.h"
#import "Block_title_normal_1.h"
#import "Html_pureColor.h"

@interface BlocksManager ()

@property (nonatomic, strong) NSString *htmlFolderPath;

@end

@implementation BlocksManager

+ (void)createDefaultValueWithHtmlFolderPath:(NSString *)htmlFolderPath {
    
    Block_title_normal_1 *title = [Block_title_normal_1 defalutObject];
    title.title                 = @"默认标题";
    title.itemId                = @(1);
    
    // 创建文件夹
    [[NSFileManager defaultManager] createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@", htmlFolderPath, title.folderName]
                              withIntermediateDirectories:YES attributes:nil error:nil];
    [[NSFileManager defaultManager] createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@/block", htmlFolderPath, title.folderName]
                              withIntermediateDirectories:YES attributes:nil error:nil];
    
    // 写入二进制文件
    [title.encodeData writeToFile:[NSString stringWithFormat:@"%@/%@/block/block.data", htmlFolderPath, title.folderName] atomically:YES];
    
    // 创建body配置文件夹
    [NSFileManager.defaultManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/Block_body", htmlFolderPath]
                            withIntermediateDirectories:YES attributes:nil error:nil];
    
    [NSFileManager.defaultManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/Block_body/block", htmlFolderPath]
                            withIntermediateDirectories:YES attributes:nil error:nil];
    
    // 写入二进制文件
    Html_pureColor *body = [Html_pureColor defalutObject];
    [body.encodeData writeToFile:[NSString stringWithFormat:@"%@/Block_body/block/block.data", htmlFolderPath]
                      atomically:YES];
    
    // 写入管理器的二进制文件
    BlocksManager *manager = [BlocksManager new];
    manager.htmlFolderPath = htmlFolderPath;
    
    BlockMessage *message   = [BlockMessage new];
    message.blockFolderName = title.folderName;
    message.blockId         = title.itemId.integerValue;
    manager.blocks          = [NSMutableArray arrayWithArray:@[message]];
    [manager store];
}

+ (instancetype)blocksManagerWithHtmlFolderPath:(NSString *)htmlFolderPath {
    
    NSData        *data    = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/block_manager.data", htmlFolderPath]];
    BlocksManager *manager = [BlocksManager decodeWithData:data];
    manager.htmlFolderPath = htmlFolderPath;
    
    return manager;
}

- (NSArray<NSString *> *)blocksPaths {
    
    NSMutableArray *paths = [NSMutableArray array];
    
    [self.blocks enumerateObjectsUsingBlock:^(BlockMessage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [paths addObject:[NSString stringWithFormat:@"%@/%@/block/block.data", self.htmlFolderPath, obj.blockFolderName]];
    }];
    
    return paths;
}

- (void)addBaseBlockItem:(BaseBlockItem *)blockItem {
    
    // 创建BlockMessage
    BlockMessage *message   = [BlockMessage new];
    message.blockFolderName = blockItem.folderName;
    message.blockId         = blockItem.itemId.integerValue;
    
    // 添加message
    [self.blocks addObject:message];
    
    // 存储
    [self store];
}

- (NSInteger)currentMaxItemId {
    
    __block NSInteger maxId = 0;
    
    [self.blocks enumerateObjectsUsingBlock:^(BlockMessage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (maxId <= obj.blockId) {
            
            maxId = obj.blockId;
        }
    }];
    
    return maxId;
}

- (void)store {
    
    [self.encodeData writeToFile:[NSString stringWithFormat:@"%@/block_manager.data", self.htmlFolderPath] atomically:YES];
}

#pragma mark - coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.blocks forKey:@"blocks"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        self.blocks = [aDecoder decodeObjectForKey:@"blocks"];
    }
    
    return self;
}


@end
