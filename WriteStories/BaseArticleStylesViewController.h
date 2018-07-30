//
//  ArticleStylesViewController.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "NormalTitleViewController.h"
#import "BlockInputInfoEditViewController.h"
#import "BaseStyleCell.h"
#import "BaseBlockItem.h"
#import "StyleSectionObject.h"

@interface BaseArticleStylesViewController : NormalTitleViewController

#pragma mark - 给BaseBlockItem赋值

@property (nonatomic) NSInteger         itemId;
@property (nonatomic, strong) NSString *htmlFolderName;

#pragma mark - 子类重写

- (void)registerCellsWithTableView:(UITableView *)tableView;
- (void)didSelectedBlockItems:(BaseBlockItem *)blockItem;
- (void)addStyleSectionObjectsWithSectionArray:(NSMutableArray <StyleSectionObject *> *)sections;

@end
