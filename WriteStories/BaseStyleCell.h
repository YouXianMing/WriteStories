//
//  BaseStyleCell.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "CustomCell.h"
#import "UIFont+Project.h"
#import "UIColor+Project.h"
#import "UIView+SetRect.h"
#import "NSString+LabelWidthAndHeight.h"
#import "HexColors.h"
#import "BaseBlockItem.h"

@interface BaseStyleCell : CustomCell

@property (nonatomic, readonly) BaseBlockItem *blockItem;

@end
