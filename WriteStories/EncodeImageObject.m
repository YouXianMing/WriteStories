//
//  EncodeImageObject.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/17.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "EncodeImageObject.h"
#import "Math.h"

@implementation EncodeImageObject

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeInteger:self.source   forKey:@"source"];
    [aCoder encodeObject:self.imageName forKey:@"imageName"];
    
    [aCoder encodeInteger:self.width  forKey:@"width"];
    [aCoder encodeInteger:self.height forKey:@"height"];
    
    [aCoder encodeObject:self.scale forKey:@"scale"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        self.source    = [aDecoder decodeIntegerForKey:@"source"];
        self.imageName = [aDecoder decodeObjectForKey:@"imageName"];
        
        self.width  = [aDecoder decodeIntegerForKey:@"width"];
        self.height = [aDecoder decodeIntegerForKey:@"height"];
        
        self.scale = [aDecoder decodeObjectForKey:@"scale"];
    }
    
    return self;
}

+ (instancetype)bigImageWithScale:(NSString *)scale source:(EncodeImageObjectSource)source imageName:(NSString *)imageName {
    
    NSArray *array  = [scale componentsSeparatedByString:@":"];
    CGFloat  width  = [array[0] floatValue];
    CGFloat  height = [array[1] floatValue];
    CGSize   size   = [Math resetFromSize:CGSizeMake(width, height) withFixedWidth:400];;
    
    EncodeImageObject *object = [EncodeImageObject new];
    object.scale              = scale;
    object.source             = source;
    object.imageName          = imageName;
    object.width              = (NSInteger)size.width;
    object.height             = (NSInteger)size.height;
    
    return object;
}

@end
