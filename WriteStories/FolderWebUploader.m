//
//  FolderWebUploader.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/5.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "FolderWebUploader.h"
#import "DateFormatter.h"

@implementation FolderWebUploader

/**
 *  This method is called to check if a file upload is allowed to complete.
 *  The uploaded file is available for inspection at "tempPath".
 *
 *  The default implementation returns YES.
 */
- (BOOL)shouldUploadFileAtPath:(NSString*)path withTemporaryFile:(NSString*)tempPath {
    
    NSString *fileName = path.lastPathComponent;
    
    // 文件夹名字过滤
    if (fileName.length >= 30 &&
        [[fileName substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"["] &&
        [[fileName substringWithRange:NSMakeRange(20, 2)] isEqualToString:@"] "]) {
        
        NSDate *date = [DateFormatter dateFormatterWithInputDateString:[fileName substringWithRange:NSMakeRange(1, 19)]
                                              inputDateStringFormatter:@"yyyy-MM-dd HH-mm-ss"];
        
        if (date) {
            
            return YES;
        }
    }
    
    return NO;
}

/**
 *  This method is called to check if a file or directory is allowed to be moved.
 *
 *  The default implementation returns YES.
 */
- (BOOL)shouldMoveItemFromPath:(NSString*)fromPath toPath:(NSString*)toPath {
    
    return YES;
}

/**
 *  This method is called to check if a file or directory is allowed to be deleted.
 *
 *  The default implementation returns YES.
 */
- (BOOL)shouldDeleteItemAtPath:(NSString*)path {
    
    return YES;
}

/**
 *  This method is called to check if a directory is allowed to be created.
 *
 *  The default implementation returns YES.
 */
- (BOOL)shouldCreateDirectoryAtPath:(NSString*)path {
    
    return YES;
}

@end
