//
//  Mark_time.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/3.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Mark_time.h"
#import "DateFormatter.h"

@implementation Mark_time

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
    
    {
        InputEditor *editor    = [InputEditor new];
        editor.title           = @"时间";
        editor.key             = @"time";
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
            editor.pickerViewValuesRanges      = @[@[@(1),  @(2),  @(3),  @(4),  @(5),
                                                     @(6),  @(7),  @(8),  @(9),  @(10),
                                                     @(11), @(12)]];
            editor.pickerViewValuesShowStrings = @[@[@"风格1",  @"风格2",  @"风格3",  @"风格4",  @"风格5",
                                                     @"风格6",  @"风格7",  @"风格8",  @"风格9",  @"风格10",
                                                     @"风格11", @"风格12"]];
            
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
    
    {
        // 时间
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"时间"];
        [manager.headers addObject:header];
        
        {
            // 颜色
            StyleEditor *editor   = [StyleEditor new];
            editor.cellTitle      = @"颜色";
            editor.keys           = @[@"timeColorHex"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 字体类型
            StyleEditor *editor   = [StyleEditor new];
            editor.cellTitle      = @"字体类型";
            editor.keys           = @[@"timeFontFamily"];
            editor.setupViewClass = FontsPickerSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 大小
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"大小";
            editor.keys              = @[@"timeFontSize"];
            
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
            editor.keys              = @[@"timeAlpha"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"可见度"];
            editor.pickerViewValuesRanges      = @[Values.AlphaValueRanges];
            editor.pickerViewValuesShowStrings = @[Values.AlphaValueRangeStrings];
            
            [header.editors addObject:editor];
        }
    }
    
    {
        // 线条
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"线条"];
        [manager.headers addObject:header];
        
        {
            // 颜色
            StyleEditor *editor   = [StyleEditor new];
            editor.cellTitle      = @"颜色";
            editor.keys           = @[@"lineColorHex"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 可见度
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"可见度";
            editor.keys              = @[@"lineAlpha"];
            
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
    
    Mark_time *item = [Mark_time new];
    
    // cell相关
    item.cellReuseId     = @"Mark_time";
    item.cellClassString = @"Mark_time_cell";
    item.isEmitterType   = NO;
    
    // 父类属性
    item.backgroundColorHex = @"#ffffff";
    item.title              = @"默认标题";
    item.titleColorHex      = @"#000000";
    item.titleFontFamily    = @"PingFangSC-Thin";
    item.titleFontSize      = @(35);
    item.titleAlpha         = @(1.f);
    
    // 当前类属性
    item.styleType = @(1);
    
    item.iconFontUnicode = @"0x0053";
    item.iconFontName    = @"Weather&Time";
    item.iconColorHex    = @"#000000";
    item.iconFontSize    = @(80);
    item.iconOpacity     = @(1);
    
    item.subTitle           = @"默认副标题";
    item.subTitleColorHex   = @"#000000";
    item.subTitleFontFamily = @"PingFangSC-Thin";
    item.subTitleFontSize   = @(20);
    item.subTitleAlpha      = @(1.f);
    
    item.time           = [DateFormatter dateStringFromDate:NSDate.date outputDateStringFormatter:@"yyyy-MM-dd HH:mm:ss"];;
    item.timeColorHex   = @"#000000";
    item.timeFontFamily = @"Lato-ThinItalic";
    item.timeFontSize   = @(16);
    item.timeAlpha      = @(1.f);
    
    item.lineColorHex = @"#565051";
    item.lineAlpha    = @(0.15);
    
    if (Width == 320.f) {
        
        item.timeFontSize     = @(26);
        item.subTitleFontSize = @(15);
        item.timeFontSize     = @(14);
    }
    
    return item;
}

#pragma mark - Style

- (instancetype)currentStyleObject {
    
    Mark_time *object = (Mark_time *)[BaseMarkItem decodeWithData:self.encodeData];
    
    // 父类属性输入置空
    object.title = nil;
    
    // 当前类属性输入置空
    object.subTitle = nil;
    object.time     = nil;
    
    return object;
}

- (void)useStyleObject:(id)styleObject {
    
    Mark_time *style = styleObject;
    
    // 父类属性
    self.backgroundColorHex = style.backgroundColorHex;
    self.titleFontFamily    = style.titleFontFamily;
    self.titleColorHex      = style.titleColorHex;
    self.titleFontSize      = style.titleFontSize;
    self.titleAlpha         = style.titleAlpha;
    
    // 当前类属性
    self.styleType = style.styleType;
    
    self.iconFontUnicode = style.iconFontUnicode;
    self.iconFontName    = style.iconFontName;
    self.iconColorHex    = style.iconColorHex;
    self.iconFontSize    = style.iconFontSize;
    self.iconOpacity     = style.iconOpacity;
    
    self.subTitleFontFamily = style.subTitleFontFamily;
    self.subTitleColorHex   = style.subTitleColorHex;
    self.subTitleFontSize   = style.subTitleFontSize;
    self.subTitleAlpha      = style.subTitleAlpha;
    
    self.timeFontFamily = style.timeFontFamily;
    self.timeColorHex   = style.timeColorHex;
    self.timeFontSize   = style.timeFontSize;
    self.timeAlpha      = style.timeAlpha;
    
    self.lineColorHex = style.lineColorHex;
    self.lineAlpha    = style.lineAlpha;
}

#pragma mark - Coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [self autoEncodePropertiesWithCoder:aCoder class:Mark_time.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:Mark_time.class];
    }
    
    return self;
}

+ (NSArray<NSString *> *)autoEncodePropertyKeys {
    
    return @[@"styleType",
             
             @"iconFontUnicode",
             @"iconFontName",
             @"iconColorHex",
             @"iconFontSize",
             @"iconOpacity",
             
             @"subTitle",
             @"subTitleFontFamily",
             @"subTitleColorHex",
             @"subTitleFontSize",
             @"subTitleAlpha",
             
             @"time",
             @"timeFontFamily",
             @"timeColorHex",
             @"timeFontSize",
             @"timeAlpha",
             
             @"lineColorHex",
             @"lineAlpha"];
}

@end
