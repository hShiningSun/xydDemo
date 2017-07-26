//
//  Tools.m
//  threeT
//
//  Created by Admin on 2017/1/16.
//  Copyright © 2017年 ChinaMobile. All rights reserved.
//  

#import "Tools.h"
#import "NSString+helper.h"

@implementation Tools
+ (UIViewController *)currentViewController
{
    UIViewController* activityViewController = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows){
            if(tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0){
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        
        if([nextResponder isKindOfClass:[UIViewController class]]){
            activityViewController = nextResponder;
        }else{
            activityViewController = window.rootViewController;
        }
    }
    
   
    while (1) {
        // 如果是tabbar
        if ([activityViewController isKindOfClass:[UITabBarController class]]) {
            activityViewController = ((UITabBarController*)activityViewController).selectedViewController;
        }
        
        // 如果是 导航
        if ([activityViewController isKindOfClass:[UINavigationController class]]) {
            activityViewController = ((UINavigationController*)activityViewController).visibleViewController;
        }
        
        // 如果是 present 跳转
        if (activityViewController.presentedViewController) {
            activityViewController = activityViewController.presentedViewController;
        }else{
            break;
        }
        
    }
    
    return activityViewController;
}


+ (NSString *)currentDateTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYYMMDDhhmmss"];
    return [formatter stringFromDate:[NSDate date]];
}


#pragma mark <汉子转化数字>
+ (double)getDoubleWithString:(NSString *)st
{
    double num = 0.0;
    //去掉元
    if ([st hasSuffix:@"元"]||[st hasSuffix:@"岁"]) {
        st = [st substringWithRange:NSMakeRange(0, st.length-1)];
    }
    
    if([st doubleValue]>0){
        return [st doubleValue];
    }
    
    NSMutableArray *stArr = [NSMutableArray array];
    
    for (NSInteger i = 0; i<st.length; i++) {
        unichar cha = [st characterAtIndex:i];
        NSString *currentSt = [[NSString alloc]initWithCharactersNoCopy:&cha length:1 freeWhenDone:NO];
        [stArr addObject:[currentSt mutableCopy]];
    }
    
    
    
    
    
    // 去掉无用字符
    stArr = [Tools checkNoUserAndDelete:stArr ];
    
    // 一万   十万    二万五千三百一十五    一万五
    NSInteger unitNumber = [Tools countUnitWithArr:stArr];
    
    
    // 计算最终结果
    num = [Tools countResultWithArr:stArr unitNum:unitNumber];
    
    return num;
}

//#pragma mark <去掉元>
//+(NSMutableArray *) deleteYuan:(NSMutableArray *)stArr
//{
//    NSMutableArray *arr = stArr;
//    for (int i = 0; i<arr.count; i++) {
//        NSString *st = arr[i];
//        
//        if ([st is:@"元"]) {
//            [arr removeObject:st];
//            i--;
//        }
//    }
//    
//    
//    return arr;
//}
#pragma mark <检查是否有无用的字符，有则删去>
+ (NSMutableArray *) checkNoUserAndDelete:(NSMutableArray *)stArr
{
    NSMutableArray *arr = stArr;
    for (int i = 0; i<arr.count; i++) {
        NSString *st = arr[i];
        if (([st is:@"一"] || [st is:@"二"]|| [st is:@"三"]|| [st is:@"四"]|| [st is:@"五"]|| [st is:@"六"]|| [st is:@"七"]|| [st is:@"八"]|| [st is:@"九"]|| [st is:@"十"]|| [st is:@"亿"]|| [st is:@"万"] || [st is:@"千"] || [st is:@"百"]|| [st is:@"两"]) == NO) {
            [arr removeObject:st];
            i--;
        }
    }
    
    return arr;
}

#pragma mark <单个数字转化数字>
+ (double)getNumWithString:(NSString *)st
{
    double num = 0.0;
    if ([st is:@"一"]||[st is:@"个"]) {
        num = 1;
    }
    else if ([st is:@"二"] || [st is:@"两"]){
        num = 2;
    }
    else if ([st is:@"三"]){
        num = 3;
    }
    else if ([st is:@"四"]){
        num = 4;
    }
    else if ([st is:@"五"]){
        num = 5;
    }else if ([st is:@"六"]){
        num = 6;
    }else if ([st is:@"七"]){
        num = 7;
    }else if ([st is:@"八"]){
        num = 8;
    }else if ([st is:@"九"]){
        num = 9;
    }else if ([st is:@"十"]){
        num = 10;
    }else if ([st is:@"亿"]){
        num = 100000000;
    }else if ([st is:@"万"]){
        num = 10000;
    }else if ([st is:@"千"]){
        num = 1000;
    }else if ([st is:@"百"]){
        num = 100;
    }
    
    return num;
}

#pragma mark <计算有几组>
+ (NSInteger) countUnitWithArr:(NSMutableArray *)arr
{
    NSInteger num;
    num = arr.count;
    
    //只有一位
    if (num == 1) {
        num = 1;
    }
    else if(num % 2 == 0){
        num = num/2;
    }
    else{
        num = num/2 + 1;
    }

    return num;
}

#pragma mark <计算最终结果>
+ (double) countResultWithArr:(NSMutableArray *)arr unitNum:(NSInteger)unitNum
{
    NSInteger num = 0;
    
    NSString* lastPositionUnitSt;
    
    for (int i = 0; i<unitNum*2; i+=2) {
        //最高位的数字
        double maxPositionNum;
        NSString *maxPositionString = arr[i];
    
        
        if ([maxPositionString is:@"亿"] || [maxPositionString is:@"万"] || [maxPositionString is:@"千"] ||[maxPositionString is:@"百"]) {
            maxPositionNum = 1;
        }
        else{
            maxPositionNum  = [Tools getNumWithString:maxPositionString];
        }

        
        // 最高位的单位
        double maxPositionUnitNum;
        NSString *maxPositionUnitString;
        if (arr.count == 1) {
            maxPositionUnitString = @"个";
        }
        else if (i<unitNum){
            maxPositionUnitString = arr[i+1];
        }
        else{//没有这一位的处理
            maxPositionUnitString = [Tools minOfUnitSt:lastPositionUnitSt];
        }
        
        lastPositionUnitSt = maxPositionUnitString;
        
        maxPositionUnitNum = [Tools getNumWithString:maxPositionUnitString];
        
        num = maxPositionNum * maxPositionUnitNum  + num;
        
    }
    
    return num;
}

+ (NSString *) minOfUnitSt:(NSString *)st
{
    NSArray *arr = @[@"亿",@"万",@"千",@"百",@"十",@"个"];
    __block NSInteger idex;
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:st]) {
            idex = idx+1;
            *stop = YES;
        }
    }];
    NSString *string = arr[idex];
    
    return string;
}
@end
