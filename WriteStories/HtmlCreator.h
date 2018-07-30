//
//  HtmlCreator.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/12.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlocksManager.h"

@interface HtmlCreator : NSObject

+ (instancetype)htmlCreatorWithHtmlFolder:(NSString *)htmlFolder;

- (void)startCreateHtmlWithBlocksManager:(BlocksManager *)blocksManager;

@end
