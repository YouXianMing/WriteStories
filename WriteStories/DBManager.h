//
//  DBManager.h
//  FamousQuotes
//
//  Created by YouXianMing on 2018/1/16.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface DBManager : NSObject

+ (void)prepare;

/**
 Get a new databaseObject.

 @return FMDatabase object.
 */
+ (FMDatabase *)database;

/**
 Get a FMDatabaseQueue.

 @return FMDatabaseQueue object.
 */
+ (FMDatabaseQueue *)queue;

@end
