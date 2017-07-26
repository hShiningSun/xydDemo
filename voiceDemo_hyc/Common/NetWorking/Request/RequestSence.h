//
//  RequestSence.h
//  threeT
//
//  Created by Admin on 2016/12/20.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

// 网络请求发起

#import <Foundation/Foundation.h>

/// 请求进度
typedef void(^RequestProgressBlock)(NSProgress * obj);
/// 请求完成
typedef void(^RequestSuccessBlock)(id obj);
/// 请求失败
typedef void(^RequestErrorBlock)(NSError *error);
/// 返回缓存
typedef void(^RequestCacheBlock)(id obj);

@interface RequestSence : NSObject

@property (nonatomic, strong, readonly) NSURLSessionDataTask * task;

/// 各种block
/// 进度
@property (nonatomic, copy) RequestProgressBlock progressBlock;
/// 成功
@property (nonatomic, copy) RequestSuccessBlock successBlock;
/// 失败
@property (nonatomic, copy) RequestErrorBlock errorBlock;
/// 缓存
@property (nonatomic, copy) RequestCacheBlock cacheBlock;

/// 取消
- (void)cancel;

/// get请求
+ (instancetype) requestGetWithURL:(NSString *)url parameters:(NSDictionary *)parameters;
//- (void) requestGetWithURL:(NSString *)url parameters:(NSDictionary *)parameters;

/// post请求
+ (instancetype) requestPOSTWithURL:(NSString *)url parameters:(NSDictionary *)parameters;
//- (void) requestPOSTWithURL:(NSString *)url parameters:(NSDictionary *)parameters;


/// RAC 方式请求
+ (RACSignal *) RACGetWithURL:(NSString *)url parameters:(NSDictionary *)parameters;
+ (RACSignal *) RACPostWithURL:(NSString *)url parameters:(NSDictionary *)parameters;
@end



