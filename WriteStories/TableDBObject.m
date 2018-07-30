//
//  TableDBObject.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/16.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "TableDBObject.h"

@implementation TableDBObject

+ (void)updateHomePage {
    
    [GCDQueue executeInMainQueue:^{
        
        [DefaultNotificationCenter postEventToNotificationName:Values.Noti_RootMenuViewControllerUpdateCountNumber object:nil];
    }];
}

+ (void)updateFolderCountWithFolderId:(NSInteger)folderId {
    
    [GCDQueue executeInMainQueue:^{
        
        [DefaultNotificationCenter postEventToNotificationName:Values.Noti_FolderListViewControllerUpdateCountNumber object:@(folderId)];
    }];
}

+ (void)updateAllFoldersCount {
    
    [GCDQueue executeInMainQueue:^{
        
        [DefaultNotificationCenter postEventToNotificationName:Values.Noti_FolderListViewControllerUpdateAllFoldersCountNumber object:nil];
    }];
}

@end
