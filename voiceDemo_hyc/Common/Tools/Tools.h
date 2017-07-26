//
//  Tools.h
//  threeT
//
//  Created by Admin on 2017/1/16.
//  Copyright © 2017年 ChinaMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject

// 当前活动的viewcontroller
+ (UIViewController *)currentViewController;

// 当前时间
+ (NSString *)currentDateTime;

/** 亿、万、千、百、十、两、三、四等转换成数字 */
+ (double)getDoubleWithString:(NSString *)st;
@end
