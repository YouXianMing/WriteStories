//
//  MarkEditViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/23.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "MarkEditViewController.h"
#import "BaseFolderCreator.h"
#import "BaseMarkItemCell.h"
#import "TitleIconButton.h"
#import "StyleAdjustEditView.h"
#import "StyleManagerEditView.h"
#import "Table_Mark_List.h"
#import "FoldersManager.h"
#import "StyleSaveView.h"
#import "MarkInputInfoEditViewController.h"
#import "Table_Style_List.h"
#import "WSAlertView.h"
#import "Math.h"

@interface MarkEditViewController () <UICollectionViewDelegate, UICollectionViewDataSource, EditViewDelegate, CustomViewControllerDelegate, StyleManagerEditViewDelegate>

@property (nonatomic, strong) UICollectionView                   *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout         *layout;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

@end

@implementation MarkEditViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    CGFloat gap       = 15.f;
    CGFloat itemWidth = Width - gap * 2;
    
    self.layout = [UICollectionViewFlowLayout new];
    self.layout.minimumLineSpacing      = gap;
    self.layout.minimumInteritemSpacing = gap;
    self.layout.itemSize                = CGSizeMake(itemWidth, [Math resetFromSize:CGSizeMake(77.f, 30.f) withFixedWidth:itemWidth].height);
    
    self.collectionView                        = [[UICollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:self.layout];
    self.collectionView.alpha                  = 1.f;
    self.collectionView.delegate               = self;
    self.collectionView.dataSource             = self;
    self.collectionView.contentInset           = UIEdgeInsetsMake(gap, gap, gap, gap);
    self.collectionView.backgroundColor        = [UIColor clearColor];
    self.collectionView.userInteractionEnabled = NO;
    [self.contentView addSubview:self.collectionView];
    
    self.adapters = [NSMutableArray array];
    [self.markItem registerToCollectionView:self.collectionView];
    [self.adapters addObject:self.markItem.collectionViewAdapter];
    
    CGFloat safeBottomHeight = 0;
    if (DeviceInfo.isFringeScreen) {
        
        safeBottomHeight = DeviceInfo.fringeScreenBottomSafeHeight;
    }
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 80.f)];
    contentView.bottom  = Height - 120.f - safeBottomHeight;
    [self.contentView addSubview:contentView];
    
    // 信息编辑 + 样式调整 + 样式管理
    {
        TitleIconButton *adjustButton = [[TitleIconButton alloc] initWithFrame:CGRectMake(0, 0, 80, 80) iconType:TitleIconButtonIconType_StyleAdjust];
        adjustButton.center           = contentView.middlePoint;
        [adjustButton addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:adjustButton];
        
        TitleIconButton *editButton = [[TitleIconButton alloc] initWithFrame:CGRectMake(0, 0, 80, 80) iconType:TitleIconButtonIconType_InfoEdit];
        editButton.right            = adjustButton.left - 10.f;
        [editButton addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:editButton];
        
        TitleIconButton *managerButton = [[TitleIconButton alloc] initWithFrame:CGRectMake(0, 0, 80, 80) iconType:TitleIconButtonIconType_StyleManager];
        managerButton.left             = adjustButton.right + 10.f;
        [managerButton addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:managerButton];
    }
}

- (void)buttonsEvent:(TitleIconButton *)button {
    
    if (button.tag == TitleIconButtonIconType_InfoEdit) {
        
        MarkInputInfoEditViewController *controller   = [MarkInputInfoEditViewController new];
        controller.title                              = @"信息编辑";
        controller.markItem                           = self.markItem.dbCopyObject;
        controller.eventDelegate                      = self;
        [self.navigationController pushViewController:controller animated:YES];
        
    } else if (button.tag == TitleIconButtonIconType_StyleAdjust) {
        
        EditView *editView   = [StyleAdjustEditView new];
        editView.delegate    = self;
        editView.editManager = self.markItem.editManager;
        [editView showInContentView:self.contentView];
        
    } else if (button.tag == TitleIconButtonIconType_StyleManager) {
        
        StyleManagerEditView *editView = [StyleManagerEditView new];
        editView.styles                = [Table_Style_List styleObjectsByShowStyleType:[self.markItem.class ShowStyleType]];
        editView.delegate              = self;
        editView.styleDelegate         = self;
        [editView showInContentView:self.contentView];
    }
}

#pragma mark - StyleManagerEditViewDelegate

- (void)styleManagerEditView:(StyleManagerEditView *)editView selectedStyle:(WriteStoriesBaseItemObject *)style {
    
    [self.markItem useStyleObject:style];
    
    // 获取cell
    BaseMarkItemCell *cell = (BaseMarkItemCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    // 加载普通数据
    [cell loadContent];
    
    // 加载粒子效果数据
    [cell loadCAEmitterCellContent];
}

#pragma mark - EditViewDelegate

- (void)editViewDidUpdateValues:(EditView *)editView {
    
    // 获取cell
    BaseMarkItemCell *cell = (BaseMarkItemCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    // 加载普通数据
    [cell loadContent];
    
    // 加载粒子效果数据
    [cell loadCAEmitterCellContent];
}

- (void)editViewButtonEvent:(EditView *)editView {
    
    if ([Table_Style_List styleCountsByItemObject:self.markItem] >= 10) {
        
        [WSAlertView showAlertViewWithMessage:@"每种样式风格最多只能存储10种！"
                            messageBoldRanges:@[[NSValue valueWithRange:NSMakeRange(12, 2)]]
                                  buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"我知道了")]
                                         type:WSAlertViewTypeError
                                     delegate:nil weakObject:nil tag:0 selectedBlock:nil];
        return;
    }
    
    [StyleSaveView styleSaveViewShowWithText:@"自定义样式" delegate:nil confirmEvent:^(NSString *text) {
        
        [Table_Style_List storeStyleObject:self.markItem styleName:text];
        
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
    
    self.backButton.enabled = NO;
}

- (void)editViewDidShow:(EditView *)editView {
    
}

- (void)editViewWillHide:(EditView *)editView {
    
}

- (void)editViewDidHide:(EditView *)editView {
    
    self.backButton.enabled = YES;    
    [self udpateDatas];
}

#pragma mark - Other

- (void)udpateDatas {
    
    [GCDQueue executeInGlobalQueue:^{
        
        // 获取二进制文件
        NSData *data = self.markItem.encodeData;
        
        // 写数据
        NSString *path = [NSString stringWithFormat:@"%@/%@/content/title/title.data", FoldersManager.ArticleList, self.markItem.mark_name];
        [data writeToFile:path atomically:YES];
        
        // 更新数据库
        [Table_Mark_List updateData:data
                             markId:self.markItem.mark_id
                              title:self.markItem.title
                          sortIndex:self.markItem.sort_index];
        
        // 通知代理,更新cell
        [GCDQueue executeInMainQueue:^{
            
            if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(baseCustomViewController:event:)]) {
                
                [self.eventDelegate baseCustomViewController:self event:self.markItem];
            }
        }];
    }];
}

#pragma mark - CustomViewControllerDelegate

- (void)baseCustomViewController:(__kindof CustomViewController *)controller event:(id)event {
    
    self.markItem                  = event;
    self.adapters.firstObject.data = event;
    [self.collectionView reloadData];
    
    [self udpateDatas];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.adapters.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter  *adapter = self.adapters[indexPath.row];
    BaseMarkItemCell *cell    = [collectionView dequeueReusableCellWithReuseIdentifier:adapter.cellReuseIdentifier forIndexPath:indexPath];
    cell.indexPath            = indexPath;
    cell.dataAdapter          = adapter;
    cell.data                 = adapter.data;
    [cell loadContent];
    
    return cell;
}

@end
