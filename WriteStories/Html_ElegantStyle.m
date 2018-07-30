//
//  Html_ElegantStyle.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/22.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Html_ElegantStyle.h"

#import "BasePaperType.h"
#import "BaseDecorateType.h"

@implementation Html_ElegantStyle

#pragma mark - Editors

- (NSArray<InputEditor *> *)inputEditors {
    
    return nil;
}

- (ItemsStyleEditManager *)editManager {
    
    ItemsStyleEditManager *manager = [ItemsStyleEditManager managerWithWeakObject:self];
    
    {
        // 风格
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"风格"];
        [manager.headers addObject:header];
        
        {
            // 背景图案
            StyleEditor *editor   = [StyleEditor new];
            editor.cellTitle      = @"背景图案";
            editor.keys           = @[@"backgroundImageName"];
            editor.setupViewClass = PatternImagesSetupView.class;
            
            [header.editors addObject:editor];
        }
        
        {
            // 纸张
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"纸张";
            editor.keys              = @[@"paperType"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"纸张"];
            editor.pickerViewValuesRanges      = @[@[@(1),  @(2),  @(3),  @(4),  @(5),
                                                     @(6),  @(7),  @(8),  @(9),  @(10),
                                                     @(11), @(12), @(13), @(14), @(15)]];
            editor.pickerViewValuesShowStrings = @[@[@"样式1",  @"样式2",  @"样式3",  @"样式4",  @"样式5",
                                                     @"样式6",  @"样式7",  @"样式8",  @"样式9",  @"样式10",
                                                     @"样式11", @"样式12", @"样式13", @"样式14", @"样式15"]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 装饰
            StyleEditor *editor       = [StyleEditor new];
            editor.cellTitle         = @"装饰";
            editor.keys              = @[@"decorateType"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"装饰"];
            editor.pickerViewValuesRanges      = @[@[@(1),    @(2),    @(3),    @(4),    @(5),
                                                     @(6),    @(7),    @(8),    @(9),    @(10),
                                                     @(11)]];
            editor.pickerViewValuesShowStrings = @[@[@"无",   @"样式1",  @"样式2", @"样式3", @"样式4",
                                                     @"样式5", @"样式6", @"样式7", @"样式8", @"样式9",
                                                     @"样式10"]];
            
            [header.editors addObject:editor];
        }
    }
    
    {
        // 矩形区域
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"矩形区域"];
        [manager.headers addObject:header];
        
        {
            // 矩形区域上下间距
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"矩形区域上下间距";
            editor.keys              = @[@"containerGapTop", @"containerGapBottom"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"上间距", @"下间距"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:0 to:150], [Values valuesFrom:0 to:300]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:0 to:150], [Values stringsFrom:0 to:300]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 矩形区域左右间距
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"矩形区域左右间距";
            editor.keys              = @[@"containerGapLeft", @"containerGapRight"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"左间距", @"右间距"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:0 to:50], [Values valuesFrom:0 to:50]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:0 to:50], [Values stringsFrom:0 to:50]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 底部加长
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"底部加长";
            editor.keys              = @[@"bottomGap"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"加长长度"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:0 to:300]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:0 to:300]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 投影位移
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"投影位移";
            editor.keys              = @[@"shadowOffsetX", @"shadowOffsetY"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"X偏移量", @"Y偏移量"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:-20 to:20], [Values valuesFrom:-20 to:20]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:-20 to:20], [Values stringsFrom:-20 to:20]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 投影颜色
            StyleEditor *editor    = [StyleEditor new];
            editor.cellTitle      = @"投影颜色";
            editor.keys           = @[@"shadowHexColor"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 投影可见度
            StyleEditor *editor       = [StyleEditor new];
            editor.cellTitle         = @"投影可见度";
            editor.keys              = @[@"shadowHexColorAlpha"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"可见度"];
            editor.pickerViewValuesRanges      = @[Values.AlphaValueRanges];
            editor.pickerViewValuesShowStrings = @[Values.AlphaValueRangeStrings];
            
            [header.editors addObject:editor];
        }
        
        {
            // 投影模糊程度
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"投影模糊程度";
            editor.keys              = @[@"shadowBlur"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"模糊程度"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:0 to:20]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:0 to:20]];
            
            [header.editors addObject:editor];
        }
    }
    
    return manager;
}

#pragma mark - Html

- (NSString *)jsConfig {
    
    OutterAndInnerDivs *divs = [OutterAndInnerDivs new];
    divs.body_style          = FmtStr(@"background: url(../../../images/patterns/%@);", self.backgroundImageName);
    
    divs.container_style = FmtStr(@"margin: %@px %@px %@px %@px; padding-bottom: %@px;", self.containerGapTop, self.containerGapRight, self.containerGapBottom, self.containerGapLeft, self.bottomGap);
    divs.container_class = @"pr z_0";
    
    BasePaperType *paper = [NSClassFromString(FmtStr(@"Paper_%@", self.paperType)) new];
    [paper config_js_WithOutterAndInnerDivs:divs];
    
    BaseDecorateType *decorate = [NSClassFromString(FmtStr(@"Decorate_%@", self.decorateType)) new];
    [decorate config_js_WithOutterAndInnerDivs:divs];
    
    divs.inner_1_style = FmtStr(@"background: %@; border-radius: %@px; -webkit-box-shadow: %@px %@px %@px %@;",
                                paper.inner_1_backgroundColorHex,
                                self.containerCornerRadius,
                                self.shadowOffsetX,
                                self.shadowOffsetY,
                                self.shadowBlur,
                                [self RGBAWithHex:self.shadowHexColor alpha:self.shadowHexColorAlpha]);
    divs.inner_1_class = @"pa h_100 w_100 z_n3";
    
    return divs.jsConfig;
}

- (NSString *)bodyString {
    
    NSString *bodyStyle      = FmtStr(@"background: url(../../../images/patterns/%@);", self.backgroundImageName);
    NSString *containerStyle = FmtStr(@"margin: %@px %@px %@px %@px; padding-bottom: %@px;", self.containerGapTop, self.containerGapRight, self.containerGapBottom, self.containerGapLeft, self.bottomGap);
    
    OutterAndInnerDivs *divs = [OutterAndInnerDivs new];
    divs.body = FmtStr(@"<body %@ %@ %@>",
                       _html_id(@"body"),
                       _html_class(@" "),
                       _html_style(bodyStyle));
    
    divs.container = FmtStr(@"<div %@ %@ %@>",
                            _html_id(@"container"),
                            _html_class(@"pr z_0"),
                            _html_style(containerStyle));
    
    BasePaperType *paper = [NSClassFromString(FmtStr(@"Paper_%@", self.paperType)) new];
    [paper config_htmlString_WithOutterAndInnerDivs:divs];
    
    BaseDecorateType *decorate = [NSClassFromString(FmtStr(@"Decorate_%@", self.decorateType)) new];
    [decorate config_htmlString_WithOutterAndInnerDivs:divs];
    
    NSString *inner_1_Style = FmtStr(@"background: %@; border-radius: %@px; -webkit-box-shadow: %@px %@px %@px %@;",
                                     paper.inner_1_backgroundColorHex,
                                     self.containerCornerRadius,
                                     self.shadowOffsetX,
                                     self.shadowOffsetY,
                                     self.shadowBlur,
                                     [self RGBAWithHex:self.shadowHexColor alpha:self.shadowHexColorAlpha]);
    
    divs.inner_1 = FmtStr(@"<div %@ %@ %@></div>",
                          _html_id(@"inner_1"),
                          _html_class(@"pa h_100 w_100 z_n3"),
                          _html_style(inner_1_Style));
    
    return divs.htmlString;
}

#pragma mark - Object

+ (instancetype)defalutObject {
    
    Html_ElegantStyle *item = [Html_ElegantStyle new];
    
    // 当前类属性
    item.backgroundImageName = @"1_052.gif";
    
    item.containerGapTop    = @(60);
    item.containerGapRight  = @(15);
    item.containerGapBottom = @(60);
    item.containerGapLeft   = @(15);
    
    item.containerHexColorAlpha = @(0.7);
    item.containerHexColor      = @"#FFF5EE";
    
    item.containerCornerRadius = @(0);
    
    item.shadowOffsetX       = @(0);
    item.shadowOffsetY       = @(0);
    item.shadowBlur          = @(10);
    item.shadowHexColor      = @"#000000";
    item.shadowHexColorAlpha = @(0.5);
    
    item.paperType    = @(1);
    item.decorateType = @(1);
    item.bottomGap    = @(50);
    
    return item;
}

#pragma mark - Style

- (instancetype)currentStyleObject {
    
    Html_ElegantStyle *object = (Html_ElegantStyle *)[BaseHtmlBodyItem decodeWithData:self.encodeData];
    
    return object;
}

- (void)useStyleObject:(id)styleObject {
    
    Html_ElegantStyle *style = styleObject;
    
    // 当前类属性
    self.backgroundImageName = style.backgroundImageName;
    
    self.containerGapTop    = style.containerGapTop;
    self.containerGapRight  = style.containerGapRight;
    self.containerGapBottom = style.containerGapBottom;
    self.containerGapLeft   = style.containerGapLeft;
    
    self.containerHexColorAlpha = style.containerHexColorAlpha;
    self.containerHexColor      = style.containerHexColor;
    
    self.containerCornerRadius = style.containerCornerRadius;
    
    self.shadowOffsetX       = style.shadowOffsetX;
    self.shadowOffsetY       = style.shadowOffsetY;
    self.shadowBlur          = style.shadowBlur;
    self.shadowHexColor      = style.shadowHexColor;
    self.shadowHexColorAlpha = style.shadowHexColorAlpha;
    
    self.paperType    = style.paperType;
    self.decorateType = style.decorateType;
    self.bottomGap    = style.bottomGap;
}

#pragma mark - Coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [self autoEncodePropertiesWithCoder:aCoder class:Html_ElegantStyle.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:Html_ElegantStyle.class];
    }
    
    return self;
}

+ (NSArray<NSString *> *)autoEncodePropertyKeys {
    
    return @[@"backgroundImageName",
             
             @"containerGapTop",
             @"containerGapRight",
             @"containerGapBottom",
             @"containerGapLeft",
             
             @"containerHexColorAlpha",
             @"containerHexColor",
             
             @"containerCornerRadius",
             
             @"shadowOffsetX",
             @"shadowOffsetY",
             @"shadowBlur",
             @"shadowHexColor",
             @"shadowHexColorAlpha",
             
             @"paperType",
             @"decorateType",
             @"bottomGap"];
}

@end
