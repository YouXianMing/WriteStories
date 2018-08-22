//
//  ScaleSelectedView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/1.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ScaleSelectedView.h"
#import "UIButton+Inits.h"
#import "UIView+SetRect.h"
#import "UIColor+Project.h"
#import "UIFont+Project.h"
#import "ScaleSelectedViewTableViewCell.h"
#import "GCD.h"

@interface ScaleSelectedView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *backgroundButton;
@property (nonatomic, weak)   UIWindow *keyWindow;
@property (nonatomic, strong) UIView   *contentView;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ScaleSelectedView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self.keyWindow = [UIApplication sharedApplication].keyWindow;
    if (self = [super initWithFrame:self.keyWindow.bounds]) {
    
        self.backgroundColor = [UIColor clearColor];
        
        self.backgroundButton = [[UIButton alloc] initWithFrame:self.bounds];
        [self.backgroundButton addTarget:self action:@selector(hide)];
        [self addSubview:self.backgroundButton];
    }
    
    return self;
}

- (void)show {
    
    [self.keyWindow addSubview:self];
    
    
    self.contentView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width - 120.f, 40 + 50 * 5)];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.center          = self.middlePoint;
    self.contentView.alpha           = 0.f;
    [self addSubview:self.contentView];
    
    UIButton *closeButton        = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40.f, 40.f)];
    closeButton.normalImage      = [UIImage imageNamed:@"menuClose"];
    closeButton.highlightedImage = [UIImage imageNamed:@"menuClose-pre"];
    closeButton.right            = self.contentView.width;
    [closeButton addTarget:self action:@selector(hide)];
    [self.contentView addSubview:closeButton];
    
    UILabel *titleLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Width - 120.f, 40.f)];
    titleLabel.font          = [UIFont PingFangSC_Regular_WithFontSize:16.f];
    titleLabel.text          = @"图片宽高比";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLabel];
    
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5f, self.contentView.width, 0.5f)];
    line.backgroundColor = UIColor.LineColor;
    [self.contentView addSubview:line];
    
    self.tableView                = [[UITableView alloc] initWithFrame:CGRectMake(0, 40.f, self.contentView.width, 50 * 5)];
    self.tableView.dataSource     = self;
    self.tableView.delegate       = self;
    self.tableView.rowHeight      = 50.f;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:self.tableView];
    [ScaleSelectedViewTableViewCell registerToTableView:self.tableView];
    
    self.contentView.top -= 20.f;
    [UIView animateWithDuration:0.45f animations:^{
    
        self.contentView.top  += 20.f;
        self.contentView.alpha = 1.f;
        self.backgroundColor   = [[UIColor blackColor] colorWithAlphaComponent:0.15f];
    }];
}

- (void)hide {
    
    [UIView animateWithDuration:0.25f animations:^{
       
        self.contentView.top  += 10.f;
        self.contentView.alpha = 0.f;
        self.backgroundColor   = [UIColor clearColor];
        
    } completion:^(BOOL finished) {
    
        [self removeFromSuperview];
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return self.imageObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ScaleSelectedViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScaleSelectedViewTableViewCell"];
    cell.data                            = self.imageObjects[indexPath.row];
    [cell loadContent];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self hide];
    
    [GCDQueue executeInMainQueue:^{
        
        if (self.selectedBlock) {
            
            self.selectedBlock(self.imageObjects[indexPath.row]);
        }
        
    } afterDelaySecs:0.25f];
}

#pragma mark -

+ (void)scaleSelectedViewShowWithImageObjects:(NSArray <EncodeImageObject *> *)imageObjects
                                selectedBlock:(ScaleSelectedViewSelectedBlock_t)selectedBlock {
    
    ScaleSelectedView *selectedView = [ScaleSelectedView new];
    selectedView.imageObjects       = imageObjects;
    selectedView.selectedBlock      = selectedBlock;
    
    [selectedView show];
}

- (void)dealloc {
    
    NSLog(@"ScaleSelectedView is dealloced.");
}

@end
