//
//  StoreViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/5.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "StoreViewController.h"
#import "StoreButtonsView.h"
#import "UIView+SetRect.h"
#import "PaymentsManager.h"

#import "StoreFolderView.h"
#import "StoreArticleView.h"
#import "StoreBackgroundView.h"
#import "AppleProducts.h"
#import "ProductPayment.h"
#import "LoadingView.h"
#import "WSAlertView.h"

@interface StoreViewController () <StoreButtonsViewDelegate, AppleProductsDelegate, ProductPaymentDelegate, BaseStoreCollectionViewDelegate>

@property (nonatomic, strong) UIButton *restoreButton;

@property (nonatomic, strong) StoreButtonsView *buttonsView;

@property (nonatomic, strong) StoreFolderView     *storeFolderView;
@property (nonatomic, strong) StoreArticleView    *storeArticleView;
@property (nonatomic, strong) StoreBackgroundView *storeBackgroundView;

@property (nonatomic, strong) LoadingView *loadingView;

@property (nonatomic, strong) AppleProducts  *products;
@property (nonatomic, strong) ProductPayment *productPayment;

@end

@implementation StoreViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.buttonsView              = [[StoreButtonsView alloc] initWithFrame:CGRectMake(0, 0, Width, 50.f)];
    self.buttonsView.selectedItem = self.selectedItem;
    self.buttonsView.delegate     = self;
    [self.contentView addSubview:self.buttonsView];
    
    CGRect rect = CGRectMake(0, self.buttonsView.height, Width, self.contentView.height - self.buttonsView.height);
    
    // 文件夹
    self.storeFolderView          = [[StoreFolderView alloc] initWithFrame:rect];
    self.storeFolderView.delegate = self;
    [self.contentView addSubview:self.storeFolderView];
    
    // 文章标签
    self.storeArticleView          = [[StoreArticleView alloc] initWithFrame:rect];
    self.storeArticleView.delegate = self;
    [self.contentView addSubview:self.storeArticleView];
    
    // 背景
    self.storeBackgroundView          = [[StoreBackgroundView alloc] initWithFrame:rect];
    self.storeBackgroundView.delegate = self;
    [self.contentView addSubview:self.storeBackgroundView];
    
    // 选中的那个
    [self changeToSelectedItem:self.selectedItem animated:NO];
}

#pragma mark - BaseStoreCollectionViewDelegate

- (void)baseStoreCollectionView:(BaseStoreCollectionView *)collectionView didSelectedItemId:(NSString *)itemId {
    
    NSLog(@"%@", itemId);
    
    if ([PaymentsManager.defaultManager didPayByItemID:itemId] == NO) {
    
        [WSAlertView showAlertViewWithMessage:@"您确定要购买该项内容？"
                            messageBoldRanges:@[]
                                  buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"不购买"), buttonInfo(WSAlertViewButtonTypeConfirm, @"购买")]
                                         type:WSAlertViewTypeMessage
                                     delegate:nil
                                   weakObject:nil
                                          tag:0
                                selectedBlock:^(WSAlertViewButtonInfo *buttonInfo) {
                                    
                                    if (buttonInfo.type == WSAlertViewButtonTypeConfirm) {
                                        
                                        self.loadingView         = [LoadingView loadingViewStartLoadingInKeyWindow];
                                        self.products            = [AppleProducts new];
                                        self.products.delegate   = self;
                                        self.products.productIDs = @[itemId];
                                        [self.products startGetProducts];
                                    }
                                }];
    }
}

#pragma mark - restoreButtonEvent

- (void)restoreButtonEvent {
    
    self.loadingView             = [LoadingView loadingViewStartLoadingInKeyWindow];
    self.productPayment          = [ProductPayment new];
    self.productPayment.delegate = self;
    [self.productPayment restoreCompletedPayments];
}

#pragma mark - AppleProductsDelegate

- (void)appleProductsDidFinish:(AppleProducts *)appleProducts {
 
    NSLog(@"%@", appleProducts.products);
    
    self.productPayment          = [ProductPayment new];
    self.productPayment.delegate = self;
    [self.productPayment startPaymentWithProduct:appleProducts.products.firstObject];
}

- (void)appleProductsDidFailed:(AppleProducts *)appleProducts withError:(NSError *)error {
    
    [self.loadingView stopLoading];
    [WSAlertView showAlertViewWithMessage:@"网络异常，请稍后再试！"
                        messageBoldRanges:@[]
                              buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"我知道了")]
                                     type:WSAlertViewTypeError
                                 delegate:nil
                               weakObject:nil
                                      tag:0
                            selectedBlock:nil];
}

#pragma mark - ProductPaymentDelegate

- (void)productDidPaymentWithResult:(ProductPaymentResult)result productIDs:(NSArray <NSString *> *)productIDs {
    
    [self.loadingView stopLoading];
    
    if /* 恢复内购成功 */ (result == ProductPaymentResultPurchasedDidRestoredSuccess) {
        
        NSLog(@"productIDs ==> %@", productIDs);
        if (productIDs.count <= 0) {
            
            [WSAlertView showAlertViewWithMessage:@"您没有购买过商品，无法恢复！"
                                messageBoldRanges:@[]
                                      buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"我知道了")]
                                             type:WSAlertViewTypeError
                                         delegate:nil
                                       weakObject:nil
                                              tag:0
                                    selectedBlock:nil];
            
        } else {
            
            // 更新本地数据
            PaymentsManager *manager = PaymentsManager.defaultManager;
            [productIDs enumerateObjectsUsingBlock:^(NSString *itemId, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [manager.paymentItems enumerateObjectsUsingBlock:^(PaymentItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if ([itemId isEqualToString:item.paymentID]) {
                        
                        item.didPay = YES;
                        *stop       = YES;
                    }
                }];
            }];
            
            [manager store];
            
            // 重新加载页面
            [self.storeFolderView     reloadData];
            [self.storeArticleView    reloadData];
            [self.storeBackgroundView reloadData];
        }
        
    } /* 恢复内购失败 */ else if (result == ProductPaymentResultPurchasedDidRestoredFailed) {
        
        [WSAlertView showAlertViewWithMessage:@"网络异常，请稍后再试！"
                            messageBoldRanges:@[]
                                  buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"我知道了")]
                                         type:WSAlertViewTypeError
                                     delegate:nil
                                   weakObject:nil
                                          tag:0
                                selectedBlock:nil];
        
    } /* 购买成功 */ else if (result == ProductPaymentResultPurchasedSuccess) {
        
        PaymentsManager *manager = PaymentsManager.defaultManager;
        [manager.paymentItems enumerateObjectsUsingBlock:^(PaymentItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([item.paymentID isEqualToString:productIDs.firstObject]) {
                
                item.didPay = YES;
                *stop       = YES;
            }
        }];
        
        [manager store];
        
        // 重新加载页面
        [self.storeFolderView     reloadData];
        [self.storeArticleView    reloadData];
        [self.storeBackgroundView reloadData];
        
    } /* 购买失败 */ else if (result == ProductPaymentResultPurchasedFailed) {
        
        [WSAlertView showAlertViewWithMessage:@"用户取消或网络异常！"
                            messageBoldRanges:@[]
                                  buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"我知道了")]
                                         type:WSAlertViewTypeError
                                     delegate:nil
                                   weakObject:nil
                                          tag:0
                                selectedBlock:nil];
    }
}

#pragma mark - StoreButtonsViewDelegate

- (void)storeButtonsView:(StoreButtonsView *)buttonsView selected:(StoreViewControllerSelectedItem)selectedItem {
    
    if (selectedItem == self.selectedItem) {
        
        return;
    }
    
    self.selectedItem = selectedItem;
    NSLog(@"%lu", (unsigned long)selectedItem);
}

- (void)changeToSelectedItem:(StoreViewControllerSelectedItem)selectedItem animated:(BOOL)animated {
    
    if (selectedItem == StoreViewControllerSelectedItem_Folder) {
        
        [UIView animateWithDuration:animated ? 0.25f : 0 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            self.storeFolderView.alpha     = 1.f;
            self.storeArticleView.alpha    = 0.f;
            self.storeBackgroundView.alpha = 0.f;
            
        } completion:nil];
        
    } else if (selectedItem == StoreViewControllerSelectedItem_Article) {
        
        [UIView animateWithDuration:animated ? 0.25f : 0 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            self.storeFolderView.alpha     = 0.f;
            self.storeArticleView.alpha    = 1.f;
            self.storeBackgroundView.alpha = 0.f;
            
        } completion:nil];
        
    } else if (selectedItem == StoreViewControllerSelectedItem_Background) {
        
        [UIView animateWithDuration:animated ? 0.25f : 0 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            self.storeFolderView.alpha     = 0.f;
            self.storeArticleView.alpha    = 0.f;
            self.storeBackgroundView.alpha = 1.f;
            
        } completion:nil];
    }
}

- (void)backButtonEvent:(TitleMenuButton *)button {
    
    [super backButtonEvent:button];
    
    if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(baseCustomViewController:event:)]) {
        
        [self.eventDelegate baseCustomViewController:self event:nil];
    }
}

#pragma mark - Overwrite

- (void)setSelectedItem:(StoreViewControllerSelectedItem)selectedItem {
    
    _selectedItem = selectedItem;
    [self changeToSelectedItem:selectedItem animated:YES];
}

- (void)setupSubViews {
    
    [super setupSubViews];
    
    self.restoreButton                 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.restoreButton.frame           = CGRectMake(0, 0, 100, self.titleContentView.height);
    self.restoreButton.right           = Width;
    self.restoreButton.tintColor       = UIColor.blackColor;
    self.restoreButton.titleLabel.font = [UIFont PingFangSC_Regular_WithFontSize:16.f];
    [self.restoreButton setTitle:@"恢复购买" forState:UIControlStateNormal];
    self.restoreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.restoreButton.contentEdgeInsets          = UIEdgeInsetsMake(0, 0, 0, 15.f);
    [self.restoreButton addTarget:self action:@selector(restoreButtonEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.titleContentView addSubview:self.restoreButton];
}

@end
