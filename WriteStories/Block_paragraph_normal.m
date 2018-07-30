//
//  Block_paragraph_normal.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Block_paragraph_normal.h"
#import "TextInputEditorView.h"

@implementation Block_paragraph_normal

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
            // 上下间距
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"上下间距";
            editor.keys              = @[@"textTopGap", @"textBottomGap"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"上间距", @"下间距"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:0 to:100], [Values valuesFrom:0 to:100]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:0 to:100], [Values stringsFrom:0 to:100]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 左右间距
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"左右间距";
            editor.keys              = @[@"textLeftGap", @"textRightGap"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"左间距", @"右间距"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:0 to:100], [Values valuesFrom:0 to:100]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:0 to:100], [Values stringsFrom:0 to:100]];
            
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
    
    Block_paragraph_normal *item = [Block_paragraph_normal new];
    
    // cell相关
    item.cellReuseId     = @"Edit_paragraph_1_Cell";
    item.cellClassString = @"Edit_paragraph_1_Cell";
    
    // 当前类
    item.text = @"";
    
    item.textFontName  = @"PingFangSC-Light";
    item.textHexColor  = @"#000000";
    item.textAlign     = @"tal";
    item.textFontSize  = @(18);
    item.textOpacity   = @(1);
    
    item.textTopGap    = @(0);
    item.textRightGap  = @(15);
    item.textBottomGap = @(0);
    item.textLeftGap   = @(15);
    
    item.lineHeight  = @(28);
    item.paramHeight = @(10);
    item.textIndent  = @(0);
    item.italic      = @"normal";
    
    item.decorationLine = @"none";
    
    return item;
}

#pragma mark - Style

- (instancetype)currentStyleObject {
    
    Block_paragraph_normal *object = (Block_paragraph_normal *)[BaseBlockItem decodeWithData:self.encodeData];
    
    // 当前类属性输入置空
    object.text = nil;
    
    return object;
}

- (void)useStyleObject:(id)styleObject {
    
    Block_paragraph_normal *style = styleObject;
    
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
    
    self.lineHeight  = style.lineHeight;
    self.paramHeight = style.paramHeight;
    self.textIndent  = style.textIndent;
    self.italic      = style.italic;
    
    self.decorationLine = style.decorationLine;
}

#pragma mark - Html

- (NSString *)htmlString {
    
    NSMutableString *div = [NSMutableString string];
    
    [div appendFormat:@"<div %@ %@ %@>",
     _html_id(self.itemIdString),
     _html_class(FmtStr(@"%@", self.textAlign)),
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
    
    NSArray <NSString *> *params = [self.text componentsSeparatedByString:@"\n"];
    [params enumerateObjectsUsingBlock:^(NSString *string, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [div appendFormat:@"<p %@ %@ %@>%@</p>",
         _html_tag(FmtStr(@"param")),
         _html_class(FmtStr(@" ")),
         _html_style(FmtStr(@"padding-bottom: %@px;", self.paramHeight)),
         string];
    }];
    
    [div appendFormat:@"</div>"];
    
    return div;
}

- (NSString *)jsonConfigWithDebug:(BOOL)debug {
    
    JSConfigManager *manager = [JSConfigManager managerWithClassName:debug ? FmtStr(@"%@ showDebug", self.textAlign) : FmtStr(@"%@", self.textAlign)
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
    [manager.subs addObject:jsConfig(FmtStr(@"param"),
                                     FmtStr(@"%@", self.textAlign),
                                     FmtStr(@"padding-bottom: %@px;", self.paramHeight))];
    
    return manager.config.toJSONString;
}

#pragma mark - Coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [self autoEncodePropertiesWithCoder:aCoder class:Block_paragraph_normal.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:Block_paragraph_normal.class];
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
             
             @"lineHeight",
             @"paramHeight",
             @"textIndent",
             @"italic",
             
             @"decorationLine"];
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
    
    return @"段落 - 普通";
}

@end
