//
//  Mark_snow_0.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/7.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Mark_snow_0.h"

@implementation Mark_snow_0

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
        // 风格
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"风格"];
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
        
        {
            // 可见度
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"可见度";
            editor.keys              = @[@"emitterAlpha"];
            
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
    
    Mark_snow_0 *item = [Mark_snow_0 new];
    
    // cell相关
    item.cellReuseId     = NSString.UniqueString;
    item.cellClassString = @"Mark_snow_0_cell";
    item.isEmitterType   = YES;
    
    // 父类属性
    item.backgroundColorHex = @"#FFDFDD";
    item.title              = @"默认标题";
    item.titleColorHex      = @"#fbbbb9";
    item.titleFontFamily    = @"PingFangSC-Thin";
    item.titleFontSize      = @(36);
    item.titleAlpha         = @(1.f);
    
    // 当前类属性
    item.styleType           = @(1);
    
    item.emitterAlpha        = @(1);
    item.emitterPureColor    = @"#FFFFFF"; // 纯白色
    item.emitterMixColorType = @(1);
    
    return item;
}

#pragma mark - Style

- (instancetype)currentStyleObject {
    
    Mark_snow_0 *object = (Mark_snow_0 *)[BaseMarkItem decodeWithData:self.encodeData];
    
    // 父类属性输入置空
    object.title = nil;
    
    return object;
}

- (void)useStyleObject:(id)styleObject {
    
    Mark_snow_0 *style = styleObject;
    
    // 父类属性
    self.backgroundColorHex = style.backgroundColorHex;
    self.titleFontFamily    = style.titleFontFamily;
    self.titleColorHex      = style.titleColorHex;
    self.titleFontSize      = style.titleFontSize;
    self.titleAlpha         = style.titleAlpha;
    
    // 当前类属性
    self.styleType           = style.styleType;
    
    self.emitterAlpha        = style.emitterAlpha;
    self.emitterPureColor    = style.emitterPureColor;
    self.emitterMixColorType = style.emitterMixColorType;
}

#pragma mark - Coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [self autoEncodePropertiesWithCoder:aCoder class:Mark_snow_0.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:Mark_snow_0.class];
    }
    
    return self;
}

+ (NSArray<NSString *> *)autoEncodePropertyKeys {
    
    return @[@"styleType",
             
             @"emitterAlpha",
             @"emitterPureColor",
             @"emitterMixColorType"];
}

@end
