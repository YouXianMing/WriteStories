//
//  BaseFolderItemCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/15.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseFolderItemCell.h"
#import "BaseFolderItem.h"
#import "PaymentLabel.h"

@interface BaseFolderItemCell ()

@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;
@property (nonatomic, strong) UIView  *contentBackgroundView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *countLabel;

@property (nonatomic, strong) PaymentLabel *payLabel;

@end

@implementation BaseFolderItemCell

- (void)setupCell {
    
    self.longPressGesture                   = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    self.longPressGesture.allowableMovement = 200.f;
    [self addGestureRecognizer:self.longPressGesture];
    
    self.lock = [NSLock new];
}

- (void)longPressGesture:(UILongPressGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(customCollectionCell:event:)]) {
            
            [self.delegate customCollectionCell:self event:self.data];
        }
    }
}

- (void)buildSubview {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    imageView.image        = [[UIImage imageNamed:@"homeMenuBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    imageView.x           -= 3;
    imageView.y           -= 3;
    imageView.width       += 7.f;
    imageView.height      += 7.f;
    [self.contentView addSubview:imageView];
    
    self.contentBackgroundView                 = [[UIView alloc] initWithFrame:self.contentView.bounds];
    self.contentBackgroundView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.contentBackgroundView];
    
    self.bottomContentView = [[UIView alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:self.bottomContentView];
    
    self.titleLabel      = [[UILabel alloc] initWithFrame:CGRectMake(15.f, 0, self.width - 30.f, 40.f)];
    self.titleLabel.font = [UIFont PingFangSC_Semibold_WithFontSize:17.f];
    [self.contentView addSubview:self.titleLabel];
    
    self.countLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 15.f)];
    self.countLabel.font          = [UIFont PingFangSC_Regular_WithFontSize:8.f];
    self.countLabel.textAlignment = NSTextAlignmentRight;
    self.countLabel.right         = self.width - 15.f;
    self.countLabel.bottom        = 40.f;
    [self.contentView addSubview:self.countLabel];
    
    self.coverContentView = [[UIView alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:self.coverContentView];
    
    self.payLabel        = [[PaymentLabel alloc] initWithPaymentLabel];
    self.payLabel.bottom = self.height - 10.f;
    self.payLabel.right  = self.width - 10.f;
    [self.contentView addSubview:self.payLabel];
    
    if (Width == 320.f) {
        
        self.titleLabel.font = [UIFont PingFangSC_Semibold_WithFontSize:15.f];
        self.countLabel.font = [UIFont PingFangSC_Regular_WithFontSize:7.f];
    }
}

- (void)loadContent {
    
    WriteStoriesBaseItemObjectCellType cellType = self.dataAdapter.cellType;
    if (cellType == WriteStoriesBaseItemObjectCellType_Normal) {
        
        self.longPressGesture.enabled = YES;
        
    } else if (cellType == WriteStoriesBaseItemObjectCellType_Disable) {
        
        self.longPressGesture.enabled = NO;
    }
    
    BaseFolderItem *item = self.data;
    self.contentBackgroundView.backgroundColor = [UIColor colorWithHexString:item.backgroundColorHex];
    
    self.titleLabel.text      = item.title;
    self.titleLabel.textColor = [UIColor colorWithHexString:item.titleColorHex];
    self.titleLabel.alpha     = item.titleAlpha.floatValue;
    
    self.countLabel.text      = [NSString stringWithFormat:@"%ld/40", (long)item.articleCount];
    self.countLabel.textColor = [UIColor colorWithHexString:item.articleCountColorHex];
    self.countLabel.alpha     = item.articleCountAlpha.floatValue;
    
    self.payLabel.paymentState = item.paymentState;
    
    // 加载一次粒子效果
    if ([self.lock tryLock]) {
        
        [self loadCAEmitterCellContent];
    }
}

- (void)loadCAEmitterCellContent {
    
}

- (void)setHighlighted:(BOOL)highlighted {
    
    [super setHighlighted:highlighted];
    
    WriteStoriesBaseItemObjectCellType cellType = self.dataAdapter.cellType;
    
    if (cellType == WriteStoriesBaseItemObjectCellType_Normal) {
        
        [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            self.alpha = highlighted ? 0.5f : 1.f;
            
        } completion:nil];
    }
}

- (void)dealloc {
    
    [self.lock unlock];
    self.lock = nil;
}

@end
