//
//  BaseViewModel.m
//  threeT
//
//  Created by Admin on 2016/12/19.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

#define GITHUBURL             @"github.com/hShiningSun"
#define CODE_ERROR_RAC        2333                         // viewmodel 信号订阅失败
#define INFO_RACSIGNAL_ERROR  @{@"errorMessage":@"信号异常错误"}

#import "BaseViewModel.h"


@implementation BaseViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self doSetup];
    }
    return self;
}


- (RACSignal *)viewModelSignal

{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        // 如果有错，发送
        BOOL isError;
        if (isError) {
            [subscriber sendError:[NSError errorWithDomain:GITHUBURL code:CODE_ERROR_RAC userInfo:INFO_RACSIGNAL_ERROR]];
        }
        else
        {
            // 设置dataArray 数据源
            // 发送信号
            [subscriber sendNext:_dataArray];
        }
        
        
        // 没错信号发完后完成，有错不执行
        [subscriber sendCompleted];
        
        // 这里实在创建，没有一次性的订阅
        return nil;
    }];
}
// 初始化设置
- (void) doSetup
{
    
}
//发起请求
- (void) requestSend
{
    RACSignal * requestSignal = [RequestSence RACGetWithURL:@"" parameters:nil];
    [requestSignal subscribeNext:^(id  _Nullable x) {
        // 请求成功 返回
        
    } error:^(NSError * _Nullable error) {
        // 请求失败
        
    } completed:^{
        //请求完成
        
    }];
}

//解析数据
- (void) parsedData
{

}

//UI赋值
- (void) setViewData
{

}

@end
