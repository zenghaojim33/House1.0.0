//
//  QSYTenantDetailRecommendRentHouseViewController.h
//  House
//
//  Created by ysmeng on 15/4/30.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "QSTurnBackViewController.h"

@class QSBaseModel;
@interface QSYTenantDetailRecommendRentHouseViewController : QSTurnBackViewController

/**
 *  @author         yangshengmeng, 15-04-30 15:04:08
 *
 *  @brief          根据推荐房源回调，创建出租房选择列表
 *
 *  @param callBack 推荐房源回调
 *
 *  @return         返回当前创建的出租房列表
 *
 *  @since          1.0.0
 */
- (instancetype)initWithCallBack:(void(^)(BOOL isPicked,QSBaseModel *houseModel,NSString *commend))callBack;

@end
