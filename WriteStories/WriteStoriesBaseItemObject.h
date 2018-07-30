//
//  WriteStoriesBaseItemObject.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/4.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseEncodeObject.h"
#import "BaseCustomCollectionCell.h"
#import "CustomCell.h"
#import "Math.h"
#import "ItemsStyleEditManager.h"
#import "EncodeImageObject.h"
#import "InputEditor.h"
#import "ShowStyleTypeManager.h"
#import "NSString+RandomString.h"
#import "HexColors.h"
#import "CAGradientViewObject.h"

typedef enum : NSUInteger {
    
    WriteStoriesBaseItemObjectCellType_Normal = 0,
    WriteStoriesBaseItemObjectCellType_Disable,
    
} WriteStoriesBaseItemObjectCellType;

typedef enum : NSUInteger {
    
    WriteStoriesBaseItemObjectPaymantStateNormalUse = 0, // 正常使用,不需要购买
    WriteStoriesBaseItemObjectPaymantStateNotPay,        // 没有购买的
    WriteStoriesBaseItemObjectPaymantStateDidPay,        // 已经购买的
    
} WriteStoriesBaseItemObjectPaymantState;

NS_INLINE NSString * _html_id(NSString *string) {
    
    return [NSString stringWithFormat:@"id=\"%@\"", string];
}

NS_INLINE NSString * _html_style(NSString *string) {
    
    return [NSString stringWithFormat:@"style=\"%@\"", string];
}

NS_INLINE NSString * _html_tag(NSString *string) {
    
    return [NSString stringWithFormat:@"tag=\"%@\"", string];
}

NS_INLINE NSString * _html_class(NSString *string) {
    
    return [NSString stringWithFormat:@"class=\"%@\"", string];
}

NS_INLINE NSString * _html_src(NSString *string) {
    
    return [NSString stringWithFormat:@"src=\"%@\"", string];
}

@interface WriteStoriesBaseItemObject : BaseEncodeObject

/**
 [非存储属性] 购买状态
 */
@property (nonatomic) WriteStoriesBaseItemObjectPaymantState paymentState;

/**
 [存储属性] 物品id
 */
@property (nonatomic, strong) NSString *paymentID;

#pragma mark - Cell相关

/**
 cell的class的字符串
 */
@property (nonatomic, strong) NSString *cellClassString;

/**
 cell的重用标识
 */
@property (nonatomic, strong) NSString *cellReuseId;

/**
 是否是粒子类型
 */
@property (nonatomic) BOOL isEmitterType;

#pragma mark - 样式设置管理器

/**
 [使用的类重写] 输入配置对象,如文本或者图片属于输入信息
 */
@property (nonatomic, readonly) NSArray <InputEditor *> *inputEditors;

/**
 [使用的类重写] 每个被配置的对象都会返回一个可设置属性信息的完整列表
 */
@property (nonatomic, readonly) ItemsStyleEditManager *editManager;

#pragma mark - 图片复制操作

/**
 [使用的类重写] 每个被配置的对象都会返回一个复制图片的数组,用于复制图片
 */
@property (nonatomic, readonly) NSArray <EncodeImageObject *> *imageObjects;

#pragma mark - 数据库拷贝以及默认值

/**
 [使用的类重写] 拷贝出来的包含了数据库数据的对象
 
 @return 新对象,包含了数据库信息
 */
- (instancetype)dbCopyObject;

/**
 [使用的类重写] 返回带默认值的对象
 
 @return 默认值的对象
 */
+ (instancetype)defalutObject;

#pragma mark - 样式存储相关

/**
 样式ID
 */
@property (class, readonly) NSInteger ShowStyleType;

/**
 [使用的类重写] 创建当前的配置对象(去掉非样式信息的值)
 
 @return 对象
 */
- (instancetype)currentStyleObject;

/**
 [使用的类重写] 使用配置对象(将样式信息赋值)
 
 @param styleObject 配置对象
 */
- (void)useStyleObject:(id)styleObject;

#pragma mark - 样式数据库存储属性

/**
 样式名字
 */
@property (nonatomic, strong) NSString *styleName;

/**
 样式存储的id
 */
@property (nonatomic) NSInteger styleId;

#pragma mark - collectionView相关

/**
 获取cell用的适配器

 @return 适配器
 */
- (CellDataAdapter *)collectionViewAdapter;

/**
 获取cell用的适配器

 @param cellType cell类型
 @return 适配器
 */
- (CellDataAdapter *)collectionViewAdapterWithCellType:(WriteStoriesBaseItemObjectCellType)cellType;

/**
 注册collectionView

 @param collectionView collectionView
 */
- (void)registerToCollectionView:(UICollectionView *)collectionView;

#pragma mark - tableView相关

/**
 获取cell的适配器
 
 @param type Adapter类型
 @return 适配器
 */
- (CellDataAdapter *)tableViewAdapterWithAdapterType:(NSInteger)type;

/**
 注册tableView

 @param tableView collectionView
 */
- (void)registerToTableView:(UITableView *)tableView;

#pragma mark - 常用工具

- (NSString *)RGBAWithHex:(NSString *)hex alpha:(NSNumber *)alpha;

@end
