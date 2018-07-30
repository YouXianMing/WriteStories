//
//  ZipsUnzip.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/2.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ZipsUnzip.h"
#import "FileManager.h"
#import "FoldersManager.h"
#import "SSZipArchive.h"
#import "BaseFolderItem.h"
#import "BaseMarkItem.h"
#import "NSString+Path.h"
#import "NSString+RandomString.h"
#import "Table_Folder_List.h"
#import "Table_Mark_List.h"

//////////////////////////////////////////////////////////////////////////////////////////////////

@interface ZipArticle : NSObject

@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *title;

@end

@implementation ZipArticle

@end

@interface ZipFolder : NSObject

@property (nonatomic) NSInteger         folderId; // 文件夹id,数据库值
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSMutableArray <ZipArticle *> *articles;

@end

@implementation ZipFolder

- (instancetype)init {
    
    if (self = [super init]) {
    
        self.articles = [NSMutableArray array];
    }
    
    return self;
}

@end

//////////////////////////////////////////////////////////////////////////////////////////////////

@implementation ZipsUnzip

+ (void)prepare {
    
    NSMutableArray <ZipFolder *> *folders = [NSMutableArray array];
    
    {
        ZipFolder *folder  = [ZipFolder new];
        folder.fileName    = @"文章.folder";
        folder.title       = @"文章";
        [folders addObject:folder];
        
        {
            ZipArticle *article = [ZipArticle new];
            article.fileName    = @"从百草园到三味书屋.article";
            article.title       = @"从百草园到三味书屋";
            [folder.articles addObject:article];
        }
        
        {
            ZipArticle *article = [ZipArticle new];
            article.fileName    = @"诫子书.article";
            article.title       = @"诫子书";
            [folder.articles addObject:article];
        }
        
        {
            ZipArticle *article = [ZipArticle new];
            article.fileName    = @"未选择的路.article";
            article.title       = @"未选择的路";
            [folder.articles addObject:article];
        }
        
        {
            ZipArticle *article = [ZipArticle new];
            article.fileName    = @"三行情书（节选）.article";
            article.title       = @"三行情书（节选）";
            [folder.articles addObject:article];
        }
    }
    
    {
        ZipFolder *folder  = [ZipFolder new];
        folder.fileName    = @"日记 2018.06.folder";
        folder.title       = @"日记 2018.06";
        [folders addObject:folder];
        
        {
            ZipArticle *article = [ZipArticle new];
            article.fileName    = @"梦.article";
            article.title       = @"梦";
            [folder.articles addObject:article];
        }
        
        {
            ZipArticle *article = [ZipArticle new];
            article.fileName    = @"阿英妹妹.article";
            article.title       = @"阿英妹妹";
            [folder.articles addObject:article];
        }
    }
    
    [folders enumerateObjectsUsingBlock:^(ZipFolder *folder, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BaseFolderItem *folderItem = [Table_Folder_List itemWithFolderTitle:folder.title type:1];
        if (folderItem == nil) {
            
            // 从数据库中没有找到文件就解压文件夹
            [self upZipFolderWithZipFolder:folder];
            folderItem = [Table_Folder_List itemWithFolderTitle:folder.title type:1];
        }
        
        folder.folderId = folderItem.folder_id;
        
        [folder.articles enumerateObjectsUsingBlock:^(ZipArticle *article, NSUInteger idx, BOOL * _Nonnull stop) {
            
            BaseMarkItem *markItem = [Table_Mark_List itemWithFolderId:folder.folderId title:article.title];
            if (markItem == nil) {
                
                // 从数据库没有找到文件就解压文件
                [self upZipArticleWithZipArticle:article folderId:folder.folderId];
                markItem = [Table_Mark_List itemWithFolderId:folder.folderId title:article.title];
            }
        }];
    }];
}

+ (void)upZipFolderWithZipFolder:(ZipFolder *)zipFolder {
    
    // 获取随机文件夹名字
    NSString *string     = NSString.UniqueString;
    NSArray  *strings    = [string componentsSeparatedByString:@"-"];
    NSString *folderName = [NSString stringWithFormat:@"%@-%@", strings.firstObject, strings.lastObject];
    
    // 创建文件夹
    NSString *folderPath = [FoldersManager.FolderList addPathComponent:folderName];
    [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    // 解压
    [SSZipArchive unzipFileAtPath:[FileManager bundleFileWithName:zipFolder.fileName]
                    toDestination:folderPath
                        overwrite:YES
                         password:@"write.stories.you.xian.ming.folder"
                            error:nil];
    
    // 获取二进制文件
    NSData *data = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/content/folder.data", folderPath]];
    
    BaseFolderItem *folderItem = [BaseFolderItem decodeWithData:data];
    
    // 如果cellReuseId是不唯一的类型
    if (folderItem.isEmitterType) {
        
        folderItem.cellReuseId = NSString.UniqueString;
        data                   = folderItem.encodeData;
    }
    
    // 存储数据库
    [Table_Folder_List storeData:data
                            type:1
                           title:folderItem.title
                      folderName:folderName
                       sortIndex:[Table_Folder_List maxSortIndexWithType:1] + 1];
}

+ (void)upZipArticleWithZipArticle:(ZipArticle *)article folderId:(NSInteger)folderId {
    
    // 获取随机文件夹名字
    NSString *string     = NSString.UniqueString;
    NSArray  *strings    = [string componentsSeparatedByString:@"-"];
    NSString *folderName = [NSString stringWithFormat:@"%@-%@", strings.firstObject, strings.lastObject];
    
    // 创建文件夹
    NSString *folderPath = [FoldersManager.ArticleList addPathComponent:folderName];
    [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    // 解压文件
    [SSZipArchive unzipFileAtPath:[FileManager bundleFileWithName:article.fileName]
                    toDestination:folderPath
                        overwrite:YES
                         password:@"write.stories.you.xian.ming.article"
                            error:nil];
    
    // 获取二进制文件
    NSData *data = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/content/title/title.data", folderPath]];
    
    BaseMarkItem *markItem = [BaseMarkItem decodeWithData:data];
    
    // 如果cellReuseId是不唯一的类型
    if (markItem.isEmitterType) {
        
        markItem.cellReuseId = NSString.UniqueString;
        data                 = markItem.encodeData;
    }
    
    // 存储数据库
    [Table_Mark_List storeData:data
                          type:1
                      folderId:folderId
                         title:markItem.title
                      markName:folderName
                     sortIndex:[Table_Mark_List maxSortIndexWithFolderId:folderId] + 1];
}

@end
