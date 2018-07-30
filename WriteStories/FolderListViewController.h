//
//  FolderListViewController.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/24.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "NormalTitleViewController.h"

@interface FolderListViewController : NormalTitleViewController

@property (nonatomic, strong) NSNumber *type;
@property (nonatomic)         BOOL      canEdit; // 是否可以进行编辑

@end
