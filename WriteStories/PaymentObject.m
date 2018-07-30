//
//  PaymentObject.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/30.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "PaymentObject.h"
#import "FoldersManager.h"
#import "FileManager.h"

static NSTimeInterval _time = 24 * 60 * 60 * 15;
// static NSTimeInterval _time = 60 * 2;

@implementation PaymentObject

+ (void)prepare {
    
    if ([FileManager fileExistWithAbsoluteFilePath:FmtStr(@"%@/version.data", FoldersManager.ArticleList)] == NO) {
        
        PaymentObject *object = [PaymentObject new];
        object.version        = @"1.0";
        object.subVersion     = @"0";
        object.startDate      = [NSDate date];
        [object.encodeData writeToFile:FmtStr(@"%@/version.data", FoldersManager.ArticleList) atomically:YES];
    }
}

+ (NSString *)theVersion {
    
    PaymentObject *object = [PaymentObject decodeWithData:[NSData dataWithContentsOfFile:FmtStr(@"%@/version.data", FoldersManager.ArticleList)]];
    return object.version;
}

+ (NSString *)theSubVersion {
    
    PaymentObject *object = [PaymentObject decodeWithData:[NSData dataWithContentsOfFile:FmtStr(@"%@/version.data", FoldersManager.ArticleList)]];
    return object.subVersion;
}

+ (NSDate *)theStartDate {
    
    PaymentObject *object = [PaymentObject decodeWithData:[NSData dataWithContentsOfFile:FmtStr(@"%@/version.data", FoldersManager.ArticleList)]];
    return object.startDate;
}

+ (void)updateVersion {
    
    PaymentObject *object = [PaymentObject decodeWithData:[NSData dataWithContentsOfFile:FmtStr(@"%@/version.data", FoldersManager.ArticleList)]];
    object.version        = @"1.1";
    [object.encodeData writeToFile:FmtStr(@"%@/version.data", FoldersManager.ArticleList) atomically:YES];
}

+ (void)updateSubVersion {
    
    PaymentObject *object = [PaymentObject decodeWithData:[NSData dataWithContentsOfFile:FmtStr(@"%@/version.data", FoldersManager.ArticleList)]];
    object.subVersion     = @"1";
    [object.encodeData writeToFile:FmtStr(@"%@/version.data", FoldersManager.ArticleList) atomically:YES];
}

+ (NSString *)showString {
    
    NSTimeInterval timeInterval = [NSDate.date timeIntervalSinceDate:PaymentObject.theStartDate];
    
    NSTimeInterval _15day = _time;
    NSTimeInterval remain = _15day - timeInterval;
    
    if (remain > 0) {

        NSInteger d = remain / 60 / 60 / 24;
        NSInteger h = (NSInteger)(remain / 60 / 60) % 24;
        NSInteger m = (NSInteger)(remain / 60) % 60;
        NSInteger s = (NSInteger)(remain) % 60;
        
        return FmtStr(@"您有15天试用期限，您会在%ld天%ld小时%ld分钟%ld秒后强制进入预览模式，所有内容不能创建、编辑、删除或者移动！您只能通过购买完全版来关闭预览模式！", (long)d, (long)h, (long)m, (long)s);
        
    } else {
        
        return FmtStr(@"您的试用期限已结束，您需要购买完全版才能对内容进行创建、编辑、删除或者移动！");
    }
}

+ (BOOL)timeout {
    
    NSTimeInterval timeInterval = [NSDate.date timeIntervalSinceDate:PaymentObject.theStartDate];
    
    NSTimeInterval _15day = _time;
    NSTimeInterval remain = _15day - timeInterval;
    
    if (remain > 0) {
        
        NSInteger d = remain / 60 / 60 / 24;
        if (d > 15) {
            
            [NSException raise:@"作弊，没门！" format:@"想作弊，没门！"];
        }
        
        return NO;
        
    } else {
        
        return YES;
    }
}

#pragma mark - Coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [self autoEncodePropertiesWithCoder:aCoder class:PaymentObject.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:PaymentObject.class];
    }
    
    return self;
}

+ (NSArray<NSString *> *)autoEncodePropertyKeys {
    
    return @[@"version",
             @"subVersion",
             @"startDate"];
}

@end
