//
//  FontsPickerSetupView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/18.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "FontsPickerSetupView.h"
#import "FontsPickerView.h"

@interface FontsPickerSetupView () <FontsPickerViewDelegate>

@end

@implementation FontsPickerSetupView

- (void)buildSubViews {

    FontsPickerView *pickerView = [[FontsPickerView alloc] initWithFrame:self.bounds font:[UIFont fontWithName:self.inputValues.firstObject size:18] delegate:self];
    [self addSubview:pickerView];
}

- (void)fontsPickerView:(FontsPickerView *)pickerView didSelectedRows:(NSArray <NSNumber *> *)rows selectedDatas:(NSArray <id> *)datas {
    
    FontInfoObject *object = datas.firstObject;
    NSLog(@"%@", object.font.fontName);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemSetupView:updateValues:)]) {
        
        [self.delegate itemSetupView:self updateValues:@[object.font.fontName]];
    }
}

@end
