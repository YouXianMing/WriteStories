//
//  Block_subtitle_colorblock_3.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/10.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Block_subtitle_colorblock_3.h"
#import "FieldInputEditorView.h"

@implementation Block_subtitle_colorblock_3

#pragma mark - Editors

- (NSArray<InputEditor *> *)inputEditors {
    
    NSMutableArray *array = [NSMutableArray array];
    
    {
        InputEditor *editor    = [InputEditor new];
        editor.title           = @"小标题";
        editor.key             = @"title";
        editor.editorViewClass = FieldInputEditorView.class;
        [array addObject:editor];
    }
    
    return array;
}

- (ItemsStyleEditManager *)editManager {
    
    ItemsStyleEditManager *manager = [ItemsStyleEditManager managerWithWeakObject:self];
    
    {
        // 标题
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"标题"];
        [manager.headers addObject:header];
        
        {
            // 颜色
            StyleEditor *editor    = [StyleEditor new];
            editor.cellTitle      = @"颜色";
            editor.keys           = @[@"titleHexColor"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 字体类型
            StyleEditor *editor    = [StyleEditor new];
            editor.cellTitle      = @"字体类型";
            editor.keys           = @[@"titleFontName"];
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
            editor.keys              = @[@"titleOpacity"];
            
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
    }
    
    {
        // 距离
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"距离"];
        [manager.headers addObject:header];
        
        {
            // 上下间距
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"上下间距";
            editor.keys              = @[@"titleTopGap", @"titleBottomGap"];
            
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
            editor.keys              = @[@"titleLeftGap", @"titleRightGap"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"左间距", @"右间距"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:0 to:100], [Values valuesFrom:0 to:100]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:0 to:100], [Values stringsFrom:0 to:100]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 线条左下间距
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"线条左下间距";
            editor.keys              = @[@"wordGap"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"线条左右间距"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:0 to:50]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:0 to:50]];
            
            [header.editors addObject:editor];
        }
    }
    
    {
        // 左边线条
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"左边线条"];
        [manager.headers addObject:header];
        
        {
            // 宽度
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"宽度";
            editor.keys              = @[@"leftBorderWidth"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"线条宽度"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:2 to:30]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:2 to:30]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 颜色
            StyleEditor *editor    = [StyleEditor new];
            editor.cellTitle      = @"颜色";
            editor.keys           = @[@"leftBorderColor"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 类型
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"类型";
            editor.keys              = @[@"leftBorderStyle"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"类型"];
            editor.pickerViewValuesRanges      = @[Values.BolderStyle[EN]];
            editor.pickerViewValuesShowStrings = @[Values.BolderStyle[CH]];
            
            [header.editors addObject:editor];
        }
    }
    
    {
        // 底部线条
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"底部线条"];
        [manager.headers addObject:header];
        
        {
            // 宽度
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"宽度";
            editor.keys              = @[@"rightBorderWidth"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"线条宽度"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:2 to:30]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:2 to:30]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 颜色
            StyleEditor *editor    = [StyleEditor new];
            editor.cellTitle      = @"颜色";
            editor.keys           = @[@"rightBorderColor"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 类型
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"类型";
            editor.keys              = @[@"rightBorderStyle"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"类型"];
            editor.pickerViewValuesRanges      = @[Values.BolderStyle[EN]];
            editor.pickerViewValuesShowStrings = @[Values.BolderStyle[CH]];
            
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
    
    Block_subtitle_colorblock_3 *item = [Block_subtitle_colorblock_3 new];
    
    // cell相关
    item.cellReuseId     = @"Edit_subTitle_1_Cell";
    item.cellClassString = @"Edit_subTitle_1_Cell";
    
    // 当前类
    item.textAlign      = @"tal";
    
    item.title          = @"";
    item.titleFontName  = @"PingFangSC-Medium";
    item.titleHexColor  = @"#000000";
    item.titleFontSize  = @(22);
    item.titleOpacity   = @(1.f);
    item.titleTopGap    = @(15);
    item.titleRightGap  = @(15);
    item.titleBottomGap = @(15);
    item.titleLeftGap   = @(15);
    
    item.wordGap = @(5);
    
    item.leftBorderWidth = @(5);
    item.leftBorderColor = @"#ff0000";
    item.leftBorderStyle = @"solid";
    
    item.rightBorderWidth = @(2);
    item.rightBorderColor = @"#ff0000";
    item.rightBorderStyle = @"solid";
    
    return item;
}

#pragma mark - Style

- (instancetype)currentStyleObject {
    
    Block_subtitle_colorblock_3 *object = (Block_subtitle_colorblock_3 *)[BaseBlockItem decodeWithData:self.encodeData];
    
    // 当前类属性输入置空
    object.title = nil;
    
    return object;
}

- (void)useStyleObject:(id)styleObject {
    
    Block_subtitle_colorblock_3 *style = styleObject;
    
    // 当前类属性
    self.textAlign = style.textAlign;
    
    self.titleFontName  = style.titleFontName;
    self.titleHexColor  = style.titleHexColor;
    self.titleFontSize  = style.titleFontSize;
    self.titleOpacity   = style.titleOpacity;
    self.titleTopGap    = style.titleTopGap;
    self.titleRightGap  = style.titleRightGap;
    self.titleBottomGap = style.titleBottomGap;
    self.titleLeftGap   = style.titleLeftGap;
    
    self.wordGap = style.wordGap;
    
    self.leftBorderWidth = style.leftBorderWidth;
    self.leftBorderColor = style.leftBorderColor;
    self.leftBorderStyle = style.leftBorderStyle;
    
    self.rightBorderWidth = style.rightBorderWidth;
    self.rightBorderColor = style.rightBorderColor;
    self.rightBorderStyle = style.rightBorderStyle;
}

#pragma mark - Html

- (NSString *)htmlString {
    
    NSMutableString *div = [NSMutableString string];
    
    [div appendFormat:@"<div %@ %@ %@>",
     _html_id(self.itemIdString),
     _html_class(FmtStr(@"wbl %@", self.textAlign)),
     _html_style([NSString stringWithFormat:@"padding: %@px %@px %@px %@px;;", self.titleTopGap, self.titleRightGap, self.titleBottomGap, self.titleLeftGap])];
    
    [div appendFormat:@"<span %@ %@ %@>%@</span>",
     _html_tag(@"title"),
     _html_class(@" "),
     _html_style(FmtStr(@"font: normal 400 %@px %@; color: %@; opacity: %@; border-left:%@px %@ %@; border-bottom: %@px %@ %@; padding: 0px %@px 0px %@px;",
                  self.titleFontSize, self.titleFontName, self.titleHexColor, self.titleOpacity, self.leftBorderWidth, self.leftBorderStyle, self.leftBorderColor,
                  self.rightBorderWidth, self.rightBorderStyle, self.rightBorderColor, self.wordGap, self.wordGap)),
     self.title];
    
    [div appendString:@"</div>"];
    
    return div;
}

- (NSString *)jsonConfigWithDebug:(BOOL)debug {
    
    
    JSConfigManager *manager = [JSConfigManager managerWithClassName:debug ? FmtStr(@"wbl %@ showDebug", self.textAlign) : FmtStr(@"wbl %@", self.textAlign)
                                                               style:FmtStr(@"padding: %@px %@px %@px %@px;", self.titleTopGap, self.titleRightGap, self.titleBottomGap, self.titleLeftGap)];
    [manager.subs addObject:jsConfig(@"title", @" ", [NSString stringWithFormat:@"font: normal 400 %@px %@; color: %@; opacity: %@; border-left:%@px %@ %@; border-bottom: %@px %@ %@; padding: 0px %@px 0px %@px;",
                                                self.titleFontSize, self.titleFontName, self.titleHexColor, self.titleOpacity, self.leftBorderWidth, self.leftBorderStyle, self.leftBorderColor,
                                                self.rightBorderWidth, self.rightBorderStyle, self.rightBorderColor, self.wordGap, self.wordGap])];
    
    return manager.config.toJSONString;
}

#pragma mark - Coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [self autoEncodePropertiesWithCoder:aCoder class:Block_subtitle_colorblock_3.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:Block_subtitle_colorblock_3.class];
    }
    
    return self;
}

+ (NSArray<NSString *> *)autoEncodePropertyKeys {
    
    return @[@"textAlign",
             
             @"title",
             @"titleFontName",
             @"titleHexColor",
             @"titleFontSize",
             @"titleOpacity",
             @"titleTopGap",
             @"titleRightGap",
             @"titleBottomGap",
             @"titleLeftGap",
             
             @"wordGap",
             
             @"leftBorderWidth",
             @"leftBorderColor",
             @"leftBorderStyle",
             
             @"rightBorderWidth",
             @"rightBorderColor",
             @"rightBorderStyle"];
}

#pragma mark - 协议方法

- (NSString *)cell_text {
    
    return self.title;
}

#pragma mark - 协议方法(必须实现)

- (ArticleEditObjectType)cell_Type {
    
    return ArticleEditObjectType_SubTitle;
}

- (NSString *)cell_TypeText {
    
    return @"小标题 - 色块";
}

@end
