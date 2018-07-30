//
//  UserDefaults.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/30.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "UserDefaults.h"

static NSString *_key_editHtmlNotShowNotice  = @"_key_editHtmlNotShowNotice";

@implementation UserDefaults

+ (BOOL)EditHtmlNotShowNotice {
 
    return [UserDefaults boolForKey:_key_editHtmlNotShowNotice];
}

+ (void)setEditHtmlNotShowNotice:(BOOL)EditHtmlNotShowNotice {
    
    [UserDefaults setBool:EditHtmlNotShowNotice forKey:_key_editHtmlNotShowNotice];
}

@end
