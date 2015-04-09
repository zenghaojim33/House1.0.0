//
//  QSYMessagePictureTableViewCell.m
//  House
//
//  Created by ysmeng on 15/4/9.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "QSYMessagePictureTableViewCell.h"

#import "QSYSendMessagePicture.h"

#import <objc/runtime.h>

///关联
static char UserIconKey;    //!<头像关联
static char ImageMessageKey;//!<图片消息

@interface QSYMessagePictureTableViewCell ()

@property (nonatomic,assign) MESSAGE_FROM_TYPE messageType;//!<消息的归属类型

@end

@implementation QSYMessagePictureTableViewCell

#pragma mark - 初始化
/**
 *  @author                 yangshengmeng, 15-04-06 13:04:23
 *
 *  @brief                  创建图片聊天显示框
 *
 *  @param style            风格
 *  @param reuseIdentifier  复用标签
 *  @param isMyMessage      消息是当前用户的还是其他人发送过来的
 *
 *  @return                 返回当前创建的文字聊天信息展示框
 *
 *  @since                  1.0.0
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andMessageType:(MESSAGE_FROM_TYPE)isMyMessage
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        ///保存消息类型
        self.messageType = isMyMessage;
        
        ///搭建UI
        [self createMessagePictureUI];
        
    }
    
    return self;
    
}

#pragma mark - UI搭建
- (void)createMessagePictureUI
{
    
    ///根据消息的类型，计算不同控件的坐标
    CGFloat xpointIcon = SIZE_DEFAULT_MARGIN_LEFT_RIGHT;
    CGFloat xpointArrow = xpointIcon + 40.0f + 3.0f;
    CGFloat xpointMessage = xpointArrow + 5.0f;
    CGFloat widthMessage = SIZE_DEVICE_WIDTH * 2.0f / 5.0f;
    if (mMessageFromTypeMY == self.messageType) {
        
        xpointIcon = SIZE_DEVICE_WIDTH - 40.0f - SIZE_DEFAULT_MARGIN_LEFT_RIGHT;
        xpointArrow = xpointIcon - 3.0f - 5.0f;
        xpointMessage = xpointArrow - widthMessage;
        
    }
    
    ///头像
    QSImageView *iconView = [[QSImageView alloc] initWithFrame:CGRectMake(xpointIcon, 15.0f, 40.0f, 40.0f)];
    iconView.image = [UIImage imageNamed:IMAGE_USERICON_DEFAULT_80];
    [self.contentView addSubview:iconView];
    objc_setAssociatedObject(self, &UserIconKey, iconView, OBJC_ASSOCIATION_ASSIGN);
    
    ///头像六角
    QSImageView *iconSixformView = [[QSImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, iconView.frame.size.width, iconView.frame.size.height)];
    iconSixformView.image = [UIImage imageNamed:IMAGE_USERICON_HOLLOW_80];
    [iconView addSubview:iconSixformView];
    
    ///指示三角
    QSImageView *arrowIndicator = [[QSImageView alloc] initWithFrame:CGRectMake(xpointArrow, iconView.frame.origin.y + 20.0f - 7.5f, 5.0f, 15.0f)];
    arrowIndicator.image = [UIImage imageNamed:IMAGE_CHAT_MESSAGE_SENDER_ARROW_NORMAL];
    if (mMessageFromTypeMY == self.messageType) {
        
        arrowIndicator.image = [UIImage imageNamed:IMAGE_CHAT_MESSAGE_MY_ARROW_NORMAL];;
        
    }
    [self.contentView addSubview:arrowIndicator];
    
    ///消息图片底view
    UIView *rootView = [[UIView alloc] initWithFrame:CGRectMake(xpointMessage, iconView.frame.origin.y, widthMessage, 100.0f)];
    rootView.layer.cornerRadius = 4.0f;
    rootView.backgroundColor = COLOR_CHARACTERS_GRAY;
    if (mMessageFromTypeMY == self.messageType) {
        
        rootView.backgroundColor = COLOR_CHARACTERS_YELLOW;
        
    }
    [self.contentView addSubview:rootView];
    
    ///图片消息
    QSImageView *pictureView = [[QSImageView alloc] initWithFrame:CGRectMake(10.0f, 10.0f, rootView.frame.size.width - 20.0f, rootView.frame.size.height - 20.0f)];
    pictureView.image = [UIImage imageNamed:IMAGE_USERICON_DEFAULT_100];
    [rootView addSubview:pictureView];
    objc_setAssociatedObject(self, &ImageMessageKey, pictureView, OBJC_ASSOCIATION_ASSIGN);
    
}

#pragma mark - 刷新UI
- (void)updateMessageWordUI:(QSYSendMessagePicture *)model
{
    
    ///更新头像
    UIImageView *icontView = objc_getAssociatedObject(self, &UserIconKey);
    if (icontView) {
        
        
        
    }
    
    ///更新图片
    UIImageView *messageView = objc_getAssociatedObject(self, &ImageMessageKey);
    if (messageView) {
        
        ///更新消息体尺寸
        UIView *rootView = messageView.superview;
        
        if (mMessageFromTypeMY == self.messageType) {
            
            CGFloat originalWidth = rootView.frame.size.width;
            rootView.frame = CGRectMake(rootView.frame.origin.x + (originalWidth - model.showWidth), rootView.frame.origin.y, model.showWidth, model.showHeight);
            
        } else {
            
            rootView.frame = CGRectMake(rootView.frame.origin.x, rootView.frame.origin.y, model.showWidth, model.showHeight);
            
        }
        
        messageView.frame = CGRectMake(10.0f, 10.0f, rootView.frame.size.width - 20.0f, rootView.frame.size.height - 20.0f);
        
        if (model.pictureInfo) {
            
            messageView.image = model.pictureInfo;
            
        }
        
    }
    
}

@end