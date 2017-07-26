//
//  UIImage+imageURL.m
//  threeT
//
//  Created by Admin on 2017/1/13.
//  Copyright © 2017年 ChinaMobile. All rights reserved.
//

#import "UIImage+imageURL.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImage (imageURL)
+ (UIImage *)imageWithURL:(NSString *)imageUrl
{
    
        __block UIImage *img;
        UIImageView *imgView = [[UIImageView alloc]init];
        [imgView sd_setImageWithURL:[NSURL URLWithString:imageUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (error) {
                DLog(@"图片URL未转化成Image,error==%@",error);
            }
            else{
                img = image;
            }
        }];
    
        return img;
    
    
}
@end
