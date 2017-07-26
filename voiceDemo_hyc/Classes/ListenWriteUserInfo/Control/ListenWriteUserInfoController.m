//
//  ListenWriteUserInfoController.m
//  voiceDemo_hyc
//
//  Created by Admin on 2017/7/18.
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

static NSString * const labMoney = @"年收入:";
static NSString * const labMoney_speak = @"你的年收入多少？";
static NSString * const tfMoney_ploceholder = @"请输入你的年收入，人民币";

static CGFloat const widthLab  = 100.0f;
static CGFloat const heightLab = 30.0f;

#import "ListenWriteUserInfoController.h"

#import "soundSynthesisOnLine.h"// 转语音
#import "dictation.h"// 转文字
#import "hButton.h"

@interface ListenWriteUserInfoController ()
{
    UIView *containerView;
    
    dispatch_queue_t listenDispatchQueue;
}

@property (nonatomic, copy) NSMutableString *listenName; //听到的名字
@property (nonatomic, copy) NSMutableString *listenAge; //年龄
@property (nonatomic, copy) NSMutableString *listenIdentityCard; //身份证
@property (nonatomic, copy) NSMutableString *listenMoney; //年收入
@end

@implementation ListenWriteUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"录入资料测试";
    
    listenDispatchQueue = dispatch_queue_create("录入用户资料", NULL);
    
    [self setupUI];
    
    hButton *openBtn = [[hButton alloc]init];//WithFrame:CGRectMake(50, CGRectGetHeight(self.view.bounds)-150, 200, 40)];
    [containerView addSubview:openBtn];
    [openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(containerView).offset(-150);
        make.centerX.equalTo(containerView);
        make.height.offset(40);
        make.width.offset(150);
    }];
    
    
    [[GCDAfter Time:0.3]afterBlock:^{
        openBtn.isRound = YES;
    }];
    
    openBtn.enableHighlightedAnimation = YES;
    openBtn.backgroundColor = [UIColor whiteColor];
    openBtn.titleNormal = @"开始语音听信息";
    [openBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    __weak typeof(self) weak_self = self;
    [openBtn eventTouchUpInSide:^{
        [weak_self openListen];
    }];
    
    
    
}


/** 
 *  设置页面UI 
 */
- (void) setupUI
{
    // 背景
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.image = [UIImage imageNamed:@"bg_1"];
    [self.view addSubview:imgView];
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
    
    // 容器
    containerView = [[UIView alloc]initWithFrame:self.view.bounds];
    containerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_1"]];
    [self.view addSubview:containerView];
    
    // 姓名
    UILabel *nameLabel = [self getAddLabelWithTitile:labName];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView).offset(60);
        make.left.equalTo(containerView).offset(20);
        make.width.offset(widthLab);
        make.height.offset(heightLab);
    }];
    
    UITextField *tfName = [self getAddTFWithPlaceholder:tfName_ploceholder];
    [tfName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView).offset(60);
        make.left.equalTo(nameLabel.mas_right).offset(20);
        make.right.equalTo(containerView).offset(-20);
        make.height.offset(heightLab);
    }];
    
    RAC(tfName,text) = RACObserve(self, listenName);
    
    // 年龄
    UILabel *ageLabel = [self getAddLabelWithTitile:labAge];
    [ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel).offset(60);
        make.left.equalTo(containerView).offset(20);
        make.width.offset(widthLab);
        make.height.offset(heightLab);
    }];
    
    UITextField *tfAge = [self getAddTFWithPlaceholder:tfAge_ploceholder];
    [tfAge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel).offset(60);
        make.left.equalTo(ageLabel.mas_right).offset(20);
        make.right.equalTo(containerView).offset(-20);
        make.height.offset(heightLab);
    }];
    
    RAC(tfAge,text) = RACObserve(self, listenAge);
    
    // 身份证号
    UILabel *identityCardLabel = [self getAddLabelWithTitile:labIdentityCard];
    [identityCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ageLabel).offset(60);
        make.left.equalTo(containerView).offset(20);
        make.width.offset(widthLab);
        make.height.offset(heightLab);
    }];
    
    UITextField *tfIdentityCard = [self getAddTFWithPlaceholder:tfIdentityCard_ploceholder];
    [tfIdentityCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ageLabel).offset(60);
        make.left.equalTo(identityCardLabel.mas_right).offset(20);
        make.right.equalTo(containerView).offset(-20);
        make.height.offset(heightLab);
    }];
    
    RAC(tfIdentityCard,text) = RACObserve(self, listenIdentityCard);
    
    // 年收入
    UILabel *moneyLabel = [self getAddLabelWithTitile:labMoney];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(identityCardLabel).offset(60);
        make.left.equalTo(containerView).offset(20);
        make.width.offset(widthLab);
        make.height.offset(heightLab);
    }];
    
    UITextField *tfMoney = [self getAddTFWithPlaceholder:tfMoney_ploceholder];
    [tfMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(identityCardLabel).offset(60);
        make.left.equalTo(moneyLabel.mas_right).offset(20);
        make.right.equalTo(containerView).offset(-20);
        make.height.offset(heightLab);
    }];
    
    RAC(tfMoney,text) = RACObserve(self, listenMoney);
}

#pragma mark <启动听写>
- (void) openListen
{
    __weak typeof(self) weak_self = self;
    [[soundSynthesisOnLine shareInstance]startSpeak:labName_speak WithFinishblock:^{
        
        [[dictation shareDictation]startListen:^(NSMutableString *st) {
            weak_self.listenName = st;
            [[GCDAfter Time:2]afterBlock:^{
                [weak_self listenAgel];
            }];
            
        }];
        
    }];
}

- (void) listenAgel
{
    __weak typeof(self) weak_self = self;
    
    
    // 播放问年龄  主线程
    
    [[soundSynthesisOnLine shareInstance]startSpeak:labAge_speak WithFinishblock:^{
        
        [[GCDAfter Time:0.2]afterBlock:^{
            [[dictation shareDictation]startListen:^(NSMutableString *st) {
                weak_self.listenAge = st;
                [[GCDAfter Time:2]afterBlock:^{
                    [weak_self speakIedntidtyCard];
                }];
            }];
        }];
    }];
}


- (void) speakIedntidtyCard
{
    __weak typeof(self) weak_self = self;
    
    
    // 播放问身份证号  主线程
    
    [[soundSynthesisOnLine shareInstance]startSpeak:labIdentityCard_speak WithFinishblock:^{
        
        [[GCDAfter Time:0.2]afterBlock:^{
            [[dictation shareDictation]startListen:^(NSMutableString *st) {
                
                    weak_self.listenIdentityCard = st;
                    [[GCDAfter Time:2]afterBlock:^{
                        [weak_self speakMoney];
                    }];
            }];
        }];
    }];
}


- (void) speakMoney
{
    __weak typeof(self) weak_self = self;
    // 播放问身份证号  主线程
    
    [[soundSynthesisOnLine shareInstance]startSpeak:labMoney_speak WithFinishblock:^{
        
        [[GCDAfter Time:0.2]afterBlock:^{
            [[dictation shareDictation]startListen:^(NSMutableString *st) {
                weak_self.listenMoney = st;
                
                
            }];
        }];
    }];
}
#pragma mark <创建添加label>
- (UILabel *)getAddLabelWithTitile:(NSString *)titSt
{
    UILabel *label = [[UILabel alloc]init];
    label.text = titSt;
    [self.view addSubview:label];
    
    return label;
}


#pragma mark <创建添加输入框>

- (UITextField *)getAddTFWithPlaceholder:(NSString *)ploceholder
{
    UITextField *tf = [[UITextField alloc]init];
    tf.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    tf.layer.cornerRadius = 5;
    tf.layer.borderWidth = 1;
    //tf.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    tf.placeholder = ploceholder;
    [self.view addSubview:tf];
    
    return tf;
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
