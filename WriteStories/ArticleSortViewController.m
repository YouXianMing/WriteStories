//
//  ArticleSortViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ArticleSortViewController.h"
#import "BaseArticleEditCell.h"

@interface ArticleSortViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView                        *tableView;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

@end

@implementation ArticleSortViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.adapters = [NSMutableArray array];
    
    self.tableView                 = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    self.tableView.dataSource      = self;
    self.tableView.delegate        = self;
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setEditing:YES animated:NO];
    [self.contentView addSubview:self.tableView];
    
    [self.blockItems enumerateObjectsUsingBlock:^(BaseBlockItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj registerToTableView:self.tableView];
        [self.adapters addObject:[obj tableViewAdapterWithAdapterType:BaseArticleEditCellAdapterTypeEdit]];
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.adapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter *adapter = self.adapters[indexPath.row];
    CustomCell      *cell    = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    cell.dataAdapter         = adapter;
    cell.data                = adapter.data;
    cell.indexPath           = indexPath;
    [cell loadContent];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    // 移动之后更新数据
    if (sourceIndexPath.row != destinationIndexPath.row) {
        
        CellDataAdapter *object = [self.adapters objectAtIndex:sourceIndexPath.row];
        [self.adapters removeObjectAtIndex:sourceIndexPath.row];
        
        if (destinationIndexPath.row > self.adapters.count) {
            
            [self.adapters addObject:object];
            
        } else {
            
            [self.adapters insertObject:object atIndex:destinationIndexPath.row];
        }
    }
    
    // 通知代理
    if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(baseCustomViewController:event:)]) {
        
        NSMutableArray *datas = [NSMutableArray array];
        [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [datas addObject:obj.data];
        }];
        
        [self.eventDelegate baseCustomViewController:self event:datas];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.adapters[indexPath.row].cellHeight;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 不显示删除等状态
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 进入编辑状态时左侧不缩进
    return NO;
}

@end
