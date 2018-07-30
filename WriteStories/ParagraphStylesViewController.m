//
//  ParagraphStylesViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ParagraphStylesViewController.h"

#import "Block_paragraph_normal_cell.h"
#import "Block_paragraph_quote_1_cell.h"
#import "Block_paragraph_quote_2_cell.h"

@interface ParagraphStylesViewController ()

@end

@implementation ParagraphStylesViewController

- (void)registerCellsWithTableView:(UITableView *)tableView {
    
    [Block_paragraph_normal_cell  registerToTableView:tableView];
    [Block_paragraph_quote_1_cell registerToTableView:tableView];
    [Block_paragraph_quote_2_cell registerToTableView:tableView];
}

- (void)addStyleSectionObjectsWithSectionArray:(NSMutableArray <StyleSectionObject *> *)sections {
    
    {
        // -普通-
        StyleSectionObject *section = [StyleSectionObject new];
        section.title               = @"普通";
        [sections addObject:section];
        
        // ParagraphStyleNormalCell
        [section.adapters addObject:Block_paragraph_normal_cell.fixedHeightTypeDataAdapter];
    }
    
    {
        // -引用-
        StyleSectionObject *section = [StyleSectionObject new];
        section.title               = @"引用";
        [sections addObject:section];
        
        // ParagraphStyleQuote_1_Cell
        [section.adapters addObject:Block_paragraph_quote_1_cell.fixedHeightTypeDataAdapter];
        
        // ParagraphStyleQuote_2_Cell
        [section.adapters addObject:Block_paragraph_quote_2_cell.fixedHeightTypeDataAdapter];
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
