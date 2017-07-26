//
//  define.h
//  threeT
//
//  Created by Admin on 2016/12/19.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

#ifndef Define_h
#define Define_h


// 头像宽高
#define kAVATAR_WIDTH       25

// 字体簇
#define kFONT_NAME          @""
#define kFONT_SIZE_19       19
#define kFONT_SIZE_16       16
#define kFONT_SIZE_14       14
#define kFONT_SIZE_12       12
#define kFONT_SIZE_10       10
#define kFONT_SIZE_8        8
/// 打印
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

/// 主屏幕的高度
#define kSCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height
/// 主屏幕的宽度
#define kSCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width




//加载图片
#define kPNGIMAGE(NAME)         [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define kJPGIMAGE(NAME)         [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define kIMAGE(NAME,EXT)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]

// xib界面的动画按钮 处理事件
#define kANIMATIONAL_TIME_BTN    0.1
// 边框的宽度
#define kBORDER_WIDTH            1


#endif /* define_h */
