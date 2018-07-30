//
//  EncodeImageObject.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/17.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseEncodeObject.h"

typedef enum : NSUInteger {
    
    // 默认文件夹
    EncodeImageObjectSourceDefault = 100,
    
    // 目标文件夹
    EncodeImageObjectSourceFolder,
    
} EncodeImageObjectSource;

@interface EncodeImageObject : BaseEncodeObject

@property (nonatomic) EncodeImageObjectSource  source;
@property (nonatomic, strong) NSString        *imageName;

@property (nonatomic) NSInteger width;  // 切割的宽度
@property (nonatomic) NSInteger height; // 切割的高度

@property (nonatomic, strong) NSString *scale; // 比例,如(1:2)

/**
 屏幕显示的最大高清尺寸

 @param scale 图片比例
 @param source 图片源头
 @return 创建好的对象
 */
+ (instancetype)bigImageWithScale:(NSString *)scale source:(EncodeImageObjectSource)source imageName:(NSString *)imageName;

@end
