//
//  Animation_Set.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Animation_Set.h"

@implementation Animation_Set

#pragma mark - Editors

- (NSArray<InputEditor *> *)inputEditors {
    
    return nil;
}

- (ItemsStyleEditManager *)editManager {
    
    ItemsStyleEditManager *manager = [ItemsStyleEditManager managerWithWeakObject:self];
    
    {
        // 动画
        ItemsHeader *header = [ItemsHeader headerWithTitle:@"动画"];
        [manager.headers addObject:header];
        
        {
            // 动画效果
            StyleEditor *editor       = [StyleEditor new];
            editor.cellTitle         = @"动画效果";
            editor.keys              = @[@"animationType"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"动画效果"];
            editor.pickerViewValuesRanges      = @[@[@(0), @(1),     @(2),    @(3),    @(4), @(5)]];
            editor.pickerViewValuesShowStrings = @[@[@"无", @"雪花1", @"雪花2", @"雪花3", @"雨", @"梦幻"]];
            
            [header.editors addObject:editor];
        }
        
        {
            // 可见度
            StyleEditor *editor      = [StyleEditor new];
            editor.cellTitle         = @"可见度";
            editor.keys              = @[@"opacity"];
            
            editor.setupViewClass              = ValuesPickerSetupView.class;
            editor.pickerViewTitles            = @[@"可见度"];
            editor.pickerViewValuesRanges      = @[Values.AlphaValueRanges];
            editor.pickerViewValuesShowStrings = @[Values.AlphaValueRangeStrings];
            
            [header.editors addObject:editor];
        }
    }
    
    return manager;
}

#pragma mark - Object

+ (instancetype)defalutObject {
    
    Animation_Set *object = [Animation_Set new];
    
    object.animationType = @(0);
    object.opacity       = @(1);
    
    return object;
}

#pragma mark - Coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [self autoEncodePropertiesWithCoder:aCoder class:Animation_Set.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:Animation_Set.class];
    }
    
    return self;
}

+ (NSArray<NSString *> *)autoEncodePropertyKeys {
    
    return @[@"animationType",
             @"opacity"];
}

@end
