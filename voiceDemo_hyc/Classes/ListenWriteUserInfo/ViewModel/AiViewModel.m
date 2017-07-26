//
//  AiViewModel.m
//  voiceDemo_hyc
//
//  Created by Admin on 2017/7/24.
//  Copyright © 2017年 xyd. All rights reserved.
//


static NSString * const labName = @"姓名:";
static NSString * const labName_speak = @"你的名字叫什么？";
static NSString * const tfName_ploceholder = @"请输入你的姓名";

static NSString * const labAge = @"年龄:";
static NSString * const labAge_speak = @"你的年龄多大？";
static NSString * const tfAge_ploceholder = @"请输入你的年龄";

static NSString * const labIdentityCard = @"身份证:";
static NSString * const labIdentityCard_speak = @"你的身份证号码？";
static NSString * const tfIdentityCard_ploceholder = @"请输入你的身份证号码";

static NSString * const labMoney = @"金额:";
static NSString * const labMoney_speak = @"您借款的金额是多少？";
static NSString * const tfMoney_ploceholder = @"请输入你的年收入，人民币";

#import "AiViewModel.h"

#import "soundSynthesisOnLine.h"// 转语音
#import "dictation.h"// 转文字
#import "AiModel.h"

@interface AiViewModel()
{
    int speakMaxIndex;//对话次数 默认4次
}

/** 数据源数组 */
@property (nonatomic,strong,readwrite) NSMutableArray *dataArray;

/** 记录是ai讲话还是用户用户讲话，用nsintger标记 */
@property (nonatomic,assign,readwrite) NSInteger indexData;

/** AI对话完成 */
@property (nonatomic,assign,readwrite)  NSInteger isAIFinish;

@end


@implementation AiViewModel
- (instancetype)init
{
    self = [super init];

    NSArray *speakArr = @[labMoney_speak,labName_speak,labAge_speak,labIdentityCard_speak];
    
    self.dataArray = [NSMutableArray array];
    
    for (int k =0; k<4; k++) {
        @autoreleasepool {
            AiModel *model = [[AiModel alloc]init];
            model.speakSt = speakArr[k];
            model.isShow = NO;
        
            [self.dataArray addObject:model];
        }
    }
    
    self.indexData = 0;
    self.isRefresh = 0;
    self.isAIFinish = 0;
    speakMaxIndex = 4;
    return self;
}
- (void) startTalk{
    [self startTalk:self.indexData];
}
- (void) nextTalk
{
    if (self.indexData == 3) {
        [self setIsAIFinish:1];
    }

    if (self.indexData < speakMaxIndex) {
        self.indexData++;
    }
    else{
        DLog(@"对话完成");
        
    }
    
    
}
- (void) startTalk:(NSInteger)indexData
{
    if (self.isAIFinish == 1) {
        [self setIsRefresh:1];
        return;
    }
    // 播放问身份证号  主线程
    NSInteger index = indexData == -1?0:indexData;
    AiModel *model = self.dataArray[index];
    NSString *st = model.speakSt;
    
    [[soundSynthesisOnLine shareInstance]startSpeak:st WithStartBlock:^{
        model.isShow = 1;
        [[GCDAfter Time:0.1]afterBlock:^{
            [[dictation shareDictation]startListen:^(NSMutableString *st) {
                if ([model.speakSt isEqualToString:labMoney_speak] || [model.speakSt isEqualToString:labAge_speak]) {
                    double num = [Tools getDoubleWithString:st];
                    NSString *numString = [NSString stringWithFormat:@"%.0f",num];
                    model.listenSt = numString;
                }
                else{
                    model.listenSt = st;
                }
                [self setIsRefresh:1];
            }];
        }];

    } Finishblock:^{
//        [[GCDAfter Time:0.2]afterBlock:^{
//            [[dictation shareDictation]startListen:^(NSMutableString *st) {
//                if ([model.speakSt isEqualToString:labMoney_speak] || [model.speakSt isEqualToString:labAge_speak]) {
//                    double num = [Tools getDoubleWithString:st];
//                    NSString *numString = [NSString stringWithFormat:@"%.0f",num];
//                    model.listenSt = numString;
//                }
//                else{
//                    model.listenSt = st;
//                }
//                [self setIsRefresh:1];
//            }];
//        }];
    }];
}

@end
























