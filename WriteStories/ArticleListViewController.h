//
//  ArticleListViewController.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "NormalTitleViewController.h"
#import "BaseFolderItem.h"

@interface ArticleListViewController : NormalTitleViewController

@property (nonatomic)         BOOL            canEdit;
@property (nonatomic, strong) BaseFolderItem *folderItem;

@end
