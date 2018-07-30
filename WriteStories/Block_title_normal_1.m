//
//  Block_title_normal_1.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Block_title_normal_1.h"
#import "FieldInputEditorView.h"

@implementation Block_title_normal_1

#pragma mark - Editors

- (NSArray<InputEditor *> *)inputEditors {
    
    NSMutableArray *array = [NSMutableArray array];
    
    {
        InputEditor *editor    = [InputEditor new];
        editor.title           = @"文章标题";
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
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:20 to:50]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:20 to:50]];
            
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
            editor.keys              = @[@"titleAlign"];
            
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
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:0 to:400], [Values valuesFrom:0 to:400]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:0 to:400], [Values stringsFrom:0 to:400]];
            
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
    
    Block_title_normal_1 *item = [Block_title_normal_1 new];
    
    // cell相关
    item.cellReuseId     = @"Edit_title_1_Cell";
    item.cellClassString = @"Edit_title_1_Cell";
    
    // 当前类
    item.title          = @"";
    item.titleFontName  = @"PingFangSC-Semibold";
    item.titleHexColor  = @"#000000";
    item.titleAlign     = @"tac";
    item.titleFontSize  = @(25);
    item.titleOpacity   = @(1.f);
    item.titleTopGap    = @(50);
    item.titleRightGap  = @(20);
    item.titleBottomGap = @(50);
    item.titleLeftGap   = @(20);
    
    return item;
}

#pragma mark - Style

- (instancetype)currentStyleObject {
    
    Block_title_normal_1 *object = (Block_title_normal_1 *)[BaseBlockItem decodeWithData:self.encodeData];
    
    // 当前类属性输入置空
    object.title = nil;
    
    return object;
}

- (void)useStyleObject:(id)styleObject {
    
    Block_title_normal_1 *style = styleObject;
    
    // 当前类属性
    self.titleFontName  = style.titleFontName;
    self.titleHexColor  = style.titleHexColor;
    self.titleAlign     = style.titleAlign;
    self.titleFontSize  = style.titleFontSize;
    self.titleOpacity   = style.titleOpacity;
    self.titleTopGap    = style.titleTopGap;
    self.titleRightGap  = style.titleRightGap;
    self.titleBottomGap = style.titleBottomGap;
    self.titleLeftGap   = style.titleLeftGap;
}

#pragma mark - Html

- (NSString *)htmlString {
    
    NSMutableString *div = [NSMutableString string];
    
    [div appendFormat:@"<div %@ %@ %@>",
     _html_id(self.itemIdString),
     _html_class(FmtStr(@" ")),
     _html_style(FmtStr(@"padding: %@px %@px %@px %@px;", self.titleTopGap, self.titleRightGap, self.titleBottomGap, self.titleLeftGap))];
    
    [div appendFormat:@"<p %@ %@ %@>%@</p>",
     _html_tag(FmtStr(@"title")),
     _html_class(FmtStr(@"%@", self.titleAlign)),
     _html_style(FmtStr(@"font: normal 400 %@px %@; color: %@;", self.titleFontSize, self.titleFontName, [self RGBAWithHex:self.titleHexColor alpha:self.titleOpacity])),
     self.title];
    
    [div appendString:@"</div>"];
    
    return div;
}

- (NSString *)jsonConfigWithDebug:(BOOL)debug {
    
    JSConfigManager *manager = [JSConfigManager managerWithClassName:debug ? @"showDebug" : @" "
                                                               style:FmtStr(@"padding: %@px %@px %@px %@px;", self.titleTopGap, self.titleRightGap, self.titleBottomGap, self.titleLeftGap)];
    [manager.subs addObject:jsConfig(FmtStr(@"title"),
                                     FmtStr(@"%@", self.titleAlign),
                                     FmtStr(@"font: normal 400 %@px %@; color: %@;",
                                            self.titleFontSize, self.titleFontName, [self RGBAWithHex:self.titleHexColor alpha:self.titleOpacity]))];
    
    return manager.config.toJSONString;
}

#pragma mark - Coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [self autoEncodePropertiesWithCoder:aCoder class:Block_title_normal_1.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:Block_title_normal_1.class];
    }
    
    return self;
}

+ (NSArray<NSString *> *)autoEncodePropertyKeys {
    
    return @[@"title",
             @"titleFontName",
             @"titleHexColor",
             @"titleAlign",
             @"titleFontSize",
             @"titleOpacity",
             @"titleTopGap",
             @"titleRightGap",
             @"titleBottomGap",
             @"titleLeftGap"];
}

#pragma mark - 协议方法

- (NSString *)cell_text {
    
    return self.title;
}

#pragma mark - 协议方法(必须实现)

- (ArticleEditObjectType)cell_Type {
    
    return ArticleEditObjectType_Title;
}

- (NSString *)cell_TypeText {
    
    return @"标题 - 普通";
}

@end
