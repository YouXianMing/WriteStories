//
//  Block_picture_normal_1.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/28.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Block_picture_normal_1.h"

@implementation Block_picture_normal_1

#pragma mark - Editors

- (NSArray<InputEditor *> *)inputEditors {
    
    NSMutableArray *array = [NSMutableArray array];
    
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
        // 距离
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"距离"];
        [manager.headers addObject:header];
        
        {
            // 上下间距
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"上下间距";
            editor.keys              = @[@"topGap", @"bottomGap"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"上间距", @"下间距"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:0 to:100], [Values valuesFrom:0 to:100]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:0 to:100], [Values stringsFrom:0 to:100]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 宽度百分比
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"宽度百分比";
            editor.keys              = @[@"widthPercent"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"宽度百分比"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:60         to:100]];
            editor.pickerViewValuesShowStrings = @[[Values percentStringsFrom:60 to:100]];
            
            [header.editors addObject:editor];
        }
    }
    
    {
        // 边框
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"边框"];
        [manager.headers addObject:header];
        
        {
            // 边框宽度
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"边框宽度";
            editor.keys              = @[@"borderWidth"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"边框宽度"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:0 to:20]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:0 to:20]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 边框样式
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"边框样式";
            editor.keys              = @[@"borderStyle"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"边框样式"];
            editor.pickerViewValuesRanges      = @[Values.BolderStyle[EN]];
            editor.pickerViewValuesShowStrings = @[Values.BolderStyle[CH]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 颜色
            StyleEditor *editor    = [StyleEditor new];
            editor.cellTitle      = @"颜色";
            editor.keys           = @[@"borderColorHex"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 可见度
            StyleEditor *editor       = [StyleEditor new];
            editor.cellTitle         = @"可见度";
            editor.keys              = @[@"borderColorAlpha"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"可见度"];
            editor.pickerViewValuesRanges      = @[Values.AlphaValueRanges];
            editor.pickerViewValuesShowStrings = @[Values.AlphaValueRangeStrings];
            
            [header.editors addObject:editor];
        }
        
        {
            // 边框圆角
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"边框圆角";
            editor.keys              = @[@"borderRadius"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"圆角值"];
            editor.pickerViewValuesRanges      = @[[Values valuesFrom:0 to:50]];
            editor.pickerViewValuesShowStrings = @[[Values stringsFrom:0 to:50]];
            
            [header.editors addObject:editor];
        }
    }
    
    return manager;
}

#pragma mark - Object

- (NSArray<EncodeImageObject *> *)imageObjects {
    
    return @[self.image];
}

- (NSDictionary<NSString *,NSArray<EncodeImageObject *> *> *)key_imageObjects {
    
    NSMutableArray *imageObjects = [NSMutableArray array];
    
    [imageObjects addObject:[EncodeImageObject bigImageWithScale:@"1:1" source:EncodeImageObjectSourceDefault imageName:@"styles_jpeg"]];
    
    [imageObjects addObject:[EncodeImageObject bigImageWithScale:@"5:4" source:EncodeImageObjectSourceDefault imageName:@"styles_jpeg"]];
    [imageObjects addObject:[EncodeImageObject bigImageWithScale:@"4:3" source:EncodeImageObjectSourceDefault imageName:@"styles_jpeg"]];
    [imageObjects addObject:[EncodeImageObject bigImageWithScale:@"3:2" source:EncodeImageObjectSourceDefault imageName:@"styles_jpeg"]];
    [imageObjects addObject:[EncodeImageObject bigImageWithScale:@"16:10" source:EncodeImageObjectSourceDefault imageName:@"styles_jpeg"]];
    [imageObjects addObject:[EncodeImageObject bigImageWithScale:@"16:9" source:EncodeImageObjectSourceDefault imageName:@"styles_jpeg"]];
    [imageObjects addObject:[EncodeImageObject bigImageWithScale:@"21:9" source:EncodeImageObjectSourceDefault imageName:@"styles_jpeg"]];
    
    [imageObjects addObject:[EncodeImageObject bigImageWithScale:@"4:5" source:EncodeImageObjectSourceDefault imageName:@"styles_jpeg"]];
    [imageObjects addObject:[EncodeImageObject bigImageWithScale:@"3:4" source:EncodeImageObjectSourceDefault imageName:@"styles_jpeg"]];
    [imageObjects addObject:[EncodeImageObject bigImageWithScale:@"2:3" source:EncodeImageObjectSourceDefault imageName:@"styles_jpeg"]];
    [imageObjects addObject:[EncodeImageObject bigImageWithScale:@"10:16" source:EncodeImageObjectSourceDefault imageName:@"styles_jpeg"]];
    [imageObjects addObject:[EncodeImageObject bigImageWithScale:@"9:16" source:EncodeImageObjectSourceDefault imageName:@"styles_jpeg"]];
    [imageObjects addObject:[EncodeImageObject bigImageWithScale:@"9:21" source:EncodeImageObjectSourceDefault imageName:@"styles_jpeg"]];
    
    return @{@"image" : imageObjects};
}

+ (instancetype)defalutObject {
    
    Block_picture_normal_1 *item = [Block_picture_normal_1 new];
    
    // cell相关
    item.cellReuseId     = @"Edit_picture_1_Cell";
    item.cellClassString = @"Edit_picture_1_Cell";
    
    // 当前类
    EncodeImageObject *object = [EncodeImageObject new];
    object.imageName          = @"styles_jpeg";
    object.source             = EncodeImageObjectSourceDefault;
    object.width              = 400;
    object.height             = 300;
    object.scale              = @"4:3";
    item.image                = object;
    
    item.topGap       = @(0);
    item.bottomGap    = @(10);
    item.widthPercent = @(100);
        
    item.borderWidth      = @(5);
    item.borderStyle      = @"solid";
    item.borderColorHex   = @"#000000";
    item.borderColorAlpha = @(0.1);
    item.borderRadius     = @(0);
    
    return item;
}

#pragma mark - Style

- (instancetype)currentStyleObject {
    
    Block_picture_normal_1 *object = (Block_picture_normal_1 *)[BaseBlockItem decodeWithData:self.encodeData];
    
    // 当前类属性输入置空
    object.image = nil;
    
    return object;
}

- (void)useStyleObject:(id)styleObject {
    
    Block_picture_normal_1 *style = styleObject;
    
    // 当前类属性
    self.topGap       = style.topGap;
    self.bottomGap    = style.bottomGap;
    self.widthPercent = style.widthPercent;
    
    self.borderWidth      = style.borderWidth;
    self.borderStyle      = style.borderStyle;
    self.borderColorHex   = style.borderColorHex;
    self.borderColorAlpha = style.borderColorAlpha;
    self.borderRadius     = style.borderRadius;
}

#pragma mark - Html

- (NSString *)htmlString {
    
    NSMutableString *div = [NSMutableString string];
    
    [div appendFormat:@"<div %@ %@ %@>",
     _html_id(self.itemIdString),
     _html_class(@" "),
     _html_style(FmtStr(@"padding: %@px 0px %@px 0px;", self.topGap, self.bottomGap))
     ];
    
    [div appendFormat:@"<img %@ %@ %@ %@>",
     _html_tag(@"img"),
     _html_class(@"db ma bsbb"),
     _html_style(FmtStr(@"max-width: %@%%; border:%@px %@ %@; border-radius: %@px;",
                        self.widthPercent,
                        self.borderWidth,
                        self.borderStyle,
                        [self RGBAWithHex:self.borderColorHex alpha:self.borderColorAlpha],
                        self.borderRadius)),
     _html_src(FmtStr(@"./%@/block/%@", self.folderName, self.image.imageName))];
    
    [div appendString:@"</div>"];
    
    return div;
}

- (NSString *)jsonConfigWithDebug:(BOOL)debug {
    
    JSConfigManager *manager = [JSConfigManager managerWithClassName:debug ? @"showDebug" : @" "
                                                               style:FmtStr(@"padding: %@px 0px %@px 0px;", self.topGap, self.bottomGap)];
    
    [manager.subs addObject:jsConfig(@"img",
                                     @"db ma bsbb",
                                     FmtStr(@"max-width: %@%%; border:%@px %@ %@; border-radius: %@px;",
                                            self.widthPercent,
                                            self.borderWidth,
                                            self.borderStyle,
                                            [self RGBAWithHex:self.borderColorHex alpha:self.borderColorAlpha],
                                            self.borderRadius))];

    return manager.config.toJSONString;
}

#pragma mark - Coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [self autoEncodePropertiesWithCoder:aCoder class:Block_picture_normal_1.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:Block_picture_normal_1.class];
    }
    
    return self;
}

+ (NSArray<NSString *> *)autoEncodePropertyKeys {
    
    return @[@"image",
             @"topGap",
             @"bottomGap",
             @"widthPercent",
             
             @"borderWidth",
             @"borderStyle",
             @"borderColorHex",
             @"borderColorAlpha",
             @"borderRadius"];
}

#pragma mark - 协议方法

- (NSString *)cell_text {
    
    return nil;
}

- (EncodeImageObject *)cell_image {
    
    return self.image;
}

#pragma mark - 协议方法(必须实现)

- (ArticleEditObjectType)cell_Type {
    
    return ArticleEditObjectType_Picture;
}

- (NSString *)cell_TypeText {
    
    return @"图文 - 纯图片";
}

@end
