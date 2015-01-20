//
//  QSHomeViewController.m
//  House
//
//  Created by ysmeng on 15/1/17.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "QSHomeViewController.h"
#import "QSTabBarViewController.h"
#import "QSBlockButtonStyleModel+NavigationBar.h"
#import "QSHouseKeySearchViewController.h"
#import "QSNetworkingStatus.h"
#import "ColorHeader.h"

@interface QSHomeViewController ()
@property (weak, nonatomic) IBOutlet UIView *houseTypeView;//!< 房源view

@end

@implementation QSHomeViewController

#pragma mark - UI搭建
- (void)createNavigationBarUI
{

    [super createNavigationBarUI];
    
    ///添加中间view
    
    
    ///添加右侧搜索按钮
    UIButton *searchButton = [UIButton createBlockButtonWithFrame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f) andButtonStyle:[QSBlockButtonStyleModel createNavigationBarButtonStyleWithType:nNavigationBarButtonLocalTypeRight andButtonType:nNavigationBarButtonTypeSearch] andCallBack:^(UIButton *button) {
        
        ///进入搜索页
        [self gotoSearchViewController];
        
    }];
    [self setNavigationBarRightView:searchButton];

}

-(void)createMainShowUI
{
    
    [super createMainShowUI];
    
    ///设置房源Label颜色
    self.houseTypeCountOneLabel.textColor = COLOR_CHARACTERS_YELLOW;
    self.houseTypeCountTwoLabel.textColor = COLOR_CHARACTERS_YELLOW;
    self.houseTypeCountThreeLabel.textColor = COLOR_CHARACTERS_YELLOW;
    self.houseTypeCountFourLabel.textColor = COLOR_CHARACTERS_YELLOW;
    self.houseTypeCountOtherLabel.textColor = COLOR_CHARACTERS_YELLOW;
    
    ///设置房源主view背景图片
    UIImageView *backgroundImage=[[UIImageView alloc]init];
    backgroundImage.image=[UIImage imageNamed:@"home_background.png"];
    [self.houseTypeView addSubview:backgroundImage];
    [self.houseTypeView sendSubviewToBack:backgroundImage];
    
}

#pragma mark - 进入搜索页面
- (void)gotoSearchViewController
{
    
    
    
}

#pragma mark -按钮点击事件

///新房按钮点击事件
- (IBAction)newHouseButton:(id)sender
{
    
    
    
}

///二手房按钮点击事件
- (IBAction)secondHandHouseButton:(id)sender
{
    
    
    
}

///租房按钮点击事件
- (IBAction)rentingHouseButton:(id)sender
{
    
    
    
}

///我要放盘按钮点击事件
- (IBAction)saleHouseButton:(id)sender
{
    
    
    
}

///笋盘推荐按钮点击事件
- (IBAction)bambooplateHouseButton:(id)sender
{
    
    
    
}

@end
