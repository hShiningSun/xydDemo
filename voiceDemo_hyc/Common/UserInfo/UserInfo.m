//
//  UserInfo.m
//  threeT
//
//  Created by Admin on 2017/1/10.
//  Copyright © 2017年 ChinaMobile. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

+ (instancetype)shareInstance
{
    static UserInfo * user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[UserInfo alloc]init];
    });
    
    return user;
}
@end
