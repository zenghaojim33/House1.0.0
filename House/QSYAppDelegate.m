//
//  QSYAppDelegate.m
//  House
//
//  Created by ysmeng on 15/1/16.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "QSYAppDelegate.h"
#import "QSRequestManager.h"
#import "QSAdvertViewController.h"
#import "QSConfigurationReturnData.h"
#import "QSCoreDataManager+App.h"
#import "QSMapManager.h"

@interface QSYAppDelegate ()

///非主线程任务处理使用的自定义线程
@property (nonatomic, strong) dispatch_queue_t appDelegateOperationQueue;

@end

@implementation QSYAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    ///非主线程任务操作线程初始化
    self.appDelegateOperationQueue = dispatch_queue_create(QUEUE_REQUEST_OPERATION, DISPATCH_QUEUE_CONCURRENT);
    
    ///显示广告页
    QSAdvertViewController *advertVC = [[QSAdvertViewController alloc] init];
    self.window.rootViewController = advertVC;
    
    ///下载配置信息
//    [self downloadApplicationBasInfo];
    
    ///开始定位个人位置信息
    [QSMapManager getUserLocation];
    
    return YES;
    
}

#pragma mark - 请求应用配置信息
- (void)downloadApplicationBasInfo
{

    ///放在后台运行
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
    
        [QSRequestManager requestDataWithType:rRequestTypeAppBaseInfo andCallBack:^(REQUEST_RESULT_STATUS resultStatus, id resultData, NSString *errorInfo, NSString *errorCode) {
            
            ///转换模型
            QSConfigurationReturnData *configModel = resultData;
            
            ///更新token信息
            [QSCoreDataManager updateApplicationCurrentToken:configModel.configurationHeaderData.t];
            [QSCoreDataManager updateApplicationCurrentTokenID:[NSString stringWithFormat:@"%@",configModel.configurationHeaderData.t_id]];
            
            ///更新版本信息
            [QSCoreDataManager updateApplicationCurrentVersion:[NSString stringWithFormat:@"%@",configModel.configurationHeaderData.version]];
            
            ///配置信息检测
            [self checkConfigurationInfo:configModel.configurationHeaderData.configurationList];
            
        }];
        
    });

}

///检测基本信息的版本：本操作要求处于子线程中，不允许在主线程里操作
- (void)checkConfigurationInfo:(NSArray *)configurationList
{

    ///暂时保存配置版本信息
    NSArray *tempConfigurationArray = [NSArray arrayWithArray:configurationList];
    
    ///获取本地配置版本数组
    NSArray *localConfigurationArray = [QSCoreDataManager getConfigurationList];
    
    ///判断本地配置版本信息
    if ((nil == localConfigurationArray) || (0 >= [localConfigurationArray count])) {
        
        ///本地暂无基本信息，则全部更新
        for (QSConfigurationDataModel *obj in tempConfigurationArray) {
            
            [self updateConfigurationInfoWithModel:obj];
            
        }
        return;
        
    }
    
    ///检测本地版本总数是否和新的版本总数一致
    if ([tempConfigurationArray count] != [localConfigurationArray count]) {
        
        
        return;
        
    }
    
    ///将两个数组转化为字典
    NSDictionary *newConfigurationDictionary = [self changeArrayToDictionary:tempConfigurationArray];
    NSDictionary *localConfigurationDictionary = [self changeArrayToDictionary:localConfigurationArray];
    
    ///检测本地版本和最新版本是否一致
    for (NSString *newKey in newConfigurationDictionary) {
        
        ///新的配置模型
        QSConfigurationDataModel *newConfDataModel = [newConfigurationDictionary valueForKey:newKey];
        
        ///本地配置模型
        QSConfigurationDataModel *localConfDataModel = [localConfigurationDictionary valueForKey:newKey];
        
        ///检测版本
        if (([newConfDataModel.conf isEqualToString:localConfDataModel.conf]) &&
            (!([newConfDataModel.c_v isEqualToString:localConfDataModel.c_v]))) {
            
            ///版本不致，则更新对应的配置信息
            [self updateConfigurationInfoWithModel:newConfDataModel];
            
        }
        
    }

}

///将数组转化为字典，方便进行数组内的对象进行比效
- (NSDictionary *)changeArrayToDictionary:(NSArray *)array
{
    
    ///临时字典
    NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
    
    ///遍历转换
    for (QSConfigurationDataModel *obj in array) {
        
        [tempDict setObject:obj forKey:obj.conf];
        
    }
    
    return [NSDictionary dictionaryWithDictionary:tempDict];

}

#pragma mark - 下载配置信息
- (void)updateConfigurationInfoWithModel:(QSConfigurationDataModel *)confModel
{

    ///在子线程中执行网络请求
    dispatch_sync(self.appDelegateOperationQueue, ^{
        
        [QSRequestManager requestDataWithType:rRequestTypeAppBaseInfoConfiguration andCallBack:^(REQUEST_RESULT_STATUS resultStatus, id resultData, NSString *errorInfo, NSString *errorCode) {
            
            
            
        }];
        
    });

}

#pragma mark - 应用退出前保存数据
- (void)applicationWillTerminate:(UIApplication *)application
{
    
    ///应用退出前进行保存动作
    [self saveContext];
    
}

- (void)saveContext
{
    
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            
             ///应用退出时的相关操作
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
            
        }
        
    }
    
}

#pragma mark - CoreData相关操作

///返回CoreData操作的上下文
- (NSManagedObjectContext *)managedObjectContext
{
    
    if (_managedObjectContext != nil) {
        
        return _managedObjectContext;
        
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
        
    }
    
    return _managedObjectContext;
    
}

///返回CoreData数据管理模型
- (NSManagedObjectModel *)managedObjectModel
{
    
    if (_managedObjectModel != nil) {
        
        return _managedObjectModel;
        
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"House" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
    
}

//返回CoreData操作的NSPersistentStoreCoordinator
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    
    if (_persistentStoreCoordinator != nil) {
        
        return _persistentStoreCoordinator;
        
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"House.sqlite"];
        
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        ///在这里添加CoreData错误处理代理
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
        
    }    
    
    return _persistentStoreCoordinator;
    
}

#pragma mark - 获取应用沙盒目录
///获取应用沙盒目录
- (NSURL *)applicationDocumentsDirectory
{
    
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
}

#pragma mark -百度地图联网与授权情况
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    
//    else if(2==iError)
//    {
//        NSLog(@"网络连接错误");
//    }
    
    else {
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        
        NSLog(@"授权成功");
        
    }
    
//    else if(-300 ==iError)
//    {
//        
//        NSLog(@"百度地图服务器连接错误");
//        
//    }
//    else if(-200==iError){
//    
//        NSLog(@"百度地图服务返回数据异常");
//    
//    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

@end
