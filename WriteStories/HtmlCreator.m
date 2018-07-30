//
//  HtmlCreator.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/12.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "HtmlCreator.h"
#import "FileManager.h"
#import "BaseHtmlBodyItem.h"
#import "BlocksManager.h"

@interface HtmlCreator ()

@property (nonatomic, strong) NSString *htmlFolder;

@end

@implementation HtmlCreator

+ (instancetype)htmlCreatorWithHtmlFolder:(NSString *)htmlFolder {
    
    HtmlCreator *creator = [HtmlCreator new];
    creator.htmlFolder   = htmlFolder;
    
    return creator;
}

- (void)startCreateHtmlWithBlocksManager:(BlocksManager *)blocksManager {
    
    // 复制并覆盖文件
    NSData *data = [NSData dataWithContentsOfFile:absoluteFilePathFrom(@"-/content-up.html")];
    [data writeToFile:[NSString stringWithFormat:@"%@/content.html", self.htmlFolder] atomically:YES];
    
    // 开始追加文件
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:[NSString stringWithFormat:@"%@/content.html", self.htmlFolder]];
    [fileHandle seekToEndOfFile];
    
    // 写入body配置
    NSString         *bodyPath = [NSString stringWithFormat:@"%@/Block_body/block/block.data", self.htmlFolder];
    BaseHtmlBodyItem *item     = [BaseHtmlBodyItem decodeWithData:[NSData dataWithContentsOfFile:bodyPath]];
    [fileHandle writeData:[item.bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 读取数据
    [blocksManager.blocksPaths enumerateObjectsUsingBlock:^(NSString *path, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 读取二进制文件
        BaseBlockItem *block = [BaseBlockItem decodeWithData:[NSData dataWithContentsOfFile:path]];
        [fileHandle writeData:[block.htmlString dataUsingEncoding:NSUTF8StringEncoding]];
    }];
    
    // 追加尾部文件
    [fileHandle writeData:[[NSData alloc] initWithContentsOfFile:absoluteFilePathFrom(@"-/content-down.html")]];
    [fileHandle closeFile];
}

@end
