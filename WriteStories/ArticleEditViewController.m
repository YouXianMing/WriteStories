//
//  ArticleEditViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/25.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ArticleEditViewController.h"
#import "ItemAddCell.h"
#import "SheetMenuView.h"
#import "SheetMenuObject.h"
#import "PopMenuView.h"
#import "PopMenuObject.h"
#import "WSAlertView.h"
#import "BaseCustomNavigationController.h"
#import "GCD.h"
#import "BlocksManager.h"
#import "BaseHtmlBodyItem.h"
#import "HtmlCreator.h"

#import "ParagraphStylesViewController.h"
#import "SubTitleStylesViewController.h"
#import "ArticleSortViewController.h"
#import "BlockInputInfoEditViewController.h"
#import "TitleStylesViewController.h"
#import "PictureStylesViewController.h"
#import "HtmlEditViewController.h"

#import "Edit_title_1_Cell.h"
#import "Edit_title_2_Cell.h"
#import "Edit_paragraph_1_Cell.h"
#import "Edit_subTitle_1_Cell.h"
#import "Edit_picture_1_Cell.h"

#import "FileManager.h"

typedef enum : NSUInteger {
    
    NavigationControllerTitle = 1000,
    NavigationControllerNormal,
    
} NavigationControllerType;

@interface ArticleEditViewController () <UITableViewDelegate, UITableViewDataSource, CustomCellDelegate, BaseWindowMenuViewDelegate, CustomNavigationControllerDelegate, CustomViewControllerDelegate> {
    
    NSIndexPath *_tmpAddCellIndexPath;
}

@property (nonatomic, strong) SheetMenuView *menuView;

@property (nonatomic, strong) HtmlCreator                        *htmlCreator;
@property (nonatomic, strong) BlocksManager                      *blocksManager;
@property (nonatomic, strong) UITableView                        *tableView;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

@end

@implementation ArticleEditViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.htmlCreator = [HtmlCreator htmlCreatorWithHtmlFolder:self.htmlFolder];
    
    [self buildTableView];
    
    [self buildButtons];
}

#pragma mark - TableView

- (void)buildTableView {
    
    // tableView
    self.tableView                 = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.alpha           = 0.f;
    self.tableView.contentInset    = UIEdgeInsetsMake(0, 0, 150.f, 0);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:self.tableView];
    
    // dataSource
    self.adapters = [NSMutableArray array];
    
    // add button
    [ItemAddCell registerToTableView:self.tableView];
    
    [Edit_title_1_Cell     registerToTableView:self.tableView]; // 标题
    [Edit_title_2_Cell     registerToTableView:self.tableView]; // 标题
    [Edit_paragraph_1_Cell registerToTableView:self.tableView]; // 段落
    [Edit_subTitle_1_Cell  registerToTableView:self.tableView]; // 小标题
    [Edit_picture_1_Cell   registerToTableView:self.tableView]; // 图片
    
    // 读取数据
    self.blocksManager = [BlocksManager blocksManagerWithHtmlFolderPath:self.htmlFolder];
    [self.blocksManager.blocksPaths enumerateObjectsUsingBlock:^(NSString *path, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 读取二进制文件
        BaseBlockItem *block = [BaseBlockItem decodeWithData:[NSData dataWithContentsOfFile:path]];
        block.htmlFolderName = self.htmlFolder;
        
        [self.adapters addObject:[block tableViewAdapterWithAdapterType:BaseArticleEditCellAdapterTypeDelete]];
        [self.adapters addObject:ItemAddCell.fixedHeightTypeDataAdapter];
    }];

    [self.tableView reloadData];
    
    [UIView animateWithDuration:0.5f animations:^{
        
        self.tableView.alpha = 1.f;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.adapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter *adapter = self.adapters[indexPath.row];
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    cell.dataAdapter = adapter;
    cell.data        = adapter.data;
    cell.indexPath   = indexPath;
    cell.controller  = self;
    cell.delegate    = self;
    [cell loadContent];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.adapters[indexPath.row].cellHeight;
}

- (void)customCell:(CustomCell *)cell event:(id)event {
    
    if ([cell isKindOfClass:ItemAddCell.class]) {
        
        self.menuView = [SheetMenuView menuViewWithDelegate:self datas:@[[SheetMenuObject sheetMenuObjectWithIndex:0 title:@"添加段落..."],
                                                                         [SheetMenuObject sheetMenuObjectWithIndex:2 title:@"添加小标题..."],
                                                                         [SheetMenuObject sheetMenuObjectWithIndex:3 title:@"添加图文..."],
                                                                         // [SheetMenuObject sheetMenuObjectWithIndex:4 title:@"添加分割线..."]
                                                                         ]];
        [self.menuView show];
        _tmpAddCellIndexPath = [self.tableView indexPathForCell:cell];
        
    } else if ([cell isKindOfClass:BaseArticleEditCell.class]) {
        
        BaseArticleEditCellEvent eventType = [event integerValue];
        
        if (eventType == BaseArticleEditCellEventDelete) {
            
            [WSAlertView showAlertViewWithMessage:@"您确定要删除该元素？删除后不可恢复！"
                                messageBoldRanges:@[[NSValue valueWithRange:NSMakeRange(13, 4)]]
                                      buttonInfos:@[buttonInfo(WSAlertViewButtonTypeCancel, @"取消"),
                                                    buttonInfo(WSAlertViewButtonTypeConfirm, @"确定")]
                                             type:WSAlertViewTypeAlert
                                         delegate:nil
                                       weakObject:nil
                                              tag:0
                                    selectedBlock:^(WSAlertViewButtonInfo *buttonInfo) {
                                        
                                        if (buttonInfo.type == WSAlertViewButtonTypeConfirm) {

                                            NSIndexPath *blockCellPath = [self.tableView indexPathForCell:cell];
                                            NSIndexPath *addCellPath   = [NSIndexPath indexPathForRow:blockCellPath.row - 1 inSection:0];

                                            // 删除block_manager.data中的配置数据
                                            BaseBlockItem        *item          = cell.data;
                                            __block BlockMessage *deleteMessage = nil;
                                            [self.blocksManager.blocks enumerateObjectsUsingBlock:^(BlockMessage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                                
                                                if (obj.blockId == item.itemId.integerValue) {
                                                    
                                                    deleteMessage = obj;
                                                    *stop = YES;
                                                }
                                            }];
                                            
                                            [self.blocksManager.blocks removeObject:deleteMessage];
                                            [self.blocksManager store];
                                            
                                            // 删除block的文件夹
                                            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", item.htmlFolderName, item.folderName]
                                                                                       error:nil];
                                            
                                            // 删除数据源
                                            NSMutableIndexSet *set = [NSMutableIndexSet indexSet];
                                            [set addIndex:addCellPath.row];
                                            [set addIndex:blockCellPath.row];
                                            [self.adapters removeObjectsAtIndexes:set];

                                            // 删除cell
                                            if (@available(iOS 11.0, *)) {
                                                
                                                [self.tableView performBatchUpdates:^{
                                                    
                                                    [self.tableView deleteRowsAtIndexPaths:@[addCellPath, blockCellPath] withRowAnimation:UITableViewRowAnimationFade];
                                                    
                                                } completion:^(BOOL finished) {
                                                
                                                    [self.tableView reloadData];
                                                }];
                                                
                                            } else {
                                                
                                                [self.tableView deleteRowsAtIndexPaths:@[addCellPath, blockCellPath] withRowAnimation:UITableViewRowAnimationFade];
                                                [GCDQueue.mainQueue execute:^{
                                                    
                                                    [self.tableView reloadData];
                                                    
                                                } afterDelaySecs:0.5f];
                                            }
                                        }
                                    }];
            
        } else if (eventType == BaseArticleEditCellEventEdit) {
            
            BlockInputInfoEditViewController *controller = [BlockInputInfoEditViewController new];
            controller.title                             = @"信息编辑";
            controller.type                              = BlockInputInfoEditViewControllerType_Edit;
            controller.blockItem                         = cell.data;
            controller.eventDelegate                     = self;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell selectedEvent];
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
        
        if ([data.menuViewTitleName isEqualToString:@"添加段落..."]) {
            
            ParagraphStylesViewController  *controller    = [ParagraphStylesViewController new];
            controller.title                              = @"段落样式";
            controller.itemId                             = self.blocksManager.currentMaxItemId + 1;
            controller.htmlFolderName                     = self.htmlFolder;
            BaseCustomNavigationController *navController = [[BaseCustomNavigationController alloc] initWithRootViewController:controller
                                                                                                        setNavigationBarHidden:YES];
            navController.eventDelegate                   = self;
            navController.view.tag                        = NavigationControllerNormal;
            [self presentViewController:navController animated:YES completion:nil];
            
        } else if ([data.menuViewTitleName isEqualToString:@"添加小标题..."]) {
            
            SubTitleStylesViewController  *controller     = [SubTitleStylesViewController new];
            controller.title                              = @"小标题样式";
            controller.itemId                             = self.blocksManager.currentMaxItemId + 1;
            controller.htmlFolderName                     = self.htmlFolder;
            BaseCustomNavigationController *navController = [[BaseCustomNavigationController alloc] initWithRootViewController:controller
                                                                                                        setNavigationBarHidden:YES];
            navController.eventDelegate                   = self;
            navController.view.tag                        = NavigationControllerNormal;
            [self presentViewController:navController animated:YES completion:nil];
            
        } else if ([data.menuViewTitleName isEqualToString:@"添加图文..."]) {
            
            NSLog(@"添加图文...");
            PictureStylesViewController *controller       = [PictureStylesViewController new];
            controller.title                              = @"图文样式";
            controller.itemId                             = self.blocksManager.currentMaxItemId + 1;
            controller.htmlFolderName                     = self.htmlFolder;
            BaseCustomNavigationController *navController = [[BaseCustomNavigationController alloc] initWithRootViewController:controller
                                                                                                        setNavigationBarHidden:YES];
            navController.eventDelegate                   = self;
            navController.view.tag                        = NavigationControllerNormal;
            [self presentViewController:navController animated:YES completion:nil];
            
        } else if ([data.menuViewTitleName isEqualToString:@"添加分割线..."]) {
            
            NSLog(@"添加分割线...");
        }
        
    } else if ([windowMenuView isKindOfClass:PopMenuView.class]) {
        
        if ([data.menuViewTitleName isEqualToString:@"更换标题模板"]) {
            
            NSLog(@"更换标题模板");
            TitleStylesViewController *controller         = [TitleStylesViewController new];
            controller.title                              = @"标题样式";
            controller.itemId                             = self.blocksManager.currentMaxItemId + 1;
            controller.htmlFolderName                     = self.htmlFolder;
            BaseCustomNavigationController *navController = [[BaseCustomNavigationController alloc] initWithRootViewController:controller
                                                                                                        setNavigationBarHidden:YES];
            navController.eventDelegate                   = self;
            navController.view.tag                        = NavigationControllerTitle;
            [self presentViewController:navController animated:YES completion:nil];
            
        } else if ([data.menuViewTitleName isEqualToString:@"内容排序"]) {
            
            NSLog(@"内容排序");
            NSMutableArray *arrays = [NSMutableArray array];
            [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter *adapter, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([adapter.data isKindOfClass:BaseBlockItem.class] && idx != 0) {
                    
                    BaseBlockItem *item = adapter.data;
                    item.cellHeight     = adapter.cellHeight;
                    [arrays addObject:adapter.data];
                }
            }];
            
            ArticleSortViewController *controller = [ArticleSortViewController new];
            controller.title                      = @"内容排序";
            controller.blockItems                 = arrays;
            controller.eventDelegate              = self;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}

#pragma mark - CustomViewControllerDelegate

- (void)baseCustomViewController:(__kindof CustomViewController *)controller event:(id)event {
    
    if /* 排序 */ ([controller isKindOfClass:ArticleSortViewController.class]) {
        
        // 更新cell
        NSArray *datas = event;
        [datas enumerateObjectsUsingBlock:^(BaseBlockItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
            
            CellDataAdapter *adapter    = self.adapters[2 + idx * 2];
            adapter.data                = item;
            adapter.cellReuseIdentifier = item.cellReuseId;
            adapter.cellHeight          = item.cellHeight;
        }];
        
        [self.tableView reloadData];
        
        // 更新 block_manager.data
        NSMutableDictionary *olds = [NSMutableDictionary dictionary];
        [self.blocksManager.blocks enumerateObjectsUsingBlock:^(BlockMessage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [olds setObject:obj forKey:@(obj.blockId)];
        }];
        
        NSMutableArray *news = [NSMutableArray array];
        [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj.data isKindOfClass:BaseBlockItem.class]) {
                
                BaseBlockItem *item = obj.data;
                [news addObject:olds[item.itemId]];
            }
        }];
        
        self.blocksManager.blocks = news;
        [self.blocksManager store];
        
    } /* 编辑结果 */ else if ([controller isKindOfClass:BlockInputInfoEditViewController.class]) {
        
        BaseBlockItem    *item  = event;
        __block NSInteger index = 0;
        
        [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj.data isKindOfClass:BaseBlockItem.class]) {
                
                BaseBlockItem *tmpItem = obj.data;
                
                if (item.itemId == tmpItem.itemId) {
                
                    index = idx;
                    *stop = YES;
                }
            }
        }];
        
        // 替换数据源
        [self.adapters replaceObjectAtIndex:index withObject:[item tableViewAdapterWithAdapterType:BaseArticleEditCellAdapterTypeDelete]];
        [self.tableView reloadData];
    }
}

#pragma mark - CustomNavigationControllerDelegate

- (void)baseCustomNavigationController:(__kindof BaseCustomNavigationController *)navigationController controller:(BaseCustomViewController *)controller
                                 event:(id)event {
    
    if /* 更换标题模板 */ (navigationController.view.tag == NavigationControllerTitle) {
        
        // 删除以前的数据
        BaseBlockItem *oldItem = self.adapters.firstObject.data;
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", oldItem.htmlFolderName, oldItem.folderName] error:nil];
        
        // 更新cell
        BaseBlockItem *item = event;
        [self.adapters replaceObjectAtIndex:0 withObject:[item tableViewAdapterWithAdapterType:BaseArticleEditCellAdapterTypeDelete]];
        [self.tableView reloadData];
        
        // 更新 block_manager.data
        BlockMessage *blockMessage   = [BlockMessage new];
        blockMessage.blockFolderName = item.folderName;
        blockMessage.blockId         = item.itemId.integerValue;
        [self.blocksManager.blocks replaceObjectAtIndex:0 withObject:blockMessage];
        [self.blocksManager store];
        
    } /* 添加段落... 添加小标题... 添加图文... 添加分割线... */ else if (navigationController.view.tag == NavigationControllerNormal) {
        
        // 插入cell
        BaseBlockItem *item = event;
        [self.adapters insertObject:[item tableViewAdapterWithAdapterType:BaseArticleEditCellAdapterTypeDelete] atIndex:_tmpAddCellIndexPath.row];
        [self.adapters insertObject:ItemAddCell.fixedHeightTypeDataAdapter atIndex:_tmpAddCellIndexPath.row];
        [self.tableView reloadData];
        
        // 更新 block_manager.data
        [self.blocksManager addBaseBlockItem:item];
        
        NSMutableDictionary *olds = [NSMutableDictionary dictionary];
        [self.blocksManager.blocks enumerateObjectsUsingBlock:^(BlockMessage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [olds setObject:obj forKey:@(obj.blockId)];
        }];
        
        NSMutableArray *news = [NSMutableArray array];
        [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj.data isKindOfClass:BaseBlockItem.class]) {
                
                BaseBlockItem *item = obj.data;
                [news addObject:olds[item.itemId]];
            }
        }];
        
        self.blocksManager.blocks = news;
        [self.blocksManager store];
    }
}

#pragma mark - Buttons

- (void)buildButtons {
    
    // 返回按钮
    CircleIconButton *backButton = [[CircleIconButton alloc] initWithType:CircleIconButtonType_Back];
    backButton.left              = 20.f;
    backButton.top               = 20.f;
    [self.contentView addSubview:backButton];
    [backButton addTarget:self action:@selector(buttonsEvent:)];
    
    // 更多按钮
    CircleIconButton *moreButton = [[CircleIconButton alloc] initWithType:CircleIconButtonType_More];
    moreButton.right             = Width - 20.f;
    moreButton.top               = 20.f;
    [self.contentView addSubview:moreButton];
    [moreButton addTarget:self action:@selector(buttonsEvent:)];
    
    // 预览按钮
    CircleIconButton *seeButton = [[CircleIconButton alloc] initWithType:CircleIconButtonType_See];
    seeButton.right             = Width - 20.f;
    seeButton.bottom            = Height - 20.f;
    [self.contentView addSubview:seeButton];
    [seeButton addTarget:self action:@selector(buttonsEvent:)];
    
    if (DeviceInfo.isFringeScreen) {
        
        backButton.top   = 20 + DeviceInfo.fringeScreenTopSafeHeight;
        moreButton.top   = 20 + DeviceInfo.fringeScreenTopSafeHeight;
        seeButton.bottom = Height - DeviceInfo.fringeScreenBottomSafeHeight - 20.f;
    }
}

- (void)buttonsEvent:(CircleIconButton *)button {
    
    if (button.tag == CircleIconButtonType_Back) {
        
        // 生成html网页
        [self.htmlCreator startCreateHtmlWithBlocksManager:self.blocksManager];
        
        if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(baseCustomViewController:event:)]) {

            [self.eventDelegate baseCustomViewController:self event:nil];
        }
        
        [self popViewControllerAnimated:YES];
        
    } else if (button.tag == CircleIconButtonType_More) {

        CGFloat y = 55.f;
        
        if (DeviceInfo.isFringeScreen) {
            
            y += DeviceInfo.fringeScreenTopSafeHeight;
        }
        
        NSMutableArray *datas = [NSMutableArray array];
        [datas addObject:[PopMenuObject popMenuObjectWithIcon:PopMenuButtonIconTypeChange type:PopMenuButtonTitleTypeCyanBold index:0 title:@"更换标题模板"]];
        if (self.adapters.count > 4) {
            
            [datas addObject:[PopMenuObject popMenuObjectWithIcon:PopMenuButtonIconTypeSort   type:PopMenuButtonTitleTypeNormal   index:1 title:@"内容排序"]];
        }

        PopMenuView *menuView = [PopMenuView menuViewWithDelegate:self datas:datas];
        [menuView showAtPoint:CGPointMake(Width - 25.f, y)];
        
    } else if (button.tag == CircleIconButtonType_See) {
        
        // 生成html网页
        [self.htmlCreator startCreateHtmlWithBlocksManager:self.blocksManager];
        
        NSMutableArray *blockItems = [NSMutableArray array];
        [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj.data isKindOfClass:BaseBlockItem.class]) {
                
                BaseBlockItem *item = obj.data;
                [blockItems addObject:item];
            }
        }];
        
        HtmlEditViewController *controller = [HtmlEditViewController new];
        controller.htmlFolder              = self.htmlFolder;
        controller.blockItems              = blockItems;
        BaseCustomNavigationController *nc = [[BaseCustomNavigationController alloc] initWithRootViewController:controller setNavigationBarHidden:YES];
        
        [self.navigationController presentViewController:nc animated:YES completion:nil];
    }
}

@end
