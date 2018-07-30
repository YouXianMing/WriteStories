//
//  FoldersManager.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileManager.h"
#import "SingleSelectedProtocol.h"

@interface GradientImage : NSObject <SingleSelectedProtocol>

@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *bgHexColor;
@property (nonatomic) BOOL    selected;

+ (instancetype)imageWithName:(NSString *)imageName bgColor:(NSString *)bgHexColor;

@end

@interface EdgePatternImage : NSObject <SingleSelectedProtocol>

@property (nonatomic, strong) NSString *imageName; 
@property (nonatomic) BOOL    selected;

@end

@interface QuoteImage : NSObject

@property (nonatomic, strong) NSString *imageName;

@property (nonatomic) CGFloat  scale; // 倍率

@property (nonatomic) UIEdgeInsets           cutEdge;      // 裁剪像素
@property (nonatomic, readonly) UIEdgeInsets scaleCutEdge; // 根据倍率调整的cutEdge

@property (nonatomic) UIEdgeInsets           areaEdge;      // 有效像素(文本可以显示的区域)
@property (nonatomic, readonly) UIEdgeInsets scaleAreaEdge; // 根据倍率调整的areaEdge

@end

@interface FoldersManager : NSObject

+ (void)prepare;

@property (class, readonly) NSString *Documents;        // ~/Documents
@property (class, readonly) NSString *FolderBackups;    // ~/Documents/文件夹备份
@property (class, readonly) NSString *ArticleBackups;   // ~/Documents/文章备份
@property (class, readonly) NSString *Datafolder;       // ~/Documents/.datafolder
@property (class, readonly) NSString *ArticleList;      // ~/Documents/.datafolder/article_list
@property (class, readonly) NSString *FolderList;       // ~/Documents/.datafolder/folder_list
@property (class, readonly) NSString *WorkShop;         // ~/Documents/.datafolder/workshop
@property (class, readonly) NSString *DefaultImages;    // ~/Documents/.datafolder/default_images
@property (class, readonly) NSString *PatternImages;    // ~/Documents/.datafolder/article_list/images/patterns
@property (class, readonly) NSString *GradientImages;   // ~/Documents/.datafolder/article_list/images/gradientImages

@property (class, readonly) NSArray <NSString *>      *PatternImagesArray;  // 图片模板数组
@property (class, readonly) NSArray <GradientImage *> *GradientImagesArray; // 图片模板数组
@property (class, readonly) NSArray <QuoteImage *>    *QuoteImages;         // 引用图片数组

#pragma mark - 文件夹相关目录

/**
 [content文件夹] ~/Documents/.datafolder/folder-list/文件夹名字/content

 @param folderName 文件夹名字
 @return ~/Documents/.datafolder/folder-list/文件夹名字/content
 */
+ (NSString *)content_FolderListWithFolderName:(NSString *)folderName;

/**
 [folder.datas文件] ~/Documents/.datafolder/folder-list/文件夹名字/content/folder.datas
 
 @param folderName 文件夹名字
 @return ~/Documents/.datafolder/folder-list/文件夹名字/content/folder.data
 */
+ (NSString *)folderData_FolderListWithFolderName:(NSString *)folderName;

/**
 [images文件夹] ~/Documents/.datafolder/folder-list/文件夹名字/content/images
 
 @param folderName 文件夹名字
 @return ~/Documents/.datafolder/folder-list/文件夹名字/content/images
 */
+ (NSString *)images_FolderListWithFolderName:(NSString *)folderName;

/**
 [images文件夹中的图片] ~/Documents/.datafolder/folder-list/文件夹名字/content/images/图片名字

 @param folderName 文件夹名字
 @param imageName 图片名字
 @return ~/Documents/.datafolder/folder-list/文件夹名字/content/images/图片名字
 */
+ (NSString *)image_FolderListWithFolderName:(NSString *)folderName imageName:(NSString *)imageName;

@end
