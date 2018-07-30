//
//  Folder_gradientImage.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/18.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseFolderItem.h"
#import "CAGradientViewObject.h"

@interface Folder_gradientImage : BaseFolderItem

@property (nonatomic, strong) EncodeImageObject    *image;
@property (nonatomic, strong) CAGradientViewObject *gradientObject;
@property (nonatomic, strong) NSNumber             *gradientObjectAlpha;

@end
