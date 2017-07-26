//
//  RequestSence.m
//  threeT
//
//  Created by Admin on 2016/12/20.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

#define asycAfterTimeValue   0.000001 //不影响程序执行

#import "RequestSence.h"
#import "RequestManager.h"

@interface RequestSence()
@property (nonatomic, strong) NSString *requestURL;

@property (nonatomic, strong, readwrite) NSURLSessionDataTask * task;

@end

@implementation RequestSence

/// get请求
+ (instancetype) requestGetWithURL:(NSString *)url parameters:(NSDictionary *)parameters
{
    // 检查是否有请求对象
    RequestSence * requestObj = [RequestSence checkRequestObjWithURL:url];
    [requestObj cancel];
    
    [[GCD globalQueue]queueBlock:^{
        [[GCDAfter Time:asycAfterTimeValue]afterBlock:^{
            requestObj.task =  [[RequestManager sharedInstance]requestGet:url parameters:parameters progressBlock:^(NSProgress *progress) {
                if(requestObj.progressBlock){
                    requestObj.progressBlock(progress);
                }
            } completion:^(id results, NSError *error) {
                [requestObj handleResult:results andError:error RequestSence:requestObj];
            }];
        }];
    }];
    return requestObj;
    
}
/// post请求
+ (instancetype) requestPOSTWithURL:(NSString *)url parameters:(NSDictionary *)parameters
{
    RequestSence * requestObj = [RequestSence checkRequestObjWithURL:url];
    [requestObj cancel];
    
    DLog(@"url==%@ \n 参数==%@",url,parameters);
    
    [[GCD globalQueue]queueBlock:^{
        [[GCDAfter Time:asycAfterTimeValue]afterBlock:^{
            
            requestObj.task =  [[RequestManager sharedInstance]requestPost:url parameters:parameters progressBlock:^(NSProgress *progress) {
                if(requestObj.progressBlock){
                    requestObj.progressBlock(progress);
                }
            } completion:^(id results, NSError *error) {
                [requestObj handleResult:results andError:error RequestSence:requestObj];
            }];
        }];
    }];
    
    
    return requestObj;
}



/// 检查管理器是否 缓存的有此请求
+ (instancetype) checkRequestObjWithURL:(NSString *)url
{
    NSMutableArray *requestObjArr = [RequestManager sharedInstance].requestObjArray;

    
    /// 根据url查找
    for (int i = 0; i<requestObjArr.count; i++) {
        RequestSence *obj = [requestObjArr objectAtIndex:i];
        if ([obj.requestURL isEqualToString:url]) {
            return obj;
        }
    }
    
    
    RequestSence * requestObj = [[RequestSence alloc]init];
    requestObj.requestURL = url;
    
    [requestObjArr addObject:requestObj];
    
    return requestObj;
}

/// 取消
- (void)cancel
{
    if (self.task == nil) {
        return;
    }
    if (self.task.state == NSURLSessionTaskStateCanceling) {
        return;
    }
    
    [self.task cancel];
    self.task = nil;
}

- (void)handleResult:(id)results andError:(NSError *)error RequestSence:(RequestSence *)obj
{
    if (error) {
        DLog(@"\n ~~~~~~ 报错啦 : %@ \n ~~~~~~ \n",error);
        [self checkErrorUserInfo:error];
        
        if (obj.errorBlock) {
            obj.errorBlock(error);
        }
        return ;
    }
    @try {
        int errorCode = [[results objectForKey:@"errorCode"] intValue];
        
        if (errorCode != 100) {
            if (obj.successBlock) {
                obj.successBlock(results);
            }
            return ;
        }

        
//        /// 记录静态地址
//        NSString *url = [NSString stringWithFormat:@"%@",[results objectForKey:@"staticUrl"]];
//        _kStaticURL = url;
//        
//        if (errorCode == 303) { // 没有登录
//            // 提示没有登录，并显示登录界面
//            _kUserInfo.isLogined = NO;
//            [_kUserInfo checkLoginStatus];
//            [self requestError:[self customErrorWithInfo:results]];
//            return;
//        }else if (errorCode != 100) {
//            [self requestError:[self customErrorWithInfo:results]];
//            return ;
//        }
//        [self requestFinished:results];
        
        if (obj.successBlock) {
            obj.successBlock(results);
        }

    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


- (void) checkErrorUserInfo:(NSError*)error
{
    NSDictionary * dic = error.userInfo;
    if ([dic[@"info"] isEqualToString:@"noNetWork"] ) {
        HUD * _hud = [HUD initWithText:@"无法连接网络"];
        
        _hud.mode = MBProgressHUDModeText;
        _hud.detailsLabel.text = @"当前没有网络或者无法识别此网络";
        _hud.enableButton = YES;
    }
}

#pragma mark - RAC 方式请求
+ (RACSignal *) RACGetWithURL:(NSString *)url parameters:(NSDictionary *)parameters{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 检查是否有请求对象
        RequestSence * requestObj = [RequestSence checkRequestObjWithURL:url];
        [requestObj cancel];
        requestObj.task = [[RequestManager sharedInstance]requestGet:url parameters:parameters progressBlock:^(NSProgress *progress) {
            if(requestObj.progressBlock){
                requestObj.progressBlock(progress);
            }
        } completion:^(id results, NSError *error) {
            
            if (error) {
                DLog(@"\n ~~~~~~ 报错啦 : %@ \n ~~~~~~ \n",error);
                [subscriber sendError:error];
                return ;
            }
            @try {
                int errorCode = [[results objectForKey:@"errorCode"] intValue];
                
                if (errorCode != 100) {
                    [subscriber sendNext:results];
                    return ;
                }
                [subscriber sendNext:results];
                
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }

            
        }];
        
        return [RACDisposable disposableWithBlock:^{
            DLog(@"取消订阅");
        }];
    }];
}
+ (RACSignal *) RACPostWithURL:(NSString *)url parameters:(NSDictionary *)parameters{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 检查是否有请求对象
        RequestSence * requestObj = [RequestSence checkRequestObjWithURL:url];
        [requestObj cancel];
        requestObj.task = [[RequestManager sharedInstance]requestPost:url parameters:parameters progressBlock:^(NSProgress *progress) {
            if(requestObj.progressBlock){
                requestObj.progressBlock(progress);
            }
        } completion:^(id results, NSError *error) {
            
            if (error) {
                DLog(@"\n ~~~~~~ 报错啦 : %@ \n ~~~~~~ \n",error);
                [subscriber sendError:error];
                return ;
            }
            @try {
                int errorCode = [[results objectForKey:@"errorCode"] intValue];
                
                if (errorCode != 100) {
                    [subscriber sendNext:results];
                    return ;
                }
                [subscriber sendNext:results];
                
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
            
            
        }];
        
        return [RACDisposable disposableWithBlock:^{
            DLog(@"取消订阅");
        }];
    }];
}
@end



