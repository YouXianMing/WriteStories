//
//  Table_Style_List.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/23.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "TableDBObject.h"
#import "WriteStoriesBaseItemObject.h"

@interface Table_Style_List : TableDBObject

+ (void)storeStyleObject:(WriteStoriesBaseItemObject *)itemObject styleName:(NSString *)styleName;

+ (NSArray <WriteStoriesBaseItemObject *> *)styleObjectsByShowStyleType:(NSInteger)type;

+ (void)deleteItemObject:(WriteStoriesBaseItemObject *)itemObject;

+ (void)updateItemObject:(WriteStoriesBaseItemObject *)itemObject;

+ (NSInteger)styleCountsByItemObject:(WriteStoriesBaseItemObject *)itemObject;

@end
