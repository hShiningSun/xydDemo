//
//  UIFont+custom.m
//  threeT
//
//  Created by Admin on 2016/12/28.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

#import "UIFont+custom.h"

@implementation UIFont (custom)

+ (UIFont *)customFontWithSize:(CGFloat)size
{
    UIFont *font = [UIFont fontWithName:kFONT_NAME size:size];
    return font;
}

@end
