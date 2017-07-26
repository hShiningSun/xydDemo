//
//  dictation.h
//  voiceDemo_hyc
//
//  Created by Admin on 2017/7/12.
//  Copyright © 2017年 xyd. All rights reserved.
//

typedef void(^finishBlock)(NSMutableString *st);
#import <Foundation/Foundation.h>

@interface dictation : NSObject
@property (nonatomic,assign,readonly)  BOOL isListening;

/** 单例 */
+ (instancetype) shareDictation;

/** 启动听并拿到结果 */
- (void) startListen:(void(^)(NSMutableString *st))block;

@end

#pragma mark <解析听到的语音>
@interface dictation (AnalysisJson)
- (NSMutableString *)listenStringWithResults:(NSArray *)arr;
- (NSDictionary *)listenDicWithString:(NSMutableString *)st;
- (void)listenResultStringWithDic:(NSDictionary *)dic;

@end
