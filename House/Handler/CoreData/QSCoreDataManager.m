//
//  QSCoreDataManager.m
//  House
//
//  Created by ysmeng on 15/1/20.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "QSCoreDataManager.h"
#import "QSYAppDelegate.h"

@implementation QSCoreDataManager

#pragma mark - 返回指定实体所有数据
/**
 *  @author             yangshengmeng, 15-01-21 18:01:56
 *
 *  @brief              返回指定实体所有数据数组
 *
 *  @param entityName   实体名
 *
 *  @return             返回实体数组
 *
 *  @since              1.0.0
 */
+ (NSArray *)getDataListWithKey:(NSString *)entityName andSortKeyWord:(NSString *)keyword andAscend:(BOOL)isAscend
{

    QSYAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *mOContext = appDelegate.managedObjectContext;
    NSEntityDescription *enty = [NSEntityDescription entityForName:entityName inManagedObjectContext:mOContext];
    
    ///设置查找
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:enty];
    
    ///设置排序
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:keyword ascending:isAscend];
    [request setSortDescriptors:@[sort]];
    
    NSError *error;
    NSArray *resultList = [mOContext executeFetchRequest:request error:&error];
    
    ///判断是否查询失败
    if (error) {
        
        return nil;
        
    }
    
    ///如果获取返回的个数为0也直接返回nil
    if (0 >= [resultList count]) {
        
        return nil;
        
    }
    
    ///查询成功
    return resultList;

}

#pragma mark - 返回coreData中的指定表中的某字段信息
/**
 *  @author             yangshengmeng, 15-01-20 09:01:45
 *
 *  @brief              查询指定表中的某字段信息
 *
 *  @param entityName   实体名
 *  @param keyword      字段名
 *
 *  @since              1.0.0
 */
+ (instancetype)getDataWithKey:(NSString *)entityName andKeyword:(NSString *)keyword
{

    QSYAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *mOContext = appDelegate.managedObjectContext;
    NSEntityDescription *enty = [NSEntityDescription entityForName:entityName inManagedObjectContext:mOContext];
    
    ///设置查找
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:enty];
    
    ///设置排序
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:keyword ascending:YES];
    [request setSortDescriptors:@[sort]];
    
    NSError *error;
    NSArray *resultList = [mOContext executeFetchRequest:request error:&error];
    
    ///判断是否查询失败
    if (error) {
        
        return nil;
        
    }
    
    ///如果获取返回的个数为0也直接返回nil
    if (0 >= [resultList count]) {
        
        return nil;
        
    }
    
    ///查询成功
    NSObject *resultModel = resultList[0];
    return resultModel ? ([resultModel valueForKey:keyword] ? [resultModel valueForKey:keyword] : nil) : nil;

}

#pragma mark - 单条数据的表更新数据
/**
 *  @author             yangshengmeng, 15-01-21 21:01:57
 *
 *  @brief              根据给定的字段和字段新内容更新CoreData数据
 *
 *  @param entityName   实体名
 *  @param fieldName    字段名
 *
 *  @return             更新结果：YES-更新成功，NO-更新失败
 *
 *  @since              1.0.0
 */
+ (BOOL)updateFieldWithKey:(NSString *)entityName andUpdateField:(NSString *)fieldName andFieldNewValue:(id)newValue
{

    QSYAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *mOContext = appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:mOContext];
    [fetchRequest setEntity:entity];
    
    //查询条件
    NSPredicate* predicate = [NSPredicate predicateWithValue:YES];
    [fetchRequest setPredicate:predicate];
    
    NSError *error=nil;
    NSArray *fetchResultArray = [mOContext executeFetchRequest:fetchRequest error:&error];
    
    ///判断读取出来的原数据
    if (nil == fetchResultArray) {
        
        NSLog(@"CoreData.GetData.Error:%@",error);
        return NO;
        
    }
    
    ///检测原来是否已有数据
    if (0 >= [fetchResultArray count]) {
        
        ///插入数据
        NSObject *model = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:mOContext];
        [model setValue:newValue forKey:fieldName];
        [mOContext save:&error];
        
        if (error) {
            
            return NO;
            
        }
        
        return YES;
        
    } else {
    
        ///获取模型后更新保存
        NSObject *model = fetchResultArray[0];
        [model setValue:newValue forKey:fieldName];
        [mOContext save:&error];
        
        if (error) {
            
            return NO;
            
        }
        
        return YES;
    
    }
    
    return NO;

}

#pragma mark - 在给定的实体中插入一条数据
/**
 *  @author                 yangshengmeng, 15-01-21 23:01:37
 *
 *  @brief                  根据给定的实例名和实体对象，插入一条数据
 *
 *  @param entityName       实体名
 *  @param coreDataModel    实体对象
 *
 *  @return                 返回是否插入成功：YES-插入成功，NO-插入失败
 *
 *  @since                  1.0.0
 */
+ (BOOL)insertEntityWithEntityName:(NSString *)entityName andCoreDataModel:(NSManagedObject *)coreDataModel
{

    QSYAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *mOContext = appDelegate.managedObjectContext;
    
    [mOContext insertObject:coreDataModel];
    
    ///保存
    NSError *error;
    BOOL isInsertSuccess = [mOContext save:&error];
    
    ///判断插入结果
    if (!isInsertSuccess) {
        
        NSLog(@"CoreData.Insert.Error:%@",error);
        
    }
    
    return isInsertSuccess;

}

#pragma mark - 清空给定实体中所有的数据
/**
 *  @author             yangshengmeng, 15-01-21 23:01:28
 *
 *  @brief              清空某个实体模型中所有的数据
 *
 *  @param entityName   实体名
 *
 *  @return             删除结果标识：YES-删除成功,NO-删除失败
 *
 *  @since              1.0.0
 */
+ (BOOL)clearDataListWithEntityName:(NSString *)entityName
{

    QSYAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *mOContext = appDelegate.managedObjectContext;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:mOContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setIncludesPropertyValues:NO];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *resultArray = [mOContext executeFetchRequest:fetchRequest error:&error];
    
    ///查询失败
    if (error) {
        
        NSLog(@"CoreData.GetData.Error:%@",error);
        return NO;
        
    }
    
    ///如果本身数据就为0，则直接返回YES
    if (0 >= [resultArray count]) {
        
        return YES;
        
    }
    
    ///遍历删除
    for (NSManagedObject *obj in resultArray) {
        
        [mOContext deleteObject:obj];
        
    }
    
    ///确认删除结果
    BOOL isChangeSuccess = [mOContext save:&error];
    if (!isChangeSuccess) {
        
        NSLog(@"CoreData.DeleteData.Error:%@",error);
        
    }
    
    return isChangeSuccess;

}

@end