//
//  PaymentsManager.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/5.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "PaymentsManager.h"
#import "FoldersManager.h"
#import "FileManager.h"
#import "AppleSystemService.h"

@implementation PaymentItem

#pragma mark - Coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [self autoEncodePropertiesWithCoder:aCoder class:PaymentItem.class];
    
    [aCoder encodeBool:self.didPay forKey:@"didPay"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:PaymentItem.class];
        
        self.didPay = [aDecoder decodeBoolForKey:@"didPay"];
    }
    
    return self;
}

+ (NSArray<NSString *> *)autoEncodePropertyKeys {
    
    return @[@"paymentID", @"name", @"version"];
}

@end

@implementation PaymentsManager

+ (void)prepare {
    
    if ([FileManager fileExistWithAbsoluteFilePath:FmtStr(@"%@/version.data", FoldersManager.ArticleList)] == NO) {
        
        NSMutableArray *items = [NSMutableArray array];
        
        /////////////////////////////////////////// 1.0版本内购 ///////////////////////////////////////////
        
        {
            PaymentItem *item = [PaymentItem new];
            item.paymentID    = @"com.YouXianMing.WriteStories.Folder_gradientImage";
            item.name         = @"渐变色文件夹模板";
            item.version      = @"1.0";
            item.didPay       = NO;
            [items addObject:item];
        }
        
        {
            PaymentItem *item = [PaymentItem new];
            item.paymentID    = @"com.YouXianMing.WriteStories.Folder_iconfont_0";
            item.name         = @"图标文件夹模板";
            item.version      = @"1.0";
            item.didPay       = NO;
            [items addObject:item];
        }
        
        {
            PaymentItem *item = [PaymentItem new];
            item.paymentID    = @"com.YouXianMing.WriteStories.Mark_gradient";
            item.name         = @"渐变色背景图模板";
            item.version      = @"1.0";
            item.didPay       = NO;
            [items addObject:item];
        }
        
        {
            PaymentItem *item = [PaymentItem new];
            item.paymentID    = @"com.YouXianMing.WriteStories.Mark_icon";
            item.name         = @"渐变色图标模板";
            item.version      = @"1.0";
            item.didPay       = NO;
            [items addObject:item];
        }
        
        {
            PaymentItem *item = [PaymentItem new];
            item.paymentID    = @"com.YouXianMing.WriteStories.BackgroundStyle_GradientImage";
            item.name         = @"背景图模板";
            item.version      = @"1.0";
            item.didPay       = NO;
            [items addObject:item];
        }
        
        {
            PaymentItem *item = [PaymentItem new];
            item.paymentID    = @"com.YouXianMing.WriteStories.BackgroundStyle_ElegantStyle";
            item.name         = @"纸张模板";
            item.version      = @"1.0";
            item.didPay       = NO;
            [items addObject:item];
        }
        
        /////////////////////////////////////////// 1.0版本内购 ///////////////////////////////////////////
        
        PaymentsManager *object = [PaymentsManager new];
        object.paymentItems     = items;
        object.version          = AppleSystemService.appVersion;
        [object.encodeData writeToFile:FmtStr(@"%@/version.data", FoldersManager.ArticleList) atomically:YES];
    }
}

+ (PaymentsManager *)defaultManager {
    
    NSData          *data    = [NSData dataWithContentsOfFile:FmtStr(@"%@/version.data", FoldersManager.ArticleList)];
    PaymentsManager *manager = [PaymentsManager decodeWithData:data];
    
    return manager;
}

+ (void)update {
    
}

- (BOOL)didPayByItemID:(NSString *)itemId {
    
    __block BOOL didPay = NO;
    
    [self.paymentItems enumerateObjectsUsingBlock:^(PaymentItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([itemId isEqualToString:obj.paymentID]) {
            
            didPay = obj.didPay;
            *stop  = YES;
        }
    }];
    
    return didPay;
}

- (void)store {
    
    [self.encodeData writeToFile:FmtStr(@"%@/version.data", FoldersManager.ArticleList) atomically:YES];
}

#pragma mark - Coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [self autoEncodePropertiesWithCoder:aCoder class:PaymentsManager.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:PaymentsManager.class];
    }
    
    return self;
}

+ (NSArray<NSString *> *)autoEncodePropertyKeys {
    
    return @[@"paymentItems",
             @"version"];
}

@end
