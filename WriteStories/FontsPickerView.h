//
//  FontsPickerView.h
//  FamousQuotes
//
//  Created by YouXianMing on 2018/3/19.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FontsManager.h"
@class FontsPickerView;

@protocol FontsPickerViewDelegate <NSObject>

- (void)fontsPickerView:(FontsPickerView *)pickerView didSelectedRows:(NSArray <NSNumber *> *)rows selectedDatas:(NSArray <id> *)datas;

@end

@interface FontsPickerView : UIView

@property (nonatomic, weak) id delegate;

- (instancetype)initWithFrame:(CGRect)frame font:(UIFont *)font delegate:(id <FontsPickerViewDelegate>)delegate;

@end
