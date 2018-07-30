//
//  StyleManagerEditView.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/17.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "EditView.h"
#import "WriteStoriesBaseItemObject.h"
@class StyleManagerEditView;

@protocol StyleManagerEditViewDelegate <NSObject>

- (void)styleManagerEditView:(StyleManagerEditView *)editView selectedStyle:(WriteStoriesBaseItemObject *)style;

@end

@interface StyleManagerEditView : EditView

@property (nonatomic, weak)   id <StyleManagerEditViewDelegate> styleDelegate;
@property (nonatomic, strong) NSArray <WriteStoriesBaseItemObject *> *styles;

@end
