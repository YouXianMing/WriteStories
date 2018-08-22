//
//  StyleAdjustEditView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/17.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "StyleAdjustEditView.h"
#import "ColorAlphaButton.h"
#import "ItemEditorCell.h"
#import "ItemHeaderView.h"
#import "BaseItemSetupView.h"

@interface StyleAdjustEditView () <UITableViewDelegate, UITableViewDataSource, BaseItemSetupViewDelegate>

@property (nonatomic, strong) UIView      *contentView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView  *setupView;

@property (nonatomic) NSInteger currentSelectedSection;
@property (nonatomic) NSInteger currentSelectedRow;

@end

@implementation StyleAdjustEditView

+ (CGFloat)StyleAdjustEditViewLeftLineGap {
    
    return 93.f;
}

- (void)buildTitle {
    
    self.iconImageView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"styleAdjust"]];
    self.iconImageView.center = CGPointMake(25.f, 45 / 2.f);
    [self.areaView addSubview:self.iconImageView];
    
    self.label           = [[UILabel alloc] initWithFrame:CGRectMake(48.f, 0, 100, 45.f)];
    self.label.font      = [UIFont PingFangSC_Regular_WithFontSize:17.f];
    self.label.textColor = [UIColor colorWithHexString:@"#7e7e7e"];
    self.label.text      = @"样式调整";
    [self.areaView addSubview:self.label];
    
    ColorAlphaButton *button = [[ColorAlphaButton alloc] initWithFrame:CGRectMake(0, 0, 100, 28.f)];
    button.backgroundColor   = [UIColor colorWithHexString:@"#d4d4d4"];
    button.centerY           = 25.f;
    button.right             = Width - 10.f;
    button.titleLabel.font   = [UIFont PingFangSC_Medium_WithFontSize:40 / 3.f];
    [button addTarget:self action:@selector(saveEvent) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"保存当前样式" forState:UIControlStateNormal];
    [self addSubview:button];
    
    if (self.hideManagerSavedButton == YES) {
        
        button.hidden = YES;
    }
}

- (void)saveEvent {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(editViewButtonEvent:)]) {
        
        [self.delegate editViewButtonEvent:self];
    }
}

- (void)buildTableView {
    
    // 给定一个不可能选中的超大值
    self.currentSelectedSection = 100000;
    self.currentSelectedRow     = 100000;
    
    self.tableView                     = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.class.StyleAdjustEditViewLeftLineGap, self.contentView.height)];
    self.tableView.rowHeight           = 45.f;
    self.tableView.sectionHeaderHeight = 23.f;
    self.tableView.delegate            = self;
    self.tableView.dataSource          = self;
    self.tableView.separatorStyle      = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:self.tableView];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [ItemEditorCell registerToTableView:self.tableView];
    [ItemHeaderView registerToTableView:self.tableView];
    
     [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

- (void)buildLines {
    
    UIView *leftLine         = [[UIView alloc] initWithFrame:CGRectMake(self.class.StyleAdjustEditViewLeftLineGap, 0, 0.5f, self.contentView.height)];
    leftLine.backgroundColor = UIColor.LineColor;
    [self.contentView addSubview:leftLine];
    
    UIView *bottomLine         = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.height, Width, 0.5f)];
    bottomLine.backgroundColor = UIColor.LineColor;
    [self.contentView addSubview:bottomLine];
}

- (void)buildSubViews {
    
    [self buildTitle];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 45.f, Width, 250.f - 45.f)];
    [self.areaView addSubview:self.contentView];
    
    self.setupView                     = [[UIView alloc] initWithFrame:CGRectMake(self.class.StyleAdjustEditViewLeftLineGap, 0,
                                                                                  Width - self.class.StyleAdjustEditViewLeftLineGap, self.contentView.height)];
    self.setupView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.setupView];
    
    [self buildTableView];
    
    [self buildLines];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.editManager.headers.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.editManager.headers[section].editors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemEditorCell"];
    cell.data        = self.editManager.headers[indexPath.section].editors[indexPath.row];
    [cell loadContent];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    ItemHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ItemHeaderView"];
    headerView.data            = self.editManager.headers[section];
    [headerView loadContent];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 防止重复点击,重复创建
    if (self.currentSelectedRow == indexPath.row && self.currentSelectedSection == indexPath.section) {
        
        return;
    }
    
    // 记录当前选中元素的编号
    self.currentSelectedRow     = indexPath.row;
    self.currentSelectedSection = indexPath.section;
    
    [self.editManager.headers enumerateObjectsUsingBlock:^(ItemsHeader *header, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [header.editors enumerateObjectsUsingBlock:^(StyleEditor *editor, NSUInteger idx, BOOL * _Nonnull stop) {
            
            editor.selected = NO;
        }];
    }];
    
    StyleEditor *editor = self.editManager.headers[indexPath.section].editors[indexPath.row];
    editor.selected    = YES;
    [self.tableView reloadData];
    
    // 删除掉添加的view
    [self.setupView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj removeFromSuperview];
    }];
    
    // 添加view
    BaseItemSetupView *setupView = [[editor.setupViewClass alloc] initWithFrame:self.setupView.bounds];
    setupView.delegate           = self;
    setupView.editor             = editor;
    setupView.inputValues        = [editor valuesWithObject:self.editManager.weakObject];
    setupView.extraInfo          = editor.extraInfo;
    
    setupView.pickerViewTitles            = editor.pickerViewTitles;
    setupView.pickerViewValuesRanges      = editor.pickerViewValuesRanges;
    setupView.pickerViewValuesShowStrings = editor.pickerViewValuesShowStrings;
    
    [setupView buildSubViews];
    [self.setupView addSubview:setupView];
}

#pragma mark - BaseItemSetupViewDelegate

- (void)itemSetupView:(BaseItemSetupView *)setupView updateValues:(NSArray *)values {
    
    [setupView.editor setObject:self.editManager.weakObject values:values];
    if (self.delegate && [self.delegate respondsToSelector:@selector(editViewDidUpdateValues:)]) {
        
        [self.delegate editViewDidUpdateValues:self];
    }
}

@end
