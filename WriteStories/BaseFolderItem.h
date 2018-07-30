//
//  BaseFolderItem.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/4.
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
#import "FolderImageInputEditorView.h"

@interface BaseFolderItem : WriteStoriesBaseItemObject

#pragma mark - 数据库属性

@property (nonatomic) NSInteger          folder_id;    // 文件夹id
@property (nonatomic, strong) NSString  *folder_name;  // 文件夹名字
@property (nonatomic) NSInteger          type;         // 文件夹所属类型
@property (nonatomic) NSInteger          sort_index;   // 排序编号
@property (nonatomic) NSInteger          articleCount; // 文章数目

#pragma mark - encode属性

@property (nonatomic, strong) NSString *backgroundColorHex; // 背景色

@property (nonatomic, strong) NSString *title;           // 标题
@property (nonatomic, strong) NSNumber *titleAlpha;      // 标题透明度
@property (nonatomic, strong) NSString *titleColorHex;   // 标题颜色

@property (nonatomic, strong) NSString *articleCountColorHex; // 文件夹数目颜色
@property (nonatomic, strong) NSNumber *articleCountAlpha;    // 文件夹数目透明度

@end
