//
//  BaseFolderItem.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/4.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseFolderItem.h"

@implementation BaseFolderItem

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];

    [self autoEncodePropertiesWithCoder:aCoder class:BaseFolderItem.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:BaseFolderItem.class];
    }
    
    return self;
}

+ (NSArray<NSString *> *)autoEncodePropertyKeys {
    
    return @[@"backgroundColorHex",
             
             @"title",
             @"titleAlpha",
             @"titleColorHex",
             
             @"articleCountColorHex",
             @"articleCountAlpha"];
}

- (instancetype)dbCopyObject {
    
    BaseFolderItem *item = [self.class decodeWithData:self.encodeData];
    item.folder_id       = self.folder_id;
    item.folder_name     = self.folder_name;
    item.type            = self.type;
    item.sort_index      = self.sort_index;
    item.articleCount    = self.articleCount;
    
    return item;
}

@end
