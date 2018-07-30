//
//  File+Property.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/4.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "File.h"

typedef enum : NSUInteger {
    
    FileImportStatusNormal = 0,       // 默认状态
    FileImportStatusImportSuccess,    // 导入完成
    FileImportStatusFileError,        // 文件异常
    FileImportStatusFileVersionError, // 高版本文件无法导入
    
} FileImportStatus;

@interface File (Property)

@property (nonatomic) BOOL selected; // 是否选中

@property (nonatomic, strong) NSDate   *date;
@property (nonatomic, strong) NSString *showName;     // 猫咪物语
@property (nonatomic, strong) NSString *showTime;     // 2018.05.04 14:36
@property (nonatomic, strong) NSString *showFileSize; // 29.5kb
@property (nonatomic) FileImportStatus  status;       // 状态

@end
