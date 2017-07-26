//
//  GCDAfter.h
//  threeT
//
//  Created by Admin on 2016/12/21.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDAfter : NSObject

+ (instancetype)Time:(double)time;

// 执行的block内容体
- (void)afterBlock:(dispatch_block_t)block;
@end
