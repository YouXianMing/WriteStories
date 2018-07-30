//
//  Block_paragraph_quote_1.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Block_paragraph_quote_1.h"
#import "TextInputEditorView.h"

@implementation Block_paragraph_quote_1

#pragma mark - Editors

- (NSArray<InputEditor *> *)inputEditors {
    
    NSMutableArray *array = [NSMutableArray array];
    
    {
        InputEditor *editor    = [InputEditor new];
        editor.title           = @"文本 (不超过5000字)";
        editor.key             = @"text";
        editor.editorViewClass = TextInputEditorView.class;
        [array addObject:editor];
    }
    
    return array;
}

- (ItemsStyleEditManager *)editManager {
    
    ItemsStyleEditManager *manager = [ItemsStyleEditManager managerWithWeakObject:self];
    
    {
        // 文本
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"文本"];
        [manager.headers addObject:header];
        
        {
            // 颜色
            StyleEditor *editor    = [StyleEditor new];
            editor.cellTitle      = @"颜色";
            editor.keys           = @[@"textColorHex"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 字体类型
            StyleEditor *editor    = [StyleEditor new];
            editor.cellTitle      = @"字体类型";
            editor.keys           = @[@"textFontName"];
            editor.setupViewClass = FontsPickerSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 大小
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"大小";
            editor.keys              = @[@"textFontSize"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"大小"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:10 to:40]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:10 to:40]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 对齐方式
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"对齐方式";
            editor.keys              = @[@"textAlign"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"对齐方式"];
            editor.pickerViewValuesRanges      = @[Values.TextAlign[CSS]];
            editor.pickerViewValuesShowStrings = @[Values.TextAlign[CH]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 斜体
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"斜体";
            editor.keys              = @[@"italic"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"斜体"];
            editor.pickerViewValuesRanges      = @[Values.Italic[EN]];
            editor.pickerViewValuesShowStrings = @[Values.Italic[CH]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 线条
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"线条";
            editor.keys              = @[@"decorationLine"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"可见度"];
            editor.pickerViewValuesRanges      = @[Values.DecorationLine[EN]];
            editor.pickerViewValuesShowStrings = @[Values.DecorationLine[CH]];
            
            [header.editors addObject:editor];
        }
    }
    
    {
        // 距离
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"距离"];
        [manager.headers addObject:header];
        
        {
            // 首行缩进
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"首行缩进";
            editor.keys              = @[@"textIndent"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"首行缩进"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:0 to:100]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:0 to:100]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 行间距
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"行间距";
            editor.keys              = @[@"lineHeight"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"行间距"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:0 to:50]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:0 to:50]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 段落间距
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"段落间距";
            editor.keys              = @[@"paramHeight"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"段落间距"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:0 to:100]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:0 to:100]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 外部上下间距
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"外部上下间距";
            editor.keys              = @[@"outerTopGap", @"outerBottomGap"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"外部上间距", @"外部下间距"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:0 to:100], [Values valuesFrom:0 to:100]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:0 to:100], [Values stringsFrom:0 to:100]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 外部左右间距
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"外部左右间距";
            editor.keys              = @[@"outerLeftGap", @"outerRightGap"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"外部左间距", @"外部右间距"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:0 to:100], [Values valuesFrom:0 to:100]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:0 to:100], [Values stringsFrom:0 to:100]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 内部上下间距
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"内部上下间距";
            editor.keys              = @[@"innerTopGap", @"innerBottomGap"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"内部上间距", @"内部下间距"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:0 to:100], [Values valuesFrom:0 to:100]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:0 to:100], [Values stringsFrom:0 to:100]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 内部左右间距
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"内部左右间距";
            editor.keys              = @[@"innerLeftGap", @"innerRightGap"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"内部左间距", @"内部右间距"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:0 to:100], [Values valuesFrom:0 to:100]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:0 to:100], [Values stringsFrom:0 to:100]];
            
            [header.editors addObject:editor];
        }
    }
    
    {
        // 线条
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"线条"];
        [manager.headers addObject:header];
        
        {
            // 线条颜色
            StyleEditor *editor    = [StyleEditor new];
            editor.cellTitle      = @"线条颜色";
            editor.keys           = @[@"lineColorHex"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 线条可见度
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"线条可见度";
            editor.keys              = @[@"lineColorHexAlpha"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"可见度"];
            editor.pickerViewValuesRanges      = @[Values.AlphaValueRanges];
            editor.pickerViewValuesShowStrings = @[Values.AlphaValueRangeStrings];
            
            [header.editors addObject:editor];
        }
        
        {
            // 线条宽度
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"线条宽度";
            editor.keys              = @[@"lineWidth"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"线条宽度"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:3 to:30]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:3 to:30]];
            
            [header.editors addObject:editor];
        }
    }
    
    {
        // 背景
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"背景"];
        [manager.headers addObject:header];
        
        {
            // 背景色
            StyleEditor *editor    = [StyleEditor new];
            editor.cellTitle      = @"背景色";
            editor.keys           = @[@"backgroundColorHex"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 背景色可见度
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"背景色可见度";
            editor.keys              = @[@"backgroundColorHexAlpha"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"可见度"];
            editor.pickerViewValuesRanges      = @[Values.AlphaValueRanges];
            editor.pickerViewValuesShowStrings = @[Values.AlphaValueRangeStrings];
            
            [header.editors addObject:editor];
        }
    }
    
    return manager;
}

#pragma mark - Objects

- (NSArray<EncodeImageObject *> *)imageObjects {
    
    return nil;
}

- (NSDictionary<NSString *,NSArray<EncodeImageObject *> *> *)key_imageObjects {
    
    return nil;
}

+ (instancetype)defalutObject {
    
    Block_paragraph_quote_1 *item = [Block_paragraph_quote_1 new];
    
    // cell相关
    item.cellReuseId     = @"Edit_paragraph_1_Cell";
    item.cellClassString = @"Edit_paragraph_1_Cell";
    
    // 当前类
    item.text         = @"";
    item.textColorHex = @"#848482";
    item.textFontSize = @(15);
    item.textFontName = @"PingFangSC-Thin";
    item.textAlign    = @"tal";
    
    item.lineWidth         = @(6);
    item.lineColorHex      = @"#D1D0CE";
    item.lineColorHexAlpha = @(0.2);
    
    item.outerTopGap    = @(15);
    item.outerRightGap  = @(60);
    item.outerBottomGap = @(15);
    item.outerLeftGap   = @(60);
    
    item.innerTopGap    = @(10);
    item.innerRightGap  = @(20);
    item.innerBottomGap = @(10);
    item.innerLeftGap   = @(15);
    
    item.lineHeight     = @(24);
    item.paramHeight    = @(15);
    item.textIndent     = @(0);
    item.italic         = @"normal";
    item.decorationLine = @"none";
    
    item.backgroundColorHex      = @"#E5E4E2";
    item.backgroundColorHexAlpha = @(0.2);
    
    return item;
}

#pragma mark - Style

- (instancetype)currentStyleObject {
    
    Block_paragraph_quote_1 *object = (Block_paragraph_quote_1 *)[BaseBlockItem decodeWithData:self.encodeData];
    
    // 当前类属性输入置空
    object.text = nil;
    
    return object;
}

- (void)useStyleObject:(id)styleObject {
    
    Block_paragraph_quote_1 *style = styleObject;
    
    self.textColorHex = style.textColorHex;
    self.textFontSize = style.textFontSize;
    self.textFontName = style.textFontName;
    self.textAlign    = style.textAlign;
    
    self.lineWidth         = style.lineWidth;
    self.lineColorHex      = style.lineColorHex;
    self.lineColorHexAlpha = style.lineColorHexAlpha;
    
    self.outerTopGap    = style.outerTopGap;
    self.outerRightGap  = style.outerRightGap;
    self.outerBottomGap = style.outerBottomGap;
    self.outerLeftGap   = style.outerLeftGap;
    
    self.innerTopGap    = style.innerTopGap;
    self.innerRightGap  = style.innerRightGap;
    self.innerBottomGap = style.innerBottomGap;
    self.innerLeftGap   = style.innerLeftGap;
    
    self.lineHeight     = style.lineHeight;
    self.paramHeight    = style.paramHeight;
    self.textIndent     = style.textIndent;
    self.italic         = style.italic;
    self.decorationLine = style.decorationLine;
    
    self.backgroundColorHex      = style.backgroundColorHex;
    self.backgroundColorHexAlpha = style.backgroundColorHexAlpha;
}

#pragma mark - Html

- (NSString *)htmlString {
    
    NSMutableString *div = [NSMutableString string];
    
    [div appendFormat:@"<div %@ %@ %@>",
     _html_id(self.itemIdString),
     _html_class(FmtStr(@"%@", self.textAlign)),
     _html_style(FmtStr(@"border-left: %@px solid %@; margin: %@px %@px %@px %@px; background-color: %@; padding: %@px 0px %@px 0px; font: %@ 400 %@px/%@px %@; text-indent: %@px; text-decoration: %@; color: %@;",
                  self.lineWidth,
                  [self RGBAWithHex:self.lineColorHex alpha:self.lineColorHexAlpha],
                  self.outerTopGap,
                  self.outerRightGap,
                  self.outerBottomGap,
                  self.outerLeftGap,
                  [self RGBAWithHex:self.backgroundColorHex alpha:self.backgroundColorHexAlpha],
                  self.innerTopGap,
                  self.innerBottomGap,
                  self.italic,
                  self.textFontSize,
                  self.lineHeight,
                  self.textFontName,
                  self.textIndent,
                  self.decorationLine,
                  self.textColorHex))];
    
    NSArray <NSString *> *params = [self.text componentsSeparatedByString:@"\n"];
    [params enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (params.count - 1 == idx) {
            
            [div appendFormat:@"<p %@ %@ %@>%@</p>",
             _html_tag(FmtStr(@"last")),
             _html_class(FmtStr(@" ")),
             _html_style(FmtStr(@"padding: 0px %@px 0px %@px;", self.innerRightGap, self.innerLeftGap)),
             obj];
            
        } else {
            
            [div appendFormat:@"<p %@ %@ %@>%@</p>",
             _html_tag(FmtStr(@"normal")),
             _html_class(FmtStr(@" ")),
             _html_style(FmtStr(@"padding: 0px %@px %@px %@px;", self.innerRightGap, self.paramHeight, self.innerLeftGap)),
             obj];
        }
    }];
    
    [div appendFormat:@"</div>"];
    
    return div;
}

- (NSString *)jsonConfigWithDebug:(BOOL)debug {
    
    JSConfigManager *manager = [JSConfigManager managerWithClassName:debug ? FmtStr(@"%@ showDebug", self.textAlign) : FmtStr(@"%@", self.textAlign)
                                                               style:FmtStr(@"border-left: %@px solid %@; margin: %@px %@px %@px %@px; background-color: %@; padding: %@px 0px %@px 0px; font: %@ 400 %@px/%@px %@; text-indent: %@px; text-decoration: %@; color: %@;",
                                                                      self.lineWidth,
                                                                      [self RGBAWithHex:self.lineColorHex alpha:self.lineColorHexAlpha],
                                                                      self.outerTopGap,
                                                                      self.outerRightGap,
                                                                      self.outerBottomGap,
                                                                      self.outerLeftGap,
                                                                      [self RGBAWithHex:self.backgroundColorHex alpha:self.backgroundColorHexAlpha],
                                                                      self.innerTopGap,
                                                                      self.innerBottomGap,
                                                                      self.italic,
                                                                      self.textFontSize,
                                                                      self.lineHeight,
                                                                      self.textFontName,
                                                                      self.textIndent,
                                                                      self.decorationLine,
                                                                      self.textColorHex)];
    
    NSArray <NSString *> *params = [self.text componentsSeparatedByString:@"\n"];
    
    if (params.count == 1) {
        
        [manager.subs addObject:jsConfig(FmtStr(@"last"), @" ", FmtStr(@"padding: 0px %@px 0px %@px;", self.innerRightGap, self.innerLeftGap))];
        
    } else if (params.count > 1) {
        
        [manager.subs addObject:jsConfig(FmtStr(@"normal"), @" ", FmtStr(@"padding: 0px %@px %@px %@px;", self.innerRightGap, self.paramHeight, self.innerLeftGap))];
        
        [manager.subs addObject:jsConfig(FmtStr(@"last"), @" ", FmtStr(@"padding: 0px %@px 0px %@px;", self.innerRightGap, self.innerLeftGap))];
    }
    
    return manager.config.toJSONString;
}

#pragma mark - Coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [self autoEncodePropertiesWithCoder:aCoder class:Block_paragraph_quote_1.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:Block_paragraph_quote_1.class];
    }
    
    return self;
}

+ (NSArray<NSString *> *)autoEncodePropertyKeys {
    
    return @[@"text",
             @"textColorHex",
             @"textFontSize",
             @"textFontName",
             @"textAlign",
             
             @"lineWidth",
             @"lineColorHex",
             @"lineColorHexAlpha",
             
             @"outerTopGap",
             @"outerRightGap",
             @"outerBottomGap",
             @"outerLeftGap",
             
             @"innerTopGap",
             @"innerRightGap",
             @"innerBottomGap",
             @"innerLeftGap",
             
             @"lineHeight",
             @"paramHeight",
             @"textIndent",
             @"italic",
             @"decorationLine",
             
             @"backgroundColorHex",
             @"backgroundColorHexAlpha"];
}

#pragma mark - 协议方法

- (NSString *)cell_text {
    
    return self.text;
}

#pragma mark - 协议方法(必须实现)

- (ArticleEditObjectType)cell_Type {
    
    return ArticleEditObjectType_Paragraph;
}

- (NSString *)cell_TypeText {
    
    return @"段落 - 引用";
}

@end
