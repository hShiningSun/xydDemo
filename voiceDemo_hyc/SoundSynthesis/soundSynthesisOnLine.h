//
//  soundSynthesisOnLine.h
//  voiceDemo_hyc
//
//  Created by Admin on 2017/7/13.
//  Copyright © 2017年 xyd. All rights reserved.
//

/** 在线合成声音 */

#import <Foundation/Foundation.h>

#import <iflyMSC/iflyMSC.h>

@interface soundSynthesisOnLine : NSObject
+ (instancetype) shareInstance;

- (void) startSpeak:(NSString *)st;

/**
 *  带播放结束的回调
 */
- (void) startSpeak:(NSString *)st WithFinishblock:(void(^)(void))block_;


/**
 *  带播放开始结束的回调
 */
- (void) startSpeak:(NSString *)st WithStartBlock:(void(^)(void))startblock  Finishblock:(void(^)(void))block_;
@end
