//
//  QSYCommunitySecondHandHouseList.h
//  House
//
//  Created by 王树朋 on 15/4/10.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QSFilterDataModel;
@interface QSYCommunitySecondHandHouseList : UICollectionView

- (instancetype)initWithFrame:(CGRect)frame andCommunitID:(NSString *)communityID andFilter:(QSFilterDataModel *)filterModel;

- (void)reloadServerData:(QSFilterDataModel *)filterModel;

@end
