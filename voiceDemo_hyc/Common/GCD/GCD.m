//
//  GCD.m
//  HomeForPets
//
//  Created by Admin on 2016/11/12.
//  Copyright © 2016年 侯迎春. All rights reserved.
//

#import "GCD.h"

static GCD *mainQueue;
static GCD *concurrentQueue;
static GCD *globalQueue;
static GCD *highPriorityGlobalQueue;
static GCD *lowPriorityGlobalQueue;
static GCD *backgroundPriorityGlobalQueue;

@interface GCD()
@property (strong,nonatomic,readwrite) dispatch_queue_t dispatchQueue;
@end

@implementation GCD

// 队列

+ (instancetype)concurrentQueue{
    return concurrentQueue;
}
+ (instancetype)mainQueue {
    return mainQueue;
}

+ (instancetype)globalQueue {
    return globalQueue;
}

+ (instancetype)highPriorityGlobalQueue {
    return highPriorityGlobalQueue;
}

+ (instancetype)lowPriorityGlobalQueue {
    return lowPriorityGlobalQueue;
}

+ (instancetype)backgroundPriorityGlobalQueue {
    return backgroundPriorityGlobalQueue;
}

// block
- (void)queueBlock:(dispatch_block_t)block{
    dispatch_async(self.dispatchQueue, block);
}
+ (void)mainQueueBlock:(dispatch_block_t)block
{
    [[GCD globalQueue]queueBlock:^{
        [[GCD mainQueue]queueBlock:block];
    }];
}
#pragma mark 内存中第一加载此类.
+ (void)initialize {
    if (self == [GCD class]) {
        mainQueue = [[GCD alloc] initWithDispatchQueue:dispatch_get_main_queue()];
        globalQueue = [[GCD alloc] initWithDispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
        highPriorityGlobalQueue = [[GCD alloc] initWithDispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)];
        lowPriorityGlobalQueue = [[GCD alloc] initWithDispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)];
        backgroundPriorityGlobalQueue = [[GCD alloc] initWithDispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)];
        concurrentQueue = [[GCD alloc] initWithDispatchQueue:dispatch_queue_create("并行队列", DISPATCH_QUEUE_CONCURRENT)];
    }
}


- (instancetype)initWithDispatchQueue:(dispatch_queue_t)dispatchQueue {
    if ((self = [super init]) != nil) {
        self.dispatchQueue = dispatchQueue;
    }
    
    return self;
}




@end


