//
//  StyleManagerEditViewCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/22.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "StyleManagerEditViewCell.h"
#import "UIView+SetRect.h"
#import "UIButton+Inits.h"
#import "UIFont+Project.h"
#import "HexColors.h"
#import "WriteStoriesBaseItemObject.h"

@interface StyleManagerEditViewCell ()

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel     *label;

@end

@implementation StyleManagerEditViewCell

- (void)buildSubview {
    
    self.bgImageView       = [[UIImageView alloc] initWithFrame:self.bounds];
    self.bgImageView.image = [[UIImage imageNamed:@"saveBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    [self.contentView addSubview:self.bgImageView];
    
    self.bgImageView.left    = -2.f;
    self.bgImageView.top     = -2.f;
    self.bgImageView.width  += 8.f;
    self.bgImageView.height += 6.f;
    
    UIView *alphaView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 36.f, self.height - 3.f)];
    alphaView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1f];
    [self.contentView addSubview:alphaView];
    
    UIButton *delButton        = [[UIButton alloc] initWithFrame:alphaView.bounds];
    delButton.normalImage      = [UIImage imageNamed:@"save-delete"];
    delButton.highlightedImage = [UIImage imageNamed:@"save-delete_pre"];
    delButton.tag              = StyleManagerEditViewCellDelete;
    [delButton addTarget:self action:@selector(buttonsEvent:)];
    [alphaView addSubview:delButton];
    
    UIButton *editButton        = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    editButton.normalImage      = [UIImage imageNamed:@"styleEdit"];
    editButton.highlightedImage = [UIImage imageNamed:@"styleEdit_pre"];
    editButton.tag    = StyleManagerEditViewCellEdit;
    [editButton addTarget:self action:@selector(buttonsEvent:)];
    editButton.right  = self.width;
    editButton.bottom = self.height - 2.f;
    [self.contentView addSubview:editButton];
    
    self.label               = [[UILabel alloc] init];
    self.label.font          = [UIFont PingFangSC_Medium_WithFontSize:15.f];
    self.label.numberOfLines = 2;
    self.label.textColor     = [UIColor colorWithHexString:@"#666666"];
    [self.contentView addSubview:self.label];
}

- (void)buttonsEvent:(UIButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCollectionCell:event:)]) {
        
        [self.delegate customCollectionCell:self event:@(button.tag)];
    }
}

- (void)loadContent {
    
    WriteStoriesBaseItemObject *object = self.data;
    
    self.label.text  = object.styleName;
    self.label.width = self.width - 50.f - 15.f;
    [self.label sizeToFit];
    self.label.left = 50.f;
    self.label.top  = 10.f;
}

- (void)selectedEvent {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCollectionCell:event:)]) {
        
        [self.delegate customCollectionCell:self event:@(StyleManagerEditViewCellSelect)];
    }
}

@end
