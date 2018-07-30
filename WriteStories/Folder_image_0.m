//
//  Folder_image_0.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/17.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Folder_image_0.h"
#import "FoldersManager.h"
#import "NSString+Path.h"

@implementation Folder_image_0

#pragma mark - Editors

- (NSArray<InputEditor *> *)inputEditors {
    
    NSMutableArray *array = [NSMutableArray array];
    
    {
        InputEditor *editor    = [InputEditor new];
        editor.title           = @"标题";
        editor.key             = @"title";
        editor.editorViewClass = FieldInputEditorView.class;
        [array addObject:editor];
    }
    
    {
        InputEditor *editor    = [InputEditor new];
        editor.title           = @"背景图";
        editor.key             = @"image";
        editor.editorViewClass = FolderImageInputEditorView.class;
        [array addObject:editor];
    }
    
    return array;
}

- (ItemsStyleEditManager *)editManager {
    
    ItemsStyleEditManager *manager = [ItemsStyleEditManager managerWithWeakObject:self];
    
    {
        // 顶部标题
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"顶部标题"];
        [manager.headers addObject:header];
        
        {
            // 字体颜色
            StyleEditor *editor    = [StyleEditor new];
            editor.cellTitle      = @"字体颜色";
            editor.keys           = @[@"titleColorHex"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 可见度
            StyleEditor *editor       = [StyleEditor new];
            editor.cellTitle         = @"可见度";
            editor.keys              = @[@"titleAlpha"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"可见度"];
            editor.pickerViewValuesRanges      = @[Values.AlphaValueRanges];
            editor.pickerViewValuesShowStrings = @[Values.AlphaValueRangeStrings];
            
            [header.editors addObject:editor];
        }
    }
    
    {
        // 文件夹计数
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"文件夹计数"];
        [manager.headers addObject:header];
        
        {
            // 字体颜色
            StyleEditor *editor    = [StyleEditor new];
            editor.cellTitle      = @"字体颜色";
            editor.keys           = @[@"articleCountColorHex"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 可见度
            StyleEditor *editor       = [StyleEditor new];
            editor.cellTitle         = @"可见度";
            editor.keys              = @[@"articleCountAlpha"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"可见度"];
            editor.pickerViewValuesRanges      = @[Values.AlphaValueRanges];
            editor.pickerViewValuesShowStrings = @[Values.AlphaValueRangeStrings];
            
            [header.editors addObject:editor];
        }
        
        {
            // 顶部色块
            ItemsHeader *header = [ItemsHeader headerWithTitle:@"顶部色块"];
            [manager.headers addObject:header];
            
            {
                // 背景色
                StyleEditor *editor    = [StyleEditor new];
                editor.cellTitle      = @"背景色";
                editor.keys           = @[@"backgroundColorHex"];
                editor.setupViewClass = ItemColorSetupView.class;
                [header.editors addObject:editor];
            }
        }
    }
    
    return manager;
}

#pragma mark - Object

- (NSArray<EncodeImageObject *> *)imageObjects {
    
    return @[self.image];
}

+ (instancetype)defalutObject {
    
    Folder_image_0 *item = [Folder_image_0 new];
    
    // cell相关
    item.cellReuseId     = @"Folder_image_0";
    item.cellClassString = @"Folder_image_cell";
    item.isEmitterType   = NO;
    
    // 父类属性
    item.backgroundColorHex   = @"#FFFFFF";
    item.title                = @"模板2";
    item.titleColorHex        = @"#000000";
    item.titleAlpha           = @(1.f);
    item.articleCountColorHex = @"#000000";
    item.articleCountAlpha    = @(1.f);
    
    // 当前类属性
    EncodeImageObject *object = [EncodeImageObject new];
    object.imageName          = @"folder-cover_jpg";
    object.source             = EncodeImageObjectSourceDefault;
    object.width              = 200;
    object.height             = 200;
    object.scale              = @"1:1";
    item.image                = object;
    
    return item;
}

#pragma mark - Style

- (instancetype)currentStyleObject {
    
    Folder_image_0 *object = (Folder_image_0 *)[BaseFolderItem decodeWithData:self.encodeData];
    
    // 父类属性输入置空
    object.title = nil;
    
    // 当前类属性输入置空
    object.image = nil;
    
    return object;    
}

- (void)useStyleObject:(id)styleObject {
    
    Folder_image_0 *style = styleObject;
    
    // 父类属性
    self.backgroundColorHex   = style.backgroundColorHex;
    self.titleAlpha           = style.titleAlpha;
    self.titleColorHex        = style.titleColorHex;
    self.articleCountColorHex = style.articleCountColorHex;
    self.articleCountAlpha    = style.articleCountAlpha;
    
    // 当前类属性
    // 无
}

#pragma mark - Coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [self autoEncodePropertiesWithCoder:aCoder class:Folder_image_0.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:Folder_image_0.class];
    }
    
    return self;
}

+ (NSArray<NSString *> *)autoEncodePropertyKeys {
    
    return @[@"image"];
}

@end
