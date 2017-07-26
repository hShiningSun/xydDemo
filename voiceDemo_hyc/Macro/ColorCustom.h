//
//  ColorHeader.h
//  threeT
//
//  Created by Admin on 2016/12/21.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

#ifndef ColorHeader_h
#define ColorHeader_h

// ===============================  APP主色系  ============================*/
// 主色调
#define kCOLOR_MAIN_COLOR         [UIColor whiteColor]



// ===============================  tabbar ===============================
// 背景颜色
#define kCOLOR_TABBAR_BACKGROUND  [UIColor whiteColor]
// 字体颜色
#define kCOLOR_TABBAR_TITLE       [UIColor blackColor]



// ============================= navigation ===============================
// 导航字体颜色
#define kCOLOR_NAVI_TITLE         [UIColor blackColor]



// ==============================  转换颜色 ===============================
//颜色（RGB）
#define kRGBCOLOR(r,g,b)          [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define kRGBCOLOR_ALPHA(r,g,b,a)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//RGB颜色转换（16进制->10进制->颜色）给的颜色值不要加#
#define kRGBCOLOR_16VALUE(rgbValueString)    [UIColor colorWithRed:((float)((strtoul([rgbValueString UTF8String],0,16) & 0xFF0000) >> 16))/255.0 green:((float)((strtoul([rgbValueString UTF8String],0,16) & 0xFF00) >> 8))/255.0 blue:((float)(strtoul([rgbValueString UTF8String],0,16) & 0xFF))/255.0 alpha:1.0]

#endif /* ColorHeader_h */
