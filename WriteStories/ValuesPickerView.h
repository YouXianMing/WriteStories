//
//  ValuesPickerView.h
//  FamousQuotes
//
//  Created by YouXianMing on 2018/3/19.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ValuesPickerView;

@protocol ValuesPickerViewDelegate <NSObject>

- (void)valuesPickerView:(ValuesPickerView *)pickerView didSelectedRows:(NSArray <NSNumber *> *)rows selectedDatas:(NSArray <id> *)datas;

@end

@interface ValuesPickerView : UIView

@property (nonatomic, strong) NSArray *valuesRanges; // 各个初始值的取值范围(根据需要可以为空)
@property (nonatomic, weak)   id <ValuesPickerViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray <NSString *> *)titles
                       values:(NSArray <NSArray <NSString *> *> *)rowsValues
               selectedIndexs: (NSArray <NSNumber *> *)selectedRows
                     delegate:(id <ValuesPickerViewDelegate>)delegate;

+ (NSArray <NSString *> *)valuesFromStart:(NSInteger)start toEnd:(NSInteger)end;

@end
