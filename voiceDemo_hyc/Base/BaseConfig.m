//
//  BaseConfig.m
//  threeT
//
//  Created by Admin on 2016/12/19.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

#import "BaseConfig.h"

@implementation BaseConfig

/// 处理json数据
+ (instancetype)handleModelWithData:(id)data
{
    BaseConfig *config = [[BaseConfig alloc] init];
    return config;
}


#pragma mark - 填入自定义的section类型
+ (NSArray *)getAllSectionTypes
{
    NSArray *array = @[
                       @(UISectionDefault),
                       @(UISectionDefault),
                       @(UISectionDefault),
                       ];
    return array;
}

#pragma mark - 填入自定义section类型对应的 头的Identifier

+ (NSDictionary *)getSectionTypeToHeaderIdentifier
{
    NSDictionary *dic = @{
                          @(UISectionDefault) : @"_identifier_default",
                          };
    
    return dic;
}
#pragma mark - 填入自定义section类型对应的 头的View
+ (NSDictionary *)getSectionTypeToHeaderView
{
    NSDictionary *dic = @{
                          @(UISectionDefault) : @"UIDefaultView",
                          };
    
    return dic;
}

#pragma mark - 填入自定义section类型对应的 足的Identifier

+ (NSDictionary *)getSectionTypeToFootIdentifier
{
    NSDictionary *dic = @{
                          @(UISectionDefault) : @"_identifier_default",
                          
                          @(UISectionSingleImageForLine) : @"_identifier_Line",
                          };
    
    return dic;
}

#pragma mark - 填入自定义section类型对应的 足的View

+ (NSDictionary *)getSectionTypeToFootView
{
    NSDictionary *dic = @{
                          @(UISectionDefault) : @"UIDefaultView",
                          };
    
    return dic;
}


#pragma mark - 填入自定义section类型对应的 显示 配置
+ (NSDictionary *)getSectionTypeToModelConfig
{
    NSDictionary *dic = @{
                          @(UISectionDefault) : @"UICBanner",
                          
                          @(UISectionSingleImageForLine) : @"UICLineImage",
                          };
    return dic;
}

@end
