//
//  QSPOrderDetailRejectPriceButtonView.h
//  House
//
//  Created by CoolTea on 15/4/11.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "QSPOrderBottomButtonView.h"

@interface QSPOrderDetailRejectPriceButtonView : QSPOrderBottomButtonView

- (instancetype)initAtTopLeft:(CGPoint)topLeftPoint andCallBack:(void(^)(BOTTOM_BUTTON_TYPE buttonType, UIButton *button))callBack;

@end
