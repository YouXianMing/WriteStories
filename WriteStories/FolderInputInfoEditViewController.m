//
//  FolderInputInfoEditViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/20.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "FolderInputInfoEditViewController.h"
#import "FoldersManager.h"
#import "NSString+Path.h"
#import "TitleMenuButton.h"
#import "WSAlertView.h"
#import "FileManager.h"
#import "Table_Folder_List.h"

@interface FolderInputInfoEditViewController ()

@property (nonatomic, strong) UIScrollView    *scrollView;
@property (nonatomic, strong) TitleMenuButton *setupButton;

@end

@implementation FolderInputInfoEditViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)];
    [self.view addGestureRecognizer:tap];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.scrollView];
    
    // 复制编辑文件
    NSString *src = [FoldersManager content_FolderListWithFolderName:self.folderItem.folder_name];
    NSString *dst = [FoldersManager.WorkShop addPathComponent:@"content"];
    [[NSFileManager defaultManager] removeItemAtPath:dst error:nil];
    [[NSFileManager defaultManager] copyItemAtPath:src toPath:dst error:nil];
    
    __block CGFloat tmpTop = 0;
    [self.folderItem.inputEditors enumerateObjectsUsingBlock:^(InputEditor *editor, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BaseInputEditorView *editorView = [editor.editorViewClass new];
        
        // 构建view
        [editorView buildSubViews];
        
        // 获取控制器
        editorView.controller = self;
        
        // 获取weakObject
        editorView.weakObject = self.folderItem;
        
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
        [self.folderItem.encodeData writeToFile:[NSString stringWithFormat:@"%@/content/folder.data", FoldersManager.WorkShop]
                                     atomically:YES];
        
        NSString *src = [FoldersManager.WorkShop addPathComponent:@"content"];
        NSString *dst = [FoldersManager content_FolderListWithFolderName:self.folderItem.folder_name];
        
        // 删除原来文字的文件夹
        [[NSFileManager defaultManager] removeItemAtPath:dst error:nil];
        
        // 将现在为止文件复制过去
        [[NSFileManager defaultManager] copyItemAtPath:src toPath:dst error:nil];
        
        // 更新数据库
        [Table_Folder_List updateData:self.folderItem.encodeData
                             folderId:self.folderItem.folder_id
                                title:self.folderItem.title
                            sortIndex:self.folderItem.sort_index];
        
        if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(baseCustomViewController:event:)]) {
            
            [self.eventDelegate baseCustomViewController:self event:self.folderItem];
        }
        
        [self popViewControllerAnimated:YES];
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
                                    NSString *dst = [FoldersManager.WorkShop addPathComponent:@"content"];
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
