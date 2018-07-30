//
//  WriteStoriesBaseItemObject.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/4.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "WriteStoriesBaseItemObject.h"

@implementation WriteStoriesBaseItemObject

- (ItemsStyleEditManager *)editManager {
    
    return nil;
}

- (NSArray<EncodeImageObject *> *)imageObjects {
    
    return nil;
}

+ (instancetype)defalutObject {
    
    return nil;
}

+ (NSInteger)ShowStyleType {
    
    return [ShowStyleTypeManager showStyleTypeValueBy:self.class];
}

- (instancetype)currentStyleObject {
    
    return nil;
}

- (void)useStyleObject:(id)styleObject {
    
}

- (instancetype)dbCopyObject {
    
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeBool:self.isEmitterType forKey:@"isEmitterType"];
    [self autoEncodePropertiesWithCoder:aCoder class:WriteStoriesBaseItemObject.class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        self.isEmitterType = [aDecoder decodeBoolForKey:@"isEmitterType"];
        [self autoDecoderPropertiesWithDecoder:aDecoder class:WriteStoriesBaseItemObject.class];
    }
    
    return self;
}

+ (NSArray<NSString *> *)autoEncodePropertyKeys {
    
    return @[@"paymentID",
             
             @"cellClassString",
             @"cellReuseId"];
}

- (CellDataAdapter *)collectionViewAdapter {
    
    return [NSClassFromString(self.cellClassString) dataAdapterWithCellReuseIdentifier:self.cellReuseId data:self];
}

- (CellDataAdapter *)collectionViewAdapterWithCellType:(WriteStoriesBaseItemObjectCellType)cellType {
    
    return [NSClassFromString(self.cellClassString) dataAdapterWithCellReuseIdentifier:self.cellReuseId data:self type:cellType];
}

- (void)registerToCollectionView:(UICollectionView *)collectionView {
    
    [collectionView registerClass:NSClassFromString(self.cellClassString) forCellWithReuseIdentifier:self.cellReuseId];
}

- (void)registerToTableView:(UITableView *)tableView {
    
    [tableView registerClass:NSClassFromString(self.cellClassString) forCellReuseIdentifier:self.cellReuseId];
}

- (CellDataAdapter *)tableViewAdapterWithAdapterType:(NSInteger)type {
    
    CGFloat cellHeight = [NSClassFromString(self.cellClassString) cellHeightWithData:self];
    return [NSClassFromString(self.cellClassString) dataAdapterWithCellReuseIdentifier:self.cellReuseId data:self cellHeight:cellHeight type:type];
}

- (NSString *)RGBAWithHex:(NSString *)hex alpha:(NSNumber *)alpha {
    
    UIColor *color = [UIColor colorWithHexString:hex];
    
    CGFloat red   = 0;
    CGFloat green = 0;
    CGFloat blue  = 0;
    CGFloat a     = alpha.floatValue;
    [color getRed:&red green:&green blue:&blue alpha:nil];
    
    return FmtStr(@"rgba(%.f, %.f, %.f, %.2f)", red * 255.f, green * 255.f, blue * 255.f, a);
}

@end
