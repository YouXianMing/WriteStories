//
//  HtmlEditViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/28.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "HtmlEditViewController.h"
#import <WebKit/WebKit.h>
#import "BackgroundStyleViewController.h"
#import "FileManager.h"
#import "FoldersManager.h"
#import "JSReturnModel.h"
#import "SheetMenuView.h"
#import "SheetMenuObject.h"
#import "StyleAdjustEditView.h"
#import "Table_Style_List.h"
#import "WSAlertView.h"
#import "StyleSaveView.h"
#import "StyleManagerEditView.h"
#import "GCD.h"
#import "UserDefaults.h"
#import "PopMenuView.h"
#import "PopMenuObject.h"
#import "BaseHtmlBodyItem.h"
#import "Animation_Set.h"
#import "Animation_Set_View.h"

typedef enum : NSUInteger {
    
    HtmlEditTag_DIV = 1000,
    HtmlEditTag_BODY,
    HtmlEditTag_ANIMATION,
    
} HtmlEditTag;

@interface HtmlEditViewController () <WKNavigationDelegate, WKScriptMessageHandler, BaseWindowMenuViewDelegate, EditViewDelegate, StyleManagerEditViewDelegate, CustomViewControllerDelegate> {
    
    CircleIconButton *_backButton;
    CircleIconButton *_moreButton;
}

@property (nonatomic, strong) NSMutableDictionary <NSNumber *, BaseBlockItem *> *saveItems;

@property (nonatomic) BOOL                   blockJSMessage;
@property (nonatomic, weak)   BaseBlockItem *currentTapedItem;
@property (nonatomic, strong) SheetMenuView *menuView;
@property (nonatomic, strong) WKWebView     *wkWebView;

@property (nonatomic, strong) BaseHtmlBodyItem *bodyItem;

@property (nonatomic, strong) Animation_Set      *animationSet;
@property (nonatomic, strong) Animation_Set_View *animationSetView;

@end

@implementation HtmlEditViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 读取body配置文件
    NSString *dataPath = [NSString stringWithFormat:@"%@/Block_body/block/block.data", self.htmlFolder];
    self.bodyItem      = [BaseHtmlBodyItem decodeWithData:[NSData dataWithContentsOfFile:dataPath]];
    
    self.saveItems = [NSMutableDictionary dictionary];
    
    // 配置文件
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    // 设置偏好设置
    config.preferences = [[WKPreferences alloc] init];
    
    // web内容处理池
    config.processPool = [[WKProcessPool alloc] init];
    
    // 通过JS与webview内容交互
    config.userContentController = [[WKUserContentController alloc] init];
    [config.userContentController addScriptMessageHandler:self name:@"AppModel"];
    
    // Load html text from Document.
    NSURL *htmlUrl            = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/content.html", self.htmlFolder]];
    NSURL *relatedDocumentUrl = [NSURL fileURLWithPath:FoldersManager.ArticleList];
    
    // Use WKWebView to load the html files.
    self.wkWebView                    = [[WKWebView alloc]initWithFrame:self.contentView.bounds configuration:config];
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.alpha              = 0.f;
    self.wkWebView.backgroundColor    = [UIColor clearColor];
    self.wkWebView.opaque             = NO;
    [self.wkWebView loadFileURL:htmlUrl allowingReadAccessToURL:relatedDocumentUrl];
    [self.contentView addSubview:self.wkWebView];
    
    // 读取动画配置文件
    NSString *animationPath = FmtStr(@"%@/animationSet.data", self.htmlFolder);
    self.animationSet       = [Animation_Set decodeWithData:[NSData dataWithContentsOfFile:animationPath]];
    
    // 加载动画页面
    self.animationSetView            = [[Animation_Set_View alloc] initWithFrame:CGRectMake(0, 0, Width, 0)];
    self.animationSetView.scrollView = self.wkWebView.scrollView;
    [self.animationSetView startObserveValue];
    [self.animationSetView firstTimeLoadAnimation_Set:self.animationSet];
    [self.wkWebView.scrollView addSubview:self.animationSetView];
    
    [self buildButtons];
}

#pragma makr - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
//    [self.wkWebView evaluateJavaScript:@"document.readyState" completionHandler:^(id data, NSError * _Nullable error) {
//
//        // 加载成功后进行处理
//        if ([data isEqualToString:@"complete"]) {
//
//            NSLog(@"%@", self.wkWebView);
//            NSLog(@"%@", self.wkWebView.scrollView);
//        }
//    }];
    
    [UIView animateKeyframesWithDuration:0.5f delay:0.15 options:0 animations:^{
        
        webView.alpha = 1.f;
        
    } completion:^(BOOL finished) {
        
        if (UserDefaults.EditHtmlNotShowNotice == NO) {
            
            [self.wkWebView showDebugFrame:YES completion:nil];
            
            [WSAlertView showAlertViewWithMessage:@"点击任意元素进行样式调整或者从样式管理中读取您之前存储的样式！"
                                messageBoldRanges:@[[NSValue valueWithRange:NSMakeRange(8, 4)],
                                                    [NSValue valueWithRange:NSMakeRange(15, 4)]]
                                      buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"我知道了")]
                                             type:WSAlertViewTypeMessage
                                         delegate:nil
                                       weakObject:nil
                                              tag:0
                                    selectedBlock:^(WSAlertViewButtonInfo *buttonInfo) {
                                        
                                        [self.wkWebView showDebugFrame:NO completion:nil];
                                        
                                        // if (buttonInfo.type == WSAlertViewButtonTypeConfirm) {
                                        //
                                        //    UserDefaults.EditHtmlNotShowNotice = YES;
                                        // }
                                    }];
        }
    }];
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
 
    if (self.blockJSMessage == NO && [message.name isEqualToString:@"AppModel"]) {
        
        JSReturnModel *model = [JSReturnModel modelWithBody:message.body];
        
        if (model.function == Function_GetDivInfoById) {
            
            // 找到点击的BaseBlockItem
            NSString *itemId = model.parameters.firstObject;
            __block BaseBlockItem *selectedItem = nil;
            [self.blockItems enumerateObjectsUsingBlock:^(BaseBlockItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj.itemIdString isEqualToString:itemId]) {
                    
                    selectedItem = obj;
                    *stop        = YES;
                }
            }];
            
            // 用于返回时进行存储
            self.saveItems[selectedItem.itemId] = selectedItem;
            
            // 样式调整 + 样式管理
            self.currentTapedItem = selectedItem;
            self.menuView = [SheetMenuView menuViewWithDelegate:self datas:@[[SheetMenuObject sheetMenuObjectWithIndex:0 title:@"样式调整"],
                                                                             [SheetMenuObject sheetMenuObjectWithIndex:2 title:@"样式管理"]]];
            [self.menuView show];
            
            
        } else if (model.function == Function_SetDivInfoById) {
            
            NSLog(@"divInfo = %@", model.data);
        }
        
    } else if (self.blockJSMessage == YES && [message.name isEqualToString:@"AppModel"]) {
        
        JSReturnModel *model = [JSReturnModel modelWithBody:message.body];
        
        if (model.function == Function_SetBodyInfo) {
            
            NSLog(@"bodyInfo = %@", model.data);
            NSString *dataPath = [NSString stringWithFormat:@"%@/Block_body/block/block.data", self.htmlFolder];
            [self.bodyItem.encodeData writeToFile:dataPath atomically:YES];
        }
    }
}

#pragma mark - BaseWindowMenuViewDelegate

- (void)windowMenuViewWillShow:(BaseWindowMenuView *)windowMenuView {
    
}

- (void)windowMenuViewDidShow:(BaseWindowMenuView *)windowMenuView {
    
}

- (void)windowMenuViewWillHide:(BaseWindowMenuView *)windowMenuView {
    
}

- (void)windowMenuViewDidHide:(BaseWindowMenuView *)windowMenuView {
    
}

- (void)windowMenuView:(BaseWindowMenuView *)windowMenuView didSelectedIndex:(NSInteger)index selectedData:(id <MenuViewObject>)data {
    
    if ([windowMenuView isKindOfClass:SheetMenuView.class]) {
        
        if ([data.menuViewTitleName isEqualToString:@"样式调整"]) {
            
            EditView *editView   = [StyleAdjustEditView new];
            editView.delegate    = self;
            editView.editManager = self.currentTapedItem.editManager;
            editView.tag         = HtmlEditTag_DIV;
            [editView showInContentView:self.contentView];
            
        } else if ([data.menuViewTitleName isEqualToString:@"样式管理"]) {
            
            StyleManagerEditView *editView = [StyleManagerEditView new];
            editView.styles                = [Table_Style_List styleObjectsByShowStyleType:[self.currentTapedItem.class ShowStyleType]];
            editView.delegate              = self;
            editView.styleDelegate         = self;
            editView.tag                   = HtmlEditTag_DIV;
            [editView showInContentView:self.contentView];
        }
        
    } else if ([windowMenuView isKindOfClass:PopMenuView.class]) {
        
        if ([data.menuViewTitleName isEqualToString:@"更换背景样式"]) {
            
            BackgroundStyleViewController *controller = [BackgroundStyleViewController new];
            controller.title                          = @"背景样式";
            controller.eventDelegate                  = self;
            [self.navigationController pushViewController:controller animated:YES];
            
        } else if ([data.menuViewTitleName isEqualToString:@"背景样式调整"]) {
            
            EditView *editView   = [StyleAdjustEditView new];
            editView.delegate    = self;
            editView.editManager = self.bodyItem.editManager;
            editView.tag         = HtmlEditTag_BODY;
            [editView showInContentView:self.contentView];
            
        } else if ([data.menuViewTitleName isEqualToString:@"背景样式读取"]) {
            
            StyleManagerEditView *editView = [StyleManagerEditView new];
            editView.styles                = [Table_Style_List styleObjectsByShowStyleType:[self.bodyItem.class ShowStyleType]];
            editView.delegate              = self;
            editView.styleDelegate         = self;
            editView.tag                   = HtmlEditTag_BODY;
            [editView showInContentView:self.contentView];
            
        } else if ([data.menuViewTitleName isEqualToString:@"动画效果设置"]) {
            
            EditView *editView              = [StyleAdjustEditView new];
            editView.delegate               = self;
            editView.editManager            = self.animationSet.editManager;
            editView.tag                    = HtmlEditTag_ANIMATION;
            editView.hideManagerSavedButton = YES;
            [editView showInContentView:self.contentView];
        }
    }
}

#pragma mark - StyleManagerEditViewDelegate

- (void)styleManagerEditView:(StyleManagerEditView *)editView selectedStyle:(WriteStoriesBaseItemObject *)style {
    
    if (editView.tag == HtmlEditTag_DIV) {
        
        [self.currentTapedItem useStyleObject:style];
        [self.wkWebView setDivInfoById:self.currentTapedItem.itemIdString json:[self.currentTapedItem jsonConfigWithDebug:YES] completion:nil];

    } else if (editView.tag == HtmlEditTag_BODY) {
        
        [self.bodyItem useStyleObject:style];
        [self.wkWebView setBodyInfoWithJson:self.bodyItem.jsConfig completion:nil];
    }
}

#pragma mark - EditViewDelete

- (void)editViewDidUpdateValues:(EditView *)editView {
    
    if (editView.tag == HtmlEditTag_DIV) {
        
        [self.wkWebView setDivInfoById:self.currentTapedItem.itemIdString json:[self.currentTapedItem jsonConfigWithDebug:YES] completion:nil];
        
    } else if (editView.tag == HtmlEditTag_BODY) {
        
        [self.wkWebView setBodyInfoWithJson:self.bodyItem.jsConfig completion:nil];
        
    } else if (editView.tag == HtmlEditTag_ANIMATION) {
        
        [self.animationSetView loadAnimation_Set:self.animationSet];
    }
}

- (void)editViewButtonEvent:(EditView *)editView {
    
    WriteStoriesBaseItemObject *itemObject = nil;
    
    if (editView.tag == HtmlEditTag_DIV) {
        
        itemObject = self.currentTapedItem;
        
    } else {
        
        itemObject = self.bodyItem;
    }
    
    if ([Table_Style_List styleCountsByItemObject:itemObject] >= 10) {
        
        [WSAlertView showAlertViewWithMessage:@"每种样式风格最多只能存储10种！"
                            messageBoldRanges:@[[NSValue valueWithRange:NSMakeRange(12, 2)]]
                                  buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"我知道了")]
                                         type:WSAlertViewTypeError
                                     delegate:nil weakObject:nil tag:0 selectedBlock:nil];
        return;
    }
    
    [StyleSaveView styleSaveViewShowWithText:@"自定义样式" delegate:nil confirmEvent:^(NSString *text) {
        
        [Table_Style_List storeStyleObject:itemObject styleName:text];
        
        [WSAlertView showAlertViewWithMessage:[NSString stringWithFormat:@"%@存储成功。您可以在样式管理中进行设置、修改、删除操作！", text]
                            messageBoldRanges:@[[NSValue valueWithRange:NSMakeRange(0, text.length)], [NSValue valueWithRange:NSMakeRange(text.length + 9, 4)]]
                                  buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"我知道了")]
                                         type:WSAlertViewTypeSuccess
                                     delegate:nil
                                   weakObject:nil
                                          tag:0
                                selectedBlock:nil];
    }];
}

- (void)editViewWillShow:(EditView *)editView {
    
    // 让button失效
    _backButton.enabled = NO;
    _moreButton.enabled = NO;
    
    if (editView.tag == HtmlEditTag_DIV) {
        
        // 显示网格
        [self.wkWebView showDebugFrame:YES completion:nil];
        
        // 开始进行值的设定
        [self.wkWebView setDivInfoById:self.currentTapedItem.itemIdString json:[self.currentTapedItem jsonConfigWithDebug:YES] completion:nil];
    }
    
    // 设置blockJSMessage为YES
    self.blockJSMessage = YES;
    
    // 调整wkWebView的位置
    [UIView animateWithDuration:0.25 animations:^{
        
        self.wkWebView.frame = CGRectMake(0, 0, Width, self.contentView.height - editView.height + 50.f);
    }];
}

- (void)editViewDidShow:(EditView *)editView {
    
}

- (void)editViewWillHide:(EditView *)editView {
    
    // 让button生效
    _backButton.enabled = YES;
    _moreButton.enabled = YES;
    
    if (editView.tag == HtmlEditTag_DIV) {
        
        // 隐藏网格
        [self.wkWebView showDebugFrame:NO completion:nil];
        
        // 开始进行值的设定
        [self.wkWebView setDivInfoById:self.currentTapedItem.itemIdString json:[self.currentTapedItem jsonConfigWithDebug:NO] completion:nil];
    }
    
    // 设置blockJSMessage为NO
    self.blockJSMessage = NO;
    
    // 调整wkWebView的位置
    [UIView animateWithDuration:0.25 animations:^{
        
        self.wkWebView.frame = CGRectMake(0, 0, Width, self.contentView.height);
    }];
}

- (void)editViewDidHide:(EditView *)editView {
    
}

#pragma mark - CustomViewControllerDelegate

- (void)baseCustomViewController:(__kindof CustomViewController *)controller event:(id)event {
    
    if ([controller isKindOfClass:BackgroundStyleViewController.class]) {
        
        // 更新bodyItem
        self.bodyItem = event;

        // 写数据
        NSString *dataPath = [NSString stringWithFormat:@"%@/Block_body/block/block.data", self.htmlFolder];
        [self.bodyItem.encodeData writeToFile:dataPath atomically:YES];

        // 更新html
        [self.wkWebView setBodyInfoWithJson:self.bodyItem.jsConfig completion:nil];
    }
}

#pragma mark - Buttons

- (void)buildButtons {
    
    // 返回按钮
    _backButton      = [[CircleIconButton alloc] initWithType:CircleIconButtonType_Close];
    _backButton.left = 20.f;
    _backButton.top  = 20.f;
    [self.contentView addSubview:_backButton];
    [_backButton addTarget:self action:@selector(buttonsEvent:)];
    
    // 更多按钮
    _moreButton       = [[CircleIconButton alloc] initWithType:CircleIconButtonType_Background];
    _moreButton.right = Width - 20.f;
    _moreButton.top   = 20.f;
    [self.contentView addSubview:_moreButton];
    [_moreButton addTarget:self action:@selector(buttonsEvent:)];
    
    if (DeviceInfo.isFringeScreen) {
        
        _backButton.top = 20 + DeviceInfo.fringeScreenTopSafeHeight;
        _moreButton.top = 20 + DeviceInfo.fringeScreenTopSafeHeight;
    }
}

- (void)buttonsEvent:(CircleIconButton *)button {
    
    if (button.tag == CircleIconButtonType_Close) {
        
        [GCDQueue executeInGlobalQueue:^{
            
            // 更新动画配置文件
            [self.animationSet.encodeData writeToFile:FmtStr(@"%@/animationSet.data", self.htmlFolder) atomically:YES];
            
            // 写数据
            [self.saveItems enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, BaseBlockItem *obj, BOOL * _Nonnull stop) {
                
                [obj.encodeData writeToFile:[NSString stringWithFormat:@"%@/%@/block/block.data", self.htmlFolder, obj.folderName]
                                 atomically:YES];
            }];
        }];
        
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        
    } else if (button.tag == CircleIconButtonType_Background) {
        
        CGFloat y = 55.f;
        
        if (DeviceInfo.isFringeScreen) {
            
            y += DeviceInfo.fringeScreenTopSafeHeight;
        }
        
        NSMutableArray *datas = [NSMutableArray array];
        [datas addObject:[PopMenuObject popMenuObjectWithIcon:PopMenuButtonIconTypeChange
                                                         type:PopMenuButtonTitleTypeCyanBold index:0 title:@"更换背景样式"]];
        [datas addObject:[PopMenuObject popMenuObjectWithIcon:PopMenuButtonIconTypeBackgroundAdjust
                                                         type:PopMenuButtonTitleTypeNormal   index:1 title:@"背景样式调整"]];
        [datas addObject:[PopMenuObject popMenuObjectWithIcon:PopMenuButtonIconTypeBackgroundManager
                                                         type:PopMenuButtonTitleTypeNormal   index:2 title:@"背景样式读取"]];
        [datas addObject:[PopMenuObject popMenuObjectWithIcon:PopMenuButtonIconTypeAnimationSet
                                                         type:PopMenuButtonTitleTypeNormal   index:3 title:@"动画效果设置"]];
        
        PopMenuView *menuView = [PopMenuView menuViewWithDelegate:self datas:datas];
        
        [menuView showAtPoint:CGPointMake(Width - 25.f, y)];
    }
}

#pragma mark - System

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    self.enableInteractivePopGestureRecognizer = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    self.enableInteractivePopGestureRecognizer = NO;
}

@end
