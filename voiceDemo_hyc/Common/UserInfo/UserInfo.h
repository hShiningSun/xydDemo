//
//  UserInfo.h
//  threeT
//
//  Created by Admin on 2017/1/10.
//  Copyright © 2017年 ChinaMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

+ (instancetype)shareInstance;

// 登陆状态
@property (nonatomic,assign) BOOL LoginStatus;

// 用户id
@property (nonatomic, strong) NSString *UserId;

// 用户昵称
@property (nonatomic, strong) NSString *NickName;



@end
