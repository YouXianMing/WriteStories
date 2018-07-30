//
//  App.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Status bar height.
 */
#define  StatusBarHeight      20.f

/**
 *  Navigation bar height.
 */
#define  NavigationBarHeight  44.f

/**
 *  Tabbar height.
 */
#define  TabbarHeight         49.f

/**
 *  Status bar & navigation bar height.
 */
#define  StatusBarAndNavigationBarHeight   (20.f + 44.f)

typedef enum : NSUInteger {
    
    Device_320x480, // iPhone4 or iPhone4s
    Device_320x568, // iPhone5 or iPhone5s or iPhoneSE
    Device_375x667, // iPhone6 or iPhone6s or iPhone 7 or iPhone 8
    Device_414x736, // iPhone6Plus or iPhone6sPlus or iPhone7sPlus or iPhone8sPlus
    Device_375x812, // iPhoneX
    
    Device_Unknown, // 未知尺寸设备
    
} DeviceType;

@interface App : NSObject

+ (void)prepare;

/**
 设备类型
 */
@property (class, readonly) DeviceType Device;

/**
 屏幕宽度
 */
@property (class, readonly) CGFloat Width;

/**
 屏幕一半宽度
 */
@property (class, readonly) CGFloat HalfWidth;

/**
 屏幕高度
 */
@property (class, readonly) CGFloat Height;

/**
 屏幕一半高度
 */
@property (class, readonly) CGFloat HalfHeight;

/**
 顶部安全高度
 */
@property (class, readonly) CGFloat TopSafeHeight;

/**
 底部安全高度
 */
@property (class, readonly) CGFloat BottomSafeHeight;

/**
 App的版本
 */
@property (class, readonly) NSString *Version;

/**
 Wifi的名字
 */
@property (class, readonly) NSString *WifiName;

@end
