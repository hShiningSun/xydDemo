//
//  HUD.h
//  threeT
//
//  Created by Admin on 2017/1/16.
//  Copyright © 2017年 ChinaMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface HUD : MBProgressHUD

// 按钮是否可用
@property (nonatomic,assign) BOOL enableButton;

+ (instancetype)initWithText:(NSString *)text;

// 显示默认进度动画
- (void) showDefaultProgressAimation;
@end
