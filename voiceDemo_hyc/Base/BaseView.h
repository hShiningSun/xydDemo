//
//  BaseView.h
//  threeT
//
//  Created by Admin on 2016/12/21.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewModel.h"

@interface BaseView : UIView
@property (nonatomic, retain) BaseModel *viewModel;

/// 初始化设置
- (void) doSetup;

/// 设置view的UI显示数据
- (void) setViewData:(id)data;
@end
