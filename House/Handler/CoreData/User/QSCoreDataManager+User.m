//
//  QSCoreDataManager+User.m
//  House
//
//  Created by ysmeng on 15/1/22.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "QSCoreDataManager+User.h"

#import "QSCDBaseConfigurationDataModel.h"
#import "QSBaseConfigurationDataModel.h"
#import "QSUserDataModel.h"
#import "QSCDUserDataModel.h"

#import "QSYAppDelegate.h"

#import "QSCoreDataManager+App.h"

///应用配置信息的CoreData模型
#define COREDATA_ENTITYNAME_USER_INFO @"QSCDUserDataModel"
#define COREDATA_ENTITYNAME_BASECONFIGURATION_INFO @"QSCDBaseConfigurationDataModel"

@implementation QSCoreDataManager (User)

/**
 *  @author yangshengmeng, 15-02-09 16:02:21
 *
 *  @brief  判断是否已登录
 *
 *  @return 返回当前登录状态
 *
 *  @since  1.0.0
 */
+ (BOOL)isLogin
{

    ///获取本地配置信息
    NSString *loginStatus = [self getUnirecordFieldWithKey:COREDATA_ENTITYNAME_USER_INFO andKeyword:@"is_login"];
    
    if (nil == loginStatus) {
        
        return NO;
        
    }
    
    if (0 == [loginStatus intValue]) {
        
        return NO;
        
    }
    
    return YES;

}

/**
 *  @author     yangshengmeng, 15-03-14 12:03:47
 *
 *  @brief      更新用户登录状态
 *
 *  @param flag YES-已登录
 *
 *  @return     返回更新是否成功
 *
 *  @since      1.0.0
 */
+ (void)updateLoginStatus:(BOOL)flag andCallBack:(void(^)(BOOL flag))callBack
{

    BOOL isSave = [self updateUnirecordFieldWithKey:COREDATA_ENTITYNAME_USER_INFO andUpdateField:@"is_login" andFieldNewValue:(flag ? @"1" : @"0")];
    
    ///回调
    callBack(isSave);

}

/**
 *  @author             yangshengmeng, 15-03-14 12:03:48
 *
 *  @brief              保存当前用户登录的基本信息
 *
 *  @param userModel    用户数据模型
 *
 *  @since              1.0.0
 */
+ (void)saveLoginUserData:(QSUserDataModel *)userModel andCallBack:(void(^)(BOOL flag))callBack
{

    ///校验
    if (nil == userModel) {
        
        callBack(NO);
        return;
        
    }
    
    __block QSYAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *mainContext = [appDelegate mainObjectContext];
    
    ///创建私有context
    NSManagedObjectContext *tempContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    tempContext.parentContext = mainContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:COREDATA_ENTITYNAME_USER_INFO inManagedObjectContext:tempContext];
    [fetchRequest setEntity:entity];
    
    ///设置查询过滤
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"collected_id == %@",userModel.id_];
    [fetchRequest setPredicate:predicate];
    
    NSError *error=nil;
    NSArray *fetchResultArray = [tempContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        
        NSLog(@"CoreData.SearchCollectedData.Error:%@",error);
        
        ///回调
        if (callBack) {
            
            callBack(NO);
            
        }
        
        return;
    }
    
    ///判断本地是否有数据
    if ([fetchResultArray count] > 0) {
        
        QSCDUserDataModel *cdUserModel = fetchResultArray[0];
        cdUserModel.user_id = userModel.id_;
        cdUserModel.user_count_type = userModel.user_type;
        cdUserModel.user_name = userModel.username;
        cdUserModel.user_count = userModel.username;
        cdUserModel.email = userModel.email;
        cdUserModel.last_login_time = userModel.last_login_time;
        cdUserModel.ischeck_mail = userModel.ischeck_mail;
        cdUserModel.ischeck_mobile = userModel.ischeck_mobile;
        cdUserModel.mobile = userModel.mobile;
        cdUserModel.realname = userModel.realname;
        cdUserModel.sex = userModel.sex;
        cdUserModel.avatar = userModel.avatar;
        cdUserModel.nick_name = userModel.nickname;
        cdUserModel.web = userModel.web;
        cdUserModel.qq = userModel.qq;
        cdUserModel.age = userModel.age;
        cdUserModel.idcard = userModel.idcard;
        cdUserModel.vocation = userModel.vocation;
        cdUserModel.tj_rentHouse_num = userModel.tj_rentHouse_num;
        cdUserModel.tj_secondHouse_num = userModel.tj_secondHouse_num;
        
        [tempContext save:&error];
        
    } else {
        
        QSCDUserDataModel *cdUserModel = [NSEntityDescription insertNewObjectForEntityForName:COREDATA_ENTITYNAME_USER_INFO inManagedObjectContext:tempContext];
        
        cdUserModel.user_id = userModel.id_;
        cdUserModel.user_count_type = userModel.user_type;
        cdUserModel.user_name = userModel.username;
        cdUserModel.user_count = userModel.username;
        cdUserModel.email = userModel.email;
        cdUserModel.last_login_time = userModel.last_login_time;
        cdUserModel.ischeck_mail = userModel.ischeck_mail;
        cdUserModel.ischeck_mobile = userModel.ischeck_mobile;
        cdUserModel.mobile = userModel.mobile;
        cdUserModel.realname = userModel.realname;
        cdUserModel.sex = userModel.sex;
        cdUserModel.avatar = userModel.avatar;
        cdUserModel.nick_name = userModel.nickname;
        cdUserModel.web = userModel.web;
        cdUserModel.qq = userModel.qq;
        cdUserModel.age = userModel.age;
        cdUserModel.idcard = userModel.idcard;
        cdUserModel.vocation = userModel.vocation;
        cdUserModel.tj_rentHouse_num = userModel.tj_rentHouse_num;
        cdUserModel.tj_secondHouse_num = userModel.tj_secondHouse_num;
        
        [tempContext save:&error];
        
    }
    
    ///判断是否保存成功
    if (error) {
        
        NSLog(@"CoreData.SaveCollectedData.Error:%@",error);
        
        ///回调
        if (callBack) {
            
            callBack(NO);
            
        }
        
        return;
        
    }
    
    ///保存数据到本地
    if ([NSThread isMainThread]) {
        
        [appDelegate saveContextWithWait:YES];
        
    } else {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [appDelegate saveContextWithWait:NO];
            
        });
        
    }
    
    ///回调
    if (callBack) {
        
        callBack(YES);
        
    }
    
}

///获取当前用户ID
+ (NSString *)getUserID
{

    return (NSString *)[self getUnirecordFieldWithKey:COREDATA_ENTITYNAME_USER_INFO andKeyword:@"user_id"];

}

/**
 *  @author yangshengmeng, 15-01-23 10:01:47
 *
 *  @brief  返回当前用户所在的城市
 *
 *  @return 返回城市
 *
 *  @since  1.0.0
 */
+ (QSBaseConfigurationDataModel *)getCurrentUserCityModel
{

    QSBaseConfigurationDataModel *cityKey = [QSCoreDataManager getCityModelWithCityKey:[self getCurrentUserCityKey]];
    return cityKey;

}

+ (NSString *)getCurrentUserCity
{

    return (NSString *)[self getUnirecordFieldWithKey:COREDATA_ENTITYNAME_USER_INFO andKeyword:@"user_current_city"];

}

///获取当前城市的key
+ (NSString *)getCurrentUserCityKey
{

    return (NSString *)[self getUnirecordFieldWithKey:COREDATA_ENTITYNAME_USER_INFO andKeyword:@"user_current_city_key"];

}

///更新当前用户所有城市
+ (BOOL)updateCurrentUserCity:(QSCDBaseConfigurationDataModel *)cityModel
{

    ///查找城市对应的省
    if (!cityModel) {
        
        return NO;
        
    }
    
    ///conf
    NSString *cityConf = cityModel.conf;
    
    ///省的key
    NSString *provinceKey = [cityConf substringFromIndex:4];
    
    ///省的模型
    QSCDBaseConfigurationDataModel *provinceModel = [self searchEntityWithKey:COREDATA_ENTITYNAME_BASECONFIGURATION_INFO andFieldName:@"key" andFieldSearchKey:provinceKey];
    
    if (!provinceModel) {
        
        return NO;
        
    }
    
    return [self updateCurrentUserCity:provinceModel andCity:cityModel];

}

///更新当前用户的所在城市
+ (BOOL)updateCurrentUserCity:(QSCDBaseConfigurationDataModel *)provinceModel andCity:(QSCDBaseConfigurationDataModel *)cityModel
{

    if (nil == provinceModel || nil == cityModel) {
        
        return NO;
        
    }
    
    [self updateUnirecordFieldWithKey:COREDATA_ENTITYNAME_USER_INFO andUpdateField:@"user_current_province" andFieldNewValue:provinceModel.val];
    
    [self updateUnirecordFieldWithKey:COREDATA_ENTITYNAME_USER_INFO andUpdateField:@"user_current_province_key" andFieldNewValue:provinceModel.key];
    
    [self updateUnirecordFieldWithKey:COREDATA_ENTITYNAME_USER_INFO andUpdateField:@"user_current_city" andFieldNewValue:cityModel.val];
    
    return [self updateUnirecordFieldWithKey:COREDATA_ENTITYNAME_USER_INFO andUpdateField:@"user_current_city_key" andFieldNewValue:cityModel.key];

}

/**
 *  @author yangshengmeng, 15-01-23 10:01:47
 *
 *  @brief  返回当前用户当前所在的区
 *
 *  @return 返回区
 *
 *  @since  1.0.0
 */
+ (NSString *)getCurrentUserDistrict
{

    return (NSString *)[self getUnirecordFieldWithKey:COREDATA_ENTITYNAME_USER_INFO andKeyword:@"user_current_district"];

}

///更新当前用户所在区
+ (BOOL)updateCurrentUserDistrict:(NSString *)district
{

    if (nil == district) {
        
        return NO;
        
    }
    
    return [self updateUnirecordFieldWithKey:COREDATA_ENTITYNAME_USER_INFO andUpdateField:@"user_current_district" andFieldNewValue:district];

}

/**
 *  @author yangshengmeng, 15-01-28 17:01:56
 *
 *  @brief  获取当前用户当前所在的街道
 *
 *  @return 返回街道
 *
 *  @since  1.0.0
 */
+ (NSString *)getCurrentUserStreet
{

    return (NSString *)[self getUnirecordFieldWithKey:COREDATA_ENTITYNAME_USER_INFO andKeyword:@"user_current_street"];

}

///更新当前用户所在的街道
+ (BOOL)updateCurrentUserStreet:(NSString *)street
{

    if (nil == street) {
        
        return NO;
        
    }
    
    return [self updateUnirecordFieldWithKey:COREDATA_ENTITYNAME_USER_INFO andUpdateField:@"user_current_street" andFieldNewValue:street];

}

#pragma mark - 用户默认过滤器获取
/**
 *  @author yangshengmeng, 15-02-05 10:02:10
 *
 *  @brief  获取当前用户默认过滤器:user_default_filter_id
 *
 *  @return 返回默认过滤器的ID
 *
 *  @since  1.0.0
 */
+ (NSString *)getCurrentUserDefaultFilterID
{

    return [self getUnirecordFieldWithKey:COREDATA_ENTITYNAME_USER_INFO andKeyword:@"user_default_filter_id"];

}

///更新用户默认过滤器
+ (void)updateCurrentUserDefaultFilter:(NSString *)filterID andCallBack:(void(^)(BOOL isSuccess))callBack
{

    if (nil == filterID) {
        
        callBack(NO);
        return;
        
    }
    
    BOOL isUpdateSuccess = [self updateUnirecordFieldWithKey:COREDATA_ENTITYNAME_USER_INFO andUpdateField:@"user_default_filter_id" andFieldNewValue:filterID];
    
    callBack(isUpdateSuccess);

}

#pragma mark - 用户的类型获取
/**
 *  @author yangshengmeng, 15-01-27 12:01:42
 *
 *  @brief  返回当前用户的权限类型
 *
 *  @return 返回用户权限类型
 *
 *  @since  1.0.0
 */
+ (USER_COUNT_TYPE)getCurrentUserCountType
{

    NSString *userCountTypeString = (NSString *)[self getUnirecordFieldWithKey:COREDATA_ENTITYNAME_USER_INFO andKeyword:@"user_count_type"];
    
    ///如果没有配置，默认返回普通客户
    if (nil == userCountTypeString) {
        
        return uUserCountTypeTenant;
        
    }
    
    int userCountType = [userCountTypeString intValue];
    
    return userCountType;
    
}

/**
 *  @author         yangshengmeng, 15-01-27 12:01:41
 *
 *  @brief          更新当前用户的类型
 *
 *  @param userType 用户类型
 *
 *  @return         返回更新是否成功
 *
 *  @since          1.0.0
 */
+ (BOOL)updateCurrentUserCountType:(USER_COUNT_TYPE)userType
{

    if (uUserCountTypeTenant > userType || uUserCountTypeDeveloper < userType) {
        
        return NO;
        
    }
    
    return [self updateUnirecordFieldWithKey:COREDATA_ENTITYNAME_USER_INFO andUpdateField:@"user_count_type" andFieldNewValue:[NSString stringWithFormat:@"%d",userType]];

}

@end
