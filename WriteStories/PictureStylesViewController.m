//
//  PictureStylesViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "PictureStylesViewController.h"
#import "ScaleSelectedView.h"

#import "Block_picture_normal_1_cell.h"
#import "Block_picture_normal_2_cell.h"
#import "Block_picture_normal_3_cell.h"

@interface PictureStylesViewController ()

@end

@implementation PictureStylesViewController

- (void)registerCellsWithTableView:(UITableView *)tableView {
    
    [Block_picture_normal_1_cell   registerToTableView:tableView];
    [Block_picture_normal_2_cell   registerToTableView:tableView];
    [Block_picture_normal_3_cell   registerToTableView:tableView];
}

- (void)addStyleSectionObjectsWithSectionArray:(NSMutableArray <StyleSectionObject *> *)sections {
    
    {
        // -纯图片-
        StyleSectionObject *section = [StyleSectionObject new];
        section.title               = @"纯图片";
        [sections addObject:section];

        // Block_picture_normal_1_cell
        [section.adapters addObject:Block_picture_normal_1_cell.fixedHeightTypeDataAdapter];
    }
    
    {
        // -上图下文-
        StyleSectionObject *section = [StyleSectionObject new];
        section.title               = @"上图下文";
        [sections addObject:section];

        // Block_picture_normal_2_cell
        [section.adapters addObject:Block_picture_normal_2_cell.fixedHeightTypeDataAdapter];
    }
    
    {
        // -上文下图-
        StyleSectionObject *section = [StyleSectionObject new];
        section.title               = @"上文下图";
        [sections addObject:section];
        
        // Block_picture_normal_2_cell
        [section.adapters addObject:Block_picture_normal_3_cell.fixedHeightTypeDataAdapter];
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
