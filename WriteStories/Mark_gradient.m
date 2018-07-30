//
//  Mark_gradient.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/3.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Mark_gradient.h"

@implementation Mark_gradient

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
        editor.title           = @"背景图";
        editor.key             = @"image";
        editor.editorViewClass = MarkImageInputEditorView.class;
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
                                                     @(11), @(12), @(13)]];
            editor.pickerViewValuesShowStrings = @[@[@"风格1",  @"风格2",  @"风格3",  @"风格4",  @"风格5",
                                                     @"风格6",  @"风格7",  @"风格8",  @"风格9",  @"风格10",
                                                     @"风格11", @"风格12", @"风格13"]];
            
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
    
    return @[self.image];
}

+ (instancetype)defalutObject {
    
    Mark_gradient *item = [Mark_gradient new];
    
    // 支付相关
    item.paymentID = @"com.YouXianMing.WriteStories.Mark_gradient";
    
    // cell相关
    item.cellReuseId     = @"Mark_gradient";
    item.cellClassString = @"Mark_gradient_cell";
    item.isEmitterType   = NO;
    
    // 父类属性
    item.backgroundColorHex = @"#FFFFFF";
    item.title              = @"默认标题";
    item.titleColorHex      = @"#FFFFFF";
    item.titleFontFamily    = @"AaFangMeng";
    item.titleFontSize      = @(19);
    item.titleAlpha         = @(1.f);
    
    // 当前类属性
    item.styleType          = @(1);
    
    EncodeImageObject *object = [EncodeImageObject new];
    object.imageName          = @"image_bg_jpg";
    object.source             = EncodeImageObjectSourceDefault;
    object.width              = 77 * 8;
    object.height             = 30 * 8;
    object.scale              = @"77:30";
    item.image                = object;
    
    item.subTitle           = @"默认副标题";
    item.subTitleFontFamily = @"PingFangSC-Thin";
    item.subTitleColorHex   = @"#FFFFFF";
    item.subTitleFontSize   = @(14);
    item.subTitleAlpha      = @(1.f);
    
    item.coverViewColorHex = @"#848482";
    item.coverViewAlpha    = @(0.5f);
    
    item.lineColorHex = @"#FFFFFF";
    item.lineAlpha    = @(0.5f);
    
    CAGradientViewObject *gradientObject    = [CAGradientViewObject new];
    gradientObject.gradientHexColor_1       = @"#F660AB";
    gradientObject.gradientHexColor_2       = @"#e799a3";
    gradientObject.gradientColor_1_alpha    = @(1.f);
    gradientObject.gradientColor_2_alpha    = @(0.f);
    gradientObject.gradientColor_1_location = @(0.f);
    gradientObject.gradientColor_2_location = @(1.f);
    gradientObject.startPoint               = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    gradientObject.endPoint                 = [NSValue valueWithCGPoint:CGPointMake(1, 0)];
    
    item.gradientObject      = gradientObject;
    item.gradientObjectAlpha = @(1.f);
    
    return item;
}

#pragma mark - Style

- (instancetype)currentStyleObject {
    
    Mark_gradient *object = (Mark_gradient *)[BaseMarkItem decodeWithData:self.encodeData];
    
    // 父类属性输入置空
    object.title = nil;
    
    // 当前类属性输入置空
    object.subTitle = nil;
    object.image    = nil;
    
    return object;
}

- (void)useStyleObject:(id)styleObject {
    
    Mark_gradient *style = styleObject;
    
    // 父类属性
    self.backgroundColorHex = style.backgroundColorHex;
    self.titleFontFamily    = style.titleFontFamily;
    self.titleColorHex      = style.titleColorHex;
    self.titleFontSize      = style.titleFontSize;
    self.titleAlpha         = style.titleAlpha;
    
    // 当前类属性
    self.styleType = style.styleType;
    
    self.subTitleFontFamily = style.subTitleFontFamily;
    self.subTitleColorHex   = style.subTitleColorHex;
    self.subTitleFontSize   = style.subTitleFontSize;
    self.subTitleAlpha      = style.subTitleAlpha;
    
    self.coverViewColorHex = style.coverViewColorHex;
    self.coverViewAlpha    = style.coverViewAlpha;
    
    self.lineColorHex = style.lineColorHex;
    self.lineAlpha    = style.lineAlpha;
    
    self.gradientObject      = style.gradientObject;
    self.gradientObjectAlpha = style.gradientObjectAlpha;
}

#pragma mark - Coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [self autoEncodePropertiesWithCoder:aCoder class:Mark_gradient.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:Mark_gradient.class];
    }
    
    return self;
}

+ (NSArray<NSString *> *)autoEncodePropertyKeys {
    
    return @[@"styleType",
             
             @"image",
             
             @"subTitle",
             @"subTitleFontFamily",
             @"subTitleColorHex",
             @"subTitleFontSize",
             @"subTitleAlpha",
             
             @"coverViewColorHex",
             @"coverViewAlpha",
             
             @"lineColorHex",
             @"lineAlpha",
             
             @"gradientObject",
             @"gradientObjectAlpha"];
}

@end
