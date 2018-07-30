//
//  Values.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/15.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *CH  = @"ch";
static NSString *EN  = @"en";
static NSString *CSS = @"css";

@interface Values : NSObject

@property (class, readonly) NSString *Noti_RootMenuViewControllerUpdateCountNumber;
@property (class, readonly) NSString *Noti_FolderListViewControllerUpdateCountNumber;
@property (class, readonly) NSString *Noti_FolderListViewControllerUpdateAllFoldersCountNumber;

@property (class, nonatomic) NSDictionary <NSString *, NSArray *>  *TextAlign;
@property (class, nonatomic) NSDictionary <NSString *, NSArray *>  *DecorationLine;
@property (class, nonatomic) NSDictionary <NSString *, NSArray *>  *Italic;
@property (class, nonatomic) NSDictionary <NSString *, NSArray *>  *BolderStyle;
@property (class, nonatomic) NSDictionary <NSString *, NSNumber *> *FolderType;
@property (class, nonatomic) NSDictionary <NSNumber *, NSString *> *FolderName;

@property (class, readonly) NSArray <NSNumber *> *AlphaValueRanges;
@property (class, readonly) NSArray <NSString *> *AlphaValueRangeStrings;

@property (class, readonly) NSArray <NSNumber *> *ScaleValueRanges;
@property (class, readonly) NSArray <NSString *> *ScaleValueRangeStrings;

+ (NSArray <NSNumber *> *)valuesFrom:(NSInteger)from to:(NSInteger)to;
+ (NSArray <NSString *> *)stringsFrom:(NSInteger)from to:(NSInteger)to;
+ (NSArray <NSString *> *)percentStringsFrom:(NSInteger)from to:(NSInteger)to;

@property (class, nonatomic) BOOL PreviewMode;
@property (class, nonatomic) NSArray <NSNumber *> *Passwords;

@end

NS_INLINE void Values_prepare() {
    
    Values.TextAlign = @{EN  : @[@"left",  @"center", @"right"],
                         CSS : @[@"tal",   @"tac",    @"tar"],
                         CH  : @[@"左对齐", @"居中对齐", @"右对齐"]};
    
    Values.DecorationLine = @{EN : @[@"none", @"underline", @"line-through"],
                              CH : @[@"无",   @"下划线",     @"中划线"]};
    
    Values.Italic = @{EN : @[@"normal", @"italic"],
                      CH : @[@"否",     @"是"]};
    
    Values.BolderStyle = @{EN : @[@"solid", @"dotted" , @"double", @"dashed"],
                           CH : @[@"线条",   @"点",      @"双线条",   @"虚线条"]};
    
    Values.FolderType = @{@"示例" : @(1),
                          @"美文" : @(2),
                          @"随笔" : @(3),
                          @"私密" : @(4),
                          @"草稿" : @(5),
                          @"其他" : @(6)};
    
    Values.FolderName = @{@(1) : @"示例",
                          @(2) : @"美文",
                          @(3) : @"随笔",
                          @(4) : @"私密",
                          @(5) : @"草稿",
                          @(6) : @"其他"};
}
