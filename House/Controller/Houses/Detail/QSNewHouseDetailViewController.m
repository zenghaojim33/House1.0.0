//
//  QSNewHouseDetailViewController.m
//  House
//
//  Created by ysmeng on 15/3/6.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "QSNewHouseDetailViewController.h"

#import "QSAutoScrollView.h"

#import "QSImageView+Block.h"

#import "QSBlockButtonStyleModel+Normal.h"
#import "NSDate+Formatter.h"

#import "QSNewHouseDetailDataModel.h"

#import "QSCoreDataManager+House.h"
#import "QSCoreDataManager+App.h"

#import "MJRefresh.h"

#import <objc/runtime.h>

///关联
static char DetailRootViewKey;      //!<所有信息的view
static char BottomButtonRootViewKey;//!<底部按钮的底view关联
static char MainInfoRootViewKey;    //!<主信息的底view关联

static char SecondInfoRootViewKey;  //!<详情信息以下所有信息的底view关联Key

static char RightScoreKey;          //!<右侧评分
static char RightStarKey;           //!<右侧星级
static char LeftScoreKey;           //!<左侧评分
static char LeftStarKey;            //!<左侧星级

@interface QSNewHouseDetailViewController () <QSAutoScrollViewDelegate>

@property (nonatomic,copy) NSString *title;                 //!<标题
@property (nonatomic,copy) NSString *loupanID;              //!<详情的ID
@property (nonatomic,copy) NSString *buildingID;            //!<楼栋ID
@property (nonatomic,assign) FILTER_MAIN_TYPE detailType;   //!<详情的类型

@end

@implementation QSNewHouseDetailViewController

#pragma mark - 初始化
/**
 *  @author             yangshengmeng, 15-03-09 09:03:30
 *
 *  @brief              根据楼盘ID和楼栋ID，创建新房详情页面
 *
 *  @param title        标题
 *  @param loupanID     楼盘ID
 *  @param buildingID   楼栋ID
 *  @param detailType   房子的类型
 *
 *  @return             返回新房详情页
 *
 *  @since              1.0.0
 */
- (instancetype)initWithTitle:(NSString *)title andLoupanID:(NSString *)loupanID andLoupanBuildingID:(NSString *)buildingID andDetailType:(FILTER_MAIN_TYPE)detailType
{
    
    if (self = [super init]) {
        
        ///保存相关参数
        self.title = title;
        self.loupanID = loupanID;
        self.buildingID = buildingID;
        self.detailType = detailType;
        
    }
    
    return self;
    
}

#pragma mark - UI搭建
///重写导航栏，添加标题信息
- (void)createNavigationBarUI
{
    
    [super createNavigationBarUI];
    
    [self setNavigationBarTitle:(self.title ? self.title : @"详情")];
    
}

///主展示信息
- (void)createMainShowUI
{
    
    ///所有信息的底view
    QSScrollView *rootView = [[QSScrollView alloc] initWithFrame:CGRectMake(0.0f, 64.0f, SIZE_DEVICE_WIDTH, SIZE_DEVICE_HEIGHT - 64.0f)];
    [self.view addSubview:rootView];
    objc_setAssociatedObject(self, &DetailRootViewKey, rootView, OBJC_ASSOCIATION_ASSIGN);
    
    ///添加刷新
    [rootView addHeaderWithTarget:self action:@selector(getNewHouseDetailInfo)];

    ///其他信息底view
    QSScrollView *infoRootView = [[QSScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SIZE_DEVICE_WIDTH, rootView.frame.size.height - 60.0f)];
    [rootView addSubview:infoRootView];
    infoRootView.hidden = YES;
    objc_setAssociatedObject(self, &MainInfoRootViewKey, infoRootView, OBJC_ASSOCIATION_ASSIGN);
    
    ///底部按钮
    UIView *bottomRootView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, rootView.frame.size.height - 60.0f, rootView.frame.size.width, 60.0f)];
    [rootView addSubview:bottomRootView];
    bottomRootView.hidden = YES;
    objc_setAssociatedObject(self, &BottomButtonRootViewKey, bottomRootView, OBJC_ASSOCIATION_ASSIGN);
    [self createBottomButtonViewUI:YES];
    
    ///一开始就请求数据
    [rootView headerBeginRefreshing];

}

#pragma mark - 搭建底部按钮
///创建底部按钮
- (void)createBottomButtonViewUI:(BOOL)isLooked
{

    ///获取底view
    UIView *view = objc_getAssociatedObject(self, &BottomButtonRootViewKey);
    
    ///清空原数据
    for (UIView *obj in [view subviews]) {
        
        [obj removeFromSuperview];
        
    }
    
    ///分隔线
    UILabel *sepLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, view.frame.size.width, 0.25f)];
    sepLabel.backgroundColor = COLOR_CHARACTERS_BLACKH;
    [view addSubview:sepLabel];
    
    ///根据是否已看房，创建不同的功能按钮
    if (isLooked) {
        
        ///按钮风格
        QSBlockButtonStyleModel *buttonStyle = [QSBlockButtonStyleModel createNormalButtonWithType:nNormalButtonTypeCornerYellow];
        
        ///免费通话按钮
        buttonStyle.title = TITLE_HOUSES_DETAIL_NEW_FREECALL;
        UIButton *callFreeButton = [UIButton createBlockButtonWithFrame:CGRectMake(SIZE_DEFAULT_MARGIN_LEFT_RIGHT, 8.0f, (view.frame.size.width - 3.0f * SIZE_DEFAULT_MARGIN_LEFT_RIGHT) / 2.0f, 44.0f) andButtonStyle:buttonStyle andCallBack:^(UIButton *button) {
            
            ///判断是否已登录
            
            
            ///已登录重新刷新数据
            
            
        }];
        [view addSubview:callFreeButton];
        
        ///我要看房按钮
        buttonStyle.title = TITLE_HOUSES_DETAIL_NEW_LOOKHOUSE;
        UIButton *lookHouseButton = [UIButton createBlockButtonWithFrame:CGRectMake(callFreeButton.frame.origin.x + callFreeButton.frame.size.width + SIZE_DEFAULT_MARGIN_LEFT_RIGHT, callFreeButton.frame.origin.y, callFreeButton.frame.size.width, callFreeButton.frame.size.height) andButtonStyle:buttonStyle andCallBack:^(UIButton *button) {
            
            
            
        }];
        [view addSubview:lookHouseButton];
        
    } else {
    
        ///按钮风格
        QSBlockButtonStyleModel *buttonStyel = [QSBlockButtonStyleModel createNormalButtonWithType:nNormalButtonTypeCornerYellow];
        
        ///免费通话按钮
        buttonStyel.title = TITLE_HOUSES_DETAIL_NEW_FREECALL;
        UIButton *callFreeButton = [UIButton createBlockButtonWithFrame:CGRectMake(SIZE_DEFAULT_MARGIN_LEFT_RIGHT, 8.0f, view.frame.size.width - 2.0f * SIZE_DEFAULT_MARGIN_LEFT_RIGHT, 44.0f) andButtonStyle:buttonStyel andCallBack:^(UIButton *button) {
            
            ///判断是否已登录
            
            
            ///已登录重新刷新数据
            
            
        }];
        [view addSubview:callFreeButton];
    
    }

}

#pragma mark - 显示信息UI:网络请求成功后才显示UI
///显示信息UI:网络请求成功后才显示UI
- (void)showInfoUI:(BOOL)flag
{
    
    UIView *mainInfoView = objc_getAssociatedObject(self, &MainInfoRootViewKey);
    UIView *bottomView = objc_getAssociatedObject(self, &BottomButtonRootViewKey);

    if (flag) {
        
        mainInfoView.hidden = NO;
        bottomView.hidden = NO;
        
    } else {
    
        mainInfoView.hidden = YES;
        bottomView.hidden = YES;
    
    }

}

#pragma mark - 创建数据UI：网络请求后，按数据创建不同的UI
///创建数据UI：网络请求后，按数据创建不同的UI
- (void)createNewDetailInfoViewUI:(QSNewHouseDetailDataModel *)dataModel
{
    
    ///信息底view
    UIScrollView *infoRootView = objc_getAssociatedObject(self, &MainInfoRootViewKey);
    
    ///清空原UI
    for (UIView *obj in [infoRootView subviews]) {
        
        [obj removeFromSuperview];
        
    }
    
    ///信息的起始y坐标，如果有广告，则会下移
    CGFloat startYPoint = SIZE_DEVICE_WIDTH * 253.0f / 750.0f;
    
    ///活动栏
    QSAutoScrollView *activityRootView = [[QSAutoScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SIZE_DEVICE_WIDTH, SIZE_DEVICE_WIDTH * 253.0f / 750.0f) andDelegate:self andScrollDirectionType:aAutoScrollDirectionTypeRightToLeft andShowPageIndex:NO andShowTime:3.0f andTapCallBack:^(id params) {
        
        NSLog(@"========================================");
        NSLog(@"点击活动:%@",params);
        NSLog(@"========================================");
        
    }];
    [infoRootView addSubview:activityRootView];
    
    ///头图片
    QSImageView *headerImageView = [[QSImageView alloc] initWithFrame:CGRectMake(0.0f, startYPoint, infoRootView.frame.size.width, infoRootView.frame.size.width * 562.0f / 750.0f)];
    headerImageView.backgroundColor = [UIColor orangeColor];
    [infoRootView addSubview:headerImageView];
    
    ///主信息边框
    CGFloat leftGap = SIZE_DEVICE_WIDTH > 320.0f ? 35.0f : 15.0f;
    ///主信息框的宽
    CGFloat mainInfoWidth = headerImageView.frame.size.width - 2.0f * leftGap;
    
    ///评分栏
    UIView *scoreRootView = [[UIView alloc] initWithFrame:CGRectMake(leftGap, headerImageView.frame.origin.y + headerImageView.frame.size.height - 45.0f, mainInfoWidth, 90.0f)];
    [self createScoreSubviews:scoreRootView];
    [infoRootView addSubview:scoreRootView];
    
    ///均价栏
    UIView *avgPriceRootView = [[UIView alloc] initWithFrame:CGRectMake(leftGap, scoreRootView.frame.origin.y + scoreRootView.frame.size.height + 15.0f, mainInfoWidth, 60.0f)];
    [self createAveragePriceSubviews:avgPriceRootView andAveragePrice:nil];
    [infoRootView addSubview:avgPriceRootView];
    
    ///特色标签
    UIView *featuresRootView = [[UIView alloc] initWithFrame:CGRectMake(leftGap, avgPriceRootView.frame.origin.y + avgPriceRootView.frame.size.height + 10.0f, mainInfoWidth, 20.0f)];
    [self createFeaturesSubviews:featuresRootView andDataSource:@"200301,200302,200303"];
    [infoRootView addSubview:featuresRootView];
    
    ///地址信息
    QSBlockView *addressRootView = [[QSBlockView alloc] initWithFrame:CGRectMake(leftGap, featuresRootView.frame.origin.y + featuresRootView.frame.size.height + 10.0f, mainInfoWidth, 20.0f) andSingleTapCallBack:^(BOOL flag) {
        
        ///进入地图：需要传经纬度
        NSLog(@"点击定位");
        
    }];
    [self createAddressSubviewsUI:addressRootView andDistriceID:@"" andStreetID:@"" andDetailAddress:@"城建大厦5楼" andCommunityInfo:@"碧桂园清泉城"];
    [infoRootView addSubview:addressRootView];
    
    ///分隔线
    UILabel *addressSepLine = [[UILabel alloc] initWithFrame:CGRectMake(leftGap, addressRootView.frame.origin.y + addressRootView.frame.size.height + 20.0f, mainInfoWidth, 0.25f)];
    addressSepLine.backgroundColor = COLOR_CHARACTERS_BLACKH;
    [infoRootView addSubview:addressSepLine];
    
    ///开盘信息
    UIView *openRootView = [[UIView alloc] initWithFrame:CGRectMake(leftGap, addressRootView.frame.origin.y + addressRootView.frame.size.height + 40.0f, mainInfoWidth, 65.0f)];
    [self createOpenedSubviewsUI:openRootView andOpenedType:[NSDate currentDateTimeStamp] andCheckInDate:[NSDate currentDateTimeStamp] andTradeType:@"" andDecoratorType:@"200202" andTotalPrice:@"3000000"];
    [infoRootView addSubview:openRootView];
    
    ///分隔线
    UILabel *openSepLine = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, mainInfoWidth, 0.25f)];
    openSepLine.backgroundColor = COLOR_CHARACTERS_BLACKH;
    
    ///另起底view，方便详情信息展开与收缩
    UIView *secondRootView = [[UIView alloc] initWithFrame:CGRectMake(leftGap, openRootView.frame.origin.y + openRootView.frame.size.height, mainInfoWidth, 60.0f)];
    
    ///户型信息
    QSScrollView *houseTypeRootView = [[QSScrollView alloc] initWithFrame:CGRectMake(0.0f, 20.0f, mainInfoWidth, 75.0f)];
    [self createHouseTypeInfoUI:houseTypeRootView];
    
    ///分隔线
    UILabel *houseTypeSepLine = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, houseTypeRootView.frame.origin.y + houseTypeRootView.frame.size.height + 20.0f, mainInfoWidth, 0.25f)];
    houseTypeSepLine.backgroundColor = COLOR_CHARACTERS_BLACKH;
    
    ///贷款说明信息
    QSBlockView *provideRootView = [[QSBlockView alloc] initWithFrame:CGRectMake(0.0f, houseTypeRootView.frame.origin.y + houseTypeRootView.frame.size.height + 40.0f, mainInfoWidth, 70.0f) andSingleTapCallBack:^(BOOL flag) {
        
        ///进入计算器页面
        NSLog(@"月供参考");
        
    }];
    [self createProvideInfoUI:provideRootView];
    
    ///分隔线
    UILabel *provideSepLine = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, provideRootView.frame.origin.y + provideRootView.frame.size.height + 20.0f, mainInfoWidth, 0.25f)];
    provideSepLine.backgroundColor = COLOR_CHARACTERS_BLACKH;
    
    ///税金参考
    QSBlockView *taxRootView = [[QSBlockView alloc] initWithFrame:CGRectMake(0.0f, provideRootView.frame.origin.y + provideRootView.frame.size.height + 40.0f, mainInfoWidth, 70.0f) andSingleTapCallBack:^(BOOL flag) {
        
        ///进入税金计算页面
        NSLog(@"税金参考");
        
    }];
    [self createTaxInfoUI:taxRootView];
    
    ///分隔线
    UILabel *taxSepLine = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, taxRootView.frame.origin.y + taxRootView.frame.size.height + 20.0f, mainInfoWidth, 0.25f)];
    taxSepLine.backgroundColor = COLOR_CHARACTERS_BLACKH;
    
    ///价格走向
    UIView *priceLineRootView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, taxRootView.frame.origin.y + taxRootView.frame.size.height + 40.0f, mainInfoWidth, 185.0f)];
    [self createPriceTrendInfoUI:priceLineRootView];
    
    ///分隔线
    UILabel *priceLineSepLine = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, priceLineRootView.frame.origin.y + priceLineRootView.frame.size.height + 20.0f, mainInfoWidth, 0.25f)];
    priceLineSepLine.backgroundColor = COLOR_CHARACTERS_BLACKH;
    
    ///其他信息
    QSBlockView *otherInfoRootView = [[QSBlockView alloc] initWithFrame:CGRectMake(0.0f, priceLineRootView.frame.origin.y + priceLineRootView.frame.size.height + 40.0f, mainInfoWidth, 65.0f) andSingleTapCallBack:^(BOOL flag) {
        
        ///进入更多配套信息页面
        NSLog(@"配套信息");
        
    }];
    [self createOtherInstallationInfoUI:otherInfoRootView];
    
    ///将其他信息view加载到第二底view上
    [secondRootView addSubview:openSepLine];
    [secondRootView addSubview:houseTypeRootView];
    [secondRootView addSubview:houseTypeSepLine];
    [secondRootView addSubview:provideRootView];
    [secondRootView addSubview:provideSepLine];
    [secondRootView addSubview:taxRootView];
    [secondRootView addSubview:taxSepLine];
    [secondRootView addSubview:priceLineRootView];
    [secondRootView addSubview:priceLineSepLine];
    [secondRootView addSubview:otherInfoRootView];
    
    [infoRootView addSubview:secondRootView];
    objc_setAssociatedObject(self, &SecondInfoRootViewKey, secondRootView, OBJC_ASSOCIATION_ASSIGN);
    
    ///第二个view的总高
    CGFloat secondViewHeight = otherInfoRootView.frame.origin.y + otherInfoRootView.frame.size.height;
    secondRootView.frame = CGRectMake(secondRootView.frame.origin.x, secondRootView.frame.origin.y, secondRootView.frame.size.width, secondViewHeight);
    
    ///判断滚动尺寸
    if ((secondRootView.frame.origin.y + secondViewHeight + 10.0f) > infoRootView.frame.size.height) {
        
        infoRootView.contentSize = CGSizeMake(infoRootView.frame.size.width, (secondRootView.frame.origin.y + secondViewHeight + 10.0f));
        
    }

}

#pragma mark - 其他配套信息的UI
///其他配套信息的UI
- (void)createOtherInstallationInfoUI:(UIView *)view
{
    
    ///间隙
    CGFloat width = 60.0f;
    CGFloat gap = (view.frame.size.width - width * 4.0f - 26.0f) / 3.0f;

    ///公交路线
    UILabel *busLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 30.0f, width, 15.0f)];
    busLabel.text = @"公交线路";
    busLabel.textAlignment = NSTextAlignmentCenter;
    busLabel.textColor = COLOR_CHARACTERS_GRAY;
    busLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:busLabel];
    
    UILabel *busCountLable = [[UILabel alloc] initWithFrame:CGRectMake(busLabel.frame.origin.x, 0.0f, width / 2.0f + 5.0f, 25.0f)];
    busCountLable.text = @"28";
    busCountLable.textAlignment = NSTextAlignmentRight;
    busCountLable.font = [UIFont boldSystemFontOfSize:FONT_BODY_18];
    busCountLable.textColor = COLOR_CHARACTERS_YELLOW;
    [view addSubview:busCountLable];
    
    UILabel *busCountUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake(busCountLable.frame.origin.x + busCountLable.frame.size.width, 9.0f, 15.0f, 10.0f)];
    busCountUnitLabel.text = @"条";
    busCountUnitLabel.textAlignment = NSTextAlignmentLeft;
    busCountUnitLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_14];
    busCountUnitLabel.textColor = COLOR_CHARACTERS_GRAY;
    [view addSubview:busCountUnitLabel];
    
    ///分隔线
    UILabel *busSepLine = [[UILabel alloc] initWithFrame:CGRectMake(busLabel.frame.origin.x + busLabel.frame.size.width + gap / 2.0f, 0.0f, 0.25f, view.frame.size.height - 20.0f)];
    busSepLine.backgroundColor = COLOR_CHARACTERS_BLACKH;
    [view addSubview:busSepLine];
    
    ///教育机构
    UILabel *techLabel = [[UILabel alloc] initWithFrame:CGRectMake(width + gap, 30.0f, width, 15.0f)];
    techLabel.text = @"教育机构";
    techLabel.textAlignment = NSTextAlignmentCenter;
    techLabel.textColor = COLOR_CHARACTERS_GRAY;
    techLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:techLabel];
    
    UILabel *techCountLable = [[UILabel alloc] initWithFrame:CGRectMake(techLabel.frame.origin.x, 0.0f, width / 2.0f + 5.0f, 25.0f)];
    techCountLable.text = @"28";
    techCountLable.textAlignment = NSTextAlignmentRight;
    techCountLable.font = [UIFont boldSystemFontOfSize:FONT_BODY_18];
    techCountLable.textColor = COLOR_CHARACTERS_YELLOW;
    [view addSubview:techCountLable];
    
    UILabel *techCountUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake(techCountLable.frame.origin.x + techCountLable.frame.size.width, 9.0f, 15.0f, 10.0f)];
    techCountUnitLabel.text = @"间";
    techCountUnitLabel.textAlignment = NSTextAlignmentLeft;
    techCountUnitLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_14];
    techCountUnitLabel.textColor = COLOR_CHARACTERS_GRAY;
    [view addSubview:techCountUnitLabel];
    
    ///分隔线
    UILabel *techSepLine = [[UILabel alloc] initWithFrame:CGRectMake(techLabel.frame.origin.x + techLabel.frame.size.width + gap / 2.0f, 0.0f, 0.25f, view.frame.size.height - 20.0f)];
    techSepLine.backgroundColor = COLOR_CHARACTERS_BLACKH;
    [view addSubview:techSepLine];
    
    ///医疗机构
    UILabel *medicalLabel = [[UILabel alloc] initWithFrame:CGRectMake(2.0f * (width + gap), 30.0f, width, 15.0f)];
    medicalLabel.text = @"医疗机构";
    medicalLabel.textAlignment = NSTextAlignmentCenter;
    medicalLabel.textColor = COLOR_CHARACTERS_GRAY;
    medicalLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:medicalLabel];
    
    UILabel *medicalCountLable = [[UILabel alloc] initWithFrame:CGRectMake(medicalLabel.frame.origin.x, 0.0f, width / 2.0f + 5.0f, 25.0f)];
    medicalCountLable.text = @"28";
    medicalCountLable.textAlignment = NSTextAlignmentRight;
    medicalCountLable.font = [UIFont boldSystemFontOfSize:FONT_BODY_18];
    medicalCountLable.textColor = COLOR_CHARACTERS_YELLOW;
    [view addSubview:medicalCountLable];
    
    UILabel *medicalCountUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake(medicalCountLable.frame.origin.x + medicalCountLable.frame.size.width, 9.0f, 15.0f, 10.0f)];
    medicalCountUnitLabel.text = @"间";
    medicalCountUnitLabel.textAlignment = NSTextAlignmentLeft;
    medicalCountUnitLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_14];
    medicalCountUnitLabel.textColor = COLOR_CHARACTERS_GRAY;
    [view addSubview:medicalCountUnitLabel];
    
    ///分隔线
    UILabel *medicalSepLine = [[UILabel alloc] initWithFrame:CGRectMake(medicalLabel.frame.origin.x + medicalLabel.frame.size.width + gap / 2.0f, 0.0f, 0.25f, view.frame.size.height - 20.0f)];
    medicalSepLine.backgroundColor = COLOR_CHARACTERS_BLACKH;
    [view addSubview:medicalSepLine];
    
    ///餐饮娱乐
    UILabel *foodLabel = [[UILabel alloc] initWithFrame:CGRectMake(3.0f * (width + gap), 30.0f, width, 15.0f)];
    foodLabel.text = @"餐饮娱乐";
    foodLabel.textAlignment = NSTextAlignmentCenter;
    foodLabel.textColor = COLOR_CHARACTERS_GRAY;
    foodLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:foodLabel];
    
    UILabel *foodCountLable = [[UILabel alloc] initWithFrame:CGRectMake(foodLabel.frame.origin.x, 0.0f, width / 2.0f + 5.0f, 25.0f)];
    foodCountLable.text = @"128";
    foodCountLable.textAlignment = NSTextAlignmentRight;
    foodCountLable.font = [UIFont boldSystemFontOfSize:FONT_BODY_18];
    foodCountLable.textColor = COLOR_CHARACTERS_YELLOW;
    [view addSubview:foodCountLable];
    
    UILabel *foodCountUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake(foodCountLable.frame.origin.x + foodCountLable.frame.size.width, 9.0f, 15.0f, 10.0f)];
    foodCountUnitLabel.text = @"个";
    foodCountUnitLabel.textAlignment = NSTextAlignmentLeft;
    foodCountUnitLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_14];
    foodCountUnitLabel.textColor = COLOR_CHARACTERS_GRAY;
    [view addSubview:foodCountUnitLabel];
    
    ///右侧箭头
    QSImageView *arrowView = [[QSImageView alloc] initWithFrame:CGRectMake(view.frame.size.width - 13.0f - 8.0f, view.frame.size.height / 2.0f - 11.5f, 13.0f, 23.0f)];
    arrowView.image = [UIImage imageNamed:IMAGE_PUBLIC_RIGHT_ARROW];
    [view addSubview:arrowView];

}

#pragma mark - 价格走向图UI
///价格走向图UI
- (void)createPriceTrendInfoUI:(UIView *)view
{

    ///标题
    UILabel *consultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 8.0f, 85.0f, 15.0f)];
    consultLabel.text = @"小区房价走势";
    consultLabel.textColor = COLOR_CHARACTERS_BLACK;
    consultLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_14];
    [view addSubview:consultLabel];
    
    ///最新价格
    UILabel *newPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width - 95.0f - 35.0f - 60.0f, 8.0f, 60.0f, 15.0f)];
    newPriceLabel.text = @"最新均价";
    newPriceLabel.textColor = COLOR_CHARACTERS_BLACK;
    newPriceLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_14];
    [view addSubview:newPriceLabel];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width - 95.0f - 35.0f, 0.0f, 95.0f, 25.0f)];
    priceLabel.text = @"122451.45";
    priceLabel.textColor = COLOR_CHARACTERS_YELLOW;
    priceLabel.textAlignment = NSTextAlignmentRight;
    priceLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_20];
    [view addSubview:priceLabel];
    
    ///单位
    UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width - 30.0f, 9.0f, 35.0f, 10.0f)];
    unitLabel.text = [NSString stringWithFormat:@"元/%@",APPLICATION_AREAUNIT];
    unitLabel.textAlignment = NSTextAlignmentLeft;
    unitLabel.textColor = COLOR_CHARACTERS_BLACK;
    unitLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_14];
    [view addSubview:unitLabel];

}

#pragma mark - 税金信息UI
///税金信息UI
- (void)createTaxInfoUI:(UIView *)view
{

    ///税金参考
    UILabel *consultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 8.0f, 70.0f, 15.0f)];
    consultLabel.text = @"税金参考：";
    consultLabel.textColor = COLOR_CHARACTERS_BLACK;
    consultLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_14];
    [view addSubview:consultLabel];
    
    ///税金
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(consultLabel.frame.size.width, 0.0f, 95.0f, 25.0f)];
    priceLabel.text = @"122451.45";
    priceLabel.textColor = COLOR_CHARACTERS_YELLOW;
    priceLabel.textAlignment = NSTextAlignmentRight;
    priceLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_20];
    [view addSubview:priceLabel];
    
    ///单位
    UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(priceLabel.frame.origin.x + priceLabel.frame.size.width + 2.0f, 9.0f, 15.0f, 10.0f)];
    unitLabel.text = @"元";
    unitLabel.textAlignment = NSTextAlignmentLeft;
    unitLabel.textColor = COLOR_CHARACTERS_BLACK;
    unitLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_14];
    [view addSubview:unitLabel];
    
    ///最长宽度
    CGFloat width = (view.frame.size.width - 10.0f - 26.0f) / 2.0f;
    
    ///契税
    UILabel *referencePriceTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, priceLabel.frame.origin.y + priceLabel.frame.size.height + 10.0f, 50.0f, 15.0f)];
    referencePriceTipsLabel.text = @"契税：";
    referencePriceTipsLabel.textColor = COLOR_CHARACTERS_GRAY;
    referencePriceTipsLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:referencePriceTipsLabel];
    
    UILabel *referencePriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(referencePriceTipsLabel.frame.origin.x + referencePriceTipsLabel.frame.size.width, referencePriceTipsLabel.frame.origin.y, width - referencePriceTipsLabel.frame.size.width, 15.0f)];
    referencePriceLabel.text = @"3200元";
    referencePriceLabel.textColor = COLOR_CHARACTERS_BLACK;
    referencePriceLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_14];
    [view addSubview:referencePriceLabel];
    
    ///公证费
    UILabel *priovideTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(width + 5.0f, referencePriceTipsLabel.frame.origin.y, 60.0f, 15.0f)];
    priovideTipsLabel.text = @"公证费：";
    priovideTipsLabel.textColor = COLOR_CHARACTERS_GRAY;
    priovideTipsLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:priovideTipsLabel];
    
    UILabel *priovideLabel = [[UILabel alloc] initWithFrame:CGRectMake(priovideTipsLabel.frame.origin.x + priovideTipsLabel.frame.size.width, priovideTipsLabel.frame.origin.y, width - priovideTipsLabel.frame.size.width, 15.0f)];
    priovideLabel.text = @"320元";
    priovideLabel.textColor = COLOR_CHARACTERS_BLACK;
    priovideLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_14];
    [view addSubview:priovideLabel];
    
    ///印花税
    UILabel *rateTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, referencePriceTipsLabel.frame.origin.y + referencePriceTipsLabel.frame.size.height + 5.0f, 60.0f, 15.0f)];
    rateTipsLabel.text = @"印花税：";
    rateTipsLabel.textColor = COLOR_CHARACTERS_GRAY;
    rateTipsLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:rateTipsLabel];
    
    UILabel *rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(rateTipsLabel.frame.origin.x + rateTipsLabel.frame.size.width, rateTipsLabel.frame.origin.y, width - rateTipsLabel.frame.size.width, 15.0f)];
    rateLabel.text = @"876元";
    rateLabel.textColor = COLOR_CHARACTERS_BLACK;
    rateLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_14];
    [view addSubview:rateLabel];
    
    ///产权手续
    UILabel *downPayTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(width + 5.0f, rateTipsLabel.frame.origin.y, 70.0f, 15.0f)];
    downPayTipsLabel.text = @"产权手续：";
    downPayTipsLabel.textColor = COLOR_CHARACTERS_GRAY;
    downPayTipsLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:downPayTipsLabel];
    
    UILabel *downPayLabel = [[UILabel alloc] initWithFrame:CGRectMake(downPayTipsLabel.frame.origin.x + downPayTipsLabel.frame.size.width, downPayTipsLabel.frame.origin.y, width - downPayTipsLabel.frame.size.width, 15.0f)];
    downPayLabel.text = @"3600元";
    downPayLabel.textColor = COLOR_CHARACTERS_BLACK;
    downPayLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_14];
    [view addSubview:downPayLabel];
    
    ///右侧箭头
    QSImageView *arrowView = [[QSImageView alloc] initWithFrame:CGRectMake(view.frame.size.width - 13.0f - 8.0f, view.frame.size.height / 2.0f - 11.5f, 13.0f, 23.0f)];
    arrowView.image = [UIImage imageNamed:IMAGE_PUBLIC_RIGHT_ARROW];
    [view addSubview:arrowView];

}

#pragma mark - 代款信息UI
///代款信息UI
- (void)createProvideInfoUI:(UIView *)view
{

    ///月供参考
    UILabel *consultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 8.0f, 70.0f, 15.0f)];
    consultLabel.text = @"月供参考：";
    consultLabel.textColor = COLOR_CHARACTERS_BLACK;
    consultLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_14];
    [view addSubview:consultLabel];
    
    ///月供
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(consultLabel.frame.size.width, 0.0f, 95.0f, 25.0f)];
    priceLabel.text = @"122451.45";
    priceLabel.textColor = COLOR_CHARACTERS_YELLOW;
    priceLabel.textAlignment = NSTextAlignmentRight;
    priceLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_20];
    [view addSubview:priceLabel];
    
    ///单位
    UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(priceLabel.frame.origin.x + priceLabel.frame.size.width + 2.0f, 9.0f, 15.0f, 10.0f)];
    unitLabel.text = @"元";
    unitLabel.textAlignment = NSTextAlignmentLeft;
    unitLabel.textColor = COLOR_CHARACTERS_BLACK;
    unitLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_14];
    [view addSubview:unitLabel];
    
    ///最长宽度
    CGFloat width = (view.frame.size.width - 10.0f - 26.0f) / 2.0f;
    
    ///参考格价
    UILabel *referencePriceTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, priceLabel.frame.origin.y + priceLabel.frame.size.height + 10.0f, 70.0f, 15.0f)];
    referencePriceTipsLabel.text = @"参考价格：";
    referencePriceTipsLabel.textColor = COLOR_CHARACTERS_GRAY;
    referencePriceTipsLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:referencePriceTipsLabel];
    
    UILabel *referencePriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(referencePriceTipsLabel.frame.origin.x + referencePriceTipsLabel.frame.size.width, referencePriceTipsLabel.frame.origin.y, width - referencePriceTipsLabel.frame.size.width, 15.0f)];
    referencePriceLabel.text = @"1200万";
    referencePriceLabel.textColor = COLOR_CHARACTERS_BLACK;
    referencePriceLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_14];
    [view addSubview:referencePriceLabel];
    
    ///贷款七成
    UILabel *priovideTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(width + 5.0f, referencePriceTipsLabel.frame.origin.y, 70.0f, 15.0f)];
    priovideTipsLabel.text = @"代款7成：";
    priovideTipsLabel.textColor = COLOR_CHARACTERS_GRAY;
    priovideTipsLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:priovideTipsLabel];
    
    UILabel *priovideLabel = [[UILabel alloc] initWithFrame:CGRectMake(priovideTipsLabel.frame.origin.x + priovideTipsLabel.frame.size.width, priovideTipsLabel.frame.origin.y, width - priovideTipsLabel.frame.size.width, 15.0f)];
    priovideLabel.text = @"840万";
    priovideLabel.textColor = COLOR_CHARACTERS_BLACK;
    priovideLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_14];
    [view addSubview:priovideLabel];
    
    ///利率
    UILabel *rateTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, referencePriceTipsLabel.frame.origin.y + referencePriceTipsLabel.frame.size.height + 5.0f, 72.0f, 15.0f)];
    rateTipsLabel.text = @"利       率：";
    rateTipsLabel.textColor = COLOR_CHARACTERS_GRAY;
    rateTipsLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:rateTipsLabel];
    
    UILabel *rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(rateTipsLabel.frame.origin.x + rateTipsLabel.frame.size.width, rateTipsLabel.frame.origin.y, width - rateTipsLabel.frame.size.width, 15.0f)];
    rateLabel.text = @"6.15%";
    rateLabel.textColor = COLOR_CHARACTERS_BLACK;
    rateLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_14];
    [view addSubview:rateLabel];
    
    ///参考格价
    UILabel *downPayTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(width + 5.0f, rateTipsLabel.frame.origin.y, 70.0f, 15.0f)];
    downPayTipsLabel.text = @"首付3成：";
    downPayTipsLabel.textColor = COLOR_CHARACTERS_GRAY;
    downPayTipsLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:downPayTipsLabel];
    
    UILabel *downPayLabel = [[UILabel alloc] initWithFrame:CGRectMake(downPayTipsLabel.frame.origin.x + downPayTipsLabel.frame.size.width, downPayTipsLabel.frame.origin.y, width - downPayTipsLabel.frame.size.width, 15.0f)];
    downPayLabel.text = @"360万";
    downPayLabel.textColor = COLOR_CHARACTERS_BLACK;
    downPayLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_14];
    [view addSubview:downPayLabel];
    
    ///右侧箭头
    QSImageView *arrowView = [[QSImageView alloc] initWithFrame:CGRectMake(view.frame.size.width - 13.0f - 8.0f, view.frame.size.height / 2.0f - 11.5f, 13.0f, 23.0f)];
    arrowView.image = [UIImage imageNamed:IMAGE_PUBLIC_RIGHT_ARROW];
    [view addSubview:arrowView];

}

#pragma mark - 户型信息UI
///户型信息UI
- (void)createHouseTypeInfoUI:(QSScrollView *)view
{
    
    ///每个控件的宽度
    CGFloat width = 50.0f;
    ///每个户型信息项之间的间隙
    CGFloat gap = 30.0f;
    ///总的户型信息个数
    int sum = 6;
    
    ///循环创建户型信息
    for (int i = 0; i < sum; i++) {
        
        ///底图
        QSImageView *sixFormImage = [[QSImageView alloc] initWithFrame:CGRectMake(i * (width + gap), 0.0f, width, 55.0f)];
        sixFormImage.image = [UIImage imageNamed:IMAGE_HOUSES_DETAIL_HOUSETYPE_SIXFORM];
        [view addSubview:sixFormImage];
        
        ///主标题信息
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(2.0f, 12.5f, sixFormImage.frame.size.width - 6.0f - 15.0f, 30.0f)];
        titleLabel.text = @"124";
        titleLabel.textAlignment = NSTextAlignmentRight;
        titleLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_16];
        titleLabel.textColor = COLOR_CHARACTERS_BLACK;
        [sixFormImage addSubview:titleLabel];
        
        ///单位
        UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x + titleLabel.frame.size.width, titleLabel.frame.origin.y + titleLabel.frame.size.height - 19.0f, 15.0f, 10.0f)];
        unitLabel.text = APPLICATION_AREAUNIT;
        unitLabel.textAlignment = NSTextAlignmentLeft;
        unitLabel.textColor = COLOR_CHARACTERS_BLACK;
        unitLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
        [sixFormImage addSubview:unitLabel];
        
        ///说明信息
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(sixFormImage.frame.origin.x, sixFormImage.frame.origin.y + sixFormImage.frame.size.height + 5.0f, sixFormImage.frame.size.width, 15.0f)];
        infoLabel.textAlignment = NSTextAlignmentCenter;
        infoLabel.text = @"3室2厅";
        infoLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
        infoLabel.adjustsFontSizeToFitWidth = YES;
        infoLabel.textColor = COLOR_CHARACTERS_GRAY;
        [view addSubview:infoLabel];
        
    }
    
    ///判断是否需要开启滚动
    if ((width * sum + gap * (sum - 1)) > view.frame.size.width) {
        
        view.contentSize = CGSizeMake((width * sum + gap * (sum - 1)) + 10.0f, view.frame.size.height);
        
    }

}

#pragma mark - 开盘等信息UI
///开盘等信息UI
- (void)createOpenedSubviewsUI:(UIView *)view andOpenedType:(NSString *)openedTime andCheckInDate:(NSString *)checkInData andTradeType:(NSString *)tradeType andDecoratorType:(NSString *)decType andTotalPrice:(NSString *)totalPrice
{
    
    ///暂时的底view
    __block UIView *tempRootView = view;
    
    ///最大宽度
    CGFloat infoWidth = (view.frame.size.width - 50.0f) / 2.0f;
    CGFloat width = 45.0f;
    CGFloat height = 15.0f;

    ///开盘日期
    UILabel *openTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, width, height)];
    openTipsLabel.text = @"开盘：";
    openTipsLabel.textColor = COLOR_CHARACTERS_BLACK;
    openTipsLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [tempRootView addSubview:openTipsLabel];
    
    UILabel *openTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(width, 0.0f, infoWidth - width - 5.0f, height)];
    openTimeLabel.text = [[NSDate formatNSTimeToNSDateString:openedTime] substringToIndex:10];
    openTimeLabel.textColor = COLOR_CHARACTERS_BLACK;
    openTimeLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [tempRootView addSubview:openTimeLabel];
    
    ///入住日期
    UILabel *checkInTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(infoWidth + 5.0f, 0.0f, width, height)];
    checkInTipsLabel.text = @"入住：";
    checkInTipsLabel.textColor = COLOR_CHARACTERS_BLACK;
    checkInTipsLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [tempRootView addSubview:checkInTipsLabel];
    
    UILabel *checkInTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(checkInTipsLabel.frame.origin.x + checkInTipsLabel.frame.size.width, checkInTipsLabel.frame.origin.y, infoWidth - width - 5.0f, height)];
    checkInTimeLabel.text = [[NSDate formatNSTimeToNSDateString:checkInData] substringToIndex:10];
    checkInTimeLabel.textColor = COLOR_CHARACTERS_BLACK;
    checkInTimeLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [tempRootView addSubview:checkInTimeLabel];
    
    ///商业类型
    UILabel *tradeTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, openTipsLabel.frame.size.height + 5.0f, width, height)];
    tradeTipsLabel.text = @"类型：";
    tradeTipsLabel.textColor = COLOR_CHARACTERS_BLACK;
    tradeTipsLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [tempRootView addSubview:tradeTipsLabel];
    
    UILabel *tradeTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(openTipsLabel.frame.size.width, tradeTipsLabel.frame.origin.y, infoWidth - tradeTipsLabel.frame.size.width - 5.0f, tradeTipsLabel.frame.size.height)];
    tradeTimeLabel.text = @"商用/住宅";
    tradeTimeLabel.textColor = COLOR_CHARACTERS_BLACK;
    tradeTimeLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [tempRootView addSubview:tradeTimeLabel];
    
    ///装修类型
    UILabel *decoratorTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(infoWidth + 5.0f, tradeTipsLabel.frame.origin.y, width, height)];
    decoratorTipsLabel.text = @"装修：";
    decoratorTipsLabel.textColor = COLOR_CHARACTERS_BLACK;
    decoratorTipsLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [tempRootView addSubview:decoratorTipsLabel];
    
    UILabel *decoratorTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(decoratorTipsLabel.frame.origin.x + decoratorTipsLabel.frame.size.width, decoratorTipsLabel.frame.origin.y, infoWidth - decoratorTipsLabel.frame.size.width - 5.0f, decoratorTipsLabel.frame.size.height)];
    decoratorTimeLabel.text = [QSCoreDataManager getHouseDecorationTypeWithKey:decType];
    decoratorTimeLabel.textColor = COLOR_CHARACTERS_BLACK;
    decoratorTimeLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [tempRootView addSubview:decoratorTimeLabel];
    
    ///计算器
    UIImageView *calculatorImage = [QSImageView createBlockImageViewWithFrame:CGRectMake(view.frame.size.width - 35.0f, 0.0f, 35.0f, 35.0f) andSingleTapCallBack:^{
        
        NSLog(@"点击计算器");
        
    }];
    calculatorImage.image = [UIImage imageNamed:IMAGE_PUBLIC_CALCULATOR_NORMAL];
    [tempRootView addSubview:calculatorImage];
    
    ///展开标记
    __block BOOL isShowMore = NO;
    
    ///更多信息的底view指针
    __block UIView *moreInfoRootView = nil;
    
    ///展开按钮
    UIButton *moreButton = [UIButton createBlockButtonWithFrame:CGRectMake(view.frame.size.width / 2.0f - 15.0f, view.frame.size.height - 30.0f, 30.0f, 30.0f) andButtonStyle:nil andCallBack:^(UIButton *button) {
        
        ///其他信息底view
        UIView *secondRootView = objc_getAssociatedObject(self, &SecondInfoRootViewKey);
        
        ///修改滚动高度
        UIScrollView *infoRootView = objc_getAssociatedObject(self, &MainInfoRootViewKey);
        
        if (isShowMore) {
            
            ///收缩
            if (moreInfoRootView) {
                
                [moreInfoRootView removeFromSuperview];
                
            }
            
            ///修改滚动尺寸
            infoRootView.contentSize = CGSizeMake(infoRootView.frame.size.width, infoRootView.contentSize.height - 130.0f);
            
            ///动画收缩
            [UIView animateWithDuration:0.3f animations:^{
                
                secondRootView.frame = CGRectMake(secondRootView.frame.origin.x, secondRootView.frame.origin.y - 130.0f, secondRootView.frame.size.width, secondRootView.frame.size.height);
                tempRootView.frame = CGRectMake(tempRootView.frame.origin.x, tempRootView.frame.origin.y, tempRootView.frame.size.width, tempRootView.frame.size.height - 130.0f);
                
                ///按钮也同步位置
                button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y - 130.0f, button.frame.size.width, button.frame.size.height);
                
                ///恢复按钮
                button.transform = CGAffineTransformIdentity;
                
            } completion:^(BOOL finished) {
                
                ///将展开状态改为YES
                if (finished) {
                    
                    isShowMore = NO;
                    
                }
                
            }];
            
        } else {
            
            ///展开
            if (moreInfoRootView) {
            
                [moreInfoRootView removeFromSuperview];
                
            }
            
            moreInfoRootView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 55.0f, tempRootView.frame.size.width, 90.0f)];
            [self createMoreDetailInfo:moreInfoRootView];
            [tempRootView addSubview:moreInfoRootView];
            
            ///修改滚动尺寸
            infoRootView.contentSize = CGSizeMake(infoRootView.frame.size.width, infoRootView.contentSize.height + 130.0f);
            
            ///动画展开
            [UIView animateWithDuration:0.3f animations:^{
                
                secondRootView.frame = CGRectMake(secondRootView.frame.origin.x, secondRootView.frame.origin.y + 130.0f, secondRootView.frame.size.width, secondRootView.frame.size.height);
                tempRootView.frame = CGRectMake(tempRootView.frame.origin.x, tempRootView.frame.origin.y, tempRootView.frame.size.width, tempRootView.frame.size.height + 130.0f);
                
                ///按钮也同步位置
                button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y + 130.0f, button.frame.size.width, button.frame.size.height);
                
                ///按钮旋转180
                button.transform = CGAffineTransformMakeRotation(M_PI);
                
            } completion:^(BOOL finished) {
                
                ///将展开状态改为YES
                if (finished) {
                    
                    isShowMore = YES;
                    
                }
                
            }];
            
        }
        
    }];
    [moreButton setImage:[UIImage imageNamed:IMAGE_PUBLIC_ARROW_60X60_NORMAL] forState:UIControlStateNormal];
    [moreButton setImage:[UIImage imageNamed:IMAGE_PUBLIC_ARROW_60X60_HIGHLIGHTED] forState:UIControlStateHighlighted];
    [view addSubview:moreButton];

}

///更多详情信息
- (void)createMoreDetailInfo:(UIView *)view
{
    
    CGFloat infoWidth = (view.frame.size.width - 50.0f) / 2.0f;
    CGFloat height = 15.0f;

    ///占地面积
    UILabel *areaTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 70.0f, height)];
    areaTipsLabel.text = @"占地面积：";
    areaTipsLabel.textColor = COLOR_CHARACTERS_BLACK;
    areaTipsLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:areaTipsLabel];
    
    UILabel *areaInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(areaTipsLabel.frame.origin.x + areaTipsLabel.frame.size.width, areaTipsLabel.frame.origin.y, infoWidth - areaTipsLabel.frame.size.width - 5.0f, areaTipsLabel.frame.size.height)];
    areaInfoLabel.text = [NSString stringWithFormat:@"1.7万/%@",APPLICATION_AREAUNIT];
    areaInfoLabel.textColor = COLOR_CHARACTERS_BLACK;
    areaInfoLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:areaInfoLabel];
    
    ///建筑面积
    UILabel *buildAreaTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(infoWidth + 5.0f, 0.0f, 70.0f, height)];
    buildAreaTipsLabel.text = @"建筑面积：";
    buildAreaTipsLabel.textColor = COLOR_CHARACTERS_BLACK;
    buildAreaTipsLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:buildAreaTipsLabel];
    
    UILabel *buildAreaInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(buildAreaTipsLabel.frame.origin.x + buildAreaTipsLabel.frame.size.width, buildAreaTipsLabel.frame.origin.y, infoWidth - 5.0f - buildAreaTipsLabel.frame.size.width, buildAreaTipsLabel.frame.size.height)];
    buildAreaInfoLabel.text = [NSString stringWithFormat:@"1.7万/%@",APPLICATION_AREAUNIT];
    buildAreaInfoLabel.textColor = COLOR_CHARACTERS_BLACK;
    buildAreaInfoLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:buildAreaInfoLabel];
    
    ///住户数
    UILabel *housesNumTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, areaTipsLabel.frame.origin.y + areaTipsLabel.frame.size.height + 5.0f, 60.0f, height)];
    housesNumTipsLabel.text = @"住户数：";
    housesNumTipsLabel.textColor = COLOR_CHARACTERS_BLACK;
    housesNumTipsLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:housesNumTipsLabel];
    
    UILabel *housesNumInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(housesNumTipsLabel.frame.origin.x + housesNumTipsLabel.frame.size.width, housesNumTipsLabel.frame.origin.y, infoWidth - 5.0f - housesNumTipsLabel.frame.size.width, housesNumTipsLabel.frame.size.height)];
    housesNumInfoLabel.text = @"1555户";
    housesNumInfoLabel.textColor = COLOR_CHARACTERS_BLACK;
    housesNumInfoLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:housesNumInfoLabel];
    
    ///停车位
    UILabel *partNumTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(infoWidth + 5.0f, housesNumInfoLabel.frame.origin.y, 60.0f, height)];
    partNumTipsLabel.text = @"停车位：";
    partNumTipsLabel.textColor = COLOR_CHARACTERS_BLACK;
    partNumTipsLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:partNumTipsLabel];
    
    UILabel *partNumInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(partNumTipsLabel.frame.origin.x + partNumTipsLabel.frame.size.width, partNumTipsLabel.frame.origin.y, infoWidth - 5.0f - partNumTipsLabel.frame.size.width, partNumTipsLabel.frame.size.height)];
    partNumInfoLabel.text = @"555位";
    partNumInfoLabel.textColor = COLOR_CHARACTERS_BLACK;
    partNumInfoLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:partNumInfoLabel];
    
    ///容积率
    UILabel *volumeTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, housesNumTipsLabel.frame.origin.y + housesNumTipsLabel.frame.size.height + 5.0f, 60.0f, height)];
    volumeTipsLabel.text = @"容积率：";
    volumeTipsLabel.textColor = COLOR_CHARACTERS_BLACK;
    volumeTipsLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:volumeTipsLabel];
    
    UILabel *volumeInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(volumeTipsLabel.frame.origin.x + volumeTipsLabel.frame.size.width, volumeTipsLabel.frame.origin.y, infoWidth - 5.0f - volumeTipsLabel.frame.size.width, volumeTipsLabel.frame.size.height)];
    volumeInfoLabel.text = @"3%";
    volumeInfoLabel.textColor = COLOR_CHARACTERS_BLACK;
    volumeInfoLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:volumeInfoLabel];
    
    ///绿化率
    UILabel *greenTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(infoWidth + 5.0f, volumeTipsLabel.frame.origin.y, 60.0f, height)];
    greenTipsLabel.text = @"绿化率：";
    greenTipsLabel.textColor = COLOR_CHARACTERS_BLACK;
    greenTipsLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:greenTipsLabel];
    
    UILabel *greenInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(greenTipsLabel.frame.origin.x + greenTipsLabel.frame.size.width, greenTipsLabel.frame.origin.y, infoWidth - 5.0f - greenTipsLabel.frame.size.width, greenTipsLabel.frame.size.height)];
    greenInfoLabel.text = @"60%";
    greenInfoLabel.textColor = COLOR_CHARACTERS_BLACK;
    greenInfoLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:greenInfoLabel];
    
    ///开发商信息
    UILabel *developLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, volumeTipsLabel.frame.origin.y + volumeTipsLabel.frame.size.height + 20.0f, view.frame.size.width, height)];
    developLabel.text = @"深圳市万科房地产有限公司(许可证号20140307)";
    developLabel.textColor = COLOR_CHARACTERS_BLACK;
    developLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:developLabel];
    
    ///物业管理公司
    UILabel *estateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, developLabel.frame.origin.y + developLabel.frame.size.height + 5.0f, view.frame.size.width, height)];
    estateLabel.text = @"万科物业管理有限公司 | 2.2元/月 物业费";
    estateLabel.textColor = COLOR_CHARACTERS_BLACK;
    estateLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    [view addSubview:estateLabel];
    
}

#pragma mark - 搭建地址信息UI
///搭建地址信息UI
- (void)createAddressSubviewsUI:(UIView *)view andDistriceID:(NSString *)districtID andStreetID:(NSString *)streetID andDetailAddress:(NSString *)address andCommunityInfo:(NSString *)comunity
{

    NSMutableString *allAddress = [NSMutableString stringWithCapacity:1];
    
    ///如果有区，拼装区
    if (districtID && [districtID length] > 0) {
        
        [allAddress appendString:[QSCoreDataManager getDistrictValWithDistrictKey:districtID]];
        
    }
    
    ///如果有街道，则拼装街道
    if (streetID && [streetID length] > 0) {
        
        [allAddress appendString:[QSCoreDataManager getStreetValWithStreetKey:streetID]];
        
    }
    
    ///拼装小区信息
    [allAddress appendString:comunity];
    
    ///拼装详情地址
    [allAddress appendString:[NSString stringWithFormat:@" %@",address]];
    
    ///创建UI
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, view.frame.size.width - 100.0f, view.frame.size.height)];
    titleLabel.text = allAddress;
    titleLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    titleLabel.textColor = COLOR_CHARACTERS_BLACK;
    [view addSubview:titleLabel];
    
    ///补充信息
    UILabel *tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x + titleLabel.frame.size.width, 0.0f, 70.0f, view.frame.size.height)];
    tipsLabel.text = @"(查看地图)";
    tipsLabel.font = [UIFont systemFontOfSize:FONT_BODY_14];
    tipsLabel.textColor = COLOR_CHARACTERS_LIGHTGRAY;
    [view addSubview:tipsLabel];
    
    ///定位按钮
    QSImageView *localImageView = [[QSImageView alloc] initWithFrame:CGRectMake(view.frame.size.width - 30.0f, view.frame.size.height - 30.0f, 30.0f, 30.0f)];
    localImageView.image = [UIImage imageNamed:IMAGE_PUBLIC_LOCAL_LIGHYELLOW];
    [view addSubview:localImageView];

}

#pragma mark - 创建特色标签
///创建特色标签
- (void)createFeaturesSubviews:(UIView *)view andDataSource:(NSString *)featuresString
{

    if (featuresString && ([featuresString length] > 0)) {
        
        ///清空原标签
        for (UIView *obj in [view subviews]) {
            
            [obj removeFromSuperview];
            
        }
        
        ///将标签信息转为数组
        NSArray *featuresList = [featuresString componentsSeparatedByString:@","];
        
        ///标签宽度
        CGFloat width = 55.0f;
        
        ///循环创建特色标签
        for (int i = 0; i < [featuresList count];i++) {
            
            ///标签项
            UILabel *tempLabel = [[QSLabel alloc] initWithFrame:CGRectMake(i * (width + 3.0f), 0.0f, width, view.frame.size.height)];
            
            ///根据特色标签，查询标签内容
            NSString *featureVal = [QSCoreDataManager getHouseFeatureWithKey:featuresList[i] andFilterType:fFilterMainTypeNewHouse];
            
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

#pragma mark - 均价子UI搭建
///均价子UI搭建
- (void)createAveragePriceSubviews:(UIView *)view andAveragePrice:(NSString *)avgPrice
{

    ///标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, view.frame.size.width, 16.0f)];
    titleLabel.text = @"新盘售价";
    titleLabel.textColor = COLOR_CHARACTERS_BLACK;
    titleLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_14];
    [view addSubview:titleLabel];
    
    ///均价底view
    UIView *rootView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 16.0f, view.frame.size.width, 44.0f)];
    rootView.layer.cornerRadius = VIEW_SIZE_NORMAL_CORNERADIO;
    rootView.backgroundColor = COLOR_CHARACTERS_LIGHTYELLOW;
    [view addSubview:rootView];
    
    ///均价信息
    UILabel *avgPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, rootView.frame.size.width / 2.0f, rootView.frame.size.height)];
    avgPriceLabel.text = avgPrice ? avgPrice : @"3.1";
    avgPriceLabel.textAlignment = NSTextAlignmentRight;
    avgPriceLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_30];
    avgPriceLabel.textColor = COLOR_CHARACTERS_BLACK;
    [rootView addSubview:avgPriceLabel];
    
    ///单位
    UILabel *unitPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(rootView.frame.size.width / 2.0f, 17.0f, rootView.frame.size.width / 2.0f, 20.0f)];
    unitPriceLabel.text = [NSString stringWithFormat:@"万/%@",APPLICATION_AREAUNIT];
    unitPriceLabel.textAlignment = NSTextAlignmentLeft;
    unitPriceLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_16];
    unitPriceLabel.textColor = COLOR_CHARACTERS_BLACK;
    [rootView addSubview:unitPriceLabel];

}

#pragma mark - 评分栏子UI搭建
///评分栏子UI搭建
- (void)createScoreSubviews:(UIView *)view
{

    ///中间评分底view
    QSImageView *mainScoreRootView = [[QSImageView alloc] initWithFrame:CGRectMake(view.frame.size.width / 2.0f - 40.0f, 0.0f, 80.0f, 90.0f)];
    mainScoreRootView.image = [UIImage imageNamed:IMAGE_HOUSES_DETAIL_MAIN_SCORE];
    [view addSubview:mainScoreRootView];
    
    ///右侧评分底view
    QSImageView *rightScoreRootView = [[QSImageView alloc] initWithFrame:CGRectMake(view.frame.size.width - 60.0f, (view.frame.size.height - 64.0f) / 2.0f, 60.0f, 64.0f)];
    [self createDetailScoreInfoUI:rightScoreRootView andDetailTitle:@"内部条件" andScoreKey:RightScoreKey andStarKey:RightStarKey];
    [view addSubview:rightScoreRootView];
    
    ///左侧评分底view
    QSImageView *leftScoreRootView = [[QSImageView alloc] initWithFrame:CGRectMake(0.0f, (view.frame.size.height - 64.0f) / 2.0f, 60.0f, 64.0f)];
    [self createDetailScoreInfoUI:leftScoreRootView andDetailTitle:@"周边条件" andScoreKey:LeftScoreKey andStarKey:LeftStarKey];
    [view addSubview:leftScoreRootView];

}

///创建总评分UI
- (void)createMainScoreInfoUI:(UIView *)view andMainScore:(NSString *)mainScore
{

    

}

///创建详情评分UI
- (void)createDetailScoreInfoUI:(UIView *)view andDetailTitle:(NSString *)detailTitle andScoreKey:(char)scoreKey andStarKey:(char)starKey
{

    ///头图片
    QSImageView *imageView = [[QSImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 60.0f, 32.0f)];
    imageView.image = [UIImage imageNamed:IMAGE_HOUSES_DETAIL_DETAIL_SCORE];
    [view addSubview:imageView];
    
    ///评分
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(3.0f, 5.0f, view.frame.size.width - 8.0f - 15.0f, 25.0f)];
    scoreLabel.text = @"4.5";
    scoreLabel.textAlignment = NSTextAlignmentRight;
    scoreLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_20];
    scoreLabel.textColor = COLOR_CHARACTERS_YELLOW;
    [view addSubview:scoreLabel];
    objc_setAssociatedObject(self, &scoreKey, scoreLabel, OBJC_ASSOCIATION_ASSIGN);
    
    ///单位
    UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(scoreLabel.frame.origin.x + scoreLabel.frame.size.width, scoreLabel.frame.origin.y + scoreLabel.frame.size.height - 20.0f, 20.0f, 20.0f)];
    unitLabel.text = @"分";
    unitLabel.font = [UIFont boldSystemFontOfSize:FONT_BODY_14];
    unitLabel.textColor = COLOR_CHARACTERS_GRAY;
    [view addSubview:unitLabel];
    
    ///说明文字
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(3.0f, scoreLabel.frame.origin.y + scoreLabel.frame.size.height, view.frame.size.width - 6.0f, 15.0f)];
    titleLabel.text = detailTitle;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = COLOR_CHARACTERS_LIGHTGRAY;
    titleLabel.font = [UIFont systemFontOfSize:FONT_BODY_12];
    [view addSubview:titleLabel];
    
    ///星级
    QSImageView *starRootImageView = [[QSImageView alloc] initWithFrame:CGRectMake(0.0f, view.frame.size.height - 12.0f, view.frame.size.width, 12.0f)];
    starRootImageView.image = [UIImage imageNamed:IMAGE_HOUSES_DETAIL_STAR_GRAY];
    [view addSubview:starRootImageView];
    
    UIView *starRootView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, starRootImageView.frame.size.height)];
    starRootView.clipsToBounds = YES;
    [starRootImageView addSubview:starRootView];
    
    QSImageView *yellowStarView = [[QSImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, starRootImageView.frame.size.width, starRootImageView.frame.size.height)];
    yellowStarView.image = [UIImage imageNamed:IMAGE_HOUSES_DETAIL_STAR_YELLOW];
    [starRootView addSubview:yellowStarView];

}

#pragma mark - 活动页相关代理设置
///自滚动的总数
- (int)numberOfScrollPage:(QSAutoScrollView *)autoScrollView
{

    return 2;

}

///每个下标的广告页
- (UIView *)autoScrollViewShowView:(QSAutoScrollView *)autoScrollView viewForShowAtIndex:(int)index
{

    ///承载view
    UIView *activityInfoView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SIZE_DEVICE_WIDTH, autoScrollView.frame.size.height)];
    activityInfoView.backgroundColor = COLOR_CHARACTERS_LIGHTYELLOW;
    
    ///图片宽度
    CGFloat widthOfImage = autoScrollView.frame.size.height * 40.0f / 253.0f;
    
    ///左右图片
    QSImageView *leftImageView = [[QSImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, widthOfImage, activityInfoView.frame.size.height)];
    leftImageView.image = [UIImage imageNamed:IMAGE_HOUSES_DETAIL_NEW_ACTIVITY_LEFT];
    [activityInfoView addSubview:leftImageView];
    
    QSImageView *rightImageView = [[QSImageView alloc] initWithFrame:CGRectMake(activityInfoView.frame.size.width - widthOfImage, 0.0f, widthOfImage, activityInfoView.frame.size.height)];
    rightImageView.image = [UIImage imageNamed:IMAGE_HOUSES_DETAIL_NEW_ACTIVITY_RIGHT];
    [activityInfoView addSubview:rightImageView];
    
    return activityInfoView;

}

///每一个广告页的返回参数
- (id)autoScrollViewTapCallBackParams:(QSAutoScrollView *)autoScrollView viewForShowAtIndex:(int)index
{

    return [NSString stringWithFormat:@"第%d活动页",index];

}

#pragma mark - 请求新房详情信息
///请求新房详情信息
- (void)getNewHouseDetailInfo
{
    
    ///封装参数
//    NSDictionary *params = @{@"loupan_id" : self.loupanID ? self.loupanID : @"",
//                             @"loupan_building_id" : self.loupanBuildingID ? self.loupanBuildingID : @""};
//    
//    ///进行请求
//    [QSRequestManager requestDataWithType:rRequestTypeNewHouseDetail andParams:params andCallBack:^(REQUEST_RESULT_STATUS resultStatus, id resultData, NSString *errorInfo, NSString *errorCode) {
//        
//        ///请求成功
//        if (<#condition#>) {
//            <#statements#>
//        }
//        
//    }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIScrollView *rootView = objc_getAssociatedObject(self, &DetailRootViewKey);
        [rootView headerEndRefreshing];
        [self showInfoUI:YES];
        
        ///创建详情UI
        [self createNewDetailInfoViewUI:nil];
        
    });
    
}

@end