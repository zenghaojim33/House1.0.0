//
//  QSYOwnerPropertyDeleteTipsPopView.m
//  House
//
//  Created by ysmeng on 15/4/17.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "QSYOwnerPropertyDeleteTipsPopView.h"

#import "QSBlockButtonStyleModel+Normal.h"

@interface QSYOwnerPropertyDeleteTipsPopView ()

///删除物业时的回调
@property (nonatomic,copy) void(^propertyDeleteTipsCallBack)(PROPERTY_DELETE_ACTION_TYPE actionType);

@end

@implementation QSYOwnerPropertyDeleteTipsPopView

#pragma mark - 初始化
/**
 *  @author         yangshengmeng, 15-04-17 12:04:51
 *
 *  @brief          创建删除物业提示弹出框
 *
 *  @param frame    大小和位置
 *  @param callBack 提示框的事件回调
 *
 *  @return         返回当前创建的提示框
 *
 *  @since          1.0.0
 */
- (instancetype)initWithFrame:(CGRect)frame andCallBack:(void(^)(PROPERTY_DELETE_ACTION_TYPE actionType))callBack
{

    if (self = [super initWithFrame:frame]) {
        
        ///背景颜色
        self.backgroundColor = [UIColor whiteColor];
        
        ///保存回调
        if (callBack) {
            
            self.propertyDeleteTipsCallBack = callBack;
            
        }
        
        ///创建UI
        [self createPropertyDeleteTipsUI];
        
    }
    
    return self;

}

#pragma mark - UI搭建
- (void)createPropertyDeleteTipsUI
{

    ///提示信息
    UILabel *tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 20.0f, self.frame.size.width, 50.0f)];
    tipsLabel.text = @"是否暂停发布房源？\n暂时发布后所有预约订单将取消";
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipsLabel.textColor = COLOR_CHARACTERS_GRAY;
    tipsLabel.font = [UIFont systemFontOfSize:FONT_BODY_18];
    tipsLabel.numberOfLines = 2;
    [self addSubview:tipsLabel];
    
    ///按钮相关尺寸
    CGFloat xpoint = 2.0f * SIZE_DEFAULT_MARGIN_LEFT_RIGHT;
    CGFloat width = (self.frame.size.width - 2.0f * xpoint - VIEW_SIZE_NORMAL_VIEW_VERTICAL_GAP) / 2.0f;
    
    ///取消按钮
    QSBlockButtonStyleModel *cancelButtonStyle = [QSBlockButtonStyleModel createNormalButtonWithType:nNormalButtonTypeCornerWhiteGray];
    cancelButtonStyle.title = @"返回";
    
    UIButton *cancelButton = [UIButton createBlockButtonWithFrame:CGRectMake(xpoint, tipsLabel.frame.origin.y + tipsLabel.frame.size.height + 15.0f, width, VIEW_SIZE_NORMAL_BUTTON_HEIGHT) andButtonStyle:cancelButtonStyle andCallBack:^(UIButton *button) {
        
        ///回调
        if (self.propertyDeleteTipsCallBack) {
            
            self.propertyDeleteTipsCallBack(pPropertyDeleteActionTypeCancel);
            
        }
        
    }];
    [self addSubview:cancelButton];
    
    ///确认按钮
    QSBlockButtonStyleModel *confirmButtonStyle = [QSBlockButtonStyleModel createNormalButtonWithType:nNormalButtonTypeCornerLightYellow];
    confirmButtonStyle.title = @"暂停发布";
    
    UIButton *confirmButton = [UIButton createBlockButtonWithFrame:CGRectMake(self.frame.size.width / 2.0f + 4.0f, cancelButton.frame.origin.y, width, VIEW_SIZE_NORMAL_BUTTON_HEIGHT) andButtonStyle:confirmButtonStyle andCallBack:^(UIButton *button) {
        
        ///回调
        if (self.propertyDeleteTipsCallBack) {
            
            self.propertyDeleteTipsCallBack(pPropertyDeleteActionTypeConfirm);
            
        }
        
    }];
    [self addSubview:confirmButton];

}

@end
