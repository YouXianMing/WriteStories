//
//  ColorsManager.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/17.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ColorsManager.h"
#import "FileManager.h"
#import "NSData+JSONData.h"

static ColorsManager *_manager = nil;

@interface ColorsManager ()

@property (nonatomic, strong) NSArray *colors;

@end

@implementation ColorsManager

+ (void)prepare {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _manager = [[ColorsManager alloc] initInstance];
        
        NSMutableArray *array = [NSMutableArray array];
        
        NSArray *datas = [[[NSData alloc] initWithContentsOfFile:absoluteFilePathFrom(@"-/colors_ver2.json")] toListProperty];
        [datas enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [array addObject:obj[@"hex"]];
        }];
        
        _manager.colors = [NSArray arrayWithArray:array];
    });
}

+ (NSArray<ColorsModel *> *)colorModels {
    
    NSMutableArray *array = [NSMutableArray array];
    
    [_manager.colors enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        ColorsModel *model = [ColorsModel new];
        model.hexString    = obj;
        model.index        = idx + 1;
        [array addObject:model];
    }];
    
    return array;
}

#pragma mark - private method

- (id)initInstance {
    
    return [super init];
}

@end
