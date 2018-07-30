//
//  VersionManager.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "VersionManager.h"
#import "App.h"

@implementation VersionManager

+ (void)storeVersionDataWithFolder:(NSString *)folder {
    
    [[App.Version dataUsingEncoding:NSUTF8StringEncoding] writeToFile:[folder stringByAppendingPathComponent:@"version"]
                                                           atomically:YES];
}

+ (BOOL)checkVersionWithFolder:(NSString *)folder {
    
    NSData   *data    = [NSData dataWithContentsOfFile:[folder stringByAppendingPathComponent:@"version"]];
    NSString *version = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    if (version.floatValue <= App.Version.floatValue) {
        
        return YES;
        
    } else {
        
        return NO;
    }
}

@end
