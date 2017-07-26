//
//  dictation.m
//  voiceDemo_hyc
//
//  Created by Admin on 2017/7/12.
//  Copyright © 2017年 xyd. All rights reserved.
//

#import "dictation.h"
#import "iflyMSC/iflyMSC.h"


@interface dictation()<IFlySpeechRecognizerDelegate>

/** 本次语音转换的文字 */
@property (nonatomic,strong) NSMutableString *resultString;

/** 语音识别对象 */
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;

/** 完成回调 */
@property (nonatomic,copy) finishBlock finishBlock;

@end

@implementation dictation

+ (instancetype)shareDictation
{
    static dispatch_once_t onceToken;
    static dictation *dict = nil;
    dispatch_once(&onceToken, ^{
        dict = [[dictation alloc]init];
        dict.resultString = [[NSMutableString alloc]init];
    });
    
    return dict;
}

- (BOOL)isListening
{
    return self.iFlySpeechRecognizer.isListening;
}

/**
 *  懒加载初始化听写对象
 */

- (IFlySpeechRecognizer *)iFlySpeechRecognizer
{
    if (_iFlySpeechRecognizer == nil) {
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
        
        // 设置听写模式
        [_iFlySpeechRecognizer setParameter: @"iat" forKey: [IFlySpeechConstant IFLY_DOMAIN]];
        
        // asr_audio_path 是录音文件名，设置value为nil或者为空取消保存，默认保存目录在Library/cache下。
        [_iFlySpeechRecognizer setParameter:@"iat.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        
        
        // 无标点
        [_iFlySpeechRecognizer setParameter:@"0" forKey:[IFlySpeechConstant ASR_PTT]];
        
        //SPEECH_TIMEOUT
        [_iFlySpeechRecognizer setParameter:@"50000" forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        
        _iFlySpeechRecognizer.delegate = self;
        
    }
    return _iFlySpeechRecognizer;
}

- (void)startListen:(void(^)(NSMutableString *st))block
{
    
    [self stop];
    
    self.finishBlock = block;
    
    [self start];
}


- (void)start
{
    // 启动听写
    [self.iFlySpeechRecognizer startListening];
}

- (void)stop
{
    // 停止录音
    [self.iFlySpeechRecognizer stopListening];
}
//识别结果返回代理
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast
{
    
    NSMutableString *listenString = [self listenStringWithResults:results];
    
    NSDictionary *dic = [self listenDicWithString:listenString];
    
    [self listenResultStringWithDic:dic];
    
    }
//识别会话结束返回代理
- (void)onError: (IFlySpeechError *) error{}
//停止录音回调
- (void) onEndOfSpeech{
    if (self.finishBlock) {
        self.finishBlock(self.resultString);
    }

}
//开始录音回调
- (void) onBeginOfSpeech{
    self.resultString = [NSMutableString stringWithString:@""];
}
//音量回调函数
- (void) onVolumeChanged: (int)volume{}
//会话取消回调
- (void) onCancel{}
@end


#pragma mark <解析听到的语音>
@implementation dictation (AnalysisJson)

/**
 *  得到听到的结果信息
 */
- (NSMutableString *)listenStringWithResults:(NSArray *)arr
{
    NSDictionary *dic = [arr objectAtIndex:0];
    if (dic == nil) { return [NSMutableString stringWithString:@"没有听到内容"];};
    
    NSString *dicString = dic.allKeys.firstObject;
    if (dicString == nil) { return [NSMutableString stringWithString:@"没有听到内容"];};
    
    return [NSMutableString stringWithString:dicString];
}

/**
 *  将听到结果信息字符串转化为json
 */
- (NSDictionary *)listenDicWithString:(NSMutableString *)st
{
    NSData *data = [st dataUsingEncoding:NSUTF8StringEncoding];
    if (data == nil) {
        return nil;
    }
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
  
    return dic;
}

/** 
 *  拼接这一次听到的结果 
 */
- (void)listenResultStringWithDic:(NSDictionary *)dic
{
    
    NSArray *wsDics = [dic objectForKey:@"ws"];
    for (NSDictionary *wsDic in wsDics) {
        @autoreleasepool {
            NSArray *cwDics = wsDic[@"cw"];
            
            for (NSDictionary *cwDic in cwDics) {
                
                [self.resultString appendFormat:@"%@",cwDic[@"w"]];
            }
        }
        
    }
}
@end




