//
//  FoldersManager.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "FoldersManager.h"
#import "NSString+Path.h"
#import "FontCSSCreator.h"

@implementation GradientImage

+ (instancetype)imageWithName:(NSString *)imageName bgColor:(NSString *)bgHexColor {
    
    GradientImage *image = [GradientImage new];
    image.imageName      = imageName;
    image.bgHexColor     = bgHexColor;
    
    return image;
}

@end

@implementation EdgePatternImage

@end

@implementation QuoteImage

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.scale = 1.f;
    }
    
    return self;
}

- (UIEdgeInsets)scaleCutEdge {
    
    return UIEdgeInsetsMake(self.cutEdge.top * self.scale,
                            self.cutEdge.left * self.scale,
                            self.cutEdge.bottom * self.scale,
                            self.cutEdge.right * self.scale);
}

- (UIEdgeInsets)scaleAreaEdge {
    
    return UIEdgeInsetsMake(self.areaEdge.top * self.scale,
                            self.areaEdge.left * self.scale,
                            self.areaEdge.bottom * self.scale,
                            self.areaEdge.right * self.scale);
}

@end

static NSString *_document          = nil;
static NSString *_folderBackups     = nil;
static NSString *_articleBackups    = nil;
static NSString *_dataFolder        = nil;
static NSString *_articleList       = nil;
static NSString *_folderList        = nil;
static NSString *_defaultImages     = nil;
static NSString *_workShop          = nil;
static NSString *_patternImages     = nil;
static NSString *_gradientImages    = nil;
static NSString *_edgePatternImages = nil;
static NSString *_decorateImages    = nil;
static NSString *_quoteImages       = nil;

@interface FoldersManager ()

@end

@implementation FoldersManager

+ (void)prepare {
    
    _document          = absoluteFilePathFrom(@"~/Documents");
    _folderBackups     = [_document   addPathComponent:@"文件夹备份"];
    _articleBackups    = [_document   addPathComponent:@"文章备份"];
    _dataFolder        = [_document   addPathComponent:@".datafolder"];
    _articleList       = [_dataFolder addPathComponent:@"article_list"];
    _folderList        = [_dataFolder addPathComponent:@"folder_list"];
    _defaultImages     = [_dataFolder addPathComponent:@"default_images"];
    _workShop          = [_dataFolder addPathComponent:@"workshop"];
    _patternImages     = [NSString stringWithFormat:@"%@/article_list/images/patterns", _dataFolder];
    _gradientImages    = [NSString stringWithFormat:@"%@/article_list/images/gradientImages", _dataFolder];
    _edgePatternImages = [NSString stringWithFormat:@"%@/article_list/images/edgePatternImages", _dataFolder];
    _decorateImages    = [NSString stringWithFormat:@"%@/article_list/images/decorateImages", _dataFolder];
    _quoteImages       = [NSString stringWithFormat:@"%@/article_list/images/quoteImages", _dataFolder];
    
    // ~/Documents/文件夹备份
    createDirectoryIfNotExistAtAbsoluteFilePath(_folderBackups);
    
    // ~/Documents/文章备份
    createDirectoryIfNotExistAtAbsoluteFilePath(_articleBackups);
    
    // ~/Documents/.datafolder
    createDirectoryIfNotExistAtAbsoluteFilePath(_dataFolder);
    
    // ~/Documents/.datafolder/article-list
    createDirectoryIfNotExistAtAbsoluteFilePath(_articleList);
    
    // ~/Documents/.datafolder/article-list/images
    NSString *article_list_images = [NSString stringWithFormat:@"%@/images", _articleList];
    createDirectoryIfNotExistAtAbsoluteFilePath(article_list_images);
    
    // ~/Documents/.datafolder/article-list/images/patterns
    createDirectoryIfNotExistAtAbsoluteFilePath(_patternImages);
    
    // ~/Documents/.datafolder/article-list/images/gradientImages
    createDirectoryIfNotExistAtAbsoluteFilePath(_gradientImages);
    
    // ~/Documents/.datafolder/article-list/images/edgePatternImages
    createDirectoryIfNotExistAtAbsoluteFilePath(_edgePatternImages);
    
    // ~/Documents/.datafolder/article-list/images/decorateImages
    createDirectoryIfNotExistAtAbsoluteFilePath(_decorateImages);
    
    // ~/Documents/.datafolder/folder_list
    createDirectoryIfNotExistAtAbsoluteFilePath(_folderList);
    
    // ~/Documents/.datafolder/folder_workshop
    createDirectoryIfNotExistAtAbsoluteFilePath(_workShop);
    
    // ~/Documents/.datafolder/default_images
    createDirectoryIfNotExistAtAbsoluteFilePath(_defaultImages);
    
    // ~/Documents/.datafolder/quoteImages
    createDirectoryIfNotExistAtAbsoluteFilePath(_quoteImages);
    
    // 更新图片
    NSArray *copyFiles = @[@"folder-cover_jpg",
                           @"image_bg_jpg",
                           @"styles_jpeg",
                           @"bg_cat_jpg"];
    
    [copyFiles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([FileManager fileExistWithAbsoluteFilePath:[_defaultImages addPathComponent:obj]] == NO) {
            
            // 读取数据
            NSData *data = [[NSData alloc] initWithContentsOfFile:absoluteFilePathFrom([NSString stringWithFormat:@"-/%@", obj])];
            
            // 写数据
            [data writeToFile:[_defaultImages addPathComponent:obj] atomically:YES];
        }
    }];
    
    // 更新模板图片
    [FoldersManager.PatternImagesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([FileManager fileExistWithAbsoluteFilePath:[_patternImages addPathComponent:obj]] == NO) {
         
            // 读取数据
            NSData *data = [[NSData alloc] initWithContentsOfFile:absoluteFilePathFrom([NSString stringWithFormat:@"-/%@", obj])];
            
            // 写数据
            [data writeToFile:[_patternImages addPathComponent:obj] atomically:YES];
        }
    }];
    
    // 更新渐变图片
    [FoldersManager.GradientImagesArray enumerateObjectsUsingBlock:^(GradientImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([FileManager fileExistWithAbsoluteFilePath:[_gradientImages addPathComponent:obj.imageName]] == NO) {
         
            // 读取数据
            NSData *data = [[NSData alloc] initWithContentsOfFile:absoluteFilePathFrom([NSString stringWithFormat:@"-/%@", obj.imageName])];
            
            // 写数据
            [data writeToFile:[_gradientImages addPathComponent:obj.imageName] atomically:YES];
        }
    }];
    
    // 边缘模板文件
    [FoldersManager.EdgePatternImagesArray enumerateObjectsUsingBlock:^(EdgePatternImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([FileManager fileExistWithAbsoluteFilePath:[_edgePatternImages addPathComponent:obj.imageName]] == NO) {
            
            // 读取数据
            NSData *data = [[NSData alloc] initWithContentsOfFile:absoluteFilePathFrom([NSString stringWithFormat:@"-/%@", obj.imageName])];
            
            // 写数据
            [data writeToFile:[_edgePatternImages addPathComponent:obj.imageName] atomically:YES];
        }
    }];
    
    // 点缀文件
    [FoldersManager.DecorateImages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([FileManager fileExistWithAbsoluteFilePath:[_decorateImages addPathComponent:obj]] == NO) {
            
            // 读取数据
            NSData *data = [[NSData alloc] initWithContentsOfFile:absoluteFilePathFrom([NSString stringWithFormat:@"-/%@", obj])];
            
            // 写数据
            [data writeToFile:[_decorateImages addPathComponent:obj] atomically:YES];
        }
    }];
    
    // 引用文件
    [FoldersManager.QuoteImages enumerateObjectsUsingBlock:^(QuoteImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([FileManager fileExistWithAbsoluteFilePath:[_quoteImages addPathComponent:obj.imageName]] == NO) {
            
            // 读取数据
            NSData *data = [[NSData alloc] initWithContentsOfFile:absoluteFilePathFrom([NSString stringWithFormat:@"-/%@", obj.imageName])];
            
            // 写数据
            [data writeToFile:[_quoteImages addPathComponent:obj.imageName] atomically:YES];
        }
    }];
    
    // 创建css文件夹 + 写入css文件
    createDirectoryIfNotExistAtAbsoluteFilePath([_articleList addPathComponent:@"css"]);
    
    NSString *file_css  = [NSString stringWithFormat:@"%@/css/content.css", _articleList];
    NSString *cssString = [[NSString alloc] initWithContentsOfURL:[NSURL fileURLWithPath:absoluteFilePathFrom(@"-/content.css")] encoding:NSUTF8StringEncoding error:nil];
    NSString *fontCss   = [FontCSSCreator creatorWithFontInfo:@{
                                                                @"HuXiaoBoKuHei"   : @"站酷酷黑.ttf",
                                                                @"PangMenZhengDao" : @"庞门正道标题体.ttf",
                                                                @"QXyingbikai"     : @"QXyingbikai.ttf",
                                                                @"FZFSJW--GB1-0"   : @"方正仿宋简体.ttf",
                                                                @"HappyZcool-2016" : @"站酷快乐体2016修订版.ttf",
                                                                @"HYHeiZaiTiW"     : @"汉仪黑仔体W.ttf",
                                                                @"AaFangMeng"      : @"字体管家方萌.ttf",
                                                                @"LSSST-1498"      : @"凌氏随手体.ttf",
                                                                
                                                                @"Lato-Bold"       : @"Lato-Bold.ttf",
                                                                @"Lato-Light"      : @"Lato-Light.ttf",
                                                                @"Lato-Regular"    : @"Lato-Regular.ttf",
                                                                @"Lato-Thin"       : @"Lato-Thin.ttf",
                                                                @"Lato-ThinItalic" : @"Lato-ThinItalic.ttf",
                                                                }];
    
    NSString *newCssString = [cssString stringByReplacingOccurrencesOfString:@"/*<<<<<字体模板>>>>>*/" withString:fontCss];
    [newCssString writeToFile:file_css atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    // 创建js文件夹 + 写入js文件
    createDirectoryIfNotExistAtAbsoluteFilePath([_articleList addPathComponent:@"js"]);
    
    NSString *file_js  = [NSString stringWithFormat:@"%@/js/content.js", _articleList];
    NSString *jsString = [[NSString alloc] initWithContentsOfURL:[NSURL fileURLWithPath:absoluteFilePathFrom(@"-/content.js")] encoding:NSUTF8StringEncoding error:nil];
    [jsString writeToFile:file_js atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

+ (NSString *)content_FolderListWithFolderName:(NSString *)folderName {
    
    return [NSString stringWithFormat:@"%@/%@/content", FoldersManager.FolderList, folderName];
}

+ (NSString *)folderData_FolderListWithFolderName:(NSString *)folderName {
    
    return [NSString stringWithFormat:@"%@/%@/content/folder.data", FoldersManager.FolderList, folderName];
}

+ (NSString *)images_FolderListWithFolderName:(NSString *)folderName {
    
    return [NSString stringWithFormat:@"%@/%@/content/images", FoldersManager.FolderList, folderName];
}

+ (NSString *)image_FolderListWithFolderName:(NSString *)folderName imageName:(NSString *)imageName {
    
    return [NSString stringWithFormat:@"%@/%@/content/images/%@", FoldersManager.FolderList, folderName, imageName];
}

+ (NSString *)Documents {
    
    return _document;
}

+ (NSString *)FolderBackups {
    
    return _folderBackups;
}

+ (NSString *)ArticleBackups {
    
    return _articleBackups;
}

+ (NSString *)Datafolder {
    
    return _dataFolder;
}

+ (NSString *)ArticleList {
    
    return _articleList;
}

+ (NSString *)FolderList {
    
    return _folderList;
}

+ (NSString *)WorkShop {
    
    return _workShop;
}

+ (NSString *)DefaultImages {
    
    return _defaultImages;
}

+ (NSString *)PatternImages {
    
    return _patternImages;
}

+ (NSString *)GradientImages {
    
    return _gradientImages;
}

+ (NSArray *)PatternImagesArray {
    
    return @[@"1_052.gif",
             @"1_234.gif",
             @"1_073.gif",
             @"1_043.gif",
             @"1_147.gif",
             @"1_148.gif",
             @"1_175.gif",
             @"1_184.gif",
             @"1_188.gif",
             @"1_179.gif",
             @"1_112.gif",
             @"1_119.gif",
             @"1_372.gif",
             @"1_107.gif",
             @"1_104.gif",
             @"1_145.gif",
             @"1_191.gif",
             @"1_088.gif",
             @"1_176.gif",
             @"1_178.gif",
             @"1_093.gif",
             @"1_399.gif",
             @"1_116.gif",
             @"1_025.gif",
             @"1_377.gif",
             @"1_137.gif",
             @"1_194.gif",
             @"1_115.gif",
             @"1_230.gif",
             @"1_323.gif",
             @"1_105.gif",
             @"1_403.gif",
             @"1_181.gif",
             @"1_117.gif",
             @"1_159.gif",
             @"1_381.gif",
             @"1_003.gif",
             @"pattern-1.gif",
             ];
}

+ (NSArray <GradientImage *> *)GradientImagesArray {
    
    return @[[GradientImage imageWithName:@"flower_4_bg.png" bgColor:@"#faf9fe"],
             [GradientImage imageWithName:@"flower_2_bg.png" bgColor:@"#d3d3dd"],
             [GradientImage imageWithName:@"flower_3_bg.png" bgColor:@"#8d9ef8"],
             [GradientImage imageWithName:@"flower_bg.png"   bgColor:@"#1b1032"],
             
             [GradientImage imageWithName:@"landscape_1_bg.png" bgColor:@"#d4a474"],
             [GradientImage imageWithName:@"observatory.png"    bgColor:@"#3c393a"],
             
             [GradientImage imageWithName:@"渐变7.jpg"          bgColor:@"#F9B95E"],
             [GradientImage imageWithName:@"road_bg.png"     bgColor:@"#0f090d"],
             [GradientImage imageWithName:@"渐变9.jpg"          bgColor:@"#234953"],
             [GradientImage imageWithName:@"girl_bg.png"     bgColor:@"#2e251f"],
             [GradientImage imageWithName:@"渐变12.png"          bgColor:@"#4F608A"],
             [GradientImage imageWithName:@"渐变13.png"          bgColor:@"#041F26"],
             [GradientImage imageWithName:@"渐变14.png"          bgColor:@"#784018"],
             [GradientImage imageWithName:@"渐变15.png"          bgColor:@"#021D24"],
             [GradientImage imageWithName:@"渐变16.png"          bgColor:@"#2D70B5"],
             [GradientImage imageWithName:@"渐变17.png"          bgColor:@"#3F3A64"],
             [GradientImage imageWithName:@"渐变18.png"          bgColor:@"#7ECCCA"],
             [GradientImage imageWithName:@"渐变19.png"          bgColor:@"#4D3F37"],
             
             [GradientImage imageWithName:@"animal_1_bg.png"      bgColor:@"#00405d"],
             [GradientImage imageWithName:@"animal_2_bg.png"      bgColor:@"#354b00"],
             [GradientImage imageWithName:@"bird_1_bg.png"        bgColor:@"#3f3f3f"],
             
             [GradientImage imageWithName:@"allisonhouse-stillness.gif" bgColor:@"#FFF4E2"],
             [GradientImage imageWithName:@"cat.gif"                    bgColor:@"#f6f6f6"],
             [GradientImage imageWithName:@"goat.gif"                   bgColor:@"#827FA3"],
             [GradientImage imageWithName:@"flower-dance.gif"           bgColor:@"#F98464"],
             [GradientImage imageWithName:@"coffee.gif"                 bgColor:@"#FEC36D"],
             
             [GradientImage imageWithName:@"彩妆.png"          bgColor:@"#FFF3ED"],
             [GradientImage imageWithName:@"古诗.png"          bgColor:@"#FEFDFD"],
             [GradientImage imageWithName:@"蓝色飘花.png"       bgColor:@"#F6F3CB"],
             [GradientImage imageWithName:@"马头墙.png"        bgColor:@"#FFFFFF"],
             [GradientImage imageWithName:@"水彩.png"          bgColor:@"#F6EEE0"],
             [GradientImage imageWithName:@"我就在你方圆几里.png" bgColor:@"#FFFFFF"],
             [GradientImage imageWithName:@"想要你知道.png"      bgColor:@"#F2EAE5"],
             [GradientImage imageWithName:@"小狐狸.png"         bgColor:@"#FFFFFF"],
             [GradientImage imageWithName:@"休闲时光.png"       bgColor:@"#FFFFFF"],
             [GradientImage imageWithName:@"植物.png"          bgColor:@"#FFFFFF"],
             
             [GradientImage imageWithName:@"渐变1.png"          bgColor:@"#F8F8F8"],
             [GradientImage imageWithName:@"渐变2.png"          bgColor:@"#D8EBED"],
             [GradientImage imageWithName:@"渐变3.png"          bgColor:@"#EBC3C7"],
             [GradientImage imageWithName:@"渐变4.png"          bgColor:@"#E3D7E9"],
             [GradientImage imageWithName:@"渐变5.png"          bgColor:@"#424041"],
             [GradientImage imageWithName:@"渐变6.png"          bgColor:@"#F6F4F4"],
             
             [GradientImage imageWithName:@"渐变20.png"          bgColor:@"#2C2922"],
             [GradientImage imageWithName:@"渐变21.png"          bgColor:@"#B9EADF"],
             [GradientImage imageWithName:@"渐变22.png"          bgColor:@"#ECF2F1"],
             [GradientImage imageWithName:@"渐变23.png"          bgColor:@"#161619"],
             [GradientImage imageWithName:@"渐变24.png"          bgColor:@"#F0F0E5"],
             [GradientImage imageWithName:@"渐变25.png"          bgColor:@"#F7DDC5"],
             [GradientImage imageWithName:@"渐变26.png"          bgColor:@"#000000"],
             [GradientImage imageWithName:@"渐变27.png"          bgColor:@"#7E467F"],
             [GradientImage imageWithName:@"渐变28.png"          bgColor:@"#3E6190"],
             [GradientImage imageWithName:@"渐变29.png"          bgColor:@"#8B657E"],
             [GradientImage imageWithName:@"渐变30.png"          bgColor:@"#010923"],
             [GradientImage imageWithName:@"渐变31.png"          bgColor:@"#010622"],
             [GradientImage imageWithName:@"渐变32.png"          bgColor:@"#DEE4B9"],
             [GradientImage imageWithName:@"渐变33.png"          bgColor:@"#000000"],
             [GradientImage imageWithName:@"渐变34.png"          bgColor:@"#030100"],
             [GradientImage imageWithName:@"渐变35.png"          bgColor:@"#040200"],
             [GradientImage imageWithName:@"渐变36.png"          bgColor:@"#141D33"],
             [GradientImage imageWithName:@"渐变37.png"          bgColor:@"#141D32"],
             [GradientImage imageWithName:@"渐变38.png"          bgColor:@"#1E1B24"],
             [GradientImage imageWithName:@"渐变39.png"          bgColor:@"#353638"],
             [GradientImage imageWithName:@"渐变40.png"          bgColor:@"#FDCE8F"],
             [GradientImage imageWithName:@"渐变41.png"          bgColor:@"#091214"],
             [GradientImage imageWithName:@"渐变42.png"          bgColor:@"#E1DAD0"],
             [GradientImage imageWithName:@"渐变43.png"          bgColor:@"#943D56"],
             [GradientImage imageWithName:@"渐变44.png"          bgColor:@"#FEF8FE"],
             [GradientImage imageWithName:@"渐变45.png"          bgColor:@"#B4C7CD"],
             ];
}

+ (NSArray <EdgePatternImage *> *)EdgePatternImagesArray {
    
    NSMutableArray *array = [NSMutableArray array];
    
    {
        EdgePatternImage *image = [EdgePatternImage new];
        image.imageName         = @"典雅1.png";
        [array addObject:image];
    }
    
    {
        EdgePatternImage *image = [EdgePatternImage new];
        image.imageName         = @"典雅2.png";
        [array addObject:image];
    }
    
    {
        EdgePatternImage *image = [EdgePatternImage new];
        image.imageName         = @"典雅3.png";
        [array addObject:image];
    }
    
    {
        EdgePatternImage *image = [EdgePatternImage new];
        image.imageName         = @"典雅4-A.png";
        [array addObject:image];
    }
    
    {
        EdgePatternImage *image = [EdgePatternImage new];
        image.imageName         = @"典雅4-B.png";
        [array addObject:image];
    }
    
    {
        EdgePatternImage *image = [EdgePatternImage new];
        image.imageName         = @"典雅5.png";
        [array addObject:image];
    }
    
    {
        EdgePatternImage *image = [EdgePatternImage new];
        image.imageName         = @"典雅6.png";
        [array addObject:image];
    }
    
    {
        EdgePatternImage *image = [EdgePatternImage new];
        image.imageName         = @"典雅7.png";
        [array addObject:image];
    }
    
    {
        EdgePatternImage *image = [EdgePatternImage new];
        image.imageName         = @"典雅8.png";
        [array addObject:image];
    }
    
    {
        EdgePatternImage *image = [EdgePatternImage new];
        image.imageName         = @"典雅9-A.png";
        [array addObject:image];
    }
    
    {
        EdgePatternImage *image = [EdgePatternImage new];
        image.imageName         = @"典雅9-B.png";
        [array addObject:image];
    }
    
    {
        EdgePatternImage *image = [EdgePatternImage new];
        image.imageName         = @"典雅10.png";
        [array addObject:image];
    }
    
    {
        EdgePatternImage *image = [EdgePatternImage new];
        image.imageName         = @"典雅11.png";
        [array addObject:image];
    }
    
    {
        EdgePatternImage *image = [EdgePatternImage new];
        image.imageName         = @"典雅12.png";
        [array addObject:image];
    }
    
    {
        EdgePatternImage *image = [EdgePatternImage new];
        image.imageName         = @"典雅13.png";
        [array addObject:image];
    }
    
    {
        EdgePatternImage *image = [EdgePatternImage new];
        image.imageName         = @"典雅14.png";
        [array addObject:image];
    }
    
    {
        EdgePatternImage *image = [EdgePatternImage new];
        image.imageName         = @"典雅15.png";
        [array addObject:image];
    }
    
    return array;
}

+ (NSArray *)DecorateImages {
    
    return @[@"点缀1.png",
             @"点缀2.png",
             @"点缀3-A.png", @"点缀3-B.png",
             @"点缀4.png",
             @"点缀5.png",
             @"点缀6.png",
             @"点缀7.png",
             @"点缀8.png",
             @"点缀9.png",
             @"点缀10.png"];
}

+ (NSArray <QuoteImage *> *)QuoteImages {
    
    NSMutableArray *array = [NSMutableArray array];
    
    {
        QuoteImage *image = [QuoteImage new];
        image.imageName   = @"quote_1.png";
        image.cutEdge     = UIEdgeInsetsMake(81, 81, 81, 81);
        image.areaEdge    = UIEdgeInsetsMake(81, 81, 81, 81);
        [array addObject:image];
    }
    
    {
        QuoteImage *image = [QuoteImage new];
        image.imageName   = @"quote_2.png";
        image.cutEdge     = UIEdgeInsetsMake(80, 80, 80, 80);
        image.areaEdge    = UIEdgeInsetsMake(80, 80, 80, 80);
        [array addObject:image];
    }
    
    {
        QuoteImage *image = [QuoteImage new];
        image.imageName   = @"quote_3.png";
        image.cutEdge     = UIEdgeInsetsMake(63, 201, 63, 201);
        image.areaEdge    = UIEdgeInsetsMake(63, 35, 63, 35);
        [array addObject:image];
    }
    
    {
        QuoteImage *image = [QuoteImage new];
        image.imageName   = @"quote_4.png";
        image.cutEdge     = UIEdgeInsetsMake(110, 131, 110, 131);
        image.areaEdge    = UIEdgeInsetsMake(79, 103, 79, 103);
        [array addObject:image];
    }
    
    return array;
}

@end
