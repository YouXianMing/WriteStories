//
//  ArticleDetailViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/25.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ArticleDetailViewController.h"
#import <WebKit/WebKit.h>
#import "ArticleEditViewController.h"
#import "BlocksManager.h"
#import "FileManager.h"
#import "FoldersManager.h"
#import "LoadingView.h"
#import "BaseHtmlBodyItem.h"
#import "HtmlCreator.h"
#import "Animation_Set.h"
#import "Animation_Set_View.h"

@interface ArticleDetailViewController () <WKNavigationDelegate, WKScriptMessageHandler, CustomViewControllerDelegate>

@property (nonatomic, strong) LoadingView *loadingView;
@property (nonatomic, strong) WKWebView   *wkWebView;
@property (nonatomic, strong) HtmlCreator *htmlCreator;

@property (nonatomic, strong) Animation_Set      *animationSet;
@property (nonatomic, strong) Animation_Set_View *animationSetView;

@end

@implementation ArticleDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // div管理器
    BlocksManager *blockManager = [BlocksManager blocksManagerWithHtmlFolderPath:self.htmlFolder];
    
    // 生成html网页
    self.htmlCreator = [HtmlCreator htmlCreatorWithHtmlFolder:self.htmlFolder];
    [self.htmlCreator startCreateHtmlWithBlocksManager:blockManager];
    
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
    
    // 创建按钮
    [self buildButtons];
    
    // 显示菊花
    self.loadingView = [LoadingView loadingViewStartLoadingInKeyWindow];
}

#pragma makr - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    [self.loadingView stopLoading];
    
    [UIView animateWithDuration:0.5 delay:0.15 options:0 animations:^{
        
        self.wkWebView.alpha = 1.f;
        
    } completion:nil];
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
}

#pragma mark - Buttons

- (void)buildButtons {
    
    // 返回按钮
    CircleIconButton *backButton = [[CircleIconButton alloc] initWithType:CircleIconButtonType_Back];
    backButton.left              = 20.f;
    backButton.top               = 20.f;
    [self.contentView addSubview:backButton];
    [backButton addTarget:self action:@selector(buttonsEvent:)];
    
    if (self.canEdit) {
        
        // 编辑按钮
        CircleIconButton *editButton = [[CircleIconButton alloc] initWithType:CircleIconButtonType_Edit];
        editButton.right             = Width - 20.f;
        editButton.top               = 20.f;
        [self.contentView addSubview:editButton];
        [editButton addTarget:self action:@selector(buttonsEvent:)];
        
        if (DeviceInfo.isFringeScreen) {
            
            backButton.top = 20 + DeviceInfo.fringeScreenTopSafeHeight;
            editButton.top = 20 + DeviceInfo.fringeScreenTopSafeHeight;
        }
        
    } else {
        
        if (DeviceInfo.isFringeScreen) {
            
            backButton.top = 20 + DeviceInfo.fringeScreenTopSafeHeight;
        }
    }
}

- (void)buttonsEvent:(CircleIconButton *)button {
    
    if (button.tag == CircleIconButtonType_Back) {
        
        [self popViewControllerAnimated:YES];
        
    } else if (button.tag == CircleIconButtonType_Edit) {
        
        ArticleEditViewController *controller = [ArticleEditViewController new];
        controller.htmlFolder                 = self.htmlFolder;
        controller.eventDelegate              = self;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - CustomViewControllerDelegate

- (void)baseCustomViewController:(__kindof CustomViewController *)controller event:(id)event {
    
    // 重新读取动画配置文件
    NSString *animationPath = FmtStr(@"%@/animationSet.data", self.htmlFolder);
    self.animationSet       = [Animation_Set decodeWithData:[NSData dataWithContentsOfFile:animationPath]];
    
    // 加载动画页面
    [self.animationSetView loadAnimation_Set:self.animationSet];
    
    [self.wkWebView reload];
    self.wkWebView.alpha = 0.f;
    [UIView animateWithDuration:0.5 delay:0.15 options:0 animations:^{
    
        self.wkWebView.alpha = 1.f;
        
    } completion:nil];
}

@end
