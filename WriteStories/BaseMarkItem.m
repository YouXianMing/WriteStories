//
//  BaseMarkItem.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/19.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseMarkItem.h"

@implementation BaseMarkItem

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
        
    [self autoEncodePropertiesWithCoder:aCoder class:BaseMarkItem.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self autoDecoderPropertiesWithDecoder:aDecoder class:BaseMarkItem.class];
    }
    
    return self;
}

+ (NSArray<NSString *> *)autoEncodePropertyKeys {
    
    return @[@"backgroundColorHex",
             
             @"title",
             @"titleFontFamily",
             @"titleColorHex",
             @"titleFontSize",
             @"titleAlpha"];
}

- (instancetype)dbCopyObject {
        
    BaseMarkItem *item = [self.class decodeWithData:self.encodeData];
    item.mark_id       = self.mark_id;
    item.folder_id     = self.folder_id;
    item.mark_name     = self.mark_name;
    item.type          = self.type;
    item.sort_index    = self.sort_index;
    
    return item;
}

@end
