//
//  UIView+CGRectAndSize.m
//  threeT
//
//  Created by Admin on 2016/12/30.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

#import "UIView+CGRectAndSize.h"

@implementation UIView (CGRectAndSize)

- (CGFloat)sizeWidth
{
    return self.bounds.size.width;
}

- (CGFloat)seizHeight
{
    return self.bounds.size.height;
}

- (CGFloat)originX
{
    return self.frame.origin.x;
}

- (CGFloat)originY
{
    return self.frame.origin.y;
}
@end
