//
//  QSPBuyerBookedOrderCancelListView.h
//  House
//
//  Created by CoolTea on 15/3/10.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QSPBuyerBookedOrderCancelListView : UIView

@property (nonatomic, strong) UIViewController *parentViewController;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)getBookingListHeaderData;

@end
