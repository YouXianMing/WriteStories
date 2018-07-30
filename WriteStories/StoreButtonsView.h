//
//  StoreButtonsView.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/5.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreViewController.h"
@class StoreButtonsView;

@protocol StoreButtonsViewDelegate <NSObject>

- (void)storeButtonsView:(StoreButtonsView *)buttonsView selected:(StoreViewControllerSelectedItem)selectedItem;

@end

@interface StoreButtonsView : UIView

@property (nonatomic, weak) id <StoreButtonsViewDelegate> delegate;
@property (nonatomic) StoreViewControllerSelectedItem     selectedItem;

@end
