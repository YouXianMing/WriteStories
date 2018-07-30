//
//  BaseBlockItem.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseBlockItem.h"

@implementation BaseBlockItem

- (ArticleEditObjectType)cell_Type {
    
    return 0;
}

- (NSString *)cell_TypeText {
    
    return nil;
}

- (NSString *)jsonConfigWithDebug:(BOOL)debug {
    
    return nil;
}

- (NSString *)itemIdString {
    
    return [NSString stringWithFormat:@"ws_%@", self.itemId.stringValue];
}

#pragma mark - Coder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [self autoEncodePropertiesWithCoder:aCoder class:BaseBlockItem.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:BaseBlockItem.class];
    }
    
    return self;
}

+ (NSArray<NSString *> *)autoEncodePropertyKeys {
    
    return @[@"itemId"];
}

#pragma mark - other

- (NSString *)folderName {
    
    return [NSString stringWithFormat:@"%@_%ld", NSStringFromClass(self.class), (long)self.itemId.integerValue];
}

@end
