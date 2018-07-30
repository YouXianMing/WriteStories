//
//  Table_Folder_Object.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/19.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Table_Folder_Object;

@interface Table_Folder_Type_Object : NSObject

@property (nonatomic) NSInteger         type;
@property (nonatomic, strong) NSString *typeName;
@property (nonatomic, strong) NSMutableArray <Table_Folder_Object *> *folderObjects;

@end

@interface Table_Folder_Object : NSObject

@property (nonatomic) NSInteger          type;
@property (nonatomic) NSInteger          folderId;
@property (nonatomic) NSInteger          fileCount;
@property (nonatomic, strong) NSString  *name;

@end



