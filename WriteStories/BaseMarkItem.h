//
//  BaseMarkItem.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/19.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "WriteStoriesBaseItemObject.h"
#import "HexColors.h"
#import "EncodeImageObject.h"
#import "Values.h"

#import "ItemColorSetupView.h"
#import "ValuesPickerSetupView.h"
#import "FontsPickerSetupView.h"
#import "IconFontSetupView.h"
#import "ItemGradientDragAreaSetupView.h"

#import "FieldInputEditorView.h"
#import "MarkImageInputEditorView.h"

@interface BaseMarkItem : WriteStoriesBaseItemObject

#pragma mark - 数据库属性

@property (nonatomic) NSInteger          mark_id;     // 文章id
@property (nonatomic) NSInteger          folder_id;   // 文件夹id
@property (nonatomic, strong) NSString  *mark_name;   // 标签文件夹名字
@property (nonatomic) NSInteger          type;        // 标签所属类型
@property (nonatomic) NSInteger          sort_index;  // 排序编号

#pragma mark - encode属性

@property (nonatomic, strong) NSString *backgroundColorHex; // 背景色

@property (nonatomic, strong) NSString *title;              // 标题
@property (nonatomic, strong) NSString *titleFontFamily;    // 标题字体
@property (nonatomic, strong) NSString *titleColorHex;      // 标题颜色
@property (nonatomic, strong) NSNumber *titleFontSize;      // 标题尺寸
@property (nonatomic, strong) NSNumber *titleAlpha;         // 标题透明度

@end
