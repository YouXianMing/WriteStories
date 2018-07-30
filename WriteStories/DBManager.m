//
//  DBManager.m
//  FamousQuotes
//
//  Created by YouXianMing on 2018/1/16.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "DBManager.h"
#import "FileManager.h"
#import "FoldersManager.h"

static DBManager *_manager = nil;

@interface DBManager ()

@property (nonatomic, strong) NSString        *dbPath;
@property (nonatomic, strong) FMDatabaseQueue *queue;

@end

@implementation DBManager

- (instancetype)init {
    
    [NSException raise:@"DBManager"
                format:@"Cannot instantiate singleton using init method, sharedInstance must be used."];
    
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    
    [NSException raise:@"DBManager"
                format:@"Cannot copy singleton using copy method, sharedInstance must be used."];
    
    return nil;
}

+ (void)prepare {
    
    if (self != [DBManager class]) {
        
        [NSException raise:@"DBManager" format:@"Cannot use sharedInstance method from subclass."];
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _manager = [[DBManager alloc] initInstance];
        
        _manager.dbPath = [FoldersManager.Datafolder stringByAppendingPathComponent:@"data.db"];
        _manager.queue  = [FMDatabaseQueue databaseQueueWithPath:_manager.dbPath];
        
        NSLog(@"数据库地址:\n%@", _manager.dbPath);
    });
}

+ (FMDatabase *)database {
    
    return [FMDatabase databaseWithPath:_manager.dbPath];
}

+ (FMDatabaseQueue *)queue {
    
    return _manager.queue;
}

#pragma mark - private method

- (id)initInstance {
    
    return [super init];
}

@end
