//
//  Html_pureColor.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Html_pureColor.h"
#import "NSDictionary+JSONData.h"

@implementation Html_pureColor

#pragma mark - Editors

- (NSArray<InputEditor *> *)inputEditors {
    
    return nil;
}

- (ItemsStyleEditManager *)editManager {
    
    ItemsStyleEditManager *manager = [ItemsStyleEditManager managerWithWeakObject:self];
    
    {
        // 背景
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"背景"];
        [manager.headers addObject:header];
        
        {
            // 颜色
            StyleEditor *editor    = [StyleEditor new];
            editor.cellTitle      = @"颜色";
            editor.keys           = @[@"backgroundHexColor"];
            editor.setupViewClass = ItemColorSetupView.class;
            [header.editors addObject:editor];
        }
        
        {
            // 可见度
            StyleEditor *editor       = [StyleEditor new];
            editor.cellTitle         = @"可见度";
            editor.keys              = @[@"backgroundHexColorAlpha"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"可见度"];
            editor.pickerViewValuesRanges      = @[Values.AlphaValueRanges];
            editor.pickerViewValuesShowStrings = @[Values.AlphaValueRangeStrings];
            
            [header.editors addObject:editor];
        }
    }
    
    return manager;
}

#pragma mark - Html

- (NSString *)jsConfig {
    
    OutterAndInnerDivs *divs = [OutterAndInnerDivs new];
    divs.body_style          = FmtStr(@"background-color: %@;", [self RGBAWithHex:self.backgroundHexColor alpha:self.backgroundHexColorAlpha]);
    
    return divs.jsConfig;
}

- (NSString *)bodyString {

    NSString *bodyStyle = FmtStr(@"background-color: %@;", [self RGBAWithHex:self.backgroundHexColor alpha:self.backgroundHexColorAlpha]);
    
    OutterAndInnerDivs *divs = [OutterAndInnerDivs new];
    divs.body = FmtStr(@"<body %@ %@ %@>",
                       _html_id(@"body"),
                       _html_class(@" "),
                       _html_style(bodyStyle));
    
    return divs.htmlString;
}

#pragma mark - Object

+ (instancetype)defalutObject {
    
    Html_pureColor *item = [Html_pureColor new];
    
    // 当前类属性
    item.backgroundHexColor      = @"#FFFFFF";
    item.backgroundHexColorAlpha = @(1.0);
    
    return item;
}

#pragma mark - Style

- (instancetype)currentStyleObject {
    
    Html_pureColor *object = (Html_pureColor *)[BaseHtmlBodyItem decodeWithData:self.encodeData];
    
    return object;
}

- (void)useStyleObject:(id)styleObject {
    
    Html_pureColor *style = styleObject;
    
    // 当前类属性
    self.backgroundHexColorAlpha = style.backgroundHexColorAlpha;
    self.backgroundHexColor      = style.backgroundHexColor;
}

#pragma mark - Coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [self autoEncodePropertiesWithCoder:aCoder class:Html_pureColor.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:Html_pureColor.class];
    }
    
    return self;
}

+ (NSArray<NSString *> *)autoEncodePropertyKeys {
    
    return @[@"backgroundHexColorAlpha",
             @"backgroundHexColor"];
}

@end
