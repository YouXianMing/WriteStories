//
//  BaseHtmlBodyItem.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "WriteStoriesBaseItemObject.h"
#import "OutterAndInnerDivs.h"
#import "Values.h"
#import "HexColors.h"
#import "FoldersManager.h"

#import "ItemColorSetupView.h"
#import "ValuesPickerSetupView.h"
#import "PatternImagesSetupView.h"
#import "GradientImagesSetupView.h"

@interface BaseHtmlBodyItem : WriteStoriesBaseItemObject

- (NSString *)bodyString;

- (NSString *)jsConfig;

@end
