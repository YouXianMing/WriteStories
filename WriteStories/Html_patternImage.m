//
//  Html_patternImage.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/13.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Html_patternImage.h"

@implementation Html_patternImage

#pragma mark - Editors

- (NSArray<InputEditor *> *)inputEditors {
    
    return nil;
}

- (ItemsStyleEditManager *)editManager {
    
    ItemsStyleEditManager *manager = [ItemsStyleEditManager managerWithWeakObject:self];
    
    {
        // 背景图案
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
            // 矩形区域圆角
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"矩形区域圆角";
            editor.keys              = @[@"containerCornerRadius"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"圆角值"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:0 to:20]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:0 to:20]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 背景色
            StyleEditor *editor    = [StyleEditor new];
            editor.cellTitle      = @"背景色";
            editor.keys           = @[@"containerHexColor"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 背景色可见度
            StyleEditor *editor       = [StyleEditor new];
            editor.cellTitle         = @"背景色可见度";
            editor.keys              = @[@"containerHexColorAlpha"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"可见度"];
            editor.pickerViewValuesRanges      = @[Values.AlphaValueRanges];
            editor.pickerViewValuesShowStrings = @[Values.AlphaValueRangeStrings];
            
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
    divs.container_class = @"pr";
    
    divs.inner_1_style = FmtStr(@"background: %@; z-index: -3; border-radius: %@px; -webkit-box-shadow: %@px %@px %@px %@; opacity: 1;",
                                [self RGBAWithHex:self.containerHexColor alpha:self.containerHexColorAlpha],
                                self.containerCornerRadius,
                                self.shadowOffsetX,
                                self.shadowOffsetY,
                                self.shadowBlur,
                                [self RGBAWithHex:self.shadowHexColor alpha:self.shadowHexColorAlpha]);
    divs.inner_1_class = @"pa h_100 w_100";
    
    return divs.jsConfig;
}

- (NSString *)bodyString {
    
    NSString *bodyStyle      = FmtStr(@"background: url(../../../images/patterns/%@);", self.backgroundImageName);
    NSString *containerStyle = FmtStr(@"margin: %@px %@px %@px %@px; padding-bottom: %@px;", self.containerGapTop, self.containerGapRight, self.containerGapBottom, self.containerGapLeft, self.bottomGap);
    
    NSString *inner_1_Style = FmtStr(@"background: %@; z-index: -3; border-radius: %@px; -webkit-box-shadow: %@px %@px %@px %@; opacity: 1;",
                                     [self RGBAWithHex:self.containerHexColor alpha:self.containerHexColorAlpha],
                                     self.containerCornerRadius,
                                     self.shadowOffsetX,
                                     self.shadowOffsetY,
                                     self.shadowBlur,
                                     [self RGBAWithHex:self.shadowHexColor alpha:self.shadowHexColorAlpha]);
    
    OutterAndInnerDivs *divs = [OutterAndInnerDivs new];
    divs.body = FmtStr(@"<body %@ %@ %@>",
                       _html_id(@"body"),
                       _html_class(@" "),
                       _html_style(bodyStyle));
    
    divs.container = FmtStr(@"<div %@ %@ %@>",
                            _html_id(@"container"),
                            _html_class(@"pr"),
                            _html_style(containerStyle));
    
    divs.inner_1 = FmtStr(@"<div %@ %@ %@></div>",
                          _html_id(@"inner_1"),
                          _html_class(@"pa h_100 w_100"),
                          _html_style(inner_1_Style));
    
    return divs.htmlString;
}

#pragma mark - Object

+ (instancetype)defalutObject {
    
    Html_patternImage *item = [Html_patternImage new];
    
    // 当前类属性
    item.backgroundImageName = @"1_052.gif";
    
    item.containerGapTop    = @(20);
    item.containerGapRight  = @(20);
    item.containerGapBottom = @(20);
    item.containerGapLeft   = @(20);
    
    item.containerHexColorAlpha = @(0.7);
    item.containerHexColor      = @"#FFF5EE";
    
    item.containerCornerRadius = @(0);
    
    item.shadowOffsetX       = @(3);
    item.shadowOffsetY       = @(3);
    item.shadowBlur          = @(5);
    item.shadowHexColor      = @"#000000";
    item.shadowHexColorAlpha = @(0.25);
    
    item.bottomGap = @(50);
    
    return item;
}

#pragma mark - Style

- (instancetype)currentStyleObject {
    
    Html_patternImage *object = (Html_patternImage *)[BaseHtmlBodyItem decodeWithData:self.encodeData];
    
    return object;
}

- (void)useStyleObject:(id)styleObject {
    
    Html_patternImage *style = styleObject;
    
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
    
    self.bottomGap = style.bottomGap;
}

#pragma mark - Coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [self autoEncodePropertiesWithCoder:aCoder class:Html_patternImage.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:Html_patternImage.class];
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
             
             @"bottomGap"];
}

@end
