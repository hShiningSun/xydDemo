//
//  hButton.m
//  HomeForPets
//
//  Created by Admin on 2016/11/13.
//  Copyright © 2016年 侯迎春. All rights reserved.
//

#import "hButton.h"

@implementation hButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self doSetup];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self doSetup];
    }
    return self;
}

- (void)doSetup{
    self.clipsToBounds = YES;
}

- (void)setIsRound:(BOOL)isRound{
    _isRound = isRound;
    if (_isRound) {
        self.layer.cornerRadius = 5;
    }
    else{
        self.layer.cornerRadius = 0;
    }
    
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (self.enableHighlightedAnimation) {
        if (highlighted) {
            [self scalesToSmall];
        }else{
            [self scalesToIdentify];
        }
    }
    else{
        [super setHighlighted:highlighted];
    }
}

/// 缩小
- (void)scalesToSmall
{
    [UIView animateWithDuration:0.15 animations:^{
        self.layer.transform = CATransform3DMakeScale(0.9, 0.9, 0.9);
    }];
}
/// 正常
- (void)scalesToIdentify
{
    [UIView animateWithDuration:0.15 animations:^{
        self.layer.transform = CATransform3DIdentity;
    }];
}
@end
