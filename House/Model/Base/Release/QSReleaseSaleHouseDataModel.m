//
//  QSReleaseSaleHouseDataModel.m
//  House
//
//  Created by ysmeng on 15/3/25.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "QSReleaseSaleHouseDataModel.h"

@implementation QSReleaseSaleHouseDataModel

#pragma mark - 初始化
///初始化：同时初始化窗口类对象
- (instancetype)init
{

    if (self = [super init]) {
        
        ///配套信息数组
        self.installationList = [[NSMutableArray alloc] init];
        
        ///标签信息数组
        self.featuresList = [[NSMutableArray alloc] init];
        
        ///图片集
        self.imagesList = [[NSMutableArray alloc] init];
        
        ///星期几
        self.weekInfos = [[NSMutableArray alloc] init];
        
    }
    
    return self;

}

- (NSArray *)getCurrentPickedImages
{

    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.imagesList count]; i++) {
        
        QSReleaseSaleHousePhotoDataModel *tempModel = self.imagesList[i];
        [tempArray addObject:tempModel.image];
        
    }
    
    return [NSArray arrayWithArray:tempArray];

}

#pragma mark - 生成发布出售物业的参数
- (NSDictionary *)createReleaseSaleHouseParams
{

    return nil;

}

@end

@implementation QSReleaseSaleHousePhotoDataModel



@end