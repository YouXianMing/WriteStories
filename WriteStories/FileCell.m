//
//  FileCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/4.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "FileCell.h"
#import "UIView+SetRect.h"
#import "UIFont+Project.h"
#import "UIColor+Project.h"
#import "HexColors.h"
#import "File.h"
#import "File+Property.h"
#import "EdgeInsetsLabel.h"

@interface FileCell ()

@property (nonatomic, strong) UIView           *backgroundContentView;
@property (nonatomic, strong) UIImageView      *circleIconImageView;
@property (nonatomic, strong) UIImageView      *selectedIconImageView;
@property (nonatomic, strong) UILabel          *contentTitleLabel;
@property (nonatomic, strong) UILabel          *contentTimeLabel;
@property (nonatomic, strong) EdgeInsetsLabel  *infoLabel;

@end

@implementation FileCell

- (void)buildSubview {
    
    self.backgroundContentView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 60.f)];
    self.backgroundContentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.backgroundContentView];
    
    self.selectedIconImageView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selectedCircle"]];
    self.selectedIconImageView.center = CGPointMake(27.f, 30.f);
    [self.backgroundContentView addSubview:self.selectedIconImageView];
    
    self.circleIconImageView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"showCircle"]];
    self.circleIconImageView.center = self.selectedIconImageView.center;
    [self.backgroundContentView addSubview:self.circleIconImageView];
    
    self.contentTitleLabel      = [[UILabel alloc] initWithFrame:CGRectMake(52.f, 5, Width - 15.f - 52.f, 36.f)];
    self.contentTitleLabel.font = [UIFont PingFangSC_Medium_WithFontSize:20.f];
    [self.backgroundContentView addSubview:self.contentTitleLabel];
    
    self.contentTimeLabel           = [[UILabel alloc] initWithFrame:CGRectMake(52.f, 60.f - 28.f, Width - 15.f, 28.f)];
    self.contentTimeLabel.font      = [UIFont PingFangSC_Regular_WithFontSize:12.f];
    self.contentTimeLabel.textColor = [UIColor colorWithHexString:@"#5a5a5a"];
    [self.backgroundContentView addSubview:self.contentTimeLabel];
    
    self.infoLabel                     = [EdgeInsetsLabel new];
    self.infoLabel.font                = [UIFont PingFangSC_Light_WithFontSize:10.f];
    self.infoLabel.textColor           = [UIColor whiteColor];
    self.infoLabel.edgeInsets          = UIEdgeInsetsMake(2, 4, 2, 4);
    self.infoLabel.layer.cornerRadius  = 2.f;
    self.infoLabel.layer.masksToBounds = YES;
    [self.backgroundContentView addSubview:self.infoLabel];
    
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 59.5f, Width, 0.5f)];
    line.backgroundColor = UIColor.LineColor;
    [self.backgroundContentView addSubview:line];
}

- (void)loadContent {
    
    File *file                        = self.data;
    self.contentTitleLabel.text       = file.showName;
    self.contentTimeLabel.text        = [NSString stringWithFormat:@"%@  %@", file.showTime, file.showFileSize];
    self.selectedIconImageView.hidden = (file.selected ? NO : YES);
    
    if (file.status == FileImportStatusNormal) {
        
        self.infoLabel.hidden                      = YES;
        self.backgroundContentView.backgroundColor = [UIColor whiteColor];
        
    } else {
        
        self.infoLabel.hidden = NO;
        
        if (file.status == FileImportStatusImportSuccess) {
            
            self.backgroundContentView.backgroundColor = [[UIColor colorWithHexString:@"#1ca6cd"] colorWithAlphaComponent:0.1f];
            [self.infoLabel sizeToFitWithText:@"导入完成"];
            self.infoLabel.backgroundColor = [UIColor colorWithHexString:@"#1ca6cd"];
            self.infoLabel.right           = Width - 4;
            self.infoLabel.bottom          = 60 - 5.f;
            
        } else if (file.status == FileImportStatusFileError) {
            
            self.backgroundContentView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.1f];
            [self.infoLabel sizeToFitWithText:@"文件异常无法导入"];
            self.infoLabel.backgroundColor = [UIColor redColor];
            self.infoLabel.right           = Width - 4.f;
            self.infoLabel.bottom          = 60 - 5.f;
            
        } else if (file.status == FileImportStatusFileVersionError) {
            
            self.backgroundContentView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.1f];
            [self.infoLabel sizeToFitWithText:@"高版本文件无法导入"];
            self.infoLabel.backgroundColor = [UIColor redColor];
            self.infoLabel.right           = Width - 4.f;
            self.infoLabel.bottom          = 60 - 5.f;
        }
    }
}

@end
