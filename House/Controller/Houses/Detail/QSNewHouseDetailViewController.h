//
//  QSNewHouseDetailViewController.h
//  House
//
//  Created by ysmeng on 15/3/6.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "QSTurnBackViewController.h"

@interface QSNewHouseDetailViewController : QSTurnBackViewController

/**
 *  @author             yangshengmeng, 15-03-09 09:03:33
 *
 *  @brief              根据新房的楼盘ID，请求新房的详情信息，并生成VC
 *
 *  @param title        标题
 *  @param loupanID     楼盘ID
 *  @param buildingID   楼栋ID
 *  @param detailType   详情的类型
 *
 *  @return             返回新房详情页
 *
 *  @since              1.0.0
 */
- (instancetype)initWithTitle:(NSString *)title andLoupanID:(NSString *)loupanID andLoupanBuildingID:(NSString *)buildingID andDetailType:(FILTER_MAIN_TYPE)detailType;

@end
