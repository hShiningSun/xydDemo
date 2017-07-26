//
//  BaseView.m
//  threeT
//
//  Created by Admin on 2016/12/21.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self doSetup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self doSetup];
}


- (void) doSetup {
    
}

- (void) setViewData:(id)data{
    
}

@end
