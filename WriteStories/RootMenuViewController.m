//
//  RootMenuViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/5/24.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "RootMenuViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "SetupViewController.h"
#import "RootMenuCollectionCell.h"
#import "RootMenuCollectionCellModel.h"
#import "FolderListViewController.h"
#import "DefaultNotificationCenter.h"
#import "PasswordViewController.h"
#import "DBManager.h"
#import "Values.h"
#import "WSAlertView.h"
#import "StyleSaveView.h"
#import "GCD.h"

#import "ExamplesCollectionCell.h"
#import "BellesLettresCollectionCell.h"
#import "InformalEssayCollectionCell.h"
#import "PrivateCollectionCell.h"
#import "DraftCollectionCell.h"
#import "OtherCollectionCell.h"

@interface RootMenuViewController () <UICollectionViewDataSource, UICollectionViewDelegate, DefaultNotificationCenterDelegate, CustomViewControllerDelegate>

@property (nonatomic, strong) UICollectionView                   *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout         *layout;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) DefaultNotificationCenter          *notificationCenter;

@end

@implementation RootMenuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"美记";
    
    self.notificationCenter = [DefaultNotificationCenter defaultNotificationCenterWithDelegate:self addNotificationNames:^(NSMutableArray<NSString *> *names) {
        
        [names addObject:Values.Noti_RootMenuViewControllerUpdateCountNumber];
    }];
    
    CGFloat gap       = 15.f;
    CGFloat itemWidth = (Width - gap * 3) / 2.f;
    
    self.layout = [UICollectionViewFlowLayout new];
    self.layout.minimumLineSpacing      = gap;
    self.layout.minimumInteritemSpacing = gap;
    self.layout.itemSize                = CGSizeMake(itemWidth, itemWidth * 1.5f);
    
    self.collectionView                 = [[UICollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:self.layout];
    self.collectionView.delegate        = self;
    self.collectionView.dataSource      = self;
    self.collectionView.contentInset    = UIEdgeInsetsMake(gap, gap, gap, gap);
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.collectionView];
    
    [RootMenuCollectionCell registerToCollectionView:self.collectionView];
    
    NSArray *datas = @[[RootMenuCollectionCellModel modelWithTitle:@"示例" enTitle:@"Examples" countNumber:@"0/0"],
                       [RootMenuCollectionCellModel modelWithTitle:@"美文" enTitle:@"Belles-lettres" countNumber:@"0/0"],
                       [RootMenuCollectionCellModel modelWithTitle:@"随笔" enTitle:@"Informal essay" countNumber:@"0/0"],
                       [RootMenuCollectionCellModel modelWithTitle:@"私密" enTitle:@"Private" countNumber:@"0/0"],
                       [RootMenuCollectionCellModel modelWithTitle:@"草稿" enTitle:@"Draft" countNumber:@"0/0"],
                       [RootMenuCollectionCellModel modelWithTitle:@"其他" enTitle:@"Other" countNumber:@"0/0"]];
    
    self.adapters = [NSMutableArray array];
    
    // 示例
    {
        NSString *reuseIdentifier = [self reuseIdentifierWithIndex:0];
        [self.adapters addObject:[ExamplesCollectionCell dataAdapterWithCellReuseIdentifier:reuseIdentifier data:datas[0]]];
        [self.collectionView registerClass:ExamplesCollectionCell.class forCellWithReuseIdentifier:reuseIdentifier];
    }
    
    // 美文
    {
        NSString *reuseIdentifier = [self reuseIdentifierWithIndex:1];
        [self.adapters addObject:[BellesLettresCollectionCell dataAdapterWithCellReuseIdentifier:reuseIdentifier data:datas[1]]];
        [self.collectionView registerClass:BellesLettresCollectionCell.class forCellWithReuseIdentifier:reuseIdentifier];
    }
    
    // 随笔
    {
        NSString *reuseIdentifier = [self reuseIdentifierWithIndex:2];
        [self.adapters addObject:[InformalEssayCollectionCell dataAdapterWithCellReuseIdentifier:reuseIdentifier data:datas[2]]];
        [self.collectionView registerClass:InformalEssayCollectionCell.class forCellWithReuseIdentifier:reuseIdentifier];
    }
    
    // 私密
    {
        NSString *reuseIdentifier = [self reuseIdentifierWithIndex:3];
        [self.adapters addObject:[PrivateCollectionCell dataAdapterWithCellReuseIdentifier:reuseIdentifier data:datas[3]]];
        [self.collectionView registerClass:PrivateCollectionCell.class forCellWithReuseIdentifier:reuseIdentifier];
    }
    
    // 草稿
    {
        NSString *reuseIdentifier = [self reuseIdentifierWithIndex:4];
        [self.adapters addObject:[DraftCollectionCell dataAdapterWithCellReuseIdentifier:reuseIdentifier data:datas[4]]];
        [self.collectionView registerClass:DraftCollectionCell.class forCellWithReuseIdentifier:reuseIdentifier];
    }
    
    // 其他
    {
        NSString *reuseIdentifier = [self reuseIdentifierWithIndex:5];
        [self.adapters addObject:[OtherCollectionCell dataAdapterWithCellReuseIdentifier:reuseIdentifier data:datas[5]]];
        [self.collectionView registerClass:OtherCollectionCell.class forCellWithReuseIdentifier:reuseIdentifier];
    }
    
    [self updataCountNumber];
}

- (void)updataCountNumber {
    
    [GCDQueue executeInGlobalQueue:^{
        
        NSMutableArray <NSNumber *> *folders = [NSMutableArray array];
        NSMutableArray <NSNumber *> *files   = [NSMutableArray array];
        
        [DBManager.queue inDatabase:^(FMDatabase * _Nonnull db) {
            
            NSInteger count_1 = [db intForQuery:@"SELECT COUNT(*) FROM Table_Folder_List WHERE type = ?;", @(1)];
            NSInteger count_2 = [db intForQuery:@"SELECT COUNT(*) FROM Table_Folder_List WHERE type = ?;", @(2)];
            NSInteger count_3 = [db intForQuery:@"SELECT COUNT(*) FROM Table_Folder_List WHERE type = ?;", @(3)];
            NSInteger count_4 = [db intForQuery:@"SELECT COUNT(*) FROM Table_Folder_List WHERE type = ?;", @(4)];
            NSInteger count_5 = [db intForQuery:@"SELECT COUNT(*) FROM Table_Folder_List WHERE type = ?;", @(5)];
            NSInteger count_6 = [db intForQuery:@"SELECT COUNT(*) FROM Table_Folder_List WHERE type = ?;", @(6)];
            
            [folders addObject:@(count_1)];
            [folders addObject:@(count_2)];
            [folders addObject:@(count_3)];
            [folders addObject:@(count_4)];
            [folders addObject:@(count_5)];
            [folders addObject:@(count_6)];
            
            NSInteger file_1 = [db intForQuery:@"SELECT COUNT(*) FROM Table_Mark_List WHERE type = ?;", @(1)];
            NSInteger file_2 = [db intForQuery:@"SELECT COUNT(*) FROM Table_Mark_List WHERE type = ?;", @(2)];
            NSInteger file_3 = [db intForQuery:@"SELECT COUNT(*) FROM Table_Mark_List WHERE type = ?;", @(3)];
            NSInteger file_4 = [db intForQuery:@"SELECT COUNT(*) FROM Table_Mark_List WHERE type = ?;", @(4)];
            NSInteger file_5 = [db intForQuery:@"SELECT COUNT(*) FROM Table_Mark_List WHERE type = ?;", @(5)];
            NSInteger file_6 = [db intForQuery:@"SELECT COUNT(*) FROM Table_Mark_List WHERE type = ?;", @(6)];
            
            [files addObject:@(file_1)];
            [files addObject:@(file_2)];
            [files addObject:@(file_3)];
            [files addObject:@(file_4)];
            [files addObject:@(file_5)];
            [files addObject:@(file_6)];
        }];
        
        [GCDQueue executeInMainQueue:^{
            
            [folders enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                RootMenuCollectionCellModel *model = self.adapters[idx].data;
                model.countNumber                  = [NSString stringWithFormat:@"%@/%@", files[idx], folders[idx]];
                
                NSLog(@"%@", model.countNumber);
            }];
            
            [self.collectionView reloadData];
        }];
    }];
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.adapters.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter        *adapter = self.adapters[indexPath.row];
    RootMenuCollectionCell *cell    = [collectionView dequeueReusableCellWithReuseIdentifier:adapter.cellReuseIdentifier forIndexPath:indexPath];
    cell.dataAdapter                = adapter;
    cell.data                       = adapter.data;
    [cell loadContent];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.collectionView.visibleCells enumerateObjectsUsingBlock:^(__kindof UICollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BaseCustomCollectionCell *cell = (BaseCustomCollectionCell *)obj;
        [cell contentOffset:scrollView.contentOffset];
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RootMenuCollectionCellModel *model = self.adapters[indexPath.row].data;
    
    BOOL canEdit = YES;

    if (Values.FolderType[model.title].integerValue == 1) {

        canEdit = NO;
    }

    if (Values.PreviewMode == YES) {

        canEdit = NO;
    }
    
    if ([model.title isEqualToString:@"私密"]) {
        
        if (Values.Passwords.count) {
            
            PasswordViewController *controller = [PasswordViewController new];
            controller.type                    = PasswordViewControllerTypeComfirmPassword;
            controller.eventDelegate           = self;
            [self.navigationController presentViewController:controller animated:YES completion:nil];
            
        } else {
            
            FolderListViewController *controller = [FolderListViewController new];
            controller.title                     = model.title;
            controller.type                      = Values.FolderType[model.title];
            controller.canEdit                   = canEdit;
            [self.navigationController pushViewController:controller animated:YES];
        }
        
    } else {
        
        FolderListViewController *controller = [FolderListViewController new];
        controller.title                     = model.title;
        controller.type                      = Values.FolderType[model.title];
        controller.canEdit                   = canEdit;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - CustomViewControllerDelegate

- (void)baseCustomViewController:(__kindof CustomViewController *)controller event:(id)event {
    
    if ([controller isKindOfClass:PasswordViewController.class]) {
        
        PasswordViewControllerResult result = [event integerValue];
        
        if (result == PasswordViewControllerResultSuccess) {
            
            BOOL canEdit = YES;
            
            if (Values.FolderType[@"私密"].integerValue == 1) {
                
                canEdit = NO;
            }
            
            if (Values.PreviewMode == YES) {
                
                canEdit = NO;
            }
            
            FolderListViewController *controller = [FolderListViewController new];
            controller.title                     = @"私密";
            controller.type                      = Values.FolderType[@"私密"];
            controller.canEdit                   = canEdit;
            [self.navigationController pushViewController:controller animated:NO];
        }
    }
}

#pragma mark - Buttons event.

- (void)buttonsEvent:(UIButton *)button {
    
    if (button.tag == TitleMenuButton_Setup) {
        
        SetupViewController *controller = [SetupViewController new];
        controller.title                = @"设置";
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - DefaultNotificationCenterDelegate

- (void)defaultNotificationCenter:(DefaultNotificationCenter *)notification name:(NSString *)name object:(id)object {
    
    if ([name isEqualToString:Values.Noti_RootMenuViewControllerUpdateCountNumber]) {
        
        [self updataCountNumber];
    }
}

#pragma mark - Other.

- (NSString *)reuseIdentifierWithIndex:(NSUInteger)index {
    
    return [NSString stringWithFormat:@"cell_%lu", (unsigned long)index];
}

#pragma mark - Overwrite system methods.

- (void)setupSubViews {
    
    [super setupSubViews];
    [self.backButton removeFromSuperview];
    
    TitleMenuButton *setupButton = [[TitleMenuButton alloc] initWithFrame:CGRectMake(0, 0, 80, 64.f) type:TitleMenuButton_Setup];
    setupButton.right            = self.titleContentView.width;
    [setupButton addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleContentView addSubview:setupButton];
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
