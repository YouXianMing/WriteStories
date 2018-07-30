//
//  BlockMessage.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BlockMessage.h"

@implementation BlockMessage

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
 
    [aCoder encodeObject:self.blockFolderName forKey:@"blockFolderName"];
    [aCoder encodeInteger:self.blockId        forKey:@"blockId"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        self.blockFolderName = [aDecoder decodeObjectForKey:@"blockFolderName"];
        self.blockId         = [aDecoder decodeIntegerForKey:@"blockId"];
    }
    
    return self;
}

@end
