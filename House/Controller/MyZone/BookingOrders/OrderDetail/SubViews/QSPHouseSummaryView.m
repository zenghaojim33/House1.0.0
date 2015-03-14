//
//  QSPHouseSummaryView.m
//  House
//
//  Created by CoolTea on 15/3/13.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "QSPHouseSummaryView.h"
#import "UIKit+AFNetworking.h"

//上下间隙
#define     CONTENT_TOP_BOTTOM_OFFSETY     14.0f

////关联
//static char houseIDLabelKey;        //!<房源ID关联key
//static char contentImgViewKey;      //!<房源图片关联key
//static char houseTitleLabelKey;     //!<房源标题关联key


@implementation QSPHouseSummaryView

- (instancetype)initAtTopLeft:(CGPoint)topLeftPoint withHouseData:(id)houseData andCallBack:(void(^)(UIButton *button))callBack
{
    
    return [self initWithFrame:CGRectMake(topLeftPoint.x, topLeftPoint.y, SIZE_DEVICE_WIDTH, 0.0f) withHouseData:houseData andCallBack:callBack];
    
}

- (instancetype)initWithFrame:(CGRect)frame withHouseData:(id)houseData andCallBack:(void(^)(UIButton *button))callBack
{
    if (self = [super initWithFrame:frame]) {
        
        [self setClipsToBounds:YES];
        [self setUserInteractionEnabled:YES];
        
        //房源编号
        UILabel *houseTitleIDLabel = [[UILabel alloc] initWithFrame:CGRectMake(CONTENT_VIEW_MARGIN_LEFT_RIGHT_GAP, CONTENT_TOP_BOTTOM_OFFSETY, (SIZE_DEVICE_WIDTH - 2.0f * CONTENT_VIEW_MARGIN_LEFT_RIGHT_GAP), 22)];
        [houseTitleIDLabel setFont:[UIFont systemFontOfSize:FONT_BODY_12]];
        [houseTitleIDLabel setTextColor:COLOR_CHARACTERS_GRAY];
        NSString *IDStr = [NSString stringWithFormat:@"%@  %@",TITLE_MYZONE_ORDER_DETAIL_HOUSE_ID_TITLE_TIP, @"128734823428962"];
        [houseTitleIDLabel setText:IDStr];
        [self addSubview:houseTitleIDLabel];

        //图片
        UIImageView *contentImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CONTENT_VIEW_MARGIN_LEFT_RIGHT_GAP-2, houseTitleIDLabel.frame.origin.y+houseTitleIDLabel.frame.size.height+4, 50, 50)];
        [contentImgView setImageWithURL:[NSURL URLWithString:@"http://img0.bdstatic.com/img/image/shouye/jiaju0311.jpg"]];
        [self addSubview:contentImgView];
        
        UIImageView *contentCoverImgView = [[UIImageView alloc] initWithFrame:contentImgView.frame];
        [contentCoverImgView setImage:[UIImage imageNamed:IMAGE_ZONE_ORDER_LIST_CELL_COVER_FRAME]];
        [self addSubview:contentCoverImgView];
        
        //小区名
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentImgView.frame.origin.x+contentImgView.frame.size.width+4, contentImgView.frame.origin.y+(contentImgView.frame.size.height-40)/2.0f, (SIZE_DEVICE_WIDTH - CONTENT_VIEW_MARGIN_LEFT_RIGHT_GAP)-contentImgView.frame.origin.x-contentImgView.frame.size.width-44, 40.0f)];
        [nameLabel setNumberOfLines:2];
        [nameLabel setFont:[UIFont systemFontOfSize:FONT_BODY_16]];
        [nameLabel setText:@"小区我是小区"];
        [self addSubview:nameLabel];
        
        //右箭头
        UIImageView *rightArrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(nameLabel.frame.origin.x+nameLabel.frame.size.width+12, nameLabel.frame.origin.y+(nameLabel.frame.size.height-23.0f)/2.f, 13.0f, 23.0f)];
        [rightArrowImgView setImage:[UIImage imageNamed:IMAGE_PUBLIC_RIGHT_ARROW]];
        [self addSubview:rightArrowImgView];
        
        UIButton *clickBt = [UIButton createBlockButtonWithFrame:CGRectMake(contentImgView.frame.origin.x, contentImgView.frame.origin.y, rightArrowImgView.frame.origin.x+rightArrowImgView.frame.size.width+10, contentImgView.frame.size.height) andButtonStyle:[[QSBlockButtonStyleModel alloc] init] andCallBack:^(UIButton *button) {
            
            if (self.blockButtonCallBack) {
                self.blockButtonCallBack(button);
            }
            
        }];
        [self addSubview:clickBt];
        
        ///最下方边界区域
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(CONTENT_VIEW_MARGIN_LEFT_RIGHT_GAP, contentImgView.frame.origin.y+contentImgView.frame.size.height, (SIZE_DEVICE_WIDTH - 2.0f * CONTENT_VIEW_MARGIN_LEFT_RIGHT_GAP), CONTENT_TOP_BOTTOM_OFFSETY)];
        [bottomView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:bottomView];

        ///分隔线
        UILabel *bottomLineLablel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, CONTENT_TOP_BOTTOM_OFFSETY-0.5f, (SIZE_DEVICE_WIDTH - 2.0f * CONTENT_VIEW_MARGIN_LEFT_RIGHT_GAP), 0.5f)];
        [bottomLineLablel setBackgroundColor:COLOR_CHARACTERS_BLACKH];
        [bottomView addSubview:bottomLineLablel];
        
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, bottomView.frame.origin.y+bottomView.frame.size.height)];
        
        self.blockButtonCallBack = callBack;
    }
    
    return self;
    
}

- (void)setHouseData:(id)houseData{
    
}

@end