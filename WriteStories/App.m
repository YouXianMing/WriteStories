//
//  App.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "App.h"
#import <SystemConfiguration/CaptiveNetwork.h>

static DeviceType _type;

static CGFloat _width;
static CGFloat _halfWidth;

static CGFloat _height;
static CGFloat _halfHeight;

static NSString *_appVersion;

@interface App ()

@end

@implementation App

+ (void)prepare {

    _width     = [UIScreen mainScreen].bounds.size.width;
    _halfWidth = _width / 2.f;
    
    _height     = [UIScreen mainScreen].bounds.size.height;
    _halfHeight = _height / 2.f;
    
    if (_width == 320.f && _height == 480.f) {
        
        _type = Device_320x480;
        
    } else if (_width == 320.f && _height == 568.f) {
        
        _type = Device_320x568;
        
    } else if (_width == 375.f && _height == 667.f) {
        
        _type = Device_375x667;
        
    } else if (_width == 414.f && _height == 736.f) {
        
        _type = Device_414x736;
        
    } else if (_width == 375.f && _height == 812.f) {
        
        _type = Device_375x812;
        
    } else {
        
        _type = Device_Unknown;
    }
    
    _appVersion = [NSBundle.mainBundle.infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+ (DeviceType)Device {
    
    return _type;
}

+ (CGFloat)Width {
    
    return _width;
}

+ (CGFloat)HalfWidth {
    
    return _halfWidth;
}

+ (CGFloat)Height {
    
    return _height;
}

+ (CGFloat)HalfHeight {
    
    return _halfHeight;
}

+ (CGFloat)BottomSafeHeight {
    
    return 34.f;
}

+ (CGFloat)TopSafeHeight {
    
    return 44.f;
}

+ (NSString *)Version {
    
    return _appVersion;
}

+ (NSString *)WifiName {
    
    NSString  *wifiName       = nil;
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    if (wifiInterfaces == nil) {
        
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];            
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    
    return wifiName;
}

@end
