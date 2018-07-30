//
//  SetupViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/24.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import "SetupViewController.h"
#import "NoticeInfoCell.h"
#import "SetupViewSpaceCell.h"
#import "SetupViewSwitchCell.h"
#import "SetupViewSwitchCellModel.h"
#import "SetupViewSelectCell.h"
#import "Values.h"
#import "LoadingView.h"
#import "AppleProducts.h"
#import "ProductPayment.h"
#import "PaymentObject.h"
#import "WSAlertView.h"
#import "GCD.h"

#import "PasswordViewController.h"
#import "AboutViewController.h"
#import "StoreViewController.h"

@interface SetupViewController () <UITableViewDelegate, UITableViewDataSource, CustomCellDelegate, CustomViewControllerDelegate, AppleProductsDelegate, ProductPaymentDelegate, MFMailComposeViewControllerDelegate> {
    
    SetupViewSwitchCellModel *_passwordModel;
}

@property (nonatomic, strong) LoadingView    *loadingView;
@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

@property (nonatomic, strong) AppleProducts  *products;
@property (nonatomic, strong) ProductPayment *productPayment;

@end

@implementation SetupViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView                 = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset    = UIEdgeInsetsMake(0, 0, 20, 0);
    [self.contentView addSubview:self.tableView];
    
    [NoticeInfoCell      registerToTableView:self.tableView];
    [SetupViewSpaceCell  registerToTableView:self.tableView];
    [SetupViewSwitchCell registerToTableView:self.tableView];
    [SetupViewSelectCell registerToTableView:self.tableView];
    
    self.adapters = [NSMutableArray array];
    
    SetupViewSwitchCellModel *model_1 = [SetupViewSwitchCellModel modelWithTitle:@"密码"
                                                                        subTitle:@"开启后，进入私密模块需要输入密码。"
                                                                        switchOn:Values.Passwords.count ? YES : NO
                                                                    switchEnable:YES];
    _passwordModel = model_1;
    
    BOOL previewMode   = Values.PreviewMode;
    BOOL previewEnable = YES;
    
    SetupViewSwitchCellModel *model_2 = [SetupViewSwitchCellModel modelWithTitle:@"预览模式"
                                                                        subTitle:@"开启后，所有内容不能创建、编辑、删除或者移动。"
                                                                        switchOn:previewMode
                                                                    switchEnable:previewEnable];
    
    [self.adapters addObject:SetupViewSpaceCell.fixedHeightTypeDataAdapter];
    [self.adapters addObject:[SetupViewSwitchCell fixedHeightTypeDataAdapterWithData:model_1]];
    [self.adapters addObject:[SetupViewSwitchCell fixedHeightTypeDataAdapterWithData:model_2]];
    
    [self.adapters addObject:SetupViewSpaceCell.fixedHeightTypeDataAdapter];
    [self.adapters addObject:[SetupViewSelectCell fixedHeightTypeDataAdapterWithData:@"关于"]];
    [self.adapters addObject:[SetupViewSelectCell fixedHeightTypeDataAdapterWithData:@"商店"]];
    [self.adapters addObject:[SetupViewSelectCell fixedHeightTypeDataAdapterWithData:@"去 App Store 评价"]];
    
    [self.adapters addObject:SetupViewSpaceCell.fixedHeightTypeDataAdapter];
    [self.adapters addObject:[SetupViewSelectCell fixedHeightTypeDataAdapterWithData:@"立即反馈"]];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.adapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter *adapter = self.adapters[indexPath.row];
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    cell.dataAdapter = adapter;
    cell.data        = adapter.data;
    cell.delegate    = self;
    [cell loadContent];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.adapters[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:SetupViewSelectCell.class]) {
        
        if ([cell.data isEqualToString:@"关于"]) {
            
            AboutViewController *controller = [AboutViewController new];
            controller.title                = @"关于";
            [self.navigationController pushViewController:controller animated:YES];
            
        } else if ([cell.data isEqualToString:@"去 App Store 评价"]) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1390862464"]];
                        
        } else if ([cell.data isEqualToString:@"立即反馈"]) {
            
            [self feedback];
            
        } else if ([cell.data isEqualToString:@"恢复购买"]) {
            
            self.loadingView             = [LoadingView loadingViewStartLoadingInKeyWindow];
            self.productPayment          = [ProductPayment new];
            self.productPayment.delegate = self;
            [self.productPayment restoreCompletedPayments];
            
        } else if ([cell.data isEqualToString:@"商店"]) {
            
            StoreViewController *controller = [StoreViewController new];
            controller.title                = @"商店";
            controller.selectedItem         = StoreViewControllerSelectedItem_Folder;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}

#pragma mark - AppleProductsDelegate

- (void)appleProductsDidFinish:(AppleProducts *)appleProducts {
    
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

- (void)productDidPaymentWithResult:(ProductPaymentResult)result productIDs:(NSArray<NSString *> *)productIDs {
    
    [self.loadingView stopLoading];
    
    if /* 内购成功 */ (result == ProductPaymentResultPurchasedSuccess) {
        
        [self removeRestict];
        
    } /* 内购失败 */ else if (result == ProductPaymentResultPurchasedFailed) {
        
        [WSAlertView showAlertViewWithMessage:@"购买失败，请稍后再试！"
                            messageBoldRanges:@[]
                                  buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"我知道了")]
                                         type:WSAlertViewTypeError
                                     delegate:nil
                                   weakObject:nil
                                          tag:0
                                selectedBlock:nil];
        
    } /* 恢复内购成功 */ else if (result == ProductPaymentResultPurchasedDidRestoredSuccess) {

        __block BOOL success = NO;
        [productIDs enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            if ([obj isEqualToString:@"com.YouXianMing.WriteStories.1"]) {
                
                success = YES;
            }
        }];
        
        if (success) {
            
            [self removeRestict];
            [WSAlertView showAlertViewWithMessage:@"恢复购买成功！"
                                messageBoldRanges:@[]
                                      buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"我知道了")]
                                             type:WSAlertViewTypeSuccess
                                         delegate:nil
                                       weakObject:nil
                                              tag:0
                                    selectedBlock:nil];
            
        } else {
            
            [WSAlertView showAlertViewWithMessage:@"您此前没有购买完全版，无法恢复！"
                                messageBoldRanges:@[]
                                      buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"我知道了")]
                                             type:WSAlertViewTypeError
                                         delegate:nil
                                       weakObject:nil
                                              tag:0
                                    selectedBlock:nil];
        }
        
    } /* 恢复内购失败 */ else if (result == ProductPaymentResultPurchasedDidRestoredFailed) {
        
        [WSAlertView showAlertViewWithMessage:@"恢复购买失败，请稍后再试！"
                            messageBoldRanges:@[]
                                  buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"我知道了")]
                                         type:WSAlertViewTypeError
                                     delegate:nil
                                   weakObject:nil
                                          tag:0
                                selectedBlock:nil];
    }
}

#pragma mark - removeRestict

- (void)removeRestict {
    
    // 删除数据源
    NSMutableIndexSet *set = [NSMutableIndexSet indexSet];
    [set addIndex:0];
    [set addIndex:5];
    [set addIndex:6];
    [self.adapters removeObjectsAtIndexes:set];
    
    // 更新tableView
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0],
                                             [NSIndexPath indexPathForRow:5 inSection:0],
                                             [NSIndexPath indexPathForRow:6 inSection:0]]
                          withRowAnimation:UITableViewRowAnimationTop];
    
    // 更新购买状态
    [PaymentObject updateVersion];
    
    // 开启预览模式
    [GCDQueue executeInMainQueue:^{
        
        [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj.data isKindOfClass:SetupViewSwitchCellModel.class]) {
                
                SetupViewSwitchCellModel *model = obj.data;
                if ([model.title isEqualToString:@"预览模式"]) {
                    
                    model.switchEnable = YES;
                    *stop              = YES;
                    [self.tableView reloadData];
                }
            }
        }];
        
    } afterDelaySecs:1.f];
}

#pragma mark - CustomCellDelegate

- (void)customCell:(CustomCell *)cell event:(id)event {
    
    if ([cell isKindOfClass:SetupViewSwitchCell.class]) {
        
        SetupViewSwitchCellModel *model = cell.dataAdapter.data;
        
        if ([model.title isEqualToString:@"预览模式"]) {
            
            model.switchOn     = [event boolValue];
            Values.PreviewMode = [event boolValue];
            
        } else if ([model.title isEqualToString:@"密码"]) {
            
            if (model.switchOn == NO) {
                
                PasswordViewController *controller = [PasswordViewController new];
                controller.type                    = PasswordViewControllerTypeSetNewPassword;
                controller.eventDelegate           = self;
                [self.navigationController presentViewController:controller animated:YES completion:nil];
                
            } else {
                
                PasswordViewController *controller = [PasswordViewController new];
                controller.type                    = PasswordViewControllerTypeDeletePassword;
                controller.eventDelegate           = self;
                [self.navigationController presentViewController:controller animated:YES completion:nil];
            }
        }
    }
}

#pragma mark - CustomViewControllerDelegate

- (void)baseCustomViewController:(__kindof CustomViewController *)controller event:(id)event {
    
    if ([controller isKindOfClass:PasswordViewController.class]) {

        PasswordViewController *passwordController = (PasswordViewController *)controller;
        
        if /* 设定新密码 */ (passwordController.type == PasswordViewControllerTypeSetNewPassword) {
            
            PasswordViewControllerResult result = [event integerValue];
            
            if (result == PasswordViewControllerResultSuccess) {

                _passwordModel.switchOn = YES;
                [self.tableView reloadData];
                
            } else if (result == PasswordViewControllerResultCancel) {
                
                _passwordModel.switchOn = NO;
                [self.tableView reloadData];
            }
            
        } /* 删除密码 */ else if (passwordController.type == PasswordViewControllerTypeDeletePassword) {
            
            PasswordViewControllerResult result = [event integerValue];
            
            if (result == PasswordViewControllerResultSuccess) {
                
                _passwordModel.switchOn = NO;
                [self.tableView reloadData];
                
            } else if (result == PasswordViewControllerResultCancel) {
                
                _passwordModel.switchOn = YES;
                [self.tableView reloadData];
            }
        }
    }
}

- (void)feedback {
    
    // body
    NSString *body = @"<div style=\"font: normal 400 18px/28px PingFangSC-thin; text-indent: 0px;\">\
                            <p>反馈信息:&nbsp&nbsp</p>\
                            </div>";
    
    if ([MFMailComposeViewController canSendMail] && [MFMessageComposeViewController canSendText]) {

        // 控制器模式
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
        mailController.mailComposeDelegate          = self;

        [mailController setToRecipients:@[@"YouXianMing1987@iCloud.com"]];
        [mailController setSubject:[NSString stringWithFormat:@"反馈"]];
        [mailController setMessageBody:body isHTML:YES];
        [self presentViewController:mailController animated:YES completion:nil];

    } else {
        
        // mailto:方式
        NSMutableString *mailUrl = [[NSMutableString alloc] init];
        [mailUrl appendFormat:@"mailto:YouXianMing1987@iCloud.com"];
        [mailUrl appendFormat:@"?&subject=反馈"];
        [mailUrl appendFormat:@"&body=%@", body];
        NSString *emailPath = [mailUrl stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:emailPath]];
    }
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(nullable NSError *)error {
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
