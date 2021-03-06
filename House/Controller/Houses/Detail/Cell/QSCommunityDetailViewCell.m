//
//  QSCommunityDetailViewCell.m
//  House
//
//  Created by 王树朋 on 15/3/9.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "QSCommunityDetailViewCell.h"
#import "QSImageView.h"
#import "NSString+Calculation.h"
#import "QSBlockButtonStyleModel+Normal.h"
#import "QSBlockButton.h"

#import "QSHouseInfoDataModel.h"
#import "QSRentHouseInfoDataModel.h"

#import "QSCoreDataManager+House.h"

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
static char FeaturesKey;    //!<特色标签

@implementation QSCommunityDetailViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        ///UI搭建
        [self createHouseInfoCellUI];
        
    }
    return self;
    
}

#pragma mark - UI搭建
///UI搭建
- (void)createHouseInfoCellUI
{
    
    ///图片框
    QSImageView *houseImageView = [[QSImageView alloc] initWithFrame:CGRectMake(0.0f, 10.0f, 80.0f*330.0f/247.0f, 80.0f)];
    houseImageView.image = [UIImage imageNamed:IMAGE_HOUSES_LOADING_FAIL330x250];
    [self.contentView addSubview:houseImageView];
    objc_setAssociatedObject(self, &HouseImageKey, houseImageView, OBJC_ASSOCIATION_ASSIGN);
    
    ///左上角标签
    QSImageView *houseTagImageView = [[QSImageView alloc] initWithFrame:CGRectMake(0.0f, 10.0f, 30.0f, 18.0f)];
    houseTagImageView.hidden = YES;
    [self.contentView addSubview:houseTagImageView];
    objc_setAssociatedObject(self, &HouseTagKey, houseTagImageView, OBJC_ASSOCIATION_ASSIGN);
    
    ///价钱与面积一排的信息UI
    UIView *topRootView=[[UIView alloc] initWithFrame:CGRectMake(houseTagImageView.frame.origin.x+houseImageView.frame.size.width+8.0f, 10.0f, self.contentView.frame.size.width-houseImageView.frame.size.width-8.0f, 30.0f)];
    [self createPriceAndAreaUI:topRootView];
    [self.contentView addSubview:topRootView];
    
    ///街道和小区信息的底view，方便自适应
    UIView *streetRootView = [[UIView alloc] initWithFrame:CGRectMake(topRootView.frame.origin.x, topRootView.frame.origin.y + topRootView.frame.size.height + 5.0f, self.contentView.frame.size.width-houseImageView.frame.size.width-5.0f, 20.0f)];
    [self createStreetAndCommunityUI:streetRootView];
    [self.contentView addSubview:streetRootView];
    
    ///特色标签的底view
    UIView *featuresRootView = [[UIView alloc] initWithFrame:CGRectMake(topRootView.frame.origin.x, streetRootView.frame.origin.y + streetRootView.frame.size.height + 5.0f, self.contentView.frame.size.width-houseImageView.frame.size.width-5.0f, 20.0f)];
    [self.contentView addSubview:featuresRootView];
    objc_setAssociatedObject(self, &FeaturesKey, featuresRootView, OBJC_ASSOCIATION_ASSIGN);
    
}

///搭建价钱与面积的信息UI
-(void)createPriceAndAreaUI:(UIView *)view
{
    
    ///价钱按钮
    QSBlockButtonStyleModel *buttonStyle = [QSBlockButtonStyleModel createNormalButtonWithType:nNormalButtonTypeCornerLightYellow];
    QSBlockButton *button=[[QSBlockButton alloc] initWithButtonStyle:buttonStyle];
    button.translatesAutoresizingMaskIntoConstraints=NO;
    [self createTitleInfoUI:button];
    [view addSubview:button];
    
    ///户型
    QSLabel *houseTypeLabel = [[QSLabel alloc] init];
    houseTypeLabel.translatesAutoresizingMaskIntoConstraints=NO;
    houseTypeLabel.text = @"3房1厅";
    houseTypeLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    houseTypeLabel.textAlignment = NSTextAlignmentCenter;
    houseTypeLabel.textColor = COLOR_CHARACTERS_BLACK;
    [view addSubview:houseTypeLabel];
    objc_setAssociatedObject(self, &HouseTypeKey, houseTypeLabel, OBJC_ASSOCIATION_ASSIGN);
    
    ///分隔线
    UILabel *bottomLineLabel = [[UILabel alloc] init];
    bottomLineLabel.translatesAutoresizingMaskIntoConstraints=NO;
    bottomLineLabel.backgroundColor = COLOR_HEXCOLORH(0x000000, 0.5f);
    [view addSubview:bottomLineLabel];
    
    ///面积
    UILabel *areaLabel = [[QSLabel alloc] init];
    areaLabel.translatesAutoresizingMaskIntoConstraints=NO;
    areaLabel.text = @"128/㎡";
    areaLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    areaLabel.textAlignment = NSTextAlignmentCenter;
    areaLabel.textColor = COLOR_CHARACTERS_BLACK;
    [view addSubview:areaLabel];
    objc_setAssociatedObject(self, &HouseAreaKey, areaLabel, OBJC_ASSOCIATION_ASSIGN);
    
    ///约束参数
    NSDictionary *___viewsVFL = NSDictionaryOfVariableBindings(button,houseTypeLabel,bottomLineLabel,areaLabel);
    
    ///约束
    NSString *___hVFL_all = @"H:|-0-[button(>=60)]-0-[houseTypeLabel(>=40)]-0-[bottomLineLabel(0.25)]-0-[areaLabel(>=60)]-(>=0)-|";
    NSString *___vVFL_button = @"V:|-0-[button(30)]";
    NSString *___vVFL_houseTypeLabel = @"V:|-5-[houseTypeLabel(20)]";
    NSString *___vVFL_bottomLineLabel = @"V:|-5-[bottomLineLabel(20)]";
    NSString *___vVFL_areaLabel = @"V:|-5-[areaLabel(20)]";
    
    ///添加约束
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:___hVFL_all options:0 metrics:nil views:___viewsVFL]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:___vVFL_button options:0 metrics:nil views:___viewsVFL]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:___vVFL_houseTypeLabel options:0 metrics:nil views:___viewsVFL]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:___vVFL_bottomLineLabel options:0 metrics:nil views:___viewsVFL]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:___vVFL_areaLabel options:0 metrics:nil views:___viewsVFL]];
    
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
    communityLabel.textAlignment = NSTextAlignmentLeft;
    communityLabel.textColor = COLOR_CHARACTERS_GRAY;
    communityLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:communityLabel];
    objc_setAssociatedObject(self, &CommunityKey, communityLabel, OBJC_ASSOCIATION_ASSIGN);
    
    ///约束参数
    NSDictionary *___viewsVFL = NSDictionaryOfVariableBindings(streetLabel,communityLabel);
    
    ///约束
    NSString *___hVFL_all = @"H:|-0-[streetLabel(>=40)]-5-[communityLabel(>=80)]-(>=2)-|";
    NSString *___vVFL_street = @"V:|-2.5-[streetLabel(15)]-2.5-|";
    
    ///添加约束
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:___hVFL_all options:NSLayoutFormatAlignAllCenterY metrics:nil views:___viewsVFL]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:___vVFL_street options:NSLayoutFormatAlignAllTop metrics:nil views:___viewsVFL]];
    
}

///标题信息UI搭建
- (void)createTitleInfoUI:(UIView *)view
{
    
    ///标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"340";
    titleLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_16];
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
    NSString *___hVFL_all = @"H:|-(>=2)-[titleLabel]-0-[titleUnitLabel(15)]-(>=2)-|";
    NSString *___vVFL_title = @"V:|-5-[titleLabel(20)]-5-|";
    
    ///添加约束
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:___hVFL_all options:NSLayoutFormatAlignAllBottom metrics:nil views:___viewsVFL]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:___vVFL_title options:0 metrics:nil views:___viewsVFL]];
    
}


#pragma mark - 更新数据
/**
 *  @author             yangshengmeng, 15-02-06 10:02:42
 *
 *  @brief              根据请求返回的数据模型更新房子信息cell
 *
 *  @param dataModel    数据模型
 *  @param listType     列表的类型
 *
 *  @since              1.0.0
 */
//- (void)updateHouseInfoCellUIWithDataModel:(id)dataModel andListType:(FILTER_MAIN_TYPE)listType
//{
//
//    switch (listType) {
//            ///二手房列表
//        case fFilterMainTypeSecondHouse:
//
//            [self updateSecondHandHouseInfoCellUIWithDataModel:dataModel];
//
//            break;
//
//
//        default:
//            break;
//    }
//
//}


///小区列表UI更新
- (void)updateCommunityInfoCellUIWithDataModel:(QSHouseInfoDataModel *)tempModel
{
    
    ///更新小区
    [self updateHouseCommunityInfo:tempModel.village_name];
    
    ///更新详细街道信息
    [self updateHouseStreetInfo:tempModel.address];
    
    ///更新房子面积信息
    [self updateHouseAreaInfo:[NSString stringWithFormat:@"%d",[tempModel.house_area intValue]]];
    
    ///更新房子户型信息
    [self updateHouseTypeInfo:tempModel.house_shi and:tempModel.house_ting];
    
    ///更新中间标题
    [self updateTitleWithTitle:[NSString stringWithFormat:@"%d",[tempModel.house_price intValue]/10000]];
    [self updateTitleUnitWithUnit:@"万"];
    
    ///更新背景图片
    [self updateHouseImage:tempModel.attach_thumb];
    
    ///更新左上角标签
    [self updateHouseTagImage:tempModel.house_nature andListType:fFilterMainTypeSecondHouse];
    
    ///更新房子特色标签
    [self updateHouseFeatures:tempModel.features andListType:fFilterMainTypeSecondHouse];
    
}

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
        
        NSString *shiString = [NSString stringWithFormat:@"%@室",houseCount];
        if (hallCount) {
            
            [shiString stringByAppendingString:[NSString stringWithFormat:@"%@厅",hallCount]];
            
        }
        
        label.text = shiString;
        
    }
    
}

///更新中间标题
- (void)updateTitleWithTitle:(NSString *)title
{
    
    UILabel *label = objc_getAssociatedObject(self, &TitleLabelKey);
    if (label && title) {
        
        label.text = title;
        
    }
    
}

///更新标题右侧单位文字
- (void)updateTitleUnitWithUnit:(NSString *)unit
{
    
    UILabel *label = objc_getAssociatedObject(self, &TitleUnitKey);
    if (label && unit) {
        
        label.text = unit;
        
    }
    
}

///更新房子左上角标签图片
- (void)updateHouseTagImage:(NSString *)tag andListType:(FILTER_MAIN_TYPE)listType
{
    
    UIImageView *imageView = objc_getAssociatedObject(self, &HouseTagKey);
    if (imageView && tag) {
        
        ///二手房标签
        if (fFilterMainTypeSecondHouse == listType) {
            
            ///判断是否满足两个条件
            NSRange isFreeRange = [tag rangeOfString:@","];
            if (isFreeRange.length == 1) {
                
                imageView.hidden = NO;
                imageView.image = [UIImage imageNamed:IMAGE_HOUSES_LIST_TAXFREE];
                
            } else {
                
                imageView.hidden = YES;
                
            }
            
        }
        
    }
    
}

///更新房子的特色标签
- (void)updateHouseFeatures:(NSString *)featureString andListType:(FILTER_MAIN_TYPE)listType
{
    
    UIView *view = objc_getAssociatedObject(self, &FeaturesKey);
    if (featureString && view && ([featureString length] > 0)) {
        
        ///清空原标签
        for (UIView *obj in [view subviews]) {
            
            [obj removeFromSuperview];
            
        }
        
        ///将标签信息转为数组
        NSArray *featuresList = [featureString componentsSeparatedByString:@","];
        
        ///标签宽度
        CGFloat width = (view.frame.size.width - 12.0f) / 3.0f;
        
        ///循环创建特色标签
        for (int i = 0; i < [featuresList count] && i < 3;i++) {
            
            ///标签项
            UILabel *tempLabel = [[QSLabel alloc] initWithFrame:CGRectMake(3.0f + i * (width + 3.0f), 0.0f, width, view.frame.size.height)];
            
            ///根据特色标签，查询标签内容
            NSString *featureVal = [QSCoreDataManager getHouseFeatureWithKey:featuresList[i] andFilterType:listType];
            
            tempLabel.text = featureVal;
            tempLabel.font = [UIFont systemFontOfSize:FONT_BODY_12];
            tempLabel.textAlignment = NSTextAlignmentCenter;
            tempLabel.backgroundColor = COLOR_CHARACTERS_BLACK;
            tempLabel.textColor = [UIColor whiteColor];
            tempLabel.layer.cornerRadius = 4.0f;
            tempLabel.layer.masksToBounds = YES;
            tempLabel.adjustsFontSizeToFitWidth = YES;
            [view addSubview:tempLabel];
            
        }
        
    }
    
}

///更新房子大图
- (void)updateHouseImage:(NSString *)urlString
{
    
    UIImageView *imageView = objc_getAssociatedObject(self, &HouseImageKey);
    if (imageView && urlString && ([urlString length] > 1)) {
        
        [imageView loadImageWithURL:[urlString getImageURL] placeholderImage:[UIImage imageNamed:IMAGE_HOUSES_LOADING_FAIL330x250]];
        
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
