//
//  BaseView.h
//  threeT
//
//  Created by Admin on 2016/12/19.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseHeaderFootView : UITableViewHeaderFooterView


/// 初始化设置
- (void) doSetup;

/// 设置view的UI显示数据
- (void) setViewData:(id)data;
@end
