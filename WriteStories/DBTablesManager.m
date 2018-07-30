//
//  DBTablesManager.m
//  FamousQuotes
//
//  Created by YouXianMing on 2018/1/16.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "DBTablesManager.h"
#import "DBManager.h"
#import "Table_Folder_List.h"
#import "Table_Mark_List.h"
#import "Table_Style_List.h"

@implementation DBTablesManager

+ (void)createTables {
    
    [Table_Folder_List createTable];
    [Table_Mark_List   createTable];
    [Table_Style_List  createTable];
}

+ (void)upateTableParams {
    
    [Table_Folder_List updateTable];
    [Table_Mark_List   updateTable];
    [Table_Style_List  updateTable];
}

@end
