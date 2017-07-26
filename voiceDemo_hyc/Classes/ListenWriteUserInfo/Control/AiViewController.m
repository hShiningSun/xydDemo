//
//  AiViewController.m
//  voiceDemo_hyc
//
//  Created by Admin on 2017/7/24.
//  Copyright © 2017年 xyd. All rights reserved.
//

#import "AiViewController.h"

#import "soundSynthesisOnLine.h"// 转语音
#import "dictation.h"// 转文字
#import "hButton.h"

#import "AiCell.h"
#import "UserCell.h"
#import "AiFinishCell.h"
#import "AiViewModel.h"
#import "AiModel.h"

@interface AiViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 聊天tab */
@property (nonatomic,strong) UITableView *tableView;

/** viewModel */
@property (nonatomic,strong) AiViewModel *viewModel;

@end

@implementation AiViewController

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //_tableView.backgroundColor = [UIColor redColor];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.viewModel = [[AiViewModel alloc]init];
    
    self.title = @"AI语音录入";
    
    // 添加tab
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
    }];
    
    // 注册cell
    [self.tableView registerClass:[AiCell class] forCellReuseIdentifier:@"AiCell"];
    [self.tableView registerClass:[UserCell class] forCellReuseIdentifier:@"UserCell"];
    [self.tableView registerClass:[AiFinishCell class] forCellReuseIdentifier:@"AiFinishCell"];
    
    
    // AI进行第一次语音问话
    [self.viewModel startTalk];
    
    // 开启刷新section的第二个cell
    [self refreshSection];
    
    // 开启刷新tab
    [self refreshTable];


}

/** 
 *  刷新section 显示第二个cell用户说的内容 
 */

- (void) refreshSection
{
    @weakify(self);
    [RACObserve(self.viewModel, isRefresh) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSNumber *num = x;
        if ([num intValue] == 1) {
            
            [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:self.viewModel.indexData] withRowAnimation:UITableViewRowAnimationNone];
            
            self.viewModel.isRefresh = 0;
            [self.viewModel nextTalk];
        }
    }];
}


/** 
 *  刷新tableView 
 */
- (void) refreshTable
{
    @weakify(self);
    
    [RACObserve(self.viewModel, indexData) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
        [self.tableView reloadData];
        
        //indexData>0 代表接下机器人来说话
        if (x>0) {
            [self.viewModel startTalk];
        }
    }];
}


///**
// *  AI完成对话处理
// */
//
//- (void) aIFinisheSpeak
//{
//    [RACObserve(self.viewModel, isAIFinish) subscribeNext:^(id  _Nullable x) {
//        BOOL isFinish = x;
//        if (isFinish) {
//            
//        }
//    }];
//}


- (UITableViewCell *)getAiCell:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    // 加按钮
    if(self.viewModel.isAIFinish == 1 && indexPath.section == 4){
        AiFinishCell *finishCell = [self.tableView dequeueReusableCellWithIdentifier:@"AiFinishCell" forIndexPath:indexPath];
        cell = finishCell;
        
        return cell;
    }
    
    
    AiModel *model = [self.viewModel.dataArray objectAtIndex:indexPath.section];
    
    if (indexPath.row == 0) {
        AiCell *aiCell = [self.tableView dequeueReusableCellWithIdentifier:@"AiCell" forIndexPath:indexPath];
        aiCell.chatLabel.text = model.speakSt;
        [RACObserve(model, isShow) subscribeNext:^(id  _Nullable x) {
            NSNumber *num = x;
            if ([num intValue] == 1) {
                [UIView animateWithDuration:0.7 animations:^{
                    aiCell.chatLabel.alpha = 1;
                    aiCell.chatImageView.alpha = 1;
                    aiCell.headImageView.alpha = 1;
                }];
            }
        }];
        cell = aiCell;
    }
    else{
        UserCell *userCell = [self.tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];
        userCell.chatLabel.text = model.listenSt;
        
        cell = userCell;
    }
    
    return cell;
}

#pragma mark <tableview Delegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}



#pragma mark <tableview dataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.viewModel) {
        DLog(@"~~~~section个数==%ld",self.viewModel.indexData+1);
        return self.viewModel.indexData+1;
    }
    else{
        return 0;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.viewModel.isAIFinish == 1 && section == 4) {
        return 1;
    }
    
    AiModel *model = [self.viewModel.dataArray objectAtIndex:section];
    if (model.listenSt) {
        return 2;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [self getAiCell:indexPath];
    
    return cell;;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end


















