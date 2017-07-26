//
//  RequestManager.m
//  threeT
//
//  Created by Admin on 2016/12/19.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

#define hNetworkReachabilityStatusUnknown        AFNetworkReachabilityStatusUnknown
#define hNetworkReachabilityStatusNotReachable   AFNetworkReachabilityStatusNotReachable
#import "RequestManager.h"
#import "AFNetworkActivityIndicatorManager.h"

@interface RequestManager ()
@property (nonatomic, readwrite) AFNetworkReachabilityStatus networkStatus;


@end

@implementation RequestManager

+ (NSString *)originalURL
{
    NSString *url = nil;
#ifdef DEBUG
    url = @"http://183.230.102.57:10400";//@"http://www.baidu.com";   // 测试
#else
    url = @"http://api.onLine.com"; // 正式服务器
#endif
    return url;
}


+ (instancetype)sharedInstance
{
    static RequestManager * _manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:[RequestManager originalURL]];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        _manager = [[RequestManager alloc]initWithBaseURL:baseURL sessionConfiguration:config];
                
        _manager.requestObjArray = [NSMutableArray array];
        
         [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
    });
    
    
    return _manager;
}

/// 开启网络监控
- (void) startMonitoring
{
    
    @weakify(self)
    /// 网络状态回调
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        @strongify(self)
        self.networkStatus = status;

    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

}
#pragma mark - 添加一些公共参数
- (NSMutableDictionary *)paramsToPublicWith:(NSDictionary *)params
{
    if (params == nil) {
        params = @{};
    }
    NSMutableDictionary *finalParams = [NSMutableDictionary dictionaryWithDictionary:params];
#ifdef DEBUG
    
#else
    
#endif
    
//    [finalParams setObject:[GTPhoneInfo getAPPVersion] forKey:@"_ver"];
//    [finalParams setObject:@"IOS" forKey:@"_device"];
//    [finalParams setObject:[GTPhoneInfo getSystemVersion] forKey:@"_system"];
//    [finalParams setObject:[GTPhoneInfo getDetailModel] forKey:@"_phone"];
//    [finalParams setObject:_kMapManager.lng forKey:@"_lng"];
//    [finalParams setObject:_kMapManager.lat forKey:@"_lat"];
//    NSString *_uuid = GTAES([GTPhoneInfo getUUIDIdentifier]);
//    [finalParams setObject:_uuid forKey:@"_uuid"];
    return finalParams;
}


/// 更新用户地址
- (void)shouldUploadUserLocation
{
    //[_kMapManager uploadUserCurrentLocation];
}



#pragma mark -  get请求
- (NSURLSessionDataTask *)requestGet:(NSString *)url parameters:(NSDictionary *)params progressBlock:(void(^)(NSProgress *progress))progressBlock completion:( void (^)(id results, NSError *error) )completion
{
    if (self.networkStatus == 0 || self.networkStatus == -1) {
        if (completion) {
            
            NSError *err = [NSError errorWithDomain:self.baseURL.absoluteString code:-1001 userInfo:@{@"info":@"noNetWork"}];
            completion(nil, err);
        }
        return nil;
    }

    
    [self shouldUploadUserLocation];
    
    if (params == nil) {
        params = @{};
    }
    NSMutableDictionary *finalParams = [self paramsToPublicWith:params];
    DLog(@"\n请求参数 = %@ \n",finalParams);

    
    NSURLSessionDataTask *task = [self GET:url parameters:finalParams progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progressBlock) {
            progressBlock(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        if (httpResponse.statusCode == 200) {
            completion(responseObject, nil);
        } else {
            NSError *err = [NSError errorWithDomain:self.baseURL.absoluteString code:httpResponse.statusCode userInfo:nil];
            completion(nil, err);
        }
        DLog(@"Received: %@", responseObject);
        DLog(@"Received HTTP %ld", (long)httpResponse.statusCode);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        completion(nil, error);
    }];
    
    return task;
}
#pragma mark -  POST 请求
- (NSURLSessionDataTask *)requestPost:(NSString *)url parameters:(NSDictionary *)params progressBlock:(void(^)(NSProgress *progress))progressBlock completion:( void (^)(id results, NSError *error) )completion
{
    if (self.networkStatus == 0 || self.networkStatus == -1) {
        if (completion) {
            
            NSError *err = [NSError errorWithDomain:self.baseURL.absoluteString code:-1001 userInfo:@{@"info":@"noNetWork"}];
            completion(nil, err);
        }
        return nil;
    }
    
    [self shouldUploadUserLocation];
    
    if (params == nil) {
        params = @{};
    }
    NSMutableDictionary *finalParams = [self paramsToPublicWith:params];
    DLog(@"\n请求参数 = %@ \n",finalParams);
    NSURLSessionDataTask *task = [self POST:url parameters:finalParams progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progressBlock) {
            progressBlock(downloadProgress);
        }
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        if (httpResponse.statusCode == 200) {
            completion(responseObject, nil);
        } else {
            NSError *err = [NSError errorWithDomain:self.baseURL.absoluteString code:httpResponse.statusCode userInfo:nil];
            completion(nil, err);
        }
        DLog(@"Received: %@", responseObject);
        DLog(@"Received HTTP %ld", (long)httpResponse.statusCode);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 请求失败
        completion(nil, error);
    }];
    return task;
}

@end








//        //传入json格式数据，不写则普通post
//        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
//
//        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
//
//        _manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObject:@"text/html"];
