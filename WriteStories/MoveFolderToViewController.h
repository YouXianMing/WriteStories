//
//  MoveFolderToViewController.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/16.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "NormalTitleViewController.h"
#import "BaseFolderItem.h"

@interface MoveFolderToViewController : NormalTitleViewController

@property (nonatomic, strong) BaseFolderItem *folderItem;
@property (nonatomic, strong) NSNumber       *type;

@end
