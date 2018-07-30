//
//  StyleManagerEditViewCell.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/22.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseCustomCollectionCell.h"

typedef enum : NSUInteger {
    
    StyleManagerEditViewCellSelect = 1000,
    StyleManagerEditViewCellEdit,
    StyleManagerEditViewCellDelete,
    
} StyleManagerEditViewCellEvent;

@interface StyleManagerEditViewCell : BaseCustomCollectionCell

@end
