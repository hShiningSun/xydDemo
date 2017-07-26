//
//  BaseModel.h
//  threeT
//
//  Created by Admin on 2016/12/19.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BaseModel : NSObject
/// 此model 做什么的
@property (nonatomic, strong) NSString * descriptionModel;

/// 解析model
+ (instancetype) handleModelWithData:(id)data;
@end
