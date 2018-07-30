//
//  Folder_snow_0.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/6.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Folder_snow_0.h"

@implementation Folder_snow_0

- (NSArray<InputEditor *> *)inputEditors {
    
    NSMutableArray *array = [NSMutableArray array];
    
    {
        InputEditor *editor    = [InputEditor new];
        editor.title           = @"标题";
        editor.key             = @"title";
        editor.editorViewClass = FieldInputEditorView.class;
        [array addObject:editor];
    }
    
    return array;
}

- (ItemsStyleEditManager *)editManager {
    
    ItemsStyleEditManager *manager = [ItemsStyleEditManager managerWithWeakObject:self];
    
    {
        // 风格
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"风格"];
        [manager.headers addObject:header];
        
        {
            // 样式风格
            StyleEditor *editor       = [StyleEditor new];
            editor.cellTitle         = @"样式风格";
            editor.keys              = @[@"styleType"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"样式风格"];
            editor.pickerViewValuesRanges      = @[@[@(1), @(2)]];
            editor.pickerViewValuesShowStrings = @[@[@"风格1", @"风格2"]];
            
            [header.editors addObject:editor];
        }
    }
    
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
    
    {
        // 正方形色块
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"正方形色块"];
        [manager.headers addObject:header];
        
        {
            // 背景色
            StyleEditor *editor    = [StyleEditor new];
            editor.cellTitle      = @"背景色";
            editor.keys           = @[@"contentBackgroundColorHex"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 字体颜色
            StyleEditor *editor    = [StyleEditor new];
            editor.cellTitle      = @"字体颜色";
            editor.keys           = @[@"contentLabelColorHex"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 字体类型
            StyleEditor *editor    = [StyleEditor new];
            editor.cellTitle      = @"字体类型";
            editor.keys           = @[@"contentLabelFontFamily"];
            editor.setupViewClass = FontsPickerSetupView.class;
            [header.editors addObject:editor];
        }
    }
    
    {
        // 雪花
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"雪花"];
        [manager.headers addObject:header];
        
        {
            // 彩色
            StyleEditor *editor    = [StyleEditor new];
            editor.cellTitle      = @"彩色";
            editor.keys           = @[@"emitterMixColorType"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"彩色"];
            editor.pickerViewValuesRanges      = @[@[@(0), @(1)]];
            editor.pickerViewValuesShowStrings = @[@[@"纯色", @"彩色"]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 颜色
            StyleEditor *editor    = [StyleEditor new];
            editor.cellTitle      = @"颜色";
            editor.keys           = @[@"emitterPureColor"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
    }
    
    return manager;
}

#pragma mark - Object

- (NSArray<EncodeImageObject *> *)imageObjects {
    
    return nil;
}

+ (instancetype)defalutObject {
    
    Folder_snow_0 *item = [Folder_snow_0 new];
    
    // cell相关
    item.cellReuseId     = NSString.UniqueString;
    item.cellClassString = @"Folder_snow_0_cell";
    item.isEmitterType   = YES;
    
    // 父类属性
    item.backgroundColorHex   = @"#FFFFFF";
    item.title                = @"模板6";
    item.titleColorHex        = @"#B6B6B4";
    item.titleAlpha           = @(1.f);
    item.articleCountColorHex = @"#B6B6B4";
    item.articleCountAlpha    = @(1.f);
    
    // 当前类属性
    item.styleType                 = @(1);
    item.contentBackgroundColorHex = @"#E5E4E2";
    item.contentLabelColorHex      = @"#B6B6B4";
    item.contentLabelFontFamily    = @"PingFangSC-Semibold";
    
    item.emitterPureColor    = @"#FFFFFF"; // 纯白色
    item.emitterMixColorType = @(0);
    
    return item;
}

#pragma mark - Style

- (instancetype)currentStyleObject {
    
    Folder_snow_0 *object = (Folder_snow_0 *)[BaseFolderItem decodeWithData:self.encodeData];
    
    // 父类属性输入置空
    object.title = nil;
    
    // 当前类属性输入置空
    // 无
    
    return object;
}

- (void)useStyleObject:(id)styleObject {
    
    Folder_snow_0 *style = styleObject;
    
    // 父类属性
    self.backgroundColorHex   = style.backgroundColorHex;
    self.titleAlpha           = style.titleAlpha;
    self.titleColorHex        = style.titleColorHex;
    self.articleCountColorHex = style.articleCountColorHex;
    self.articleCountAlpha    = style.articleCountAlpha;
    
    // 当前类属性
    self.styleType                 = style.styleType;
    self.contentBackgroundColorHex = style.contentBackgroundColorHex;
    self.contentLabelColorHex      = style.contentLabelColorHex;
    self.contentLabelFontFamily    = style.contentLabelFontFamily;
    
    self.emitterPureColor    = style.emitterPureColor;
    self.emitterMixColorType = style.emitterMixColorType;
}

#pragma mark - Coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [self autoEncodePropertiesWithCoder:aCoder class:Folder_snow_0.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:Folder_snow_0.class];
    }
    
    return self;
}

+ (NSArray<NSString *> *)autoEncodePropertyKeys {
    
    return @[@"styleType",
             @"contentBackgroundColorHex",
             @"contentLabelColorHex",
             @"contentLabelFontFamily",
             
             @"emitterPureColor",
             @"emitterMixColorType"];
}

@end
