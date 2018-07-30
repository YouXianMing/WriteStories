//
//  SubTitleStylesViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "SubTitleStylesViewController.h"

#import "Block_subtitle_normal_1_cell.h"
#import "Block_subtitle_colorblock_1_cell.h"
#import "Block_subtitle_colorblock_2_cell.h"
#import "Block_subtitle_colorblock_3_cell.h"

@interface SubTitleStylesViewController ()

@end

@implementation SubTitleStylesViewController

- (void)registerCellsWithTableView:(UITableView *)tableView {
    
    [Block_subtitle_normal_1_cell     registerToTableView:tableView];
    [Block_subtitle_colorblock_1_cell registerToTableView:tableView];
    [Block_subtitle_colorblock_2_cell registerToTableView:tableView];
    [Block_subtitle_colorblock_3_cell registerToTableView:tableView];
}

- (void)addStyleSectionObjectsWithSectionArray:(NSMutableArray <StyleSectionObject *> *)sections {
    
    {
        // -普通-
        StyleSectionObject *section = [StyleSectionObject new];
        section.title               = @"普通";
        [sections addObject:section];

        // SubTitleNormal_1_Cell
        [section.adapters addObject:Block_subtitle_normal_1_cell.fixedHeightTypeDataAdapter];
    }
    
    {
        // -色块-
        StyleSectionObject *section = [StyleSectionObject new];
        section.title               = @"色块";
        [sections addObject:section];
        
        // Block_subtitle_colorblock_1_cell
        [section.adapters addObject:Block_subtitle_colorblock_1_cell.fixedHeightTypeDataAdapter];
        
        // Block_subtitle_colorblock_2_cell
        [section.adapters addObject:Block_subtitle_colorblock_2_cell.fixedHeightTypeDataAdapter];
        
        // Block_subtitle_colorblock_3_cell
        [section.adapters addObject:Block_subtitle_colorblock_3_cell.fixedHeightTypeDataAdapter];
    }
}

- (void)didSelectedBlockItems:(BaseBlockItem *)blockItem {
    
    blockItem.itemId         = @(self.itemId);
    blockItem.htmlFolderName = self.htmlFolderName;
    
    BlockInputInfoEditViewController *controller = [BlockInputInfoEditViewController new];
    controller.blockItem                         = blockItem;
    controller.type                              = BlockInputInfoEditViewControllerType_Add;
    controller.title                             = @"信息编辑";
    [self.navigationController pushViewController:controller animated:YES];
}

@end
