//
//  ValuesPickerView.m
//  FamousQuotes
//
//  Created by YouXianMing on 2018/3/19.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ValuesPickerView.h"
#import "CustomPickerView.h"
#import "NumberPickerRowView.h"
#import "UIView+SetRect.h"
#import "UIFont+Project.h"

@interface ValuesPickerView () <CustomPickerViewDelegate>

@property (nonatomic, strong) CustomPickerView      *pickerView;
@property (nonatomic, strong) PickerViewDataAdapter *pickerViewDataAdapter;

@end

@implementation ValuesPickerView

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray <NSString *> *)titles
                       values:(NSArray <NSArray <NSString *> *> *)rowsValues
               selectedIndexs: (NSArray <NSNumber *> *)selectedRows
                     delegate:(id <ValuesPickerViewDelegate>)delegate {
    
    if (self = [super initWithFrame:frame]) {
        
        self.delegate = delegate;
    
        NSMutableArray<PickerViewComponent *> *components = [NSMutableArray array];
        [rowsValues enumerateObjectsUsingBlock:^(NSArray<NSString *> *values, NSUInteger row, BOOL * _Nonnull stop) {
            
            // 初始化row
            NSMutableArray<PickerViewRow *> *rows = [NSMutableArray array];
            [values enumerateObjectsUsingBlock:^(NSString *value, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [rows addObject:[PickerViewRow pickerViewRowWithViewClass:[NumberPickerRowView class] data:value]];
            }];
            
            // 初始化component
            PickerViewComponent *component = [PickerViewComponent pickerViewComponentWithRows:rows componentWidth:self.width / (CGFloat)titles.count];
            [components addObject:component];
        }];
        
        // 数据源
        self.pickerViewDataAdapter = [PickerViewDataAdapter pickerViewDataAdapterWithComponents:components rowHeight:45.f];

        self.pickerView = [[CustomPickerView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0)
                                                         delegate:self
                                             pickerViewHeightType:kCustomPickerViewHeightTypeMin
                                                      dataAdapter:self.pickerViewDataAdapter];
        self.pickerView.bottom = self.height;
        self.pickerView.left   = 0.f;
        [self addSubview:self.pickerView];
        
        // 初始选中的元素
        [selectedRows enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self.pickerView selectRow:obj.integerValue inComponent:idx animated:NO];
        }];
        
        CGFloat labelWidth = self.width / (CGFloat)titles.count;
        [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UILabel *title      = [[UILabel alloc] initWithFrame:CGRectMake(labelWidth * idx, 0, labelWidth, 30)];
            title.textAlignment = NSTextAlignmentCenter;
            title.text          = obj;
            title.font          = [UIFont PingFangSC_Light_WithFontSize:17];
            title.bottom        = self.pickerView.top;
            [self addSubview:title];
        }];
    }
    
    return self;
}

- (void)customPickerView:(CustomPickerView *)pickerView didSelectedRows:(NSArray <NSNumber *> *)rows selectedDatas:(NSArray <id> *)datas {

    if (self.delegate && [self.delegate respondsToSelector:@selector(valuesPickerView:didSelectedRows:selectedDatas:)]) {
        
        [self.delegate valuesPickerView:self didSelectedRows:rows selectedDatas:datas];
    }
}

+ (NSArray <NSString *> *)valuesFromStart:(NSInteger)start toEnd:(NSInteger)end {
    
    NSMutableArray *strings = [NSMutableArray array];
    for (NSInteger i = start; i <= end; i++) {
        
        [strings addObject:[NSString stringWithFormat:@"%ld", i]];
    }
    
    return [NSArray arrayWithArray:strings];
}

@end
