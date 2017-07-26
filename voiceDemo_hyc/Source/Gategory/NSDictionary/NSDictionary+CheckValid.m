//
//  NSDictionary+CheckValid.m
//  threeT
//
//  Created by Admin on 2017/1/16.
//  Copyright © 2017年 ChinaMobile. All rights reserved.
//

#import "NSDictionary+CheckValid.h"

@implementation NSDictionary (CheckValid)
static char *_useInfo = "_useInfo";


+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        // 选择器
        SEL originalSEL = @selector(objectForKey:);//@selector(objectForKey:);
        SEL SwizzledSEL = @selector(hObjectForKey:);
        
        
        //方法    使用NSDictionary、NSArray，必须使用与其对应的加入内存时的元类__NSDictionaryI  __NSArrayI
        //       __NSDictionaryI——NSDictionary   __NSDictionaryM——NSMutableDictionary
        //       __NSArrayI——NSArray             __NSArrayM——NSMutableArray
        Method originalMethod = class_getInstanceMethod(NSClassFromString(@"__NSDictionaryI"), originalSEL);//class_getClassMethod(class, originalSEL);备注的是获取静态方法
        Method SwizzledMethod = class_getInstanceMethod(NSClassFromString(@"__NSDictionaryI"), SwizzledSEL);//class_getClassMethod(class, SwizzledSEL);
        
        // 方法的实现
        IMP originalIMP = method_getImplementation(originalMethod);//class_getMethodImplementation(class, originalSEL);
        IMP SwizzledIMP = method_getImplementation(SwizzledMethod);//class_getMethodImplementation(class, SwizzledSEL);
        
        
        // 是否添加成功方法:添加了初始方法，实现内容指向目标方法体
        BOOL isSuccess = class_addMethod(class, originalSEL, SwizzledIMP, method_getTypeEncoding(SwizzledMethod));
        
        if (isSuccess) {
            // 初始指向目标，那么把目标的内容指向初始
            class_replaceMethod(class, SwizzledSEL, originalIMP, method_getTypeEncoding(originalMethod));
        }
        else{
            // 没有添加成功说明已经存在，就交换
            // 注意，这里交换的是IMP 实现
            method_exchangeImplementations(originalMethod, SwizzledMethod);
        }
        
    });

}



- (id)hObjectForKey:(id)aKey{
    
    id obj = [self hObjectForKey:aKey];

    if (self.useInfo == nil || [self.useInfo isEqualToString:@""]) {
        return obj;
    }
    
    if (obj == nil) {
        [self showHUD:aKey obj:obj];
        return obj;
    }
    
    if ([obj isKindOfClass:[NSString class]] && [obj isEqualToString:@"null"] && [obj isEqualToString:@"(null)"] && [obj isEqualToString:@"nsnull"] && [obj isEqualToString:@"(nsnull)"]) {
        [self showHUD:aKey obj:obj];
    }
    
    return obj;
}

- (void) showHUD:(NSString *)key obj:(id)obj
{
    
#ifdef DEBUG
    @autoreleasepool {
        
        
        if ([Tools currentViewController].view) {
            HUD *hud = [HUD initWithText:[NSString stringWithFormat:@"%@json出错",self.useInfo]];
            hud.mode = MBProgressHUDModeText;
            hud.detailsLabel.text = [NSString stringWithFormat:@"key = %@;obj = %@;dic = %@",key,obj,self];
            hud.animationType = MBProgressHUDAnimationZoomOut;
            hud.button.titleNormal = @"知道了";
            hud.button.layer.cornerRadius = 2.0;
            [hud.button eventTouchUpInSide:^{
                [hud hideAnimated:YES];
            }];
        }
        else
        {
            DLog(@"服务器json出错");
        }
    }
#else
    
#endif

}

- (NSString *)useInfo
{
  return  objc_getAssociatedObject(self, _useInfo);
}

- (void)setUseInfo:(NSString *)useInfo
{
    objc_setAssociatedObject(self, _useInfo, useInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
