//
//  BaseMarkItemCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/19.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseMarkItemCell.h"
#import "BaseMarkItem.h"
#import "PaymentLabel.h"

@interface BaseMarkItemCell ()

@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;
@property (nonatomic, strong) PaymentLabel *payLabel;

@end

@implementation BaseMarkItemCell

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

- (void)loadContent {
    
    WriteStoriesBaseItemObjectCellType cellType = self.dataAdapter.cellType;
    if (cellType == WriteStoriesBaseItemObjectCellType_Normal) {
        
        self.longPressGesture.enabled = YES;
        
    } else if (cellType == WriteStoriesBaseItemObjectCellType_Disable) {
        
        self.longPressGesture.enabled = NO;
    }
    
    BaseMarkItem *item = self.data;
    self.contentBackgroundView.backgroundColor = [UIColor colorWithHexString:item.backgroundColorHex];
    
    self.payLabel.paymentState = item.paymentState;
    
    if ([self.lock tryLock]) {
        
        [self loadCAEmitterCellContent];
    }
}

- (void)loadCAEmitterCellContent {
    
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
    
    self.payLabel        = [[PaymentLabel alloc] initWithPaymentLabel];
    self.payLabel.bottom = self.height - 10.f;
    self.payLabel.right  = self.width - 10.f;
    [self addSubview:self.payLabel];
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
