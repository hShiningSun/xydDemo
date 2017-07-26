//
//  UIColor+func.h
//  threeT
//
//  Created by Admin on 2016/12/30.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (func)

// 将十六进制转换成颜色
+ (UIColor *) colorWithHexSystem:(NSString *)hexStstemString;
@end
