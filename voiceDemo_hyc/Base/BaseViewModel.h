//
//  BaseViewModel.h
//  threeT
//
//  Created by Admin on 2016/12/19.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

#import "RequestSence.h"
/// 模块通信

@interface BaseViewModel : NSObject
// 数据源
@property (nonatomic, retain) NSMutableArray *dataArray;

// 创建信号
- (RACSignal *)viewModelSignal;

//发起请求
- (void) requestSend;

//解析数据
- (void) parsedData;

//UI赋值
- (void) setViewData;
@end
