//
//  HUD.m
//  threeT
//
//  Created by Admin on 2017/1/16.
//  Copyright © 2017年 ChinaMobile. All rights reserved.
//

#import "HUD.h"
#import "Tools.h"
@interface HUD(){
    NSTimer *timer;
    CGFloat progressValue;
}
@end
@implementation HUD

+ (instancetype)initWithText:(NSString *)text
{
    HUD *hud = [super showHUDAddedTo:[Tools currentViewController].view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;//默认设置成菊花
    hud.animationType = MBProgressHUDAnimationZoomOut;//默认缩放动画
    hud.label.text = text;
    
    
    return hud;
}


- (void) showDefaultProgressAimation
{
    progressValue = 0.0f;
    self.mode = MBProgressHUDModeAnnularDeterminate;
    
    timer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(addProgress) userInfo:nil repeats:YES];
    
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    [loop addTimer:timer forMode:NSRunLoopCommonModes];
    
    //[timer fire];
}


- (void) addProgress
{
    if ((int)(progressValue) == 1) {
        progressValue = 0.0f;
    }
    progressValue += 0.01;
    self.progress = progressValue;
}


- (void)setEnableButton:(BOOL)enableButton
{
    if (enableButton) {
        self.button.titleNormal = @"确定";
        [self.button eventTouchUpInSide:^{
            [self hideAnimated:YES];
        }];
    }
    _enableButton = enableButton;
}
@end
