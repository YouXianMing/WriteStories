//
//  FontsPickerView.m
//  FamousQuotes
//
//  Created by YouXianMing on 2018/3/19.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "FontsPickerView.h"
#import "CustomPickerView.h"
#import "PickerViewDataAdapter.h"
#import "UIView+SetRect.h"
#import "UIFont+Project.h"
#import "FontPickerRowView.h"

@interface FontsPickerView () <CustomPickerViewDelegate>

@property (nonatomic, strong) CustomPickerView      *pickerView;
@property (nonatomic, strong) PickerViewDataAdapter *pickerViewDataAdapter;

@end

@implementation FontsPickerView

- (instancetype)initWithFrame:(CGRect)frame font:(UIFont *)font delegate:(id <FontsPickerViewDelegate>)delegate {
    
    if (self = [super initWithFrame:frame]) {
        
        self.delegate = delegate;

        NSMutableArray<PickerViewRow *> *rows = [NSMutableArray array];
        __block NSUInteger selectedRow        = 0;
        
        NSArray <FontInfoObject *> *fonts = FontsManager.fontInfos;
        [fonts enumerateObjectsUsingBlock:^(FontInfoObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [rows addObject:[PickerViewRow pickerViewRowWithViewClass:[FontPickerRowView class] data:obj]];
            
            if ([font.fontName isEqualToString:obj.font.fontName]) {
                
                selectedRow = idx;
            }
        }];
        
        PickerViewComponent *component = [PickerViewComponent pickerViewComponentWithRows:rows componentWidth:self.width];
        
        // 数据源
        self.pickerViewDataAdapter = [PickerViewDataAdapter pickerViewDataAdapterWithComponents:@[component] rowHeight:45.f];
        
        self.pickerView = [[CustomPickerView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0)
                                                         delegate:self
                                             pickerViewHeightType:kCustomPickerViewHeightTypeMin
                                                      dataAdapter:self.pickerViewDataAdapter];
        self.pickerView.bottom = self.height;
        self.pickerView.left   = 0.f;
        [self addSubview:self.pickerView];
        [self.pickerView selectRow:selectedRow inComponent:0 animated:NO];
        
        UILabel *title      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 30)];
        title.textAlignment = NSTextAlignmentCenter;
        title.text          = @"字体类型";
        title.font          = [UIFont PingFangSC_Light_WithFontSize:17];
        title.bottom        = self.pickerView.top;
        [self addSubview:title];
    }
    
    return self;
}

- (void)customPickerView:(CustomPickerView *)pickerView didSelectedRows:(NSArray <NSNumber *> *)rows selectedDatas:(NSArray <id> *)datas {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(fontsPickerView:didSelectedRows:selectedDatas:)]) {
        
        [self.delegate fontsPickerView:self didSelectedRows:rows selectedDatas:datas];
    }
}

@end
