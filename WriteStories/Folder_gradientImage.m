//
//  Folder_gradientImage.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/18.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Folder_gradientImage.h"
#import "FoldersManager.h"
#import "NSString+Path.h"

@implementation Folder_gradientImage

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
        editor.title           = @"背景图";
        editor.key             = @"image";
        editor.editorViewClass = FolderImageInputEditorView.class;
        [array addObject:editor];
    }
    
    return array;
}

- (ItemsStyleEditManager *)editManager {
    
    ItemsStyleEditManager *manager = [ItemsStyleEditManager managerWithWeakObject:self];
    
    {
        // 顶部标题
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"顶部标题"];
        [manager.headers addObject:header];
        
        {
            // 字体颜色
            StyleEditor *editor    = [StyleEditor new];
            editor.cellTitle      = @"字体颜色";
            editor.keys           = @[@"titleColorHex"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 可见度
            StyleEditor *editor       = [StyleEditor new];
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
        // 文件夹计数
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"文件夹计数"];
        [manager.headers addObject:header];
        
        {
            // 字体颜色
            StyleEditor *editor    = [StyleEditor new];
            editor.cellTitle      = @"字体颜色";
            editor.keys           = @[@"articleCountColorHex"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 可见度
            StyleEditor *editor       = [StyleEditor new];
            editor.cellTitle         = @"可见度";
            editor.keys              = @[@"articleCountAlpha"];
            
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
    
    return manager;
}

#pragma mark - Object

- (NSArray<EncodeImageObject *> *)imageObjects {
    
    return @[self.image];
}

+ (instancetype)defalutObject {
    
    Folder_gradientImage *item = [Folder_gradientImage new];
    
    // 支付相关
    item.paymentID = @"com.YouXianMing.WriteStories.Folder_gradientImage";
    
    // cell相关
    item.cellReuseId     = @"Folder_gradientImage";
    item.cellClassString = @"Folder_gradientImage_cell";
    item.isEmitterType   = NO;
    
    // 父类属性
    item.backgroundColorHex   = @"#FFFFFF";
    item.title                = @"模板5";
    item.titleColorHex        = @"#ffffff";
    item.titleAlpha           = @(1.f);
    item.articleCountColorHex = @"#ffffff";
    item.articleCountAlpha    = @(1.f);
    
    // 当前类属性
    EncodeImageObject *object = [EncodeImageObject new];
    object.imageName          = @"bg_cat_jpg";
    object.source             = EncodeImageObjectSourceDefault;
    object.width              = 180;
    object.height             = 210;
    object.scale              = @"6:7";
    
    CAGradientViewObject *gradientObject    = [CAGradientViewObject new];
    gradientObject.gradientHexColor_1       = @"#848482";
    gradientObject.gradientHexColor_2       = @"#B6B6B4";
    gradientObject.gradientColor_1_alpha    = @(1.f);
    gradientObject.gradientColor_2_alpha    = @(0.f);
    gradientObject.gradientColor_1_location = @(0.f);
    gradientObject.gradientColor_2_location = @(1.f);
    gradientObject.startPoint               = [NSValue valueWithCGPoint:CGPointMake(0, 0.1)];
    gradientObject.endPoint                 = [NSValue valueWithCGPoint:CGPointMake(0, 1)];
    
    item.image               = object;
    item.gradientObject      = gradientObject;
    item.gradientObjectAlpha = @(1.f);
    
    return item;
}

#pragma mark - Style

- (instancetype)currentStyleObject {
    
    Folder_gradientImage *gradientImage = (Folder_gradientImage *)[BaseFolderItem decodeWithData:self.encodeData];
    
    // 父类属性输入置空
    gradientImage.title = nil;
    
    // 当前类属性输入置空
    gradientImage.image = nil;
    
    return gradientImage;
}

- (void)useStyleObject:(id)styleObject {
    
    Folder_gradientImage *style = styleObject;
    
    // 父类属性
    self.backgroundColorHex   = style.backgroundColorHex;
    self.titleAlpha           = style.titleAlpha;
    self.titleColorHex        = style.titleColorHex;
    self.articleCountColorHex = style.articleCountColorHex;
    self.articleCountAlpha    = style.articleCountAlpha;
    
    // 当前类属性
    self.gradientObject      = style.gradientObject;
    self.gradientObjectAlpha = style.gradientObjectAlpha;
}

#pragma mark - Coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [self autoEncodePropertiesWithCoder:aCoder class:Folder_gradientImage.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:Folder_gradientImage.class];
    }
    
    return self;
}

+ (NSArray<NSString *> *)autoEncodePropertyKeys {
    
    return @[@"image",
             @"gradientObject",
             @"gradientObjectAlpha"];
}

@end
