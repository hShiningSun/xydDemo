//
//  BaseConfig.h
//  threeT
//
//  Created by Admin on 2016/12/19.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

// MVVM使用的基类配置

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    UISectionDefault = 0, // 白板
    UISectionSingleImageForLine = 100, // 就一行图片，相当于是空隙。
} UISectionType; // 模板样式,自定义


@interface BaseConfig : NSObject

/// 子类继承统一解析数据的方法
+ (instancetype) handleModelWithData:(id)data;

/// 获取section的全部类型
+ (NSArray *)getAllSectionTypes;

/// section header
+ (NSDictionary *)getSectionTypeToHeaderIdentifier;
+ (NSDictionary *)getSectionTypeToHeaderView;

/// section foolter
+ (NSDictionary *)getSectionTypeToFootIdentifier;
+ (NSDictionary *)getSectionTypeToFootView;


+ (NSDictionary *)getSectionTypeToModelConfig;

@end
