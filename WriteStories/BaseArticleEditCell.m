//
//  BaseArticleEditCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/25.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseArticleEditCell.h"
#import "UIButton+Inits.h"
#import "UIFont+Project.h"

@interface BaseArticleEditCell ()

@end

@implementation BaseArticleEditCell

- (void)buildSubview {

    CGFloat width = self.class.rightViewWidth;
    
    self.areaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width - width, 0)];
    [self.contentView addSubview:self.areaView];
    
    self.rightView                 = [[UIView alloc] initWithFrame:CGRectMake(Width - width, 0, width, 0)];
    self.rightView.backgroundColor = [UIColor colorWithHexString:@"#ededed"];
    [self.contentView addSubview:self.rightView];
    
    self.deleteButton                  = [[TapAlphaButton alloc] initWithFrame:CGRectMake(Width - width, 0, width, 0)];
    self.deleteButton.normalImage      = [UIImage imageNamed:@"save-delete"];
    self.deleteButton.highlightedImage = [UIImage imageNamed:@"save-delete"];
    [self.deleteButton addTarget:self action:@selector(deleteButtonsEvent:)];
    [self.contentView addSubview:self.deleteButton];
    
    self.edgeLabel                 = [EdgeInsetsLabel new];
    self.edgeLabel.textColor       = [UIColor whiteColor];
    self.edgeLabel.font            = [UIFont PingFangSC_Regular_WithFontSize:8.f];
    self.edgeLabel.edgeInsets      = UIEdgeInsetsMake(2, 5, 2, 5);
    self.edgeLabel.layer.cornerRadius  = 3.f;
    self.edgeLabel.layer.masksToBounds = YES;
    [self.contentView addSubview:self.edgeLabel];
}

- (void)loadContent {
    
    self.rightView.height    = self.dataAdapter.cellHeight;
    self.deleteButton.height = self.dataAdapter.cellHeight;
    self.areaView.height     = self.dataAdapter.cellHeight;
    
    id <ArticleEditObjectProtocol> object = self.data;
    if (object.cell_Type == ArticleEditObjectType_Paragraph) {
        
        self.edgeLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        
    } else if (object.cell_Type == ArticleEditObjectType_SubTitle) {
        
        self.edgeLabel.backgroundColor = [[UIColor colorWithHexString:@"#00c0ff"] colorWithAlphaComponent:0.5f];
        
    } else if (object.cell_Type == ArticleEditObjectType_Picture) {
        
        self.edgeLabel.backgroundColor = [[UIColor colorWithHexString:@"#ff5f5f"] colorWithAlphaComponent:0.5f];
    }
    
    [self.edgeLabel sizeToFitWithText:object.cell_TypeText];
    self.edgeLabel.right           = Width - self.class.rightViewWidth - 3;
    self.edgeLabel.bottom          = self.dataAdapter.cellHeight - 3;
    
    if (self.dataAdapter.cellType == BaseArticleEditCellAdapterTypeDelete) {
        
        self.edgeLabel.hidden          = NO;
        self.deleteButton.hidden       = NO;
        self.rightView.backgroundColor = [UIColor colorWithHexString:@"#ededed"];
        
    } else if (self.dataAdapter.cellType == BaseArticleEditCellAdapterTypeEdit) {
        
        self.edgeLabel.hidden          = YES;
        self.deleteButton.hidden       = YES;
        self.rightView.backgroundColor = UIColor.BackgroundColor;
        
    } else {
        
        self.edgeLabel.hidden          = YES;
        self.deleteButton.hidden       = YES;
    }
}

- (void)deleteButtonsEvent:(UIButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        
        [self.delegate customCell:self event:@(BaseArticleEditCellEventDelete)];
    }
}

- (void)selectedEvent {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        
        [self.delegate customCell:self event:@(BaseArticleEditCellEventEdit)];
    }
}

+ (CGFloat)rightViewWidth {
    
    return 52.5f;
}

@end
