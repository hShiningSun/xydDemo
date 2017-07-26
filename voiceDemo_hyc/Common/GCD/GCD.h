//
//  hGCD.h
//  HomeForPets
//
//  Created by Admin on 2016/11/12.
//  Copyright © 2016年 侯迎春. All rights reserved.
//

#import "GCDAfter.h"

// ************************************ 顺序线程锁 ************************************

// 创建信号号(线程锁)
#define hSemaphore(value)                   dispatch_semaphore_create(value)
// 信号量开始递减，如果信号值为0则等待
#define hSemaphoreWait(semaphore)           dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)

// 信号量+1 唤醒正在等待的线程 允许通过
#define hSemaphoreGo(semaphore)             dispatch_semaphore_signal(semaphore)

// ----------------------------------------------------------------------------------
// ************************************ 信号量 ************************************




#import <Foundation/Foundation.h>

@interface GCD : NSObject

@property (strong, readonly, nonatomic) dispatch_queue_t dispatchQueue;

// 主线程队列
+ (instancetype) mainQueue;


// ************************************ 队列 *****************************************
// 全局默认队列
+ (instancetype) globalQueue;

// 全局最高优先级队列
+ (instancetype) highPriorityGlobalQueue;

// 全局较低优先级队列
+ (instancetype) lowPriorityGlobalQueue;

// 并行队列
+ (instancetype) concurrentQueue;

// 全局后台队列
+ (instancetype) backgroundPriorityGlobalQueue;




// GCD执行的block
- (void)queueBlock:(dispatch_block_t)block;
+ (void)mainQueueBlock:(dispatch_block_t)block;

@end















