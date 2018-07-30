//
//  BaseCustomNavigationController.h
//  PersonalLibs
//
//  Created by YouXianMing on 2017/6/25.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCustomViewController.h"
@class BaseCustomNavigationController;

@protocol CustomNavigationControllerDelegate <NSObject>

@optional

/**
 The BaseCustomNavigationController's event.

 @param navigationController The BaseCustomNavigationController.
 @param controller The controller.
 @param event Event.
 */
- (void)baseCustomNavigationController:(__kindof BaseCustomNavigationController *)navigationController
                            controller:(BaseCustomViewController *)controller
                                 event:(id)event;

@end

@interface BaseCustomNavigationController : UINavigationController

/**
 The event delegate.
 */
@property (nonatomic, weak) id <CustomNavigationControllerDelegate> eventDelegate;

/**
 Get the BaseCustomNavigationController with the root BaseCustomViewController.

 @param rootViewController The root BaseCustomViewController.
 @param hidden Hidden or not.
 @return BaseCustomNavigationController object.
 */
- (instancetype)initWithRootViewController:(BaseCustomViewController *)rootViewController
                    setNavigationBarHidden:(BOOL)hidden;

@end
