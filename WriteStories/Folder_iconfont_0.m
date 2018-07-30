//
//  Folder_iconfont_0.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/30.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Folder_iconfont_0.h"

@implementation Folder_iconfont_0

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
            StyleEditor *editor   = [StyleEditor new];
            editor.cellTitle      = @"字体颜色";
            editor.keys           = @[@"titleColorHex"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 可见度
            StyleEditor *editor      = [StyleEditor new];
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
            StyleEditor *editor   = [StyleEditor new];
            editor.cellTitle      = @"字体颜色";
            editor.keys           = @[@"articleCountColorHex"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 可见度
            StyleEditor *editor      = [StyleEditor new];
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
        // 图标
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"图标"];
        [manager.headers addObject:header];
        
        {
            // 图标
            StyleEditor *editor   = [StyleEditor new];
            editor.cellTitle      = @"图标";
            editor.keys           = @[@"iconFontName", @"iconFontUnicode"];
            editor.setupViewClass = IconFontSetupView.class;
            
            [header.editors addObject:editor];
        }
        
        {
            // 颜色
            StyleEditor *editor   = [StyleEditor new];
            editor.cellTitle      = @"颜色";
            editor.keys           = @[@"iconColorHex"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 大小
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"大小";
            editor.keys              = @[@"iconFontSize"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"大小"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:20 to:110]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:20 to:110]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 可见度
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"可见度";
            editor.keys              = @[@"iconOpacity"];
            
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
    }
    
    return manager;
}

#pragma mark - Object

- (NSArray<EncodeImageObject *> *)imageObjects {
    
    return nil;
}

+ (instancetype)defalutObject {
    
    Folder_iconfont_0 *item = [Folder_iconfont_0 new];
    
    // 支付相关
    item.paymentID = @"com.YouXianMing.WriteStories.Folder_iconfont_0";
    
    // cell相关
    item.cellReuseId     = @"Folder_iconfont_0_cell";
    item.cellClassString = @"Folder_iconfont_0_cell";
    item.isEmitterType   = NO;
    
    // 父类属性
    item.backgroundColorHex   = @"#FFFFFF";
    item.title                = @"模板6";
    item.titleColorHex        = @"#B6B6B4";
    item.titleAlpha           = @(1.f);
    item.articleCountColorHex = @"#B6B6B4";
    item.articleCountAlpha    = @(1.f);
    
    // 当前类属性
    item.contentBackgroundColorHex = @"#FFFFFF";
    
    item.iconFontUnicode = @"0x0055";
    item.iconFontName    = @"Weather&Time";
    item.iconColorHex    = @"#000000";
    item.iconFontSize    = @(90);
    item.iconOpacity     = @(1);
    
    return item;
}

#pragma mark - Style

- (instancetype)currentStyleObject {
    
    Folder_iconfont_0 *object = (Folder_iconfont_0 *)[BaseFolderItem decodeWithData:self.encodeData];
    
    // 父类属性输入置空
    object.title = nil;
    
    // 当前类属性输入置空
    // 无
    
    return object;
}

- (void)useStyleObject:(id)styleObject {
    
    Folder_iconfont_0 *style = styleObject;
    
    // 父类属性
    self.backgroundColorHex   = style.backgroundColorHex;
    self.titleAlpha           = style.titleAlpha;
    self.titleColorHex        = style.titleColorHex;
    self.articleCountColorHex = style.articleCountColorHex;
    self.articleCountAlpha    = style.articleCountAlpha;
    
    // 当前类属性
    self.contentBackgroundColorHex = style.contentBackgroundColorHex;
    
    self.iconFontUnicode = style.iconFontUnicode;
    self.iconFontName    = style.iconFontName;
    self.iconColorHex    = style.iconColorHex;
    self.iconFontSize    = style.iconFontSize;
    self.iconOpacity     = style.iconOpacity;
}

#pragma mark - Coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [self autoEncodePropertiesWithCoder:aCoder class:Folder_iconfont_0.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:Folder_iconfont_0.class];
    }
    
    return self;
}

+ (NSArray<NSString *> *)autoEncodePropertyKeys {
    
    return @[@"contentBackgroundColorHex",
             
             @"iconFontUnicode",
             @"iconFontName",
             @"iconColorHex",
             @"iconFontSize",
             @"iconOpacity"];
}

@end
