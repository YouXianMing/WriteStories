//
//  Mark_icon.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/3.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Mark_icon.h"

@implementation Mark_icon

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
        // 渐变色蒙版
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"渐变色蒙版"];
        [manager.headers addObject:header];
        
        {
            // 色值域
            StyleEditor *editor    = [StyleEditor new];
            editor.cellTitle      = @"色值域";
            editor.keys           = @[@"gradientObject"];
            editor.setupViewClass = ItemGradientDragAreaSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 色值A
            StyleEditor *editor    = [StyleEditor new];
            editor.cellTitle      = @"色值A";
            editor.keys           = @[@"gradientObject.gradientHexColor_1"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 色值A可见度
            StyleEditor *editor       = [StyleEditor new];
            editor.cellTitle         = @"色值A可见度";
            editor.keys              = @[@"gradientObject.gradientColor_1_alpha"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"色值A可见度"];
            editor.pickerViewValuesRanges      = @[Values.AlphaValueRanges];
            editor.pickerViewValuesShowStrings = @[Values.AlphaValueRangeStrings];
            
            [header.editors addObject:editor];
        }
        
        {
            // 色值B
            StyleEditor *editor    = [StyleEditor new];
            editor.cellTitle      = @"色值B";
            editor.keys           = @[@"gradientObject.gradientHexColor_2"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 色值B可见度
            StyleEditor *editor       = [StyleEditor new];
            editor.cellTitle         = @"色值B可见度";
            editor.keys              = @[@"gradientObject.gradientColor_2_alpha"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"色值B可见度"];
            editor.pickerViewValuesRanges      = @[Values.AlphaValueRanges];
            editor.pickerViewValuesShowStrings = @[Values.AlphaValueRangeStrings];
            
            [header.editors addObject:editor];
        }
        
        {
            // 总体可见度
            StyleEditor *editor       = [StyleEditor new];
            editor.cellTitle         = @"总体可见度";
            editor.keys              = @[@"gradientObjectAlpha"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"总体可见度"];
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
    
    Mark_icon *item = [Mark_icon new];
    
    // 支付相关
    item.paymentID = @"com.YouXianMing.WriteStories.Mark_icon";
    
    // cell相关
    item.cellReuseId     = @"Mark_icon";
    item.cellClassString = @"Mark_icon_cell";
    item.isEmitterType   = NO;
    
    // 父类属性
    item.backgroundColorHex = @"#FEFCFF";
    item.title              = @"默认标题";
    item.titleColorHex      = @"#000000";
    item.titleFontFamily    = @"AaFangMeng";
    item.titleFontSize      = @(18);
    item.titleAlpha         = @(1.f);
    
    // 当前类属性
    item.styleType = @(1);
    
    item.iconFontUnicode = @"0xF215";
    item.iconFontName    = @"FontAwesome5BrandsRegular";
    item.iconColorHex    = @"#000000";
    item.iconFontSize    = @(75);
    item.iconOpacity     = @(1);
    
    item.subTitle           = @"默认副标题";
    item.subTitleColorHex   = @"#000000";
    item.subTitleFontFamily = @"LSSST-1498";
    item.subTitleFontSize   = @(13);
    item.subTitleAlpha      = @(1.f);
    
    CAGradientViewObject *gradientObject    = [CAGradientViewObject new];
    gradientObject.gradientHexColor_1       = @"#00ffff";
    gradientObject.gradientHexColor_2       = @"#FEFCFF";
    gradientObject.gradientColor_1_alpha    = @(1.f);
    gradientObject.gradientColor_2_alpha    = @(0.f);
    gradientObject.gradientColor_1_location = @(0.f);
    gradientObject.gradientColor_2_location = @(1.f);
    gradientObject.startPoint               = [NSValue valueWithCGPoint:CGPointMake(0.5, 0)];
    gradientObject.endPoint                 = [NSValue valueWithCGPoint:CGPointMake(0, 1)];
    
    item.gradientObject      = gradientObject;
    item.gradientObjectAlpha = @(1.f);
    
    if (Width == 320.f) {
        
        item.iconFontSize = @(45.f);
    }
    
    return item;
}

#pragma mark - Style

- (instancetype)currentStyleObject {
    
    Mark_icon *object = (Mark_icon *)[BaseMarkItem decodeWithData:self.encodeData];
    
    // 父类属性输入置空
    object.title = nil;
    
    // 当前类属性输入置空
    object.subTitle = nil;
    
    return object;
}

- (void)useStyleObject:(id)styleObject {
    
    Mark_icon *style = styleObject;
    
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
    
    self.gradientObject      = style.gradientObject;
    self.gradientObjectAlpha = style.gradientObjectAlpha;
}

#pragma mark - Coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [self autoEncodePropertiesWithCoder:aCoder class:Mark_icon.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:Mark_icon.class];
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
             
             @"gradientObject",
             @"gradientObjectAlpha"];
}

@end
