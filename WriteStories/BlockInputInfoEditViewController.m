//
//  BlockInputInfoEditViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BlockInputInfoEditViewController.h"
#import "FoldersManager.h"
#import "NSString+Path.h"
#import "TitleMenuButton.h"
#import "WSAlertView.h"
#import "FileManager.h"
#import "BaseInputEditorView.h"
#import "BaseCustomNavigationController.h"
#import "FileManager.h"
#import "UIImage+ImageEffects.h"

@interface BlockInputInfoEditViewController ()

@property (nonatomic, strong) UIScrollView    *scrollView;
@property (nonatomic, strong) TitleMenuButton *setupButton;

@end

@implementation BlockInputInfoEditViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)];
    [self.view addGestureRecognizer:tap];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.scrollView];
    
    if (self.type == BlockInputInfoEditViewControllerType_Add) {

        // 删除block
        NSString *dst = [FoldersManager.WorkShop addPathComponent:@"block"];
        [[NSFileManager defaultManager] removeItemAtPath:dst error:nil];

        // 创建block文件夹
        [[NSFileManager defaultManager] createDirectoryAtPath:dst withIntermediateDirectories:YES attributes:nil error:nil];

        // 将图片存储到 .../workshop/block 文件夹中
        [self.blockItem.imageObjects enumerateObjectsUsingBlock:^(EncodeImageObject *imageObject, NSUInteger idx, BOOL * _Nonnull stop) {

            imageObject.source = EncodeImageObjectSourceFolder;
            NSData *data       = [NSData dataWithContentsOfFile:[FileManager bundleFileWithName:imageObject.imageName]];
            
            UIImage *image     = [UIImage imageWithData:data];
            CGFloat imageScale = image.size.width / image.size.height;
            CGFloat dstScale   = (CGFloat)imageObject.width / (CGFloat)imageObject.height;
            if (dstScale <= imageScale) {
                
                CGFloat cropHeight = image.size.height;
                CGFloat cropWidth  = cropHeight * dstScale;
                CGFloat gap        = (image.size.width - cropWidth) / 2.f;
                
                data = UIImageJPEGRepresentation([image croppedImageAtFrame:CGRectMake(gap, 0, cropWidth, cropHeight)], 0.5f);
                
            } else {
                
                CGFloat cropWidth  = image.size.width;
                CGFloat cropHeight = cropWidth / dstScale;
                CGFloat gap        = (image.size.height - cropHeight) / 2.f;
                
                data = UIImageJPEGRepresentation([image croppedImageAtFrame:CGRectMake(0, gap, cropWidth, cropHeight)], 0.5f);
            }
            
            [data writeToFile:[NSString stringWithFormat:@"%@/block/%@", FoldersManager.WorkShop, imageObject.imageName] atomically:YES];
        }];
        
        // 将二进制文件存储到 .../workshop/block 文件夹中
        [self.blockItem.encodeData writeToFile:[NSString stringWithFormat:@"%@/block/block.data", FoldersManager.WorkShop] atomically:YES];
        
    } else if (self.type == BlockInputInfoEditViewControllerType_Edit) {
        
        // 删除block
        NSString *dst = [FoldersManager.WorkShop addPathComponent:@"block"];
        [[NSFileManager defaultManager] removeItemAtPath:dst error:nil];
        
        // 将block文件夹复制过去
        [[NSFileManager defaultManager] copyItemAtPath:[NSString stringWithFormat:@"%@/%@/block", self.blockItem.htmlFolderName, self.blockItem.folderName]
                                                toPath:[FoldersManager.WorkShop addPathComponent:@"block"]
                                                 error:nil];
    }
    
    __block CGFloat tmpTop = 0;
    [self.blockItem.inputEditors enumerateObjectsUsingBlock:^(InputEditor *editor, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BaseInputEditorView *editorView = [editor.editorViewClass new];
        
        // 构建view
        [editorView buildSubViews];
        
        // 获取控制器
        editorView.controller = self;
        
        // 获取weakObject
        editorView.weakObject = self.blockItem;
        
        // 输入信息
        editorView.inputEdior = editor;
        
        // 更新view高度
        [editorView updateViewHeight];
        
        // 设定顶部
        editorView.top = tmpTop;
        
        tmpTop += editorView.height;
        
        // 添加view
        [self.scrollView addSubview:editorView];
    }];
}

- (void)buttonsEvent:(UIButton *)button {
    
    [self endEdit];
    
    if (button.tag == TitleMenuButton_Save) {
        
        // 判断是否有保存
        __block BOOL success           = YES;
        __block NSString *errorMessage = nil;
        
        [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([view isKindOfClass:BaseInputEditorView.class]) {
                
                BaseInputEditorView *editorView = (BaseInputEditorView *)view;
                if (editorView.isOK == NO) {
                    
                    success      = NO;
                    errorMessage = editorView.errorMessage;
                    *stop = YES;
                }
            }
        }];
        
        if (success == NO) {
            
            [WSAlertView showAlertViewWithMessage:errorMessage
                                messageBoldRanges:nil
                                      buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"我知道了")]
                                             type:WSAlertViewTypeError
                                         delegate:nil
                                       weakObject:nil
                                              tag:0
                                    selectedBlock:nil];
            
            return;
        }
        
        // 写二进制文件
        [self.blockItem.encodeData writeToFile:[NSString stringWithFormat:@"%@/block/block.data", FoldersManager.WorkShop] atomically:YES];
        
        if (self.type == BlockInputInfoEditViewControllerType_Add) {
            
            NSString *blockFolder = [NSString stringWithFormat:@"%@/%@", self.blockItem.htmlFolderName, self.blockItem.folderName];
            
            // 创建文件夹
            [[NSFileManager defaultManager] createDirectoryAtPath:blockFolder withIntermediateDirectories:YES attributes:nil error:nil];
            
            // 进行复制
            [[NSFileManager defaultManager] copyItemAtPath:[NSString stringWithFormat:@"%@/block", FoldersManager.WorkShop]
                                                    toPath:[blockFolder addPathComponent:@"block"]
                                                     error:nil];
            
            // 通知代理, 将数据传递出去
            BaseCustomNavigationController *navigationController = (BaseCustomNavigationController *)self.navigationController;
            if (navigationController.eventDelegate && [navigationController.eventDelegate respondsToSelector:@selector(baseCustomNavigationController:controller:event:)]) {
                
                [navigationController.eventDelegate baseCustomNavigationController:navigationController
                                                                        controller:self
                                                                             event:self.blockItem];
                
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            }
            
        } else if (self.type == BlockInputInfoEditViewControllerType_Edit) {
            
            // 删除html文件夹中内容
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@/block", self.blockItem.htmlFolderName, self.blockItem.folderName]
                                                       error:nil];
            
            // 复制文件
            [[NSFileManager defaultManager] copyItemAtPath:[NSString stringWithFormat:@"%@/block", FoldersManager.WorkShop]
                                                    toPath:[NSString stringWithFormat:@"%@/%@/block", self.blockItem.htmlFolderName, self.blockItem.folderName]
                                                     error:nil];
            
            // 通知代理
            if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(baseCustomViewController:event:)]) {
                
                [self.eventDelegate baseCustomViewController:self event:self.blockItem];
                [self popViewControllerAnimated:YES];
            }
        }
    }
}

#pragma mark - Overwrite

- (void)backButtonEvent:(TitleMenuButton *)button {
    
    [self endEdit];
    
    [WSAlertView showAlertViewWithMessage:@"您确定要返回？返回后所有修改过的信息不会被保存！"
                        messageBoldRanges:@[[NSValue valueWithRange:NSMakeRange(18, 5)]]
                              buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"取消"),
                                            buttonInfo(WSAlertViewButtonTypeConfirm, @"确定")]
                                     type:WSAlertViewTypeAlert
                                 delegate:nil
                               weakObject:nil
                                      tag:0
                            selectedBlock:^(WSAlertViewButtonInfo *buttonInfo) {
                                
                                if (buttonInfo.type == WSAlertViewButtonTypeConfirm) {
                                    
                                    [self popViewControllerAnimated:YES];
                                    
                                    // 删除编辑文件
                                    NSString *dst = [FoldersManager.WorkShop addPathComponent:@"block"];
                                    [[NSFileManager defaultManager] removeItemAtPath:dst error:nil];
                                }
                            }];
}

#pragma mark - TapEvent

- (void)endEdit {
    
    [self.view endEditing:YES];
}

#pragma mark - Overwrite

- (void)setupSubViews {
    
    [super setupSubViews];
    
    self.setupButton       = [[TitleMenuButton alloc] initWithFrame:CGRectMake(0, 0, 80, 64.f) type:TitleMenuButton_Save];
    self.setupButton.right = self.titleContentView.width;
    [self.setupButton addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleContentView addSubview:self.setupButton];
}

@end
