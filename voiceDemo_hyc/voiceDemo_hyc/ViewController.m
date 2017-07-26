//
//  ViewController.m
//  voiceDemo_hyc
//
//  Created by Admin on 2017/7/11.
//  Copyright © 2017年 xyd. All rights reserved.
//

#import "ViewController.h"
#import "iflyMSC/iflyMSC.h"
#import "SBJson4.h"

#import "dictation.h"
#import "soundSynthesisOnLine.h"
#import "ListenWriteUserInfoController.h"
#import "AiViewController.h"

@interface ViewController (){
    
    UILabel *resultLab;
}



@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"语音测试";
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"bg_1"];
    [self.view addSubview:imageView];
    
    
    
    UIButton *listenBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 420, 300, 40)];
    listenBtn.layer.cornerRadius = 5;
    listenBtn.layer.borderWidth = 1;
    listenBtn.layer.borderColor = [UIColor blackColor].CGColor;
    listenBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    listenBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
    
    [listenBtn setTitle:@"点击讲话" forState:UIControlStateNormal];
    [listenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [listenBtn addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *stopBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 320, 300, 40)];
    stopBtn.layer.cornerRadius = 5;
    stopBtn.layer.borderWidth = 1;
    stopBtn.layer.borderColor = [UIColor blackColor].CGColor;
    stopBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    stopBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
    
    [stopBtn setTitle:@"点击播放上面的文字" forState:UIControlStateNormal];
    [stopBtn addTarget:self action:@selector(speak) forControlEvents:UIControlEventTouchUpInside];
    [stopBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    resultLab = [[UILabel alloc]initWithFrame:CGRectMake(33, 80, 250, 200)];
    resultLab.backgroundColor = [UIColor colorWithRed:175 green:250 blue:200 alpha:0.5];
    resultLab.layer.cornerRadius = 5;
    resultLab.layer.borderWidth = 1;
    resultLab.layer.borderColor = [UIColor blackColor].CGColor;
    resultLab.text = @"暂无";
    resultLab.numberOfLines = 0;
    resultLab.textColor = [UIColor blackColor];
    resultLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:resultLab];
    
    [self.view addSubview:listenBtn];
    [self.view addSubview:stopBtn];
    
    
    UIButton *btn = [[UIButton alloc]init];
    btn.titleNormal = @"录入资料";
    btn.titleLabel.textColor = [UIColor blackColor];
    [btn eventTouchUpInSide:^{
        //ListenWriteUserInfoController * vc = [[ListenWriteUserInfoController alloc]init];
        AiViewController *vc = [[AiViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.width.offset(100);
        make.height.offset(30);
    }];
    
    
}

- (void)start:(UIButton *)sender
{
    
    [[dictation shareDictation] startListen:^(NSMutableString *st) {
        resultLab.text = st;
    }];
    
    resultLab.text = @"请讲话...";
    
}


- (void) speak
{
    [[soundSynthesisOnLine shareInstance]startSpeak:resultLab.text];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
/**
 #define APPID_VALUE           @"5964670c"
 #define URL_VALUE             @""                 // url
 #define TIMEOUT_VALUE         @"20000"            // timeout, Unit:ms
 #define BEST_URL_VALUE        @"1"                // best_search_url
 
 #define SEARCH_AREA_VALUE     @"Hefei,Anhui"
 #define ASR_PTT_VALUE         @"1"
 #define VAD_BOS_VALUE         @"5000"
 #define VAD_EOS_VALUE         @"1800"
 #define PLAIN_RESULT_VALUE    @"1"
 #define ASR_SCH_VALUE         @"1"

*/





 












