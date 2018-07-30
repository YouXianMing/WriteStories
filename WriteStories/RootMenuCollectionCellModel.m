//
//  RootMenuCollectionCellModel.m
//  WriteStories
//
//  Created by YouXianMing on 2018/5/24.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "RootMenuCollectionCellModel.h"

@implementation RootMenuCollectionCellModel

+ (instancetype)modelWithTitle:(NSString *)title enTitle:(NSString *)enTitle countNumber:(NSString *)countNumber {
    
    RootMenuCollectionCellModel *model = [RootMenuCollectionCellModel new];
    model.title                        = title;
    model.enTitle                      = enTitle;
    model.countNumber                  = countNumber;
    
    return model;
}

@end
