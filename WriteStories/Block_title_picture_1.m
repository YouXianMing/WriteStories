//
//  Block_title_picture_1.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/18.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Block_title_picture_1.h"
#import "FieldInputEditorView.h"

@implementation Block_title_picture_1

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
    
    {
        InputEditor *editor    = [InputEditor new];
        editor.title           = @"图片";
        editor.key             = @"image";
        editor.editorViewClass = BlockImageInputEditorView.class;
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
        
        {
            // 离图片底部间距
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"离图片底部间距";
            editor.keys              = @[@"titleBottomGap"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"间距"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:0 to:50]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:0 to:50]];
            
            [header.editors addObject:editor];
        }
    }
    
    {
        // 覆盖图层色块
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"覆盖图层色块"];
        [manager.headers addObject:header];
        
        {
            // 颜色
            StyleEditor *editor    = [StyleEditor new];
            editor.cellTitle      = @"颜色";
            editor.keys           = @[@"coverHexColor"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 可见度
            StyleEditor *editor       = [StyleEditor new];
            editor.cellTitle         = @"可见度";
            editor.keys              = @[@"coverHexColorAlpha"];
            
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
    
    return @[self.image];
}

- (NSDictionary<NSString *,NSArray<EncodeImageObject *> *> *)key_imageObjects {
    
    NSMutableArray *imageObjects = [NSMutableArray array];
    
    [imageObjects addObject:[EncodeImageObject bigImageWithScale:@"16:10" source:EncodeImageObjectSourceDefault imageName:@"styles_jpeg"]];
    [imageObjects addObject:[EncodeImageObject bigImageWithScale:@"16:9" source:EncodeImageObjectSourceDefault imageName:@"styles_jpeg"]];
    [imageObjects addObject:[EncodeImageObject bigImageWithScale:@"21:9" source:EncodeImageObjectSourceDefault imageName:@"styles_jpeg"]];
    
    return @{@"image" : imageObjects};
}

+ (instancetype)defalutObject {
    
    Block_title_picture_1 *item = [Block_title_picture_1 new];
    
    // cell相关
    item.cellReuseId     = @"Edit_title_2_Cell";
    item.cellClassString = @"Edit_title_2_Cell";
    
    // 当前类
    item.image                = [EncodeImageObject bigImageWithScale:@"16:9" source:EncodeImageObjectSourceDefault imageName:@"styles_jpeg"];
    item.topGap               = @(0);
    item.bottomGap            = @(10);
    
    item.coverHexColor      = @"#000000";
    item.coverHexColorAlpha = @(0.5);
    
    item.title          = @"";
    item.titleFontName  = @"PingFangSC-Semibold";
    item.titleHexColor  = @"#ffffff";
    item.titleAlign     = @"tac";
    item.titleFontSize  = @(25);
    item.titleBottomGap = @(20);
    
    return item;
}

#pragma mark - Style

- (instancetype)currentStyleObject {
    
    Block_title_picture_1 *object = (Block_title_picture_1 *)[BaseBlockItem decodeWithData:self.encodeData];
    
    // 当前类属性输入置空
    object.title = nil;
    object.image = nil;
    
    return object;
}

- (void)useStyleObject:(id)styleObject {
    
    Block_title_picture_1 *style = styleObject;
    
    // 当前类属性
    self.topGap    = style.topGap;
    self.bottomGap = style.bottomGap;
    
    self.coverHexColor      = style.coverHexColor;
    self.coverHexColorAlpha = style.coverHexColorAlpha;
    
    self.titleFontName  = style.titleFontName;
    self.titleHexColor  = style.titleHexColor;
    self.titleAlign     = style.titleAlign;
    self.titleFontSize  = style.titleFontSize;
    self.titleBottomGap = style.titleBottomGap;
}

#pragma mark - Html

- (NSString *)htmlString {
    
    NSMutableString *div = [NSMutableString string];

    [div appendFormat:@"<div %@ %@ %@>",
     _html_id(self.itemIdString),
     _html_class(FmtStr(@"pr ofh")),
     _html_style(FmtStr(@"margin: %@px 0px %@px 0px;", self.topGap, self.bottomGap))];
    
    [div appendFormat:@"<img %@ %@ %@ %@>",
     _html_tag(@"img"),
     _html_class(@"db ma"),
     _html_style(@"max-width: 100%;"),
     _html_src(FmtStr(@"./%@/block/%@", self.folderName, self.image.imageName))];
    
    [div appendFormat:@"<div %@ %@ %@></div>",
     _html_tag(@"cover"),
     _html_class(@"pa h_100 w_100"),
     _html_style(FmtStr(@"top: 0%%; background-color: %@;", [self RGBAWithHex:self.coverHexColor alpha:self.coverHexColorAlpha]))];
    
    [div appendFormat:@"<p %@ %@ %@>%@</p>",
     _html_tag(@"title"),
     _html_class(FmtStr(@"pa ma w_100 wbl %@", self.titleAlign)),
     _html_style(FmtStr(@"max-width: 90%%; left: 5%%; bottom: %@px; font: normal 400 %@px %@; color: %@;",
                        self.titleBottomGap, self.titleFontSize, self.titleFontName, self.titleHexColor)),
     self.title
     ];
    
    [div appendString:@"</div>"];
    
    return div;
}

- (NSString *)jsonConfigWithDebug:(BOOL)debug {
    
    JSConfigManager *manager = [JSConfigManager managerWithClassName:debug ? FmtStr(@"pr ofh showDebug") : FmtStr(@"pr ofh")
                                                               style:FmtStr(@"margin: %@px 0px %@px 0px;", self.topGap, self.bottomGap)];
    [manager.subs addObject:jsConfig(FmtStr(@"img"),
                                     FmtStr(@"db ma"),
                                     @"max-width: 100%;")];
    
    [manager.subs addObject:jsConfig(FmtStr(@"cover"),
                                     FmtStr(@"pa h_100 w_100"),
                                     FmtStr(@"top: 0%%; background-color: %@;", [self RGBAWithHex:self.coverHexColor alpha:self.coverHexColorAlpha]))];
    
    [manager.subs addObject:jsConfig(FmtStr(@"title"),
                                     FmtStr(@"pa ma w_100 wbl %@", self.titleAlign),
                                     FmtStr(@"max-width: 90%%; left: 5%%; bottom: %@px; font: normal 400 %@px %@; color: %@;",
                                            self.titleBottomGap, self.titleFontSize, self.titleFontName, self.titleHexColor))];
    
    return manager.config.toJSONString;
}

#pragma mark - Coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [self autoEncodePropertiesWithCoder:aCoder class:Block_title_picture_1.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:Block_title_picture_1.class];
    }
    
    return self;
}

+ (NSArray<NSString *> *)autoEncodePropertyKeys {
    
    return @[@"image",
             @"topGap",
             @"bottomGap",
             
             @"coverHexColor",
             @"coverHexColorAlpha",
             
             @"title",
             @"titleFontName",
             @"titleHexColor",
             @"titleAlign",
             @"titleFontSize",
             @"titleBottomGap"];
}

#pragma mark - 协议方法

- (NSString *)cell_text {
    
    return self.title;
}

- (EncodeImageObject *)cell_image {
    
    return self.image;
}

#pragma mark - 协议方法(必须实现)

- (ArticleEditObjectType)cell_Type {
    
    return ArticleEditObjectType_Title;
}

- (NSString *)cell_TypeText {
    
    return @"标题 - 图文";
}

@end
