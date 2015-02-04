//
//  QSHouseCollectionViewCell.m
//  House
//
//  Created by ysmeng on 15/1/31.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "QSHouseCollectionViewCell.h"

#include <objc/runtime.h>

///关联
static char HouseImageKey;  //!<房子图片关联key
static char HouseTagKey;    //!<房子左上角标签关联key
static char TitleLabelKey;  //!<中间标题关联key
static char TitleUnitKey;   //!<中间标题计量单位关联key
static char HouseTypeKey;   //!<户型关联key
static char HouseAreaKey;   //!<面积
static char HouseStreetKey; //!<房子所在街道
static char CommunityKey;   //!<所在小区

@implementation QSHouseCollectionViewCell

#pragma mark - 初始化
/**
 *  @author         yangshengmeng, 15-01-31 14:01:11
 *
 *  @brief          重写初始化，添加UI创建
 *
 *  @param frame    大小和位置
 *
 *  @return         返回当前创建的cell
 *
 *  @since          1.0.0
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        ///UI搭建
        [self createHouseInfoCellUI];
        
        ///分隔线
        UILabel *sepLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, self.frame.size.height - 0.5f, self.frame.size.width, 0.5f)];
        sepLabel.backgroundColor = COLOR_CHARACTERS_BLACKH;
        [self.contentView addSubview:sepLabel];
        
    }
    
    return self;
    
}

#pragma mark - UI搭建
///UI搭建
- (void)createHouseInfoCellUI
{

    ///图片框
    QSImageView *houseImageView = [[QSImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.width * 247.0f / 330.0f)];
    houseImageView.image = [UIImage imageNamed:IMAGE_HOUSES_LOADING_FAIL];
    [self.contentView addSubview:houseImageView];
    objc_setAssociatedObject(self, &HouseImageKey, houseImageView, OBJC_ASSOCIATION_ASSIGN);
    
    ///左上角标签
    QSImageView *houseTagImageView = [[QSImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 30.0f, 18.0f)];
    houseTagImageView.hidden = YES;
    [self.contentView addSubview:houseTagImageView];
    objc_setAssociatedObject(self, &HouseTagKey, houseTagImageView, OBJC_ASSOCIATION_ASSIGN);
    
    ///中间六角形图标
    QSImageView *titleImageView = [[QSImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 70.0f, 79.0f)];
    titleImageView.image = [UIImage imageNamed:IMAGE_HOUSES_LIST_SIXFORM];
    titleImageView.center = CGPointMake(self.frame.size.width / 2.0f, houseImageView.frame.size.height);
    [self createTitleInfoUI:titleImageView];
    [self.contentView addSubview:titleImageView];
    
    ///户型
    UILabel *houseTypeLabel = [[QSLabel alloc] initWithFrame:CGRectMake(0.0f, titleImageView.frame.origin.y + titleImageView.frame.size.height + 5.0f, self.frame.size.width / 2.0f, 25.0f)];
    houseTypeLabel.text = @"3房1厅";
    houseTypeLabel.font = [UIFont systemFontOfSize:FONT_BODY_18];
    houseTypeLabel.textAlignment = NSTextAlignmentLeft;
    houseTypeLabel.textColor = COLOR_CHARACTERS_BLACK;
    [self.contentView addSubview:houseTypeLabel];
    objc_setAssociatedObject(self, &HouseTypeKey, houseTypeLabel, OBJC_ASSOCIATION_ASSIGN);
    
    ///面积
    UILabel *areaLabel = [[QSLabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2.0f, houseTypeLabel.frame.origin.y, houseTypeLabel.frame.size.width, houseTypeLabel.frame.size.height)];
    areaLabel.text = @"128/㎡";
    areaLabel.font = [UIFont systemFontOfSize:FONT_BODY_18];
    areaLabel.textAlignment = NSTextAlignmentRight;
    areaLabel.textColor = COLOR_CHARACTERS_BLACK;
    [self.contentView addSubview:areaLabel];
    objc_setAssociatedObject(self, &HouseAreaKey, areaLabel, OBJC_ASSOCIATION_ASSIGN);
    
    ///街道和小区信息的底view，方便自适应
    UIView *streetRootView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, houseTypeLabel.frame.origin.y + houseTypeLabel.frame.size.height + 5.0f, self.frame.size.width, 15.0f)];
    [self createStreetAndCommunityUI:streetRootView];
    [self.contentView addSubview:streetRootView];
    
    ///特色标签的底view
    UIView *featuresRootView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, streetRootView.frame.origin.y + streetRootView.frame.size.height + 10.0f, self.frame.size.width, 20.0)];
    featuresRootView.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:featuresRootView];
    
}

///搭建小区和街道的信息UI
- (void)createStreetAndCommunityUI:(UIView *)view
{

    ///街道
    UILabel *streetLabel = [[UILabel alloc] init];
    streetLabel.text = @"北京路";
    streetLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    streetLabel.textAlignment = NSTextAlignmentLeft;
    streetLabel.textColor = COLOR_CHARACTERS_GRAY;
    streetLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:streetLabel];
    objc_setAssociatedObject(self, &HouseStreetKey, streetLabel, OBJC_ASSOCIATION_ASSIGN);
    
    ///小区
    UILabel *communityLabel = [[UILabel alloc] init];
    communityLabel.text = @"科城山庄峻森园";
    communityLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    communityLabel.textAlignment = NSTextAlignmentRight;
    communityLabel.textColor = COLOR_CHARACTERS_GRAY;
    communityLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:communityLabel];
    objc_setAssociatedObject(self, &CommunityKey, communityLabel, OBJC_ASSOCIATION_ASSIGN);
    
    ///约束参数
    NSDictionary *___viewsVFL = NSDictionaryOfVariableBindings(streetLabel,communityLabel);
    
    ///约束
    NSString *___hVFL_all = @"H:|[streetLabel]-5-[communityLabel]|";
    NSString *___vVFL_street = @"V:|[streetLabel(15)]|";
    
    ///添加约束
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:___hVFL_all options:NSLayoutFormatAlignAllCenterY metrics:nil views:___viewsVFL]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:___vVFL_street options:NSLayoutFormatAlignAllCenterY metrics:nil views:___viewsVFL]];

}

///标题信息UI搭建
- (void)createTitleInfoUI:(UIView *)view
{

    ///标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"340";
    titleLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_20];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.textAlignment = NSTextAlignmentRight;
    titleLabel.textColor = COLOR_CHARACTERS_BLACK;
    [view addSubview:titleLabel];
    objc_setAssociatedObject(self, &TitleLabelKey, titleLabel, OBJC_ASSOCIATION_ASSIGN);
    
    ///单位
    UILabel *titleUnitLabel = [[UILabel alloc] init];
    titleUnitLabel.text = @"万";
    titleUnitLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_14];
    titleUnitLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleUnitLabel.textAlignment = NSTextAlignmentLeft;
    titleUnitLabel.textColor = COLOR_CHARACTERS_BLACK;
    [view addSubview:titleUnitLabel];
    objc_setAssociatedObject(self, &TitleUnitKey, titleUnitLabel, OBJC_ASSOCIATION_ASSIGN);
    
    ///约束参数
    NSDictionary *___viewsVFL = NSDictionaryOfVariableBindings(titleLabel,titleUnitLabel);
    
    ///约束
    NSString *___hVFL_all = @"H:|-(>=2)-[titleLabel]-0-[titleUnitLabel(22)]-(>=2)-|";
    NSString *___vVFL_title = @"V:|-29.5-[titleLabel(20)]-29.5-|";
    
    ///添加约束
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:___hVFL_all options:NSLayoutFormatAlignAllBottom metrics:nil views:___viewsVFL]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:___vVFL_title options:0 metrics:nil views:___viewsVFL]];

}

#pragma mark - 更新数据

///更新房子所在的小区信息
- (void)updateHouseCommunityInfo:(NSString *)info
{

    UILabel *label = objc_getAssociatedObject(self, &CommunityKey);
    if (label && info) {
        
        label.text = info;
        
    }

}

///更新街道信息
- (void)updateHouseStreetInfo:(NSString *)street
{

    UILabel *label = objc_getAssociatedObject(self, &HouseStreetKey);
    if (label && street) {
        
        label.text = street;
        
    }

}

///更新房子面积
- (void)updateHouseAreaInfo:(NSString *)area
{

    UILabel *label = objc_getAssociatedObject(self, &HouseAreaKey);
    if (label && area) {
        
        label.text = [NSString stringWithFormat:@"%@/%@",area,APPLICATION_AREAUNIT];
        
    }

}

///更新户型信息
- (void)updateHouseTypeInfo:(NSString *)houseCount and:(NSString *)hallCount
{

    UILabel *label = objc_getAssociatedObject(self, &HouseTypeKey);
    if (label) {
        
        
        
    }

}

///更新中间标题
- (void)updateTitleWithTitle:(NSString *)title
{

    UILabel *label = objc_getAssociatedObject(self, &TitleLabelKey);
    if (label && title) {
        
        
        
    }

}

///更新标题右侧单位文字
- (void)updateTitleUnitWithUnit:(NSString *)unit
{

    UILabel *label = objc_getAssociatedObject(self, &TitleUnitKey);
    if (label && unit) {
        
        
        
    }

}

///更新房子标签图片
- (void)updateHouseTagImage:(NSString *)tag
{

    UIImageView *imageView = objc_getAssociatedObject(self, &HouseTagKey);
    if (imageView && tag) {
        
        
        
    }

}

///更新房子大图
- (void)updateHouseImage:(NSString *)urlString
{

    UIImageView *imageView = objc_getAssociatedObject(self, &HouseImageKey);
    if (imageView && urlString) {
        
        
        
    }

}

@end