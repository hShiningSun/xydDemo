//
//  BaseView.m
//  threeT
//
//  Created by Admin on 2016/12/19.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

#import "BaseHeaderFootView.h"

@implementation BaseHeaderFootView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self doSetup];
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self doSetup];
    }
    return self;
}

- (void) doSetup {
    
}

- (void) setViewData:(id)data{
    DLog(@"到基础 headerFoot 来设置做什么");
}
@end
