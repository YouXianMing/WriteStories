//
//  FolderInputEditor.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/20.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "InputEditor.h"

@implementation InputEditor

- (id)valueWithObject:(NSObject *)object {
    
    return [object valueForKeyPath:self.key];
}

- (void)setObject:(NSObject *)object value:(id)value {
    
    [object setValue:value forKeyPath:self.key];
}

@end
