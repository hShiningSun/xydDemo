//
//  UIColor+func.m
//  threeT
//
//  Created by Admin on 2016/12/30.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

#import "UIColor+func.h"

@implementation UIColor (func)

+ (UIColor *) colorWithHexSystem:(NSString *)hexStstemString
{
    return [UIColor colorWithRed:((float)((strtoul([hexStstemString UTF8String],0,16) & 0xFF0000) >> 16))/255.0 green:((float)((strtoul([hexStstemString UTF8String],0,16) & 0xFF00) >> 8))/255.0 blue:((float)(strtoul([hexStstemString UTF8String],0,16) & 0xFF))/255.0 alpha:1.0];
}
@end
