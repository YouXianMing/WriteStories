//
//  File+Property.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/4.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "File+Property.h"
#import <objc/runtime.h>

@implementation File (Property)

#pragma mark - runtime

- (void)setSelected:(BOOL)selected {
    
    objc_setAssociatedObject(self, @selector(selected), [NSNumber numberWithBool:selected], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)selected {
    
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setDate:(NSDate *)date {
    
    objc_setAssociatedObject(self, @selector(date), date, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDate *)date {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setShowName:(NSString *)showName {
    
    objc_setAssociatedObject(self, @selector(showName), showName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)showName {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setShowTime:(NSString *)showTime {

    objc_setAssociatedObject(self, @selector(showTime), showTime, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)showTime {

    return objc_getAssociatedObject(self, _cmd);
}

- (void)setShowFileSize:(NSString *)showFileSize {
    
    objc_setAssociatedObject(self, @selector(showFileSize), showFileSize, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)showFileSize {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setStatus:(FileImportStatus)status {
    
    objc_setAssociatedObject(self, @selector(status), @(status), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (FileImportStatus)status {
    
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

@end
