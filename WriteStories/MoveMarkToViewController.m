//
//  MoveMarkToViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/19.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "MoveMarkToViewController.h"
#import "Table_Folder_List.h"
#import "MoveMarkToCell.h"
#import "MoveMarkToHeaderView.h"
#import "Table_Mark_List.h"
#import "GCD.h"

@interface MoveMarkToViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIImageView    *noDataImageView;
@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray <Table_Folder_Type_Object *> *foldersList;

@end

@implementation MoveMarkToViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.foldersList     = [NSMutableArray array];
    NSArray *typesObject = Table_Folder_List.folderObjects;
    
    // 过滤掉相同文件夹
    __block Table_Folder_Type_Object *type   = nil;
    __block Table_Folder_Object      *folder = nil;
    __block BOOL                      find   = NO;
    [typesObject enumerateObjectsUsingBlock:^(Table_Folder_Type_Object * _Nonnull tmpType, NSUInteger idx, BOOL * _Nonnull stop) {

        [tmpType.folderObjects enumerateObjectsUsingBlock:^(Table_Folder_Object * _Nonnull tmpFolder, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (tmpFolder.folderId == self.markItem.folder_id) {
                
                type   = tmpType;
                folder = tmpFolder;
                find   = YES;
                *stop  = YES;
            }
        }];
        
        if (find == YES) {
            
            *stop = YES;
        }
    }];
    
    [type.folderObjects removeObject:folder];
    
    // 添加可移动的文件夹
    [typesObject enumerateObjectsUsingBlock:^(Table_Folder_Type_Object * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.folderObjects.count && obj.type != 1) {
            
            [self.foldersList addObject:obj];
        }
    }];
    
    self.noDataImageView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"noData"]];
    self.noDataImageView.alpha  = 0.f;
    self.noDataImageView.center = self.contentView.middlePoint;
    [self.contentView addSubview:self.noDataImageView];
    
    self.tableView                     = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    self.tableView.dataSource          = self;
    self.tableView.delegate            = self;
    self.tableView.rowHeight           = 75.f;
    self.tableView.sectionHeaderHeight = 30.f;
    self.tableView.alpha               = 0.f;
    self.tableView.separatorStyle      = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor     = [UIColor clearColor];
    [self.contentView addSubview:self.tableView];
    
    [MoveMarkToCell       registerToTableView:self.tableView];
    [MoveMarkToHeaderView registerToTableView:self.tableView];
    
    [UIView animateWithDuration:0.45f animations:^{
        
        self.tableView.alpha       = self.foldersList.count ? 1 : 0.f;
        self.noDataImageView.alpha = self.foldersList.count ? 0 : 1.f;
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.foldersList[section].folderObjects.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.foldersList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MoveMarkToCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoveMarkToCell"];
    cell.data            = self.foldersList[indexPath.section].folderObjects[indexPath.row];
    [cell loadContent];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    MoveMarkToHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MoveMarkToHeaderView"];
    headerView.data                  = self.foldersList[section];
    [headerView loadContent];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Table_Folder_Object *object = self.foldersList[indexPath.section].folderObjects[indexPath.row];
    if (object.fileCount < 40) {
        
        [Table_Mark_List moveMarkId:self.markItem.mark_id toFolderId:object.folderId toType:object.type];
        
        if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(baseCustomViewController:event:)]) {
            
            [self.eventDelegate baseCustomViewController:self event:self.markItem];
        }
        
        [self popViewControllerAnimated:YES];
    }
}

@end
