//
//  ValuesPickerSetupView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/18.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ValuesPickerSetupView.h"
#import "ValuesPickerView.h"

@interface ValuesPickerSetupView () <ValuesPickerViewDelegate>

@end

@implementation ValuesPickerSetupView

- (void)buildSubViews {

    // 找到选中的编号
    __block NSMutableArray *selectedIndexes = [NSMutableArray array];
    [self.pickerViewValuesRanges enumerateObjectsUsingBlock:^(NSArray *values, NSUInteger i, BOOL * _Nonnull stop) {
        
        [values enumerateObjectsUsingBlock:^(id obj, NSUInteger j, BOOL * _Nonnull stop) {
            
            if ([self.inputValues[i] isEqual:obj]) {
                
                [selectedIndexes addObject:@(j)];
                *stop = YES;
            }
        }];
    }];
    
    ValuesPickerView *pickerView = [[ValuesPickerView alloc] initWithFrame:self.bounds
                                                                    titles:self.pickerViewTitles
                                                                    values:self.pickerViewValuesShowStrings
                                                            selectedIndexs:selectedIndexes
                                                                  delegate:self];
    pickerView.valuesRanges = self.pickerViewValuesRanges;
    [self addSubview:pickerView];
}

- (void)valuesPickerView:(ValuesPickerView *)pickerView didSelectedRows:(NSArray <NSNumber *> *)rows selectedDatas:(NSArray <id> *)datas {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemSetupView:updateValues:)]) {
        
        NSMutableArray *values = [NSMutableArray array];
        [self.pickerViewValuesRanges enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [values addObject:self.pickerViewValuesRanges[idx][rows[idx].integerValue]];
        }];
        
        [self.delegate itemSetupView:self updateValues:values];
    }
}

@end
