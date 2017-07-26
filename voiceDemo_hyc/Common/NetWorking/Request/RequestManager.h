//
//  RequestManager.h
//  threeT
//
//  Created by Admin on 2016/12/19.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

// 网络管理对象

#import <AFNetworking/AFNetworking.h>

typedef void(^NetworkChangedHandle)(AFNetworkReachabilityStatus status);

@interface RequestManager : AFHTTPSessionManager

// 单例
+ (instancetype) sharedInstance;

// 初始不变的头
+ (NSString *)originalURL;

// 开启网络监控
- (void) startMonitoring;

/// 网络攺变了
@property (nonatomic, readonly) AFNetworkReachabilityStatus networkStatus;

/// 请求对象数组
@property (nonatomic, strong) NSMutableArray * requestObjArray;



#pragma mark -  get请求
- (NSURLSessionDataTask *)requestGet:(NSString *)url parameters:(NSDictionary *)params progressBlock:(void(^)(NSProgress *progress))progressBlock completion:( void (^)(id results, NSError *error) )completion;
#pragma mark -  post请求
- (NSURLSessionDataTask *)requestPost:(NSString *)url parameters:(NSDictionary *)params progressBlock:(void(^)(NSProgress *progress))progressBlock completion:( void (^)(id results, NSError *error) )completion;



@end
