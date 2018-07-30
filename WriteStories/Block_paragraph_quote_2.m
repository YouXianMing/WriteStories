//
//  Block_paragraph_quote_2.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Block_paragraph_quote_2.h"
#import "TextInputEditorView.h"
#import "FoldersManager.h"

@implementation Block_paragraph_quote_2

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
            editor.keys           = @[@"textHexColor"];
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
            // 可见度
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"可见度";
            editor.keys              = @[@"textOpacity"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"可见度"];
            editor.pickerViewValuesRanges      = @[Values.AlphaValueRanges];
            editor.pickerViewValuesShowStrings = @[Values.AlphaValueRangeStrings];
            
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
        // 引用
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"引用"];
        [manager.headers addObject:header];
        
        {
            // 样式
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"样式";
            editor.keys              = @[@"quoteType"];
            
            NSInteger count = FoldersManager.QuoteImages.count;
            
            NSMutableArray *values = [NSMutableArray array];
            NSMutableArray *titles = [NSMutableArray array];
            for (int i = 0; i < count; i++) {
                
                [values addObject:@(i)];
                [titles addObject:FmtStr(@"样式%d", i + 1)];
            }
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"样式"];
            editor.pickerViewValuesRanges      = @[values];
            editor.pickerViewValuesShowStrings = @[titles];
            
            [header.editors addObject:editor];
        }
        
        {
            // 可见度
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"可见度";
            editor.keys              = @[@"quoteAlpha"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"可见度"];
            editor.pickerViewValuesRanges      = @[Values.AlphaValueRanges];
            editor.pickerViewValuesShowStrings = @[Values.AlphaValueRangeStrings];
            
            [header.editors addObject:editor];
        }
        
        {
            // 比例
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"比例";
            editor.keys              = @[@"quoteScale"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"比例"];
            editor.pickerViewValuesRanges      = @[Values.ScaleValueRanges];
            editor.pickerViewValuesShowStrings = @[Values.ScaleValueRangeStrings];
            
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
            editor.keys              = @[@"textTopGap", @"textBottomGap"];
            
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
            editor.keys              = @[@"textLeftGap", @"textRightGap"];
            
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
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:0 to:15], [Values valuesFrom:0 to:15]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:0 to:15], [Values stringsFrom:0 to:15]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 内部左右间距
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"内部左右间距";
            editor.keys              = @[@"innerLeftGap", @"innerRightGap"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"内部左间距", @"内部右间距"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:0 to:15], [Values valuesFrom:0 to:15]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:0 to:15], [Values stringsFrom:0 to:15]];
            
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
    
    Block_paragraph_quote_2 *item = [Block_paragraph_quote_2 new];
    
    // cell相关
    item.cellReuseId     = @"Edit_paragraph_1_Cell";
    item.cellClassString = @"Edit_paragraph_1_Cell";
    
    // 当前类
    item.text = @"";
    
    item.textFontName  = @"PingFangSC-Light";
    item.textHexColor  = @"#6d6968";
    item.textAlign     = @"tal";
    item.textFontSize  = @(16);
    item.textOpacity   = @(1);
    
    item.textTopGap    = @(15);
    item.textRightGap  = @(60);
    item.textBottomGap = @(15);
    item.textLeftGap   = @(60);
    
    item.innerTopGap    = @(0);
    item.innerRightGap  = @(0);
    item.innerBottomGap = @(0);
    item.innerLeftGap   = @(0);
    
    item.lineHeight  = @(25);
    item.paramHeight = @(10);
    item.textIndent  = @(0);
    item.italic      = @"normal";
    
    item.decorationLine = @"none";
    
    item.quoteType  = @(0);
    item.quoteAlpha = @(0.2);
    item.quoteScale = @(1.f);
    
    return item;
}

#pragma mark - Style

- (instancetype)currentStyleObject {
    
    Block_paragraph_quote_2 *object = (Block_paragraph_quote_2 *)[BaseBlockItem decodeWithData:self.encodeData];
    
    // 当前类属性输入置空
    object.text = nil;
    
    return object;
}

- (void)useStyleObject:(id)styleObject {
    
    Block_paragraph_quote_2 *style = styleObject;
    
    // 当前类属性
    self.textFontName  = style.textFontName;
    self.textHexColor  = style.textHexColor;
    self.textAlign     = style.textAlign;
    self.textFontSize  = style.textFontSize;
    self.textOpacity   = style.textOpacity;
    
    self.textTopGap    = style.textTopGap;
    self.textRightGap  = style.textRightGap;
    self.textBottomGap = style.textBottomGap;
    self.textLeftGap   = style.textLeftGap;
    
    self.innerTopGap    = style.innerTopGap;
    self.innerRightGap  = style.innerRightGap;
    self.innerBottomGap = style.innerBottomGap;
    self.innerLeftGap   = style.innerLeftGap;
    
    self.lineHeight  = style.lineHeight;
    self.paramHeight = style.paramHeight;
    self.textIndent  = style.textIndent;
    self.italic      = style.italic;
    
    self.decorationLine = style.decorationLine;
    
    self.quoteType  = style.quoteType;
    self.quoteAlpha = style.quoteAlpha;
    self.quoteScale = style.quoteScale;
}

#pragma mark - Html

- (NSString *)htmlString {
    
    NSMutableString *div = [NSMutableString string];
    
    [div appendFormat:@"<div %@ %@ %@>",
     _html_id(self.itemIdString),
     _html_class(FmtStr(@"pr %@", self.textAlign)),
     _html_style(FmtStr(@"color : %@; margin: %@px %@px %@px %@px; text-indent: %@px; font: %@ 400 %@px/%@px %@; text-decoration: %@;",
                        [self RGBAWithHex:self.textHexColor alpha:self.textOpacity],
                        self.textTopGap,
                        self.textRightGap,
                        self.textBottomGap,
                        self.textLeftGap,
                        self.textIndent,
                        self.italic,
                        self.textFontSize,
                        self.lineHeight,
                        self.textFontName,
                        self.decorationLine))];
    
    QuoteImage *quote = FoldersManager.QuoteImages[self.quoteType.integerValue];
    quote.scale       = self.quoteScale.floatValue * 0.33;
    
    [div appendFormat:@"<div %@ %@ %@></div>",
     _html_tag(@"quote"),
     _html_class(@"pa h_100 w_100 z_n1 bsbb bss"),
     _html_style(FmtStr(@"-webkit-border-image: url(../../../images/quoteImages/%@) %.f %.f %.f %.f repeat; border-width: %.fpx %.fpx %.fpx %.fpx; opacity: %@;",
                        quote.imageName,
                        quote.cutEdge.top, quote.cutEdge.right, quote.cutEdge.bottom, quote.cutEdge.left,
                        quote.scaleCutEdge.top, quote.scaleCutEdge.right, quote.scaleCutEdge.bottom, quote.scaleCutEdge.left, self.quoteAlpha))];
    
    NSArray <NSString *> *params = [self.text componentsSeparatedByString:@"\n"];
    
    if /* 只有一段 */ (params.count == 1) {
        
        // 只有一段
        [div appendFormat:@"<p %@ %@ %@>%@</p>",
         _html_tag(FmtStr(@"first")),
         _html_class(FmtStr(@" ")),
         _html_style(FmtStr(@"padding: %.fpx %.fpx %.fpx %.fpx;",
                            quote.scaleAreaEdge.top + self.innerTopGap.floatValue,
                            quote.scaleAreaEdge.right + self.innerRightGap.floatValue,
                            quote.scaleAreaEdge.bottom + self.innerBottomGap.floatValue,
                            quote.scaleAreaEdge.left + self.innerLeftGap.floatValue)),
         params.firstObject];
        
    } /* 仅有两段 */ else if (params.count == 2) {
        
        // 第一段
        [div appendFormat:@"<p %@ %@ %@>%@</p>",
         _html_tag(FmtStr(@"first")),
         _html_class(FmtStr(@" ")),
         _html_style(FmtStr(@"padding: %.fpx %.fpx %@px %.fpx;",
                            quote.scaleAreaEdge.top + self.innerTopGap.floatValue,
                            quote.scaleAreaEdge.right + self.innerRightGap.floatValue,
                            self.paramHeight,
                            quote.scaleAreaEdge.left + self.innerLeftGap.floatValue)),
         params.firstObject];
        
        // 最后一段
        [div appendFormat:@"<p %@ %@ %@>%@</p>",
         _html_tag(FmtStr(@"last")),
         _html_class(FmtStr(@" ")),
         _html_style(FmtStr(@"padding: 0px %.fpx %.fpx %.fpx;",
                            quote.scaleAreaEdge.right + self.innerRightGap.floatValue,
                            quote.scaleAreaEdge.bottom + self.innerBottomGap.floatValue,
                            quote.scaleAreaEdge.left + self.innerLeftGap.floatValue)),
         params.lastObject];
        
    } /* 多于两段 */ else if (params.count > 2) {
        
        [params enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx == 0) {
                
                // 第一段
                [div appendFormat:@"<p %@ %@ %@>%@</p>",
                 _html_tag(FmtStr(@"first")),
                 _html_class(FmtStr(@" ")),
                 _html_style(FmtStr(@"padding: %.fpx %.fpx %@px %.fpx;",
                                    quote.scaleAreaEdge.top + self.innerTopGap.floatValue,
                                    quote.scaleAreaEdge.right + self.innerRightGap.floatValue,
                                    self.paramHeight,
                                    quote.scaleAreaEdge.left + self.innerLeftGap.floatValue)),
                 obj];
                
            } else if (idx == params.count - 1) {
                
                // 最后一段
                [div appendFormat:@"<p %@ %@ %@>%@</p>",
                 _html_tag(FmtStr(@"last")),
                 _html_class(FmtStr(@" ")),
                 _html_style(FmtStr(@"padding: 0px %.fpx %.fpx %.fpx;",
                                    quote.scaleAreaEdge.right + self.innerRightGap.floatValue,
                                    quote.scaleAreaEdge.bottom + self.innerBottomGap.floatValue,
                                    quote.scaleAreaEdge.left + self.innerLeftGap.floatValue)),
                 obj];
                
            } else {
                
                // 中间段落
                [div appendFormat:@"<p %@ %@ %@>%@</p>",
                 _html_tag(FmtStr(@"center")),
                 _html_class(FmtStr(@" ")),
                 _html_style(FmtStr(@"padding: 0px %.fpx %@px %.fpx;",
                                    quote.scaleAreaEdge.right + self.innerRightGap.floatValue,
                                    self.paramHeight,
                                    quote.scaleAreaEdge.left + self.innerLeftGap.floatValue)),
                 obj];
            }
        }];
        
    }
    
    [div appendFormat:@"</div>"];
    
    return div;
}

- (NSString *)jsonConfigWithDebug:(BOOL)debug {
    
    JSConfigManager *manager = [JSConfigManager managerWithClassName:debug ? FmtStr(@"pr %@ showDebug", self.textAlign) : FmtStr(@"pr %@", self.textAlign)
                                                               style:FmtStr(@"color : %@; margin: %@px %@px %@px %@px; text-indent: %@px; font: %@ 400 %@px/%@px %@; text-decoration: %@;",
                                                                            [self RGBAWithHex:self.textHexColor alpha:self.textOpacity],
                                                                            self.textTopGap,
                                                                            self.textRightGap,
                                                                            self.textBottomGap,
                                                                            self.textLeftGap,
                                                                            self.textIndent,
                                                                            self.italic,
                                                                            self.textFontSize,
                                                                            self.lineHeight,
                                                                            self.textFontName,
                                                                            self.decorationLine)];
    
    QuoteImage *quote = FoldersManager.QuoteImages[self.quoteType.integerValue];
    quote.scale       = self.quoteScale.floatValue * 0.33;
    
    [manager.subs addObject:jsConfig(FmtStr(@"quote"),
                                     FmtStr(@"pa h_100 w_100 z_n1 bsbb bss"),
                                     FmtStr(@"-webkit-border-image: url(../../../images/quoteImages/%@) %.f %.f %.f %.f repeat; border-width: %.fpx %.fpx %.fpx %.fpx; opacity: %@;",
                                            quote.imageName,
                                            quote.cutEdge.top, quote.cutEdge.right, quote.cutEdge.bottom, quote.cutEdge.left,
                                            quote.scaleCutEdge.top, quote.scaleCutEdge.right, quote.scaleCutEdge.bottom, quote.scaleCutEdge.left, self.quoteAlpha))];
    
    NSArray <NSString *> *params = [self.text componentsSeparatedByString:@"\n"];
    if (params.count == 1) {
        
        [manager.subs addObject:jsConfig(FmtStr(@"first"),
                                         FmtStr(@" "),
                                         FmtStr(@"padding: %.fpx %.fpx %.fpx %.fpx;",
                                                quote.scaleAreaEdge.top + self.innerTopGap.floatValue,
                                                quote.scaleAreaEdge.right + self.innerRightGap.floatValue,
                                                quote.scaleAreaEdge.bottom + self.innerBottomGap.floatValue,
                                                quote.scaleAreaEdge.left + self.innerLeftGap.floatValue))];
        
    } else if (params.count == 2) {
        
        [manager.subs addObject:jsConfig(FmtStr(@"first"),
                                         FmtStr(@" "),
                                         FmtStr(@"padding: %.fpx %.fpx %@px %.fpx;",
                                                quote.scaleAreaEdge.top + self.innerTopGap.floatValue,
                                                quote.scaleAreaEdge.right + self.innerRightGap.floatValue,
                                                self.paramHeight,
                                                quote.scaleAreaEdge.left + self.innerLeftGap.floatValue))];
        
        [manager.subs addObject:jsConfig(FmtStr(@"last"),
                                         FmtStr(@" "),
                                         FmtStr(@"padding: 0px %.fpx %.fpx %.fpx;",
                                                quote.scaleAreaEdge.right + self.innerRightGap.floatValue,
                                                quote.scaleAreaEdge.bottom + self.innerBottomGap.floatValue,
                                                quote.scaleAreaEdge.left + self.innerLeftGap.floatValue))];
        
    } else if (params.count > 2) {
        
        [manager.subs addObject:jsConfig(FmtStr(@"first"),
                                         FmtStr(@" "),
                                         FmtStr(@"padding: %.fpx %.fpx %@px %.fpx;",
                                                quote.scaleAreaEdge.top + self.innerTopGap.floatValue,
                                                quote.scaleAreaEdge.right + self.innerRightGap.floatValue,
                                                self.paramHeight,
                                                quote.scaleAreaEdge.left + self.innerLeftGap.floatValue))];
        
        [manager.subs addObject:jsConfig(FmtStr(@"center"),
                                         FmtStr(@" "),
                                         FmtStr(@"padding: 0px %.fpx %@px %.fpx;",
                                                quote.scaleCutEdge.right + self.innerRightGap.floatValue,
                                                self.paramHeight,
                                                quote.scaleCutEdge.left + self.innerLeftGap.floatValue))];
        
        [manager.subs addObject:jsConfig(FmtStr(@"last"),
                                         FmtStr(@" "),
                                         FmtStr(@"padding: 0px %.fpx %.fpx %.fpx;",
                                                quote.scaleAreaEdge.right + self.innerRightGap.floatValue,
                                                quote.scaleAreaEdge.bottom + self.innerBottomGap.floatValue,
                                                quote.scaleAreaEdge.left + self.innerLeftGap.floatValue))];
    }
    
    return manager.config.toJSONString;
}

#pragma mark - Coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [self autoEncodePropertiesWithCoder:aCoder class:Block_paragraph_quote_2.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:Block_paragraph_quote_2.class];
    }
    
    return self;
}

+ (NSArray<NSString *> *)autoEncodePropertyKeys {
    
    return @[@"text",
             @"textFontName",
             @"textHexColor",
             @"textAlign",
             @"textFontSize",
             @"textOpacity",
             
             @"textTopGap",
             @"textRightGap",
             @"textBottomGap",
             @"textLeftGap",
             
             @"innerTopGap",
             @"innerRightGap",
             @"innerBottomGap",
             @"innerLeftGap",
             
             @"lineHeight",
             @"paramHeight",
             @"textIndent",
             @"italic",
             
             @"decorationLine",
             
             @"quoteType",
             @"quoteAlpha",
             @"quoteScale"];
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
