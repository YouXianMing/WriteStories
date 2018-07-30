//
//  ArticleStylesViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseArticleStylesViewController.h"
#import "StyleSectionHeaderView.h"

@interface BaseArticleStylesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray <StyleSectionObject *> *sections;
@property (nonatomic, strong) UITableView                           *tableView;

@end

@implementation BaseArticleStylesViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView                     = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    self.tableView.dataSource          = self;
    self.tableView.delegate            = self;
    self.tableView.backgroundColor     = [UIColor clearColor];
    self.tableView.separatorStyle      = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionHeaderHeight = 30.f;
    [self.contentView addSubview:self.tableView];
    
    [StyleSectionHeaderView registerToTableView:self.tableView];
    
    [self registerCellsWithTableView:self.tableView];
    
    self.sections = [NSMutableArray array];
    
    [self addStyleSectionObjectsWithSectionArray:self.sections];
}

#pragma mark - Overwrite by sub class.

- (void)registerCellsWithTableView:(UITableView *)tableView {
    
    
}

- (void)addStyleSectionObjectsWithSectionArray:(NSMutableArray <StyleSectionObject *> *)sections {
    
    
}

- (void)didSelectedBlockItems:(BaseBlockItem *)blockItem {
    
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.sections[section].adapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter *adapter = self.sections[indexPath.section].adapters[indexPath.row];
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    cell.dataAdapter = adapter;
    cell.data        = adapter.data;
    cell.indexPath   = indexPath;
    [cell loadContent];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.sections[indexPath.section].adapters[indexPath.row].cellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    StyleSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"StyleSectionHeaderView"];
    headerView.data                    = self.sections[section];
    [headerView loadContent];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseStyleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self didSelectedBlockItems:cell.blockItem];
}

#pragma mark - Button's event.

- (void)buttonsEvent:(UIButton *)button {
    
    if (button.tag == TitleMenuButton_Close) {
        
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    self.enableInteractivePopGestureRecognizer = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    self.enableInteractivePopGestureRecognizer = NO;
}

@end
