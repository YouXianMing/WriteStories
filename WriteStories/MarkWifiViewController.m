//
//  MarkWifiViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/6.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "MarkWifiViewController.h"
#import "GCDWebUploader.h"
#import "FoldersManager.h"
#import "FolderWebUploader.h"
#import "UIFont+Project.h"
#import "EdgeInsetsLabel.h"
#import "WSAlertView.h"
#import "NSString+HexUnicode.h"
#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"
#import "FileManager.h"

@interface MarkWifiViewController ()<GCDWebUploaderDelegate>

@property (nonatomic)         BOOL            filesDidUpdate; // 文件有修改
@property (nonatomic, strong) GCDWebUploader *webServer;

@end

@implementation MarkWifiViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 文件存储位置
    NSString* documentsPath = FoldersManager.ArticleBackups;
    
    // 创建webServer，设置根目录
    self.webServer = [[FolderWebUploader alloc] initWithUploadDirectory:documentsPath];
    // 设置代理
    self.webServer.delegate = self;
    self.webServer.allowHiddenItems = NO;
    
    // 限制文件上传类型
    self.webServer.allowedFileExtensions = @[@"article"];
    
    // 设置网页标题
    self.webServer.title = @"美记";
    
    // 设置展示在网页上的文字(开场白)
    self.webServer.prologue = @"<p>欢迎使用美记WIFI管理平台</p><p>注意，上传的文件格式必须为[年-月-日 时-分-秒] 文章名字.article，月、日、时、分、秒均为2位数（例如：[2018-05-05 09-47-30] 标题.article），否则上传无法成功！</p>";
    
    // 设置展示在网页上的文字(收场白)
    self.webServer.epilogue = @"美记";
    
    self.webServer.footer = @"2018.YouXianMing";
    
    if ([self.webServer start]) {
        
        NSLog(@"%@", self.webServer.serverURL.absoluteString);
        
        if (self.webServer.serverURL.absoluteString.length <= 0) {
            
            [self.webServer stop];
            self.webServer = nil;
            [self buildErrorUI];
            
        } else {
            
            [self buildSuccessUI];
        }
        
    } else {
        
        [self buildErrorUI];
    }
}

- (void)buildSuccessUI {
    
    // wifi图片
    UIImageView *wifiSuccessView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wifiSuccess"]];
    wifiSuccessView.centerX      = Width / 2.f;
    wifiSuccessView.bottom       = self.contentView.height / 2.f - 50.f;
    [self.contentView addSubview:wifiSuccessView];
    
    // wifi图片-彩色点
    UIImageView *wifiSuccessColorView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wifiSuccessColor"]];
    wifiSuccessColorView.centerX      = Width / 2.f;
    wifiSuccessColorView.bottom       = self.contentView.height / 2.f - 50.f;
    [self.contentView addSubview:wifiSuccessColorView];
    
    // Web Server 搭建完成，请在电脑浏览器中输入以下网址
    UILabel *centerLabel      = [UILabel new];
    centerLabel.numberOfLines = 0;
    NSMutableAttributedString *richCenter = [[NSMutableAttributedString alloc] initWithString:@"Web Server 搭建完成\n请在电脑浏览器中输入以下网址"];
    
    {
        [richCenter addAttribute:NSFontAttributeName
                           value:[UIFont PingFangSC_Light_WithFontSize:18.f]
                           range:NSMakeRange(0, 30)];
        
        [richCenter addAttribute:NSFontAttributeName
                           value:[UIFont PingFangSC_Medium_WithFontSize:18.f]
                           range:NSMakeRange(18, 5)];
        
        [richCenter addAttribute:NSForegroundColorAttributeName
                           value:[UIColor colorWithHexString:@"#5a5a5a"]
                           range:NSMakeRange(0, 30)];
        
        NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
        style.paragraphSpacing         = 10.f;
        style.alignment                = NSTextAlignmentCenter;
        
        [richCenter addAttribute:NSParagraphStyleAttributeName
                           value:style
                           range:NSMakeRange(0, 30)];
    }
    
    centerLabel.attributedText = richCenter;
    [centerLabel sizeToFit];
    
    centerLabel.top     = self.contentView.height / 2.f;
    centerLabel.centerX = Width / 2.f;
    [self.contentView addSubview:centerLabel];
    
    // ip地址
    EdgeInsetsLabel *urlLabel   = [EdgeInsetsLabel new];
    urlLabel.backgroundColor    = [UIColor colorWithHexString:@"#c2c2c2"];
    urlLabel.font               = [UIFont PingFangSC_Semibold_WithFontSize:18.f];
    urlLabel.textColor          = [UIColor colorWithHexString:@"#5a5a5a"];
    urlLabel.edgeInsets         = UIEdgeInsetsMake(5, 10, 5, 10);
    urlLabel.layer.cornerRadius = 3.f;
    urlLabel.clipsToBounds      = YES;
    [urlLabel sizeToFitWithText:self.webServer.serverURL.absoluteString];
    
    urlLabel.centerX = Width / 2.f;
    urlLabel.top     = centerLabel.bottom + 15.f;
    [self.contentView addSubview:urlLabel];
    
    if (DeviceInfo.wifiName.length) {
        
        // wifi提示
        UILabel *wifiLabel = [[UILabel alloc] init];
        [self.contentView addSubview:wifiLabel];
        
        NSString *wifiString  = DeviceInfo.wifiName;
        NSString *totalString = [NSString stringWithFormat:@"%@ %@", [NSString unicodeWithHexString:@"0xF1EB"], wifiString];
        
        NSMutableAttributedString *richWifi = [[NSMutableAttributedString alloc] initWithString:totalString];
        
        {
            [richWifi addAttribute:NSFontAttributeName
                             value:[UIFont PingFangSC_Medium_WithFontSize:12.f]
                             range:NSMakeRange(0, totalString.length)];
            
            [richWifi addAttribute:NSFontAttributeName
                             value:[UIFont fontAwesome5FreeSolidFontSize:12.f]
                             range:NSMakeRange(0, 1)];
            
            [richWifi addAttribute:NSForegroundColorAttributeName
                             value:[UIColor colorWithHexString:@"#5a5a5a"]
                             range:NSMakeRange(0, totalString.length)];
            
            [richWifi addAttribute:NSForegroundColorAttributeName
                             value:[[UIColor colorWithHexString:@"#5a5a5a"] colorWithAlphaComponent:0.2]
                             range:NSMakeRange(0, 1)];
        }
        
        wifiLabel.attributedText = richWifi;
        [wifiLabel sizeToFit];
        wifiLabel.centerX = Width / 2.f;
        wifiLabel.bottom  = self.contentView.height - 15.f;
        
        if (DeviceInfo.isFringeScreen) {
            
            wifiLabel.bottom = self.contentView.height - 15.f - DeviceInfo.fringeScreenBottomSafeHeight;
        }
        
        // 注意：请确认电脑与手机同处于
        UILabel *noticeLabel  = [UILabel new];
        noticeLabel.font      = [UIFont PingFangSC_Light_WithFontSize:12.f];
        noticeLabel.textColor = [UIColor colorWithHexString:@"#5a5a5a"];
        noticeLabel.text      = @"注意：请确认电脑与手机同处于";
        [noticeLabel sizeToFit];
        noticeLabel.centerX = Width / 2.f;
        noticeLabel.bottom  = wifiLabel.top - 7.f;
        [self.contentView addSubview:noticeLabel];
    }
}

- (void)buildErrorUI {
    
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    
    FLAnimatedImage *image = [[FLAnimatedImage alloc] initWithAnimatedGIFData:[NSData dataWithContentsOfFile:absoluteFilePathFrom(@"-/wifi.gif")]
                                                        optimalFrameCacheSize:60 * 10 predrawingEnabled:YES];
    CGSize size = [FLAnimatedImage sizeForImage:image];
    
    FLAnimatedImageView *flImageView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, size.width * 0.5, size.height * 0.5)];
    flImageView.animatedImage        = image;
    flImageView.center               = self.contentView.middlePoint;
    flImageView.top                 -= 50.f;
    [self.contentView addSubview:flImageView];
    
    // Web Server 需要连上WiFi才能搭建，请连上WiFi后再次进入本页面
    UILabel *centerLabel      = [UILabel new];
    centerLabel.numberOfLines = 0;
    NSString *string          = @"Web Server 需要连上WiFi才能搭建\n请连上WiFi后再次进入本页面";
    NSMutableAttributedString *richCenter = [[NSMutableAttributedString alloc] initWithString:string];
    
    {
        [richCenter addAttribute:NSFontAttributeName
                           value:[UIFont PingFangSC_Light_WithFontSize:18.f]
                           range:NSMakeRange(0, string.length)];
        
        [richCenter addAttribute:NSFontAttributeName
                           value:[UIFont PingFangSC_Medium_WithFontSize:18.f]
                           range:NSMakeRange(0, 10)];
        
        [richCenter addAttribute:NSFontAttributeName
                           value:[UIFont PingFangSC_Medium_WithFontSize:18.f]
                           range:NSMakeRange(13, 6)];
        
        [richCenter addAttribute:NSForegroundColorAttributeName
                           value:[UIColor colorWithHexString:@"#5a5a5a"]
                           range:NSMakeRange(0, string.length)];
        
        NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
        style.paragraphSpacing         = 10.f;
        style.alignment                = NSTextAlignmentCenter;
        
        [richCenter addAttribute:NSParagraphStyleAttributeName
                           value:style
                           range:NSMakeRange(0, string.length)];
    }
    
    centerLabel.attributedText = richCenter;
    [centerLabel sizeToFit];
    
    centerLabel.top     = self.contentView.height / 2.f + 30.f;
    centerLabel.centerX = Width / 2.f;
    [self.contentView addSubview:centerLabel];
}

#pragma mark - GCDWebUploaderDelegate

/**
 *  This method is called whenever a file has been downloaded.
 */
- (void)webUploader:(GCDWebUploader*)uploader didDownloadFileAtPath:(NSString*)path {
    
}

/**
 *  This method is called whenever a file has been uploaded.
 */
- (void)webUploader:(GCDWebUploader*)uploader didUploadFileAtPath:(NSString*)path {
    
    NSLog(@"\"%@\" 上传成功！", path.lastPathComponent);
    self.filesDidUpdate = YES;
}

/**
 *  This method is called whenever a file or directory has been moved.
 */
- (void)webUploader:(GCDWebUploader*)uploader didMoveItemFromPath:(NSString*)fromPath toPath:(NSString*)toPath {
    
}

/**
 *  This method is called whenever a file or directory has been deleted.
 */
- (void)webUploader:(GCDWebUploader*)uploader didDeleteItemAtPath:(NSString*)path {
    
    NSLog(@"\"%@\" 删除成功！", path.lastPathComponent);
    self.filesDidUpdate = YES;
}

/**
 *  This method is called whenever a directory has been created.
 */
- (void)webUploader:(GCDWebUploader*)uploader didCreateDirectoryAtPath:(NSString*)path {
    
}

#pragma mark - Button event

- (void)buttonsEvent:(UIButton *)button {
    
    if (button.tag == TitleMenuButton_Close) {
        
        if (self.webServer.isRunning) {
            
            [WSAlertView showAlertViewWithMessage:@"您确定要退出？退出后 Web Server 将停止工作！"
                                messageBoldRanges:@[[NSValue valueWithRange:NSMakeRange(23, 4)]]
                                      buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"取消"),
                                                    buttonInfo(WSAlertViewButtonTypeConfirm, @"确定")]
                                             type:WSAlertViewTypeAlert
                                         delegate:nil
                                       weakObject:nil
                                              tag:0
                                    selectedBlock:^(WSAlertViewButtonInfo *buttonInfo) {
                                        
                                        if (buttonInfo.type == WSAlertViewButtonTypeConfirm) {
                                            
                                            [self dismissViewControllerAnimated:YES completion:^{
                                                
                                                if (self.filesDidUpdate && self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(baseCustomViewController:event:)]) {
                                                    
                                                    [self.eventDelegate baseCustomViewController:self event:nil];
                                                }
                                            }];
                                        }
                                    }];
            
        } else {
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

#pragma mark - Overwrite

- (void)setupSubViews {
    
    [super setupSubViews];
    
    [self.backButton removeFromSuperview];
    
    self.backButton = [[TitleMenuButton alloc] initWithFrame:CGRectMake(0, 0, 100, 64.f) type:TitleMenuButton_Close];
    [self.backButton addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleContentView addSubview:self.backButton];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [self.webServer stop];
    self.webServer = nil;
    
    [super viewDidDisappear:animated];
}

@end
