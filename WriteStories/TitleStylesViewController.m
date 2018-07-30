//
//  TitleStylesViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "TitleStylesViewController.h"
#import "Block_title_normal_1_cell.h"
#import "Block_title_picture_1_cell.h"
#import "ScaleSelectedView.h"

@interface TitleStylesViewController ()

@end

@implementation TitleStylesViewController

- (void)registerCellsWithTableView:(UITableView *)tableView {
    
    [Block_title_normal_1_cell  registerToTableView:tableView];
    [Block_title_picture_1_cell registerToTableView:tableView];
}

- (void)addStyleSectionObjectsWithSectionArray:(NSMutableArray <StyleSectionObject *> *)sections {
    
    {
        // -普通-
        StyleSectionObject *section = [StyleSectionObject new];
        section.title               = @"普通";
        [sections addObject:section];
        
        // Block_title_normal_1_cell
        [section.adapters addObject:Block_title_normal_1_cell.fixedHeightTypeDataAdapter];
    }
    
    {
        // -图文-
        StyleSectionObject *section = [StyleSectionObject new];
        section.title               = @"图文";
        [sections addObject:section];
        
        // Block_title_picture_1_cell
        [section.adapters addObject:Block_title_picture_1_cell.fixedHeightTypeDataAdapter];
    }
}

- (void)didSelectedBlockItems:(BaseBlockItem *)blockItem {
    
    blockItem.itemId         = @(self.itemId);
    blockItem.htmlFolderName = self.htmlFolderName;
    
    // 设定给定的值
    NSDictionary<NSString *,NSArray<EncodeImageObject *> *> *key_values = blockItem.key_imageObjects;
    if (key_values.allKeys.count) {
        
        NSArray <EncodeImageObject *> *arrays = key_values.allValues.firstObject;
        [ScaleSelectedView scaleSelectedViewShowWithImageObjects:arrays selectedBlock:^(EncodeImageObject *imageObject) {
            
            // 更新blockItem的imageObject
            [blockItem setValue:imageObject forKey:key_values.allKeys.firstObject];
            
            BlockInputInfoEditViewController *controller = [BlockInputInfoEditViewController new];
            controller.blockItem                         = blockItem;
            controller.type                              = BlockInputInfoEditViewControllerType_Add;
            controller.title                             = @"信息编辑";
            [self.navigationController pushViewController:controller animated:YES];
        }];
        
    } else {
        
        BlockInputInfoEditViewController *controller = [BlockInputInfoEditViewController new];
        controller.blockItem                         = blockItem;
        controller.type                              = BlockInputInfoEditViewControllerType_Add;
        controller.title                             = @"信息编辑";
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
