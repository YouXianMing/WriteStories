//
//  RootMenuCollectionCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/5/24.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "RootMenuCollectionCell.h"

@interface RootMenuCollectionCell ()

@property (nonatomic, strong) NSLock *lock;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *enTitleLabel;

@property (nonatomic, strong) UIView *areaView;

@end

@implementation RootMenuCollectionCell

- (void)setupCell {
    
    self.lock = [NSLock new];
}

- (void)buildSubview {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    imageView.image        = [[UIImage imageNamed:@"homeMenuBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    imageView.x           -= 3;
    imageView.y           -= 3;
    imageView.width       += 7.f;
    imageView.height      += 7.f;
    [self.contentView addSubview:imageView];
    
    self.titleLabel           = [[UILabel alloc] init];
    self.titleLabel.font      = [UIFont PingFangSC_Light_WithFontSize:18.f];
    self.titleLabel.textColor = UIColor.TextMainColor;
    [self.contentView addSubview:self.titleLabel];
    
    self.numberLabel           = [[UILabel alloc] init];
    self.numberLabel.font      = [UIFont PingFangSC_Light_WithFontSize:10.f];
    self.numberLabel.textColor = UIColor.TextMainColor;
    [self.contentView addSubview:self.numberLabel];
    
    self.enTitleLabel           = [[UILabel alloc] init];
    self.enTitleLabel.font      = [UIFont PingFangSC_Light_WithFontSize:9.f];
    self.enTitleLabel.textColor = [UIColor colorWithHexString:@"#a8a8a8"];
    [self.contentView addSubview:self.enTitleLabel];
}

- (void)loadContent {
    
    RootMenuCollectionCellModel *model = self.data;
    
    self.titleLabel.text = model.title;
    [self.titleLabel sizeToFit];
    self.titleLabel.left   = 15.f;
    self.titleLabel.bottom = self.height - 15.f;
    
    self.numberLabel.text = model.countNumber;
    [self.numberLabel sizeToFit];
    self.numberLabel.right  = self.width - 15.f;
    self.numberLabel.bottom = self.height - 15.f;
    
    self.enTitleLabel.text   = model.enTitle;
    [self.enTitleLabel sizeToFit];
    self.enTitleLabel.left   = 15.f;
    self.enTitleLabel.bottom = self.titleLabel.top - 5.f;
    
    if ([self.lock tryLock]) {
        
        self.areaView                   = [[UIView alloc] initWithFrame:CGRectMake(15.f, 15.f, self.width - 30.f, self.enTitleLabel.top - 15.f - 7.f)];
        self.areaView.layer.borderWidth = 4.f;
        self.areaView.layer.borderColor = UIColor.BackgroundColor.CGColor;
        self.areaView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.areaView];
        
        [self buildViewsOnAreaView:self.areaView];
    }
}

- (void)buildViewsOnAreaView:(UIView *)view {
    
}

- (void)setHighlighted:(BOOL)highlighted {
    
    [super setHighlighted:highlighted];
    
    [UIView animateWithDuration:0.35f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.contentView.alpha = highlighted ? 0.8f : 1.f;
        
    } completion:nil];
}

@end
