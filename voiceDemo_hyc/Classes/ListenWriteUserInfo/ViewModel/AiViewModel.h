//
//  AiViewModel.h
//  voiceDemo_hyc
//
//  Created by Admin on 2017/7/24.
//  Copyright © 2017年 xyd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AiViewModel : NSObject

/** 数据源数组 */
@property (nonatomic,strong,readonly) NSMutableArray *dataArray;

/** 记录是ai讲话还是用户用户讲话，用nsintger标记 */
@property (nonatomic,assign,readonly) NSInteger indexData;

/** 是否刷新 */
@property (nonatomic,assign) NSInteger isRefresh;

/** AI对话完成 */
@property (nonatomic,assign,readonly)  NSInteger isAIFinish;

/**
 *  播放语音
 */

- (void) startTalk;
- (void) nextTalk;
@end
