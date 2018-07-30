//
//  VersionManager.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VersionManager : NSObject

+ (void)storeVersionDataWithFolder:(NSString *)folder;

+ (BOOL)checkVersionWithFolder:(NSString *)folder;

@end
