//
//  Mark_normal_2.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/2.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Mark_normal_2.h"

@implementation Mark_normal_2

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
        editor.title           = @"副标题";
        editor.key             = @"subTitle";
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
            editor.pickerViewValuesRanges      = @[@[@(1),    @(2),    @(3),    @(4),     @(5)]];
            editor.pickerViewValuesShowStrings = @[@[@"风格1", @"风格2", @"风格3", @"风格4", @"风格5"]];
            
            [header.editors addObject:editor];
        }
    }
    
    {
        // 背景
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"背景"];
        [manager.headers addObject:header];
        
        {
            // 背景色
            StyleEditor *editor   = [StyleEditor new];
            editor.cellTitle      = @"背景色";
            editor.keys           = @[@"backgroundColorHex"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
    }
    
    {
        // 标题
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"标题"];
        [manager.headers addObject:header];
        
        {
            // 颜色
            StyleEditor *editor   = [StyleEditor new];
            editor.cellTitle      = @"颜色";
            editor.keys           = @[@"titleColorHex"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 字体类型
            StyleEditor *editor   = [StyleEditor new];
            editor.cellTitle      = @"字体类型";
            editor.keys           = @[@"titleFontFamily"];
            editor.setupViewClass = FontsPickerSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 大小
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"大小";
            editor.keys              = @[@"titleFontSize"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"大小"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:5 to:50]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:5 to:50]];
            
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
        // 副标题
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"副标题"];
        [manager.headers addObject:header];
        
        {
            // 颜色
            StyleEditor *editor   = [StyleEditor new];
            editor.cellTitle      = @"颜色";
            editor.keys           = @[@"subTitleColorHex"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 字体类型
            StyleEditor *editor   = [StyleEditor new];
            editor.cellTitle      = @"字体类型";
            editor.keys           = @[@"subTitleFontFamily"];
            editor.setupViewClass = FontsPickerSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 大小
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"大小";
            editor.keys              = @[@"subTitleFontSize"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"大小"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:5 to:50]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:5 to:50]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 可见度
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"可见度";
            editor.keys              = @[@"subTitleAlpha"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"可见度"];
            editor.pickerViewValuesRanges      = @[Values.AlphaValueRanges];
            editor.pickerViewValuesShowStrings = @[Values.AlphaValueRangeStrings];
            
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
    
    Mark_normal_2 *item = [Mark_normal_2 new];
    
    // cell相关
    item.cellReuseId     = @"Mark_normal_2";
    item.cellClassString = @"Mark_normal_2_cell";
    item.isEmitterType   = NO;
    
    // 父类属性
    item.backgroundColorHex = @"#EBF4FA";
    item.title              = @"默认标题";
    item.titleColorHex      = @"#3090c7";
    item.titleFontFamily    = @"AaFangMeng";
    item.titleFontSize      = @(25);
    item.titleAlpha         = @(1.f);
    
    // 当前类属性
    item.styleType          = @(1);
    
    item.subTitle           = @"默认副标题";
    item.subTitleColorHex   = @"#98afc7";
    item.subTitleFontFamily = @"LSSST-1498";
    item.subTitleFontSize   = @(16);
    item.subTitleAlpha      = @(1.f);
    
    return item;
}

#pragma mark - Style

- (instancetype)currentStyleObject {
    
    Mark_normal_2 *object = (Mark_normal_2 *)[BaseMarkItem decodeWithData:self.encodeData];
    
    // 父类属性输入置空
    object.title = nil;
    
    // 当前类属性输入置空
    object.subTitle = nil;
    
    return object;
}

- (void)useStyleObject:(id)styleObject {
    
    Mark_normal_2 *style = styleObject;
    
    // 父类属性
    self.backgroundColorHex = style.backgroundColorHex;
    self.titleFontFamily    = style.titleFontFamily;
    self.titleColorHex      = style.titleColorHex;
    self.titleFontSize      = style.titleFontSize;
    self.titleAlpha         = style.titleAlpha;
    
    // 当前类属性
    self.styleType          = style.styleType;
    
    self.subTitleFontFamily = style.subTitleFontFamily;
    self.subTitleColorHex   = style.subTitleColorHex;
    self.subTitleFontSize   = style.subTitleFontSize;
    self.subTitleAlpha      = style.subTitleAlpha;
}

#pragma mark - Coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [self autoEncodePropertiesWithCoder:aCoder class:Mark_normal_2.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:Mark_normal_2.class];
    }
    
    return self;
}

+ (NSArray<NSString *> *)autoEncodePropertyKeys {
    
    return @[@"styleType",
             
             @"subTitle",
             @"subTitleFontFamily",
             @"subTitleColorHex",
             @"subTitleFontSize",
             @"subTitleAlpha"];
}

@end
