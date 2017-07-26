//
//  soundSynthesisOnLine.m
//  voiceDemo_hyc
//
//  Created by Admin on 2017/7/13.
//  Copyright © 2017年 xyd. All rights reserved.
//


#import "soundSynthesisOnLine.h"

@interface soundSynthesisOnLine()<IFlySpeechSynthesizerDelegate>
{
    int isEnd;
}

/** 合成对象 */
@property (nonatomic, strong) IFlySpeechSynthesizer *iFlySpeechSynthesizer;

/** 播放结束的回调block */
@property (nonatomic, copy) void(^OKblock)(void) ;

/** 开始播放block */
@property (nonatomic, copy) void(^startBlock)(void) ;

@end

@implementation soundSynthesisOnLine


- (IFlySpeechSynthesizer *)iFlySpeechSynthesizer
{
    if (_iFlySpeechSynthesizer == nil) {
        _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
        _iFlySpeechSynthesizer.delegate = self;
        
        //设置在线工作方式
        [_iFlySpeechSynthesizer setParameter:[IFlySpeechConstant TYPE_CLOUD]forKey:[IFlySpeechConstant ENGINE_TYPE]];
        
        //设置音量，取值范围 0~100
        [_iFlySpeechSynthesizer setParameter:@"50"
                                      forKey: [IFlySpeechConstant VOLUME]];
        
        //发音人，默认为”xiaoyan”，可以设置的参数列表可参考“合成发音人列表”
        [_iFlySpeechSynthesizer setParameter:@" xiaoyan "
                                      forKey: [IFlySpeechConstant VOICE_NAME]];
        
        //保存合成文件名，如不再需要，设置为nil或者为空表示取消，默认目录位于library/cache下
        [_iFlySpeechSynthesizer setParameter:@" tts.pcm"
                                      forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];
         
    }
    
    return _iFlySpeechSynthesizer;
}

+ (instancetype) shareInstance
{
    static dispatch_once_t onceToken;
    static soundSynthesisOnLine *obj = nil;
    dispatch_once(&onceToken, ^{
        obj = [[soundSynthesisOnLine alloc]init];
    });
    
    return obj;
}



- (void) startSpeak:(NSString *)st
{

    [self.iFlySpeechSynthesizer startSpeaking:st];
}

- (void) startSpeak:(NSString *)st WithStartBlock:(void(^)(void))startblock  Finishblock:(void(^)(void))block_
{
    isEnd = -1;
    self.OKblock = block_;
    self.startBlock = startblock;
    [self.iFlySpeechSynthesizer startSpeaking:st];
}

/**
 *  带播放结束的回调
 */
- (void) startSpeak:(NSString *)st WithFinishblock:(void(^)(void))block_
{

    isEnd = 0;
    self.OKblock = block_;
    [self.iFlySpeechSynthesizer startSpeaking:st];
    
}


//IFlySpeechSynthesizerDelegate协议实现
//合成结束
- (void) onCompleted:(IFlySpeechError *) error {

}
//合成开始
- (void) onSpeakBegin {

}
//合成缓冲进度
- (void) onBufferProgress:(int) progress message:(NSString *)msg {}
//合成播放进度
- (void) onSpeakProgress:(int) progress beginPos:(int)beginPos endPos:(int)endPos {
    if (progress == 100 && self.OKblock && isEnd == 0) {
        isEnd = 1;
        [[GCDAfter Time:0.2]afterBlock:^{
            self.OKblock();
        }];
        
    }
    else if(progress > 0 && self.startBlock && isEnd == -1){
        isEnd = 0;
        [[GCDAfter Time:0.2]afterBlock:^{
            self.startBlock();
        }];
    }
}
@end
























