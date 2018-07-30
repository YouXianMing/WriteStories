//
//  FolderInputEditor.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/20.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InputEditor : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *key;
@property (nonatomic) Class editorViewClass;

- (id)valueWithObject:(NSObject *)object;

- (void)setObject:(NSObject *)object value:(id)value;

@end
