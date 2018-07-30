//
//  JSConfig.h
//  FamousQuotes
//
//  Created by YouXianMing on 2018/3/29.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSConfig : NSObject

@property (nonatomic, strong) NSString *tagName;
@property (nonatomic, strong) NSString *style;
@property (nonatomic, strong) NSString *classList;

@end

NS_INLINE JSConfig * jsConfig(NSString *tagName, NSString *classList, NSString *style) {
    
    JSConfig *config = [[JSConfig alloc] init];
    config.tagName   = tagName;
    config.classList = classList;
    config.style     = style;
    
    return config;
}
