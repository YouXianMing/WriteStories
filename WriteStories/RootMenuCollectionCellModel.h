//
//  RootMenuCollectionCellModel.h
//  WriteStories
//
//  Created by YouXianMing on 2018/5/24.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RootMenuCollectionCellModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *enTitle;
@property (nonatomic, strong) NSString *countNumber;

+ (instancetype)modelWithTitle:(NSString *)title enTitle:(NSString *)enTitle countNumber:(NSString *)countNumber;

@end
