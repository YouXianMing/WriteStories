//
//  CAGradientView+CAGradientViewObject.h
//  GradientView
//
//  Created by YouXianMing on 2018/1/23.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "CAGradientView.h"
#import "CAGradientViewObject.h"

@interface CAGradientView (CAGradientViewObject)

- (void)configWithObject:(CAGradientViewObject *)object;

- (CAGradientViewObject *)configObject;

@end
