//
//  QSYHistoryNewHouseListView.m
//  House
//
//  Created by ysmeng on 15/3/28.
//  Copyright (c) 2015年 广州七升网络科技有限公司. All rights reserved.
//

#import "QSYHistoryNewHouseListView.h"

#import "QSAttentionCommunityCell.h"
#import "QSCustomHUDView.h"

#import "QSNewHouseListReturnData.h"
#import "QSNewHouseInfoDataModel.h"

#import "QSCoreDataManager+History.h"
#import "QSCoreDataManager+User.h"

#import "QSYHistoryNewHouseListReturnData.h"
#import "QSYHistoryListNewHouseDataModel.h"
#import "QSNewHouseInfoDataModel.h"
#import "QSNewHouseDetailDataModel.h"

#import "QSRequestManager.h"
#import "MJRefresh.h"

@interface QSYHistoryNewHouseListView () <UICollectionViewDataSource,UICollectionViewDelegate>

///点击房源时的回调
@property (nonatomic,copy) void(^houseListTapCallBack)(HOUSE_LIST_ACTION_TYPE actionType,id tempModel);

@property (assign) BOOL isLocalData;                                        //!<是否是本地数据
@property (nonatomic,retain) NSMutableArray *customDataSource;              //!<数据源
@property (nonatomic,retain) QSYHistoryNewHouseListReturnData *dataModel;   //!<数据模型

@end

@implementation QSYHistoryNewHouseListView

#pragma mark - 初始化
/**
 *  @author         yangshengmeng, 15-01-30 08:01:06
 *
 *  @brief          创建收藏新房列表，并且点击房源时，回调
 *
 *  @param frame    大小和位置
 *  @param callBack 点击出租房时的回调
 *
 *  @return         返回当前创建的房源列表
 *
 *  @since          1.0.0
 */
- (instancetype)initWithFrame:(CGRect)frame andCallBack:(void(^)(HOUSE_LIST_ACTION_TYPE actionType,id tempModel))callBack
{
    
    ///瀑布流布局器
    UICollectionViewFlowLayout *defaultLayout = [[UICollectionViewFlowLayout alloc] init];
    defaultLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    ///每个信息项显示大小
    defaultLayout.itemSize = CGSizeMake(SIZE_DEVICE_WIDTH, 350.0f / 690.0f * SIZE_DEFAULT_MAX_WIDTH + 39.5f + 5.0f + 25.0f + 20.0f);
    
    ///每项内容的间隙
    defaultLayout.minimumLineSpacing = 20.0f;
    defaultLayout.minimumInteritemSpacing = 0.0f;
    
    if (self = [super initWithFrame:frame collectionViewLayout:defaultLayout]) {
        
        ///初始化数据源
        self.customDataSource = [[NSMutableArray alloc] init];
        
        ///保存参数
        if (callBack) {
            
            self.houseListTapCallBack = callBack;
            
        }
        
        ///判断是否本数据
        self.isLocalData = ![QSCoreDataManager isLogin];
        
        self.backgroundColor = [UIColor clearColor];
        self.alwaysBounceVertical = YES;
        self.delegate = self;
        self.dataSource = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[QSAttentionCommunityCell class] forCellWithReuseIdentifier:@"newHouseInfoCell"];
        
        ///添加刷新
        [self addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(newHouseListHeaderRequest)];
        
        ///开始就刷新
        [self.header beginRefreshing];
        
    }
    
    return self;
    
}

#pragma mark - 请求列表数据
- (void)newHouseListHeaderRequest
{
    
    ///判断是否已登录
    if (!self.isLocalData) {
        
        ///下载服务端浏览记录
        [self downloadServerHistoryNewHouseData];
        return;
        
    }
    
    ///获取本地数据
    NSArray *tempArray = [QSCoreDataManager getLocalHistoryDataSourceWithType:fFilterMainTypeNewHouse];
    
    if ([tempArray count] > 0) {
        
        if (self.houseListTapCallBack) {
            
            self.houseListTapCallBack(hHouseListActionTypeHaveRecord,nil);
            
        }
        
        [self.customDataSource removeAllObjects];
        [self.customDataSource addObjectsFromArray:tempArray];
        [self reloadData];
        
        [self.header endRefreshing];
        
    } else {
        
        if (self.houseListTapCallBack) {
            
            self.houseListTapCallBack(hHouseListActionTypeNoRecord,nil);
            
        }
        
        [self.customDataSource removeAllObjects];
        [self reloadData];
        
        [self.header endRefreshing];
        [self.footer endRefreshing];
        
    }
    
}

- (void)downloadServerHistoryNewHouseData
{
    
    ///封装参数
    NSDictionary *params = @{@"view_type" : @"990103",
                             @"key" : @"",
                             @"page_num" : @"10",
                             @"now_page" : @"1"};
    
    [QSRequestManager requestDataWithType:rRequestTypeHistoryNewHouseList andParams:params andCallBack:^(REQUEST_RESULT_STATUS resultStatus, id resultData, NSString *errorInfo, NSString *errorCode) {
        
        ///重置数据源
        self.dataModel = nil;
        
        ///下载成功
        if (rRequestResultTypeSuccess == resultStatus) {
            
            QSYHistoryNewHouseListReturnData *tempModel = resultData;
            if ([tempModel.headerData.dataList count] > 0) {
                
                self.dataModel = tempModel;
                
                if (self.houseListTapCallBack) {
                    
                    self.houseListTapCallBack(hHouseListActionTypeHaveRecord,nil);
                    
                }
                
                ///刷新数据
                [self reloadData];
                
                ///结束动画
                [self.header endRefreshing];
                
                ///保存数据
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    [self saveHistorySecondHandHouseToLocal];
                    
                });
                
            } else {
                
                APPLICATION_LOG_INFO(@"下载服务端浏览新房信息", @"服务端数据为空")
                self.isLocalData = YES;
                [self newHouseListHeaderRequest];
                
            }
            
        } else {
            
            APPLICATION_LOG_INFO(@"下载服务端浏览新房信息", @"失败")
            self.isLocalData = YES;
            [self newHouseListHeaderRequest];
            
        }
        
    }];
    
}

- (void)saveHistorySecondHandHouseToLocal
{
    
    for (int i = 0; i < [self.dataModel.headerData.dataList count]; i++) {
        
        QSYHistoryListNewHouseDataModel *newHouseModel = self.dataModel.headerData.dataList[i];
        
        BOOL isSave = [QSCoreDataManager checkDataIsSaveToLocal:newHouseModel.houseInfo.loupan_id andHouseType:fFilterMainTypeNewHouse];
        
        if (!isSave) {
            
            QSNewHouseDetailDataModel *saveModel = [newHouseModel.houseInfo changeToNewHouseDetailModel];
            saveModel.is_syserver = @"1";
            [QSCoreDataManager saveHistoryDataWithModel:saveModel andHistoryType:fFilterMainTypeNewHouse andCallBack:^(BOOL flag) {
                
                if (flag) {
                    
                    APPLICATION_LOG_INFO(@"浏览记录->新房->同步服务端后保存本地", @"成功")
                    
                } else {
                    
                    APPLICATION_LOG_INFO(@"浏览记录->新房->同步服务端后保存本地", @"失败")
                    
                }
                
            }];
            
        }
        
    }
    
}

#pragma mark - 返回当前的房源个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (!self.isLocalData) {
        
        return [self.dataModel.headerData.dataList count];
        
    }
    return [self.customDataSource count];
    
}

#pragma mark - 返回每一个房源
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *normalCellName = @"newHouseInfoCell";
    
    ///从复用队列中返回cell
    QSAttentionCommunityCell *cellNormal = [collectionView dequeueReusableCellWithReuseIdentifier:normalCellName forIndexPath:indexPath];
    
    ///获取数据
    QSNewHouseDetailDataModel *tempModel = self.customDataSource[indexPath.row];
    if (self.isLocalData) {
        
        tempModel = self.customDataSource[indexPath.row];
        
    } else {
        
        QSYHistoryListNewHouseDataModel *historyModel = self.dataModel.headerData.dataList[indexPath.row];
        tempModel = [historyModel.houseInfo changeToNewHouseDetailModel];
        
    }
    
    ///刷新数据
    [cellNormal updateHistoryNewHouseInfoCellUIWithDataModel:tempModel];
    cellNormal.isEditing = self.isEditing;
    cellNormal.selected = YES;
    
    return cellNormal;
    
}

#pragma mark - 进入新房详情
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.isEditing) {
        
        return;
        
    }

    ///获取数据
    QSNewHouseDetailDataModel *tempModel = self.customDataSource[indexPath.row];
    if (self.isLocalData) {
        
        tempModel = self.customDataSource[indexPath.row];
        
    } else {
        
        QSYHistoryListNewHouseDataModel *historyModel = self.dataModel.headerData.dataList[indexPath.row];
        tempModel = [historyModel.houseInfo changeToNewHouseDetailModel];
        
    }
    
    if (self.houseListTapCallBack) {
        
        self.houseListTapCallBack(hHouseListActionTypeGotoDetail,tempModel);
        
    }

}

#pragma mark - 设置编辑状态
/**
 *  @author             yangshengmeng, 15-05-03 12:05:28
 *
 *  @brief              通过给定的数字设置当前的编辑状态
 *
 *  @param isEditing    0-未编辑状态；1-编辑状态
 *
 *  @since              1.0.0
 */
- (void)setIsEditingWithNumber:(NSNumber *)isEditing
{
    
    if ([isEditing intValue] == 1) {
        
        self.isEditing = YES;
        
    } else {
        
        self.isEditing = NO;
        
    }
    
}

- (void)setIsEditing:(BOOL)isEditing
{
    
    _isEditing = isEditing;
    
    ///判断是否是删除
    if (!isEditing &&
        ([self.customDataSource count] > 0 ||
         [self.dataModel.headerData.dataList count] > 0)) {
        
        [self clearHistoryNewHouse];
        
    } else {
        
        [self reloadData];
        
    }
    
}

- (void)clearHistoryNewHouse
{
    
    __block QSCustomHUDView *hud = [QSCustomHUDView showCustomHUDWithTips:@"正在清空"];
    
    ///判断是否已登录
    if (![QSCoreDataManager isLogin]) {
        
        [self clearLocalHistoryData:NO];
        [hud hiddenCustomHUDWithFooterTips:@"已清空新房浏览记录" andDelayTime:2.5f andCallBack:^(BOOL flag) {
            
            [self.header beginRefreshing];
            
        }];
        
        return;
        
    }
    
    ///封装参数
    NSDictionary *params = @{@"log_type" : [NSString stringWithFormat:@"%d",hHistoryHouseTypeNewHouse]};
    
    [QSRequestManager requestDataWithType:rRequestTypeDeleteHistoryHouse andParams:params andCallBack:^(REQUEST_RESULT_STATUS resultStatus, id resultData, NSString *errorInfo, NSString *errorCode) {
        
        ///清空成功
        if (rRequestResultTypeSuccess == resultStatus) {
            
            [self clearLocalHistoryData:YES];
            [hud hiddenCustomHUDWithFooterTips:@"已清空新房浏览记录" andDelayTime:1.5f andCallBack:^(BOOL flag) {
                
                [self.header beginRefreshing];
                
            }];
            
        } else {
        
            [self clearLocalHistoryData:NO];
            [hud hiddenCustomHUDWithFooterTips:@"已清空新房浏览记录" andDelayTime:1.5f andCallBack:^(BOOL flag) {
                
                [self.header beginRefreshing];
                
            }];
        
        }
        
    }];
    
}

- (void)clearLocalHistoryData:(BOOL)isSendServer
{
    
    [QSCoreDataManager deleteAllHistoryDataWithType:fFilterMainTypeNewHouse isSysServer:isSendServer];
    
}

@end
