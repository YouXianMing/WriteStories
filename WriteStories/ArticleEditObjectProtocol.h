//
//  ArticleEditObjectProtocol.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EncodeImageObject.h"

typedef enum : NSUInteger {
    
    ArticleEditObjectType_Title = 1000,
    ArticleEditObjectType_Paragraph,
    ArticleEditObjectType_SubTitle,
    ArticleEditObjectType_Picture,
    
} ArticleEditObjectType;

@protocol ArticleEditObjectProtocol <NSObject>

/**
 cell的类型,用以区分颜色

 @return cell类型
 */
- (ArticleEditObjectType)cell_Type;

/**
 cell的类型描述文字,如"段落-引用"

 @return 描述文字
 */
- (NSString *)cell_TypeText;

@optional

- (NSString *)cell_text;
- (NSString *)cell_subText;

- (EncodeImageObject *)cell_image;

@end
