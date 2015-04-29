//
//  TypeEnumHeader.h
//  House
//
//  Created by ysmeng on 15/1/20.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#ifndef House_TypeEnumHeader_h
#define House_TypeEnumHeader_h

///登录检测回调类型
typedef enum
{
    
    lLoginCheckActionTypeUnLogin = 99,  //!<未登录
    lLoginCheckActionTypeLogined,       //!<原来已登录
    lLoginCheckActionTypeReLogin,       //!<重新登录
    lLoginCheckActionTypeOffLine,       //!<下线
    
}LOGIN_CHECK_ACTION_TYPE;

/**
 *  //用户10  ，房源20， 聊天30 ，订单50 ，公共99
 */

/*
 *  //用户类型
 *  user_type : "100101" "房客";
 *  user_type : "100102" "业主";
 *  user_type : "100103" "中介";
 *  user_type : "100104" "开发商";
 */
typedef enum
{
    
    uUserCountTypeTenant = 100101,  //!<房客
    uUserCountTypeOwner,            //!<业主
    uUserCountTypeAgency,           //!<中介
    uUserCountTypeDeveloper         //!<开发商
    
}USER_COUNT_TYPE;                   //!<用户账号权限类型

///消息是自己的消息，还是别人的消息类型
typedef enum
{
    
    mMessageFromTypeMY = 99,//!<当前用户的消息
    mMessageFromTypeFriends,//!<朋友发送过来的
    
}MESSAGE_FROM_TYPE;

/*
 *  //楼盘均价
 *  price_avg : "10000"         "一万元以下";
 *  price_avg : "10000-15000"   "1万-1.5万";
 *  price_avg : "15000-20000"   "1.5万-2万";
 *  price_avg : "20000-30000"   "2万-3万";
 *  price_avg : "30000-40000"   "3万-4万"
 *  price_avg : "40000-50000"   "4万-5万"
 *  price_avg : "50000"         "5万以上"
 */
typedef enum
{
    
    hHouseAveragerPriceTypeBelowTenThousand = 10000,//!<1万元以下
    hHouseAveragerPriceTypeBelowFifteenThousand,    //!<1万-1.5万
    hHouseAveragerPriceTypeBelowTwentyThousand,     //!<1.5万-2万
    hHouseAveragerPriceTypeBelowThirtyThousand,     //!<2万-3万
    hHouseAveragerPriceTypeBelowFortyThousand,      //!<3万-4万
    hHouseAveragerPriceTypeBelowFiftyThousand,      //!<4万-5万
    hHouseAveragerPriceTypeOverFiftyThousand        //!<5万以上
    
}HOUSE_AVERAGEPRICE_TYPE;                           //!<房源均价

/*
 *   //建筑结构
 *  building_structure : "200101" "塔楼";
 *  building_structure : "200102" "板楼";
 *  building_structure : "200103" "平房";
 */
typedef enum
{
    
    bBuildingStructureTypeTower = 200101,   //!<塔楼
    bBuildingStructureTypeBoard,            //!<板楼
    bBuildingStructureTypeBungalow          //!<平房
    
}BUILDING_STRUCTURE_TYPE;                   //!建筑结构

/**
 *  @author yangshengmeng, 15-01-27 10:01:49
 *
 *  @brief  使用年限：used_year
 *
 *  @since  1.0.0
 */

/*
 *  //装修类型
 *  decoration_type : "200201" "豪华装修";
 *  decoration_type : "200202" "精装修";
 *  decoration_type : "200203" "中等装修";
 *  decoration_type : "200204" "简装修";
 *  decoration_type : "200205" "毛坯";
 */
typedef enum
{
    
    hHouseDecorationTypeLuxurious = 200201, //!<豪华装修
    hHouseDecorationTypeRefined,            //!<精装修
    hHouseDecorationTypeMedium,             //!<中等装修
    hHouseDecorationTypeSimple,             //!<简装修
    hHouseDecorationTypeRough               //!<毛坯
    
}HOUSE_DECORATION_TYPE;                     //!<房子装修类型

/*
 *  //特色标签
 *  features : "200301" "地铁房";
 *  features : "200302" "学位房";
 *  features : "200303" "满五唯一";
 *  features : "200304" "商住两用";
 *  features : "200305" "交通便利";
 *  features : "200306" "不限购";
 *  features : "200307" "房东急售";
 *  features : "200308" "免税房";
 */
typedef enum
{
    
    hHouseFeatureTypeMetro = 200301,    //!<地铁房
    hHouseFeatureTypeDegree,            //!<学位房
    hHouseFeatureTypeOverFiveOnly,      //!<满五唯一:满五年，唯一一套房
    hHouseFeatureTypeDualUse,           //!<商住两用
    hHouseFeatureTypeConveniently,      //!<交通便利
    hHouseFeatureTypeNotPurchase,       //!<不限购
    hHouseFeatureTypeEmergencySale,     //!<房东急售
    hHouseFeatureTypeTaxFree            //!<免税房
    
}HOUSE_FEATURE_TYPE;                    //!<房子的特色标签

/**
 *  @author yangshengmeng, 15-01-27 10:01:56
 *
 *  @brief  水电年限：water
 *
 *  @since  1.0.0
 */

/**
 *  @author yangshengmeng, 15-01-27 10:01:22
 *
 *  @brief  采暖年限：heating
 *
 *  @since  1.0.0
 */

/**
 *  @author yangshengmeng, 15-01-27 10:01:23
 *
 *  @brief  建筑年代：building_year
 *
 *  @since  1.0.0
 */

/**
 *  @author yangshengmeng, 15-01-27 10:01:29
 *
 *  @brief  小区配套
 *
 *  installation : "200401" : "燃气/天然气"
 *  installation : "200402" : "暖气";
 *  installation : "200403" : "电梯";
 *  installation : "200404" : "车位";
 *  installation : "200405" : "车库";
 *  installation : "200406" : "花园";
 *  installation : "200407" : "露台";
 *  installation : "200408" : "阁楼";
 *
 *  @since  1.0.0
 */
typedef enum
{
    
    cCommunityInstallationTypeGas = 200401, //!<燃气/天然气
    cCommunityInstallationTypeHeating,      //!<暖气
    cCommunityInstallationTypeLift,         //!<电梯
    cCommunityInstallationTypeParking,      //!<车位
    cCommunityInstallationTypeCarbarn,      //!<车库
    cCommunityInstallationTypeGarden,       //!<花园
    cCommunityInstallationTypeTerrace,      //!<露台
    cCommunityInstallationTypeLoft          //!<阁台
    
}COMMUNITY_INSTALLATION_TYPE;

/**
 *  @author yangshengmeng, 15-01-27 10:01:58
 *
 *  @brief  应用中使用的过滤类型：搜索时的头部过滤
 *
 *  //类型
 *  type : "200501" : "楼盘";
 *  type : "200502" : "新房";
 *  type : "200503" : "小区";
 *  type : "200504" : "二手房";
 *  type : "200505" : "出租房";
 *
 *  @since  1.0.0
 */
typedef enum
{
    
    hHouseListMainTypeBuilding = 200501,   //!<楼盘
    hHouseListMainTypeNewHouse,            //!<新房
    hHouseListMainTypeCommunity,           //!<小区
    hHouseListMainTypeSecondHouse,         //!<二手房
    hHouseListMainTypeRenant               //!<出租房
    
}HOUSE_LIST_MAIN_TYPE;                      //!<应用中列表主要的过滤类型

/**
 *  @author     yangshengmeng, 15-01-27 10:01:06
 *
 *  @brief      房屋性质
 *
 *  house_nature : "200601" : "满五";
 *  house_nature : "200602" : "免税";
 *
 *  @since      1.0.0
 */
typedef enum
{
    
    hHouseNatureTypeOverFiveYear = 200601,  //!<满五年
    hHouseNatureTypeFreeDuty                //!<免税
    
}HOUSE_NATURE_TYPE;                         //!<房屋性质

/**
 *  @author yangshengmeng, 15-01-27 11:01:17
 *
 *  @brief  出租性质
 *
 *  //出租性质
 *  rent_property : "200701" "整租";
 *  rent_property : "200702" "合租";
 *
 *  @since  1.0.0
 */
typedef enum
{
    
    hHouseRenantPropertyTypeEntire = 200701,//!<整租
    hHouseRenantPropertyTypeJoint           //!<合租
    
}HOUSE_RENANT_PROPERTY_TYPE;                //!<出租性质

/**
 *  @author yangshengmeng, 15-01-27 11:01:49
 *
 *  @brief  出租方式
 *
 *  //付款方式
 *  payment : "200801" "一押一付";
 *  payment : "200802" "二押一付";
 *
 *  @since  1.0.0
 */
typedef enum
{
    
    hHouseRenantPaymentStyleAA = 200801,    //!<押一付一
    hHouseRenantPaymentStyleTA              //!<押二付一
    
}HOUSE_RENANT_PAYMENT_STYLE;                //!<出租房的租金支付方式

/**
 *  @author yangshengmeng, 15-01-27 11:01:35
 *
 *  @brief  有多少个房间的类型
 *
 *  house_shi : "200901" "一";
 *  house_shi : "200902" "二";
 *  house_shi : "200903" "三";
 *  house_shi : "200904" "四";
 *
 *  @since  1.0.0
 */
typedef enum
{
    
    hHouseRoomNumberTypeOne = 200901,   //!<一房
    hHouseRoomNumberTypeTwo,            //!<二房
    hHouseRoomNumberTypeThree,          //!<三房
    hHouseRoomNumberTypeFour,           //!<四房
    hHouseRoomNumberTypeFive            //!<五房
    
}HOUSE_ROOM_NUMBER_TYPE;                //!<房子的房间数量类型

/**
 *  @author yangshengmeng, 15-01-27 11:01:41
 *
 *  @brief  房子的厅数量类型
 *
 *  //户型结构-厅
 *  house_ting" : "201001']='一';
 *  house_ting" : "201002']='二';
 *  house_ting" : "201003']='三';
 *  house_ting" : "201004']='四';
 *
 *  @since  1.0.0
 */
typedef enum
{
    
    hHouseHallNumberTypeOne = 201001,   //!<一厅
    hHouseHallNumberTypeTwo,            //!<二厅
    hHouseHallNumberTypeThree,          //!<三厅
    hHouseHallNumberTypeFour            //!<四厅
    
}HOUSE_HALL_NUMBER_TYPE;                //!<房子厅数量类型

/**
 *  @author yangshengmeng, 15-01-27 11:01:28
 *
 *  @brief  房子的卫生间数量类型
 *
 *  //户型结构-卫 生间
 *  house_wei" : "201101" "一";
 *  house_wei" : "201102" "二";
 *  house_wei" : "201103" "三";
 *  house_wei" : "201104" "四";
 *
 *  @since  1.0.0
 */
typedef enum
{
    
    hHouseToiletNumberTypeOne = 201101, //!<一卫
    hHouseToiletNumberTypeTwo,          //!<二卫
    hHouseToiletNumberTypeThree,        //!<三卫
    hHouseToiletNumberTypeFour          //!<四卫
    
}HOUSE_TOILET_NUMBER_TYPE;              //!<房子卫生间的数量类型

/**
 *  @author yangshengmeng, 15-01-27 11:01:31
 *
 *  @brief  房子的厨房数量类型
 *
 *  //户型结构-厨
 *  house_chufang" : "201201" "一";
 *  house_chufang" : "201202" "二";
 *  house_chufang" : "201203" "三";
 *  house_chufang" : "201204" "四";
 *
 *  @since  1.0.0
 */
typedef enum
{
    
    hHouseKitchenNumberTypeOne = 201201,//!<一厨
    hHouseKitchenNumberTypeTwo,         //!<二厨
    hHouseKitchenNumberTypeThree,       //!<三厨
    hHouseKitchenNumberTypeFour         //!<四厨
    
}HOUSE_KITCHEN_NUMBER_TYPE;             //!<厨房的数量类型

/**
 *  @author yangshengmeng, 15-01-27 11:01:34
 *
 *  @brief  房子的阳台类型
 *
 *  //户型结构-阳台
 *  house_yangtai" : "201301" "一";
 *  house_yangtai" : "201302" "二";
 *  house_yangtai" : "201303" "三";
 *  house_yangtai" : "201304" "四";
 *
 *  @since  1.0.0
 */
typedef enum
{
    
    hHouseTerraceNumberTypeOne = 201301,//!<一阳台
    hHouseTerraceNumberTypeTwo,         //!<二阳台
    hHouseTerraceNumberTypeThree,       //!<三阳台
    hHouseTerraceNumberTypeFour         //!<四阳台
    
}HOUSE_TERRACE_NUMBER_TYPE;             //!<房子的阳台数量类型

/**
 *  @author yangshengmeng, 15-01-27 11:01:55
 *
 *  @brief  购房目的
 *
 *  //购房目的
 *  intent" : "201401" "刚需房";
 *  intent" : "201402" "改善房";
 *  intent" : "201403" "婚房";
 *  intent" : "201404" "学位房";
 *  intent" : "201405" "养老房";
 *  intent" : "201406" "投资房";
 *
 *  @since  1.0.0
 */
typedef enum
{
    
    pPurpostPerchaseTypeJust = 201401,  //!<刚需房
    pPurpostPerchaseTypeImprove,        //!<改善房
    pPurpostPerchaseTypeMarriage,       //!<婚房
    pPurpostPerchaseTypeDegree,         //!<学位房
    pPurpostPerchaseTypeEndowment,      //!<养老房
    pPurpostPerchaseTypeInvestment      //!<投资房
    
}PURPOSE_PERCHASE_TYPE;                 //!<购房目的类型

/**
 *  house_face : "201501" "朝东";
 *  house_face : "201502" "东南";
 *  house_face : "201503" "朝南";
 *  house_face : "201504" "西南";
 *  house_face : "201505" "朝西";
 *  house_face : "201506" "西北";
 *  house_face : "201507" "朝北";
 *  house_face : "201508" "东北";
 */
typedef enum
{
    
    hHouseFaceTypeEast = 201501,    //!<朝东
    hHouseFaceTypeSoutheast,        //!<东南
    hHouseFaceTypeSouth,            //!<朝南
    hHouseFaceTypeSouthwest,        //!<西南
    hHouseFaceTypeWest,             //!<朝西
    hHouseFaceTypeNorthwest,        //!<西北
    hHouseFaceTypeNorth,            //!<朝北
    hHouseFaceTypeNortheast         //!<东北
    
}HOUSE_FACE_TYPE;                   //!<房子朝向类型

/*
 *  //出租-配套设施
 *  installation : "201601" "拎包入住";
 *  installation : "201602" "家电齐全";
 *  installation : "201603" "可上网";
 *  installation : "201604" "可洗澡";
 *  installation : "201605" "可做饭";
 *  installation : "201606" "空调房";
 *  installation : "201607" "有暖气";
 *  installation : "201608" "带车位";
 */
typedef enum
{
    
    hHouseRenantInstallationTypeTheBag = 201601,    //!<拎包入住
    hHouseRenantInstallationTypeAppliance,          //!<家电齐全
    hHouseRenantInstallationTypeNetworking,         //!<可上网
    hHouseRenantInstallationTypeBath,               //!<可洗澡
    hHouseRenantInstallationTypeCook,               //!<可做饭
    hHouseRenantInstallationTypeAirCondiction,      //!<空调房
    hHouseRenantInstallationTypeHeating = 201607,   //!<有暖气
    hHouseRenantInstallationTypeParking             //!<带车位
    
}HOUSE_RENANT_INSTALLATION_TYPE;                    //!<出租房子的配套

///出租房的限制类型
typedef enum
{
    
    rRentHouseLimitedTypeUnLimited = 990601,//!<男女不限
    rRentHouseLimitedTypeMale,              //!<艰男生
    rRentHouseLimitedTypeFemale,            //!<限女生
    
}RENT_HOUSE_LIMITED_TYPE;

///房子的状态类型
typedef enum
{
    
    hHouseStatusTypeDeleted = -1,   //!<已删除
    hHouseStatusTypeUnRelease = 0,  //!<未发布
    hHouseStatusTypeReleased = 1,   //!<已发布
    hHouseStatusTypeRented = 2,     //!<已出租
    hHouseStatusTypeSaled = 3       //!<已出售
    
}HOUSE_STASUTS_TYPE;

///初始化时，过滤器类型
typedef enum
{
    
    fFilterMainTypeBuilding = 200501,   //!<楼盘
    fFilterMainTypeNewHouse,            //!<新房
    fFilterMainTypeCommunity,           //!<小区
    fFilterMainTypeSecondHouse,         //!<二手房
    fFilterMainTypeRentalHouse          //!<出租房
    
}FILTER_MAIN_TYPE;                      //!<过滤器的类型

///过滤器的状态
typedef enum
{
    
    fFilterStatusTypeNoRecord = -1, //!<未有相关的过滤器
    fFilterStatusTypeInit = 0,      //!<刚初始化
    fFilterStatusTypeWaitSetting,   //!<等待设置
    fFilterStatusTypeWorking,       //!<正在使用中
    fFilterStatusTypeCancel         //!<已弃用
    
}FILTER_STATUS_TYPE;                //!<过滤器的状态

///瀑布流列表的回调类型
typedef enum
{
    
    hHouseListActionTypeNoRecord = 99,  //!<无记录
    hHouseListActionTypeHaveRecord,     //!<有记录
    hHouseListActionTypeGotoDetail,     //!<点击进入详情页
    hHouseListActionTypeShake,          //!<摇一摇
    
    
}HOUSE_LIST_ACTION_TYPE;

///消息的种类
typedef enum
{
    
    qQSCustomProtocolChatMessageTypeWord            = 9000, //!<文字信息
    qQSCustomProtocolChatMessageTypePicture         = 9001, //!<图片信息
    qQSCustomProtocolChatMessageTypeVideo           = 9002, //!<语音信息
    qQSCustomProtocolChatMessageTypeOnLine          = 9003, //!<下线信息
    qQSCustomProtocolChatMessageTypeOffLine         = 9004, //!<上线信息
    qQSCustomProtocolChatMessageTypeSpecial         = 9005, //!<推荐房源
    qQSCustomProtocolChatMessageTypeSystem          = 9006, //!<系统消息
    qQSCustomProtocolChatMessageTypeHistoryWord     = 9007, //!<历史文字消息
    qQSCustomProtocolChatMessageTypeHistoryPicture  = 9008, //!<历史图片消息
    qQSCustomProtocolChatMessageTypeHistoryVideo    = 9009, //!<历史音频消息
    qQSCustomProtocolChatMessageTypeHistory         = 9010, //!<获取指定联系人的历史消息
    
}QSCUSTOM_PROTOCOL_CHAT_MESSAGE_TYPE;

///聊天发送消息时的发送类型：单对单聊天、群聊
typedef enum
{
    
    qQSCustomProtocolChatSendTypePTP = 8000,//!<单对单聊天
    qQSCustomProtocolChatSendTypePTG = 8001,//!<群聊
    
}QSCUSTOM_PROTOCOL_CHAT_SEND_TYPE;

///发布物业的类型
typedef enum
{
    
    rReleasePropertyStatusNew = 99, //!<新发布
    rReleasePropertyStatusUpdate,   //!<更新原有物业
    
}RELEASE_PROPERTY_STATUS;

/**
 *  @author yangshengmeng, 15-01-20 21:01:02
 *
 *  @brief  网络请求返回的结果标识
 *
 *  @since  1.0.0
 */
typedef enum
{
    
    rRequestResultTypeSuccess = 99,     //!<请求成功,服务端返回成功
    rRequestResultTypeFail,             //!<请求失败，服务端返回失败
    
    rRequestResultTypeDataAnalyzeFail,  //!<数据解析失败
    
    rRequestResultTypeError,            //!<请求类型有误
    rRequestResultTypeURLError,         //!<无法获取有效URL信息
    rRequestResultTypeMappingClassError,//!<无效的mapping类
    rRequestResultTypeImageDataError,   //!<上传图片时，图片获取失败
    
    rRequestResultTypeNoNetworking,     //!<请求失败，无可用网络
    rRequestResultTypeBadNetworking     //!<请求失败，网络不稳定
    
}REQUEST_RESULT_STATUS;                 //!<网络请求结果标识

/**
 *  @author yangshengmeng, 15-01-20 21:01:02
 *
 *  @brief  http网络请求时使用的请求类型：POST,GET
 *
 *  @since  1.0.0
 */
typedef enum
{
    
    rRequestHttpRequestTypeGet = 0, //!<GET请求
    rRequestHttpRequestTypePost     //!<POST请求
    
}REQUEST_HTTPREQUEST_TYPE;

/**
 *  @author yangshengmeng, 15-01-20 21:01:51
 *
 *  @brief  统一的网络请求类别，通过传类型进入网络请求控制器进行请求
 *
 *  @since  1.0.0
 */
typedef enum
{
    
    rRequestTypeAdvert = 999,                           //!<广告信息请求：第一个请求
    rRequestTypeAppBaseInfo = 1000,                     //!<应用中的基本信息版本请求：如可选城市
    rRequestTypeAppBaseInfoConfiguration = 1001,        //!<具体某个配置信息的请求
    rRequestTypeAppBaseCityInfo = 1002,                 //!<城市信息

    rRequestTypeBuilding = 2000,                        //!<楼盘列表请求
    rRequestTypeNewHouse = 2001,                        //!<新房列表请求
    rRequestTypeCommunity = 2002,                       //!<小区列表请求
    rRequestTypeSecondHandHouseList = 2003,             //!<二手房列表请求
    rRequestTypeRentalHouse = 2004,                     //!<出租房列表请求

    rRequestTypeNewHouseCollected = 2020,               //!<新房收藏
    rRequestTypeCommunityIntention = 2021,              //!<小区关注
    rRequestTypeSecondHandHouseCollected = 2022,        //!<二手房收藏
    rRequestTypeRentalHouseCollected = 2023,            //!<出租房收藏
    rRequestTypeNewHouseDeleteCollected = 2024,         //!<删除新房收藏
    rRequestTypeCommunityDeleteIntention = 2025,        //!<删除小区关注
    rRequestTypeSecondHandHouseDeleteCollected = 2026,  //!<删除二手房收藏
    rRequestTypeRentalHouseDeleteCollected = 2027,      //!<删除出租房收藏
    
    rRequestTypeMapCommunity = 2045,                    //!<地图小区列表请求
    
    rRequestTypeNewHouseDetail = 2050,                  //!<新房详情请求
    rRequestTypeCommunityDetail = 2051,                 //!<小区详情请求
    rRequestTypeSecondHandHouseDetail = 2052,           //!<二手房详情请求
    rRequestTypeRentalHouseDetail = 2053,               //!<出租房详情请求
    
    rRequestTypeActivityDetail = 2061,                  //!<活动详情请求
    rRequestHouseTypeDetail = 2062,                     //!<户型详情请求
    rRequestCommentListDetail = 2063,                   //!<用户评论列表

    rRequestTypeHomeCountData = 3000,                   //!<首页统计数据
    
    rRequestTypeDeveloperHomeCountData = 3001,          //!<开发商首页数据
    rRequestTypeDeveloperActivityList =3002,            //!<开发商活动列表

    rRequestTypeChatMessageList = 4000,                 //!<消息列表
    rRequestTypeChatContactList = 4001,                 //!<联系人列表
    rRequestTypeChatContactInfo = 4002,                 //!<联系人信息
    rRequestTypeChatContactAdd = 4003,                  //!<添加联系人
    rRequestTypeChatContactInfoChange = 4004,           //!<联系人信息修改
    rRequestTypeChatComplainContact = 4005,             //!<投诉联系人
    rRequestTypeChatContactDelete = 4006,               //!<删除联系人
    
    rRequestTypeMyZoneCollectedNewHouseList = 4997,     //!<收藏新房列表
    rRequestTypeMyZoneCollectedRentHouseList = 4998,    //!<收藏出租房列表
    rRequestTypeMyZoneCollectedSecondHouseList = 4999,  //!<收藏二手房列表
    rRequestTypeMyZoneIntentionCommunityList = 5000,    //!<关注小区列表

    rRequestTypeMyZoneAskRentPurphaseList = 5001,       //!<求租求购列表
    rRequestTypeMyZoneAddAskRentPurpase = 5002,         //!<添加求租求购
    rRequestTypeLoadImage = 5003,                       //!<上传图片
    rRequestTypeMyZoneReleaseRentHouse = 5004,          //!<发布出租房
    rRequestTypeMyZoneReleaseSecondHandHouse = 5005,    //!<发布二手房
    rRequestTypeMyZoneEditAskRentPurpase = 5006,        //!<修改求租求购
    rRequestTypeMyZoneDeleteAskRentPurpase = 5007,      //!<删除求租求购
    rRequestTypeMyZoneRecommendTenantList = 5008,       //!<推荐房客
    rRequestTypeMyZoneAskRentPurphaseRentHouse = 5009,  //!<求租求购对应的推荐出租房列表
    rRequestTypeMyZoneAskRentPurphaseSecondHouse = 5010,//!<求租求购对应的推荐二手房列表
    rRequestTypeMyZoneDeleteRentHouseProperty = 5011,   //!<删除出租物业
    rRequestTypeMyZoneDeleteSaleHouseProperty = 5012,   //!<删除出售物业
    rRequestTypeMyZoneUpdateRentHouseProperty = 5013,   //!<更新出租物业
    rRequestTypeMyZoneUpdateSecondHouseProperty = 5014, //!<更新出售物业
    
    rRequestTypeMyZoneStatistics = 5500,                //!<个人中心的统计数据

    rRequestTypeTransationOrderListData = 6002,         //!<成交订单列表数据
    
    rRequestTypeOrderCancelTransation = 7001,           //!<订单详情里取消成交订单
    rRequestTypeOrderCommitTransation = 7002,           //!<订单详情里确认成交订单
    rRequestTypeOrderTransationNoticeUser = 7003,       //!<成交订单提醒对方

    rRequestTypeOrderAppointmentDetailData = 8001,      //!<预约订单详情
    rRequestTypeOrderTransationDetailData = 8002,       //!<成交订单详情
    rRequestTypeOrderResetAppointment = 8003,           //!<修改预约订单数据
    rRequestTypeOrderAppointmentAgain = 8004,           //!<再次预约预约订单数据
    rRequestTypeOrderAppointmentaApplyBargain = 8005,   //!<预约订单申请议价
    rRequestTypeOrderAppointmentAcceptOrRejectApplyBargain = 8006,   //!<预约订单接受拒绝再议价
    rRequestTypeBookOrderListData = 8008,               //!<预约订单列表数据
    
    rRequestTypeOrderAddAppointment = 8011,             //!<添加预约订单数据
    
    rRequestTypeSendPhoneVertical = 9000,               //!<发送手机验证码
    rRequestTypeRegistPhone = 9001,                     //!<普通的手机注册
    rRequestTypeLogin = 9002,                           //!<登录
    rRequestTypeLogout = 9003,                          //!<退出登录
    rRequestTypeReloadUserUnfo = 9004,                  //!<重新下载用户信息
    rRequestTypeUPDateuserInfo = 9005,                  //!<更新用户信息
    rRequestTypeResetLoginPassword = 9006,              //!<重置密码
    rRequestTypeForgetLoginPassword = 9007,             //!<密码密码并修改
    rRequestTypeResetMobile = 9008,                     //!<修改手机
    
    rRequestTypeOrderSubmitBid = 10002,                 //!<提交我的出价
    rRequestTypeOrderCancelAppointment = 10003,         //!<订单详情里取消预约订单
    rRequestTypeOrderCommitAppointment = 10004,         //!<订单详情里接受预约订单
    rRequestTypeOrderRejectPrice = 10005,               //!<订单详情里房主拒绝还价
    rRequestTypeOrderSalerAcceptPrice = 10006,          //!<订单详情里房主接受价格
    rRequestTypeOrderBuyerOrSalerCommitOrder = 10007,   //!<订单详情里房客成交
    
    rRequestTypeOrderCommitInspected = 10013,           //!<订单详情里完成看房
    
    rRequestTypeImage                                   //!<图片请求：末尾请求
    
}REQUEST_TYPE;                                          //!<请求类型


#endif
