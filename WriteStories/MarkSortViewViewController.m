//
//  MarkSortViewViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/19.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "MarkSortViewViewController.h"
#import "MarkSortCell.h"

@interface MarkSortViewViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView                        *tableView;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

@end

@implementation MarkSortViewViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.adapters = [NSMutableArray array];
    
    [self.markItems enumerateObjectsUsingBlock:^(BaseMarkItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.adapters addObject:[MarkSortCell dataAdapterWithData:obj]];
    }];
    
    self.tableView                 = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    self.tableView.dataSource      = self;
    self.tableView.delegate        = self;
    self.tableView.rowHeight       = 75.f;
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setEditing:YES animated:NO];
    [self.contentView addSubview:self.tableView];
    
    [MarkSortCell registerToTableView:self.tableView];
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

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 不显示删除等状态
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 进入编辑状态时左侧不缩进
    return NO;
}

@end
