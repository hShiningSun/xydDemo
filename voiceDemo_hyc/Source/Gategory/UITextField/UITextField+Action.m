//
//  UITextField+Action.m
//  threeT
//
//  Created by ychou on 2017/5/11.
//  Copyright © 2017年 ChinaMobile. All rights reserved.
//

#import "UITextField+Action.h"

@implementation UITextField (Action)

- (void) closeKeyboardInClickReturn
{
    [self addTarget:self action:@selector(closekeyboard) forControlEvents:UIControlEventEditingDidEndOnExit];
}

- (void) closekeyboard{
    [self resignFirstResponder];
}
@end
