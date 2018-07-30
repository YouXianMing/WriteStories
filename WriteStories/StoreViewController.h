//
//  StoreViewController.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/5.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "NormalTitleViewController.h"

typedef enum : NSUInteger {
    
    StoreViewControllerSelectedItem_Folder = 0,
    StoreViewControllerSelectedItem_Article,
    StoreViewControllerSelectedItem_Background,
    
} StoreViewControllerSelectedItem;

@interface StoreViewController : NormalTitleViewController

@property (nonatomic) StoreViewControllerSelectedItem  selectedItem;

@end
