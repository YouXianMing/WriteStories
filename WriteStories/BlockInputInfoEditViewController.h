//
//  BlockInputInfoEditViewController.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "NormalTitleViewController.h"
#import "BaseBlockItem.h"

typedef enum : NSUInteger {
    
    BlockInputInfoEditViewControllerType_Add,
    BlockInputInfoEditViewControllerType_Edit,
    
} BlockInputInfoEditViewControllerType;

@interface BlockInputInfoEditViewController : NormalTitleViewController

@property (nonatomic)         BlockInputInfoEditViewControllerType  type;
@property (nonatomic, strong) BaseBlockItem                        *blockItem;

@end
