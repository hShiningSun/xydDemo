//
//  GCDAfter.m
//  threeT
//
//  Created by Admin on 2016/12/21.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

#import "GCDAfter.h"

static GCDAfter *after;

@interface GCDAfter()

@property (nonatomic) dispatch_time_t dispatchTime;

@end

@implementation GCDAfter


// 延迟执行 time:时间
+ (instancetype)Time:(double)time{
    after = [[GCDAfter alloc]initWithDispatchTime:dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC))];
    return after;
}

- (instancetype)initWithDispatchTime:(dispatch_time_t)dispatchTime{
    if ((self = [super init]) != nil) {
        self.dispatchTime = dispatchTime;
    }
    return  self;
}

// 执行的block内容体
- (void)afterBlock:(dispatch_block_t)block{
    dispatch_after(self.dispatchTime, dispatch_get_main_queue(), block);
}


@end
