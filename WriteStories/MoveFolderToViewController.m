//
//  MoveFolderToViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/16.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "MoveFolderToViewController.h"
#import "MoveFolderToCell.h"
#import "Values.h"
#import "MoveFolderToCellModel.h"
#import "Table_Folder_List.h"

@interface MoveFolderToViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) UITableView                        *tableView;

@end

@implementation MoveFolderToViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.tableView                 = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    self.tableView.dataSource      = self;
    self.tableView.delegate        = self;
    self.tableView.rowHeight       = 75.f;
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.tableView];
    
    [MoveFolderToCell registerToTableView:self.tableView];
    
    NSMutableArray *datas = [NSMutableArray array];
    [Values.FolderType enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
       
        // 过滤掉示例以及当前文件夹
        if (obj.integerValue != self.type.integerValue && obj.integerValue != 1) {

            MoveFolderToCellModel *model = [MoveFolderToCellModel new];
            model.currentFoldersCount    = [Table_Folder_List foldersCountWithType:obj.integerValue];
            model.type                   = obj;
            model.name                   = key;
            [datas addObject:model];
        }
    }];
    
    [datas sortUsingComparator:^NSComparisonResult(MoveFolderToCellModel *obj1, MoveFolderToCellModel *obj2) {
        
        return [obj1.type compare:obj2.type];
    }];
    
    self.adapters = [NSMutableArray array];
    [datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.adapters addObject:[MoveFolderToCell dataAdapterWithData:obj]];
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
    [cell loadContent];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MoveFolderToCellModel *object = self.adapters[indexPath.row].data;
    
    if (object.currentFoldersCount < 50) {
        
        if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(baseCustomViewController:event:)]) {
            
            MoveFolderToCellModel *model = self.adapters[indexPath.row].data;
            [self.eventDelegate baseCustomViewController:self event:@{@"folderItem" : self.folderItem,
                                                                      @"folderType" : model.type}];
            [self popViewControllerAnimated:YES];
        }
    }
}

@end
