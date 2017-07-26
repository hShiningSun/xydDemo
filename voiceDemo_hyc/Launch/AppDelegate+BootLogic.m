//
//  AppDelegate+BootLogic.m
//  threeT
//
//  Created by Admin on 2016/12/28.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

#define BOOTLOGIC_START      @"BOOTLOGIC_START"//启动
#define BOOTLOGIC_GUIDE      @"BOOTLOGIC_GUIDE"//引导

#import "AppDelegate+BootLogic.h"
#import "hButton.h"
#import "BaseTabbarViewController.h"
#import <objc/runtime.h>

#import "ViewController.h"
#import "BaseNavigationController.h"


@interface AppDelegate()
@property (nonatomic, strong) UIPageControl* page;
@end
// 启动逻辑
@implementation AppDelegate (BootLogic)

static char * _page = "page";
#pragma mark - 启动逻辑检测加载
- (void) checkLoadBootLogic
{
    
    //启动页面
    if (![kUserDefaults boolForKey:BOOTLOGIC_START])
    {
        [kUserDefaults setBool:YES forKey:BOOTLOGIC_START];
        [self showStartView];
        return;
    }
    
    //导航页面
    if (![kUserDefaults boolForKey:BOOTLOGIC_GUIDE])
    {
        [kUserDefaults setBool:YES forKey:BOOTLOGIC_GUIDE];
        [self showGuideView];
        return;
    }
    
    [self showIndexViewController];//首页
}
#pragma mark - 启动页面
- (void) showStartView
{
    UIViewController *startVC = [[UIViewController alloc]initWithNibName:nil bundle:nil];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    imageView.backgroundColor = [UIColor redColor];
    imageView.image = [UIImage imageNamed:@""];
    
    [startVC.view addSubview:imageView];
    
    self.window.rootViewController = startVC;
    
    [[GCDAfter Time:1]afterBlock:^{
        // 显示3秒
        [self checkLoadBootLogic];
    }];
}

#pragma mark - 引导页面
- (void) showGuideView
{
    UIViewController *guideVC = [self createGuideVC];
    self.window.rootViewController = guideVC;
}


-(UIViewController*) createGuideVC
{
    //vc
    UIViewController *guideViewController = [[UIViewController alloc]initWithNibName:nil bundle:nil];

    //sc
    UIScrollView *guideScrol = [[UIScrollView alloc]initWithFrame:guideViewController.view.bounds];
    guideScrol.delegate = self;
    guideScrol.pagingEnabled = YES;
    guideScrol.showsHorizontalScrollIndicator = NO;
    guideScrol.showsVerticalScrollIndicator = NO;
    guideScrol.contentSize = CGSizeMake(kSCREEN_WIDTH*4, kSCREEN_HEIGHT);
    
    //image
    NSArray * colorArr = @[[UIColor blueColor],[UIColor greenColor],[UIColor darkGrayColor],[UIColor whiteColor]];
    for (NSNumber *i in @[@0,@1,@2,@3]) {
        int index = i.intValue;
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(index*kSCREEN_WIDTH, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
        
        img.backgroundColor = colorArr[index];
        
        [img setImage:[UIImage imageNamed:[@"guide0" stringByAppendingFormat:@"%i",index+1]]];
        
        [guideScrol addSubview:img];
    }
    
    [guideViewController.view addSubview:guideScrol];
    
    
    // pageVC
    UIPageControl *Page = [[UIPageControl alloc]init];
    self.page = Page;
    Page.pageIndicatorTintColor = kRGBCOLOR(225, 225, 225);
    Page.numberOfPages = 4;
    Page.currentPage = 0;
    Page.currentPageIndicatorTintColor = [UIColor colorWithHexSystem:@"85d5f6"];
    [guideViewController.view addSubview:Page];
    [Page mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(guideViewController.view).with.offset(-45);
        make.centerX.equalTo(guideViewController.view);//.with.offset(100);
        make.width.offset(100);
        make.height.offset(10);
    }];
    
    
    // 进入按钮
    CGFloat bottomSpace = (70.0/667.0)*kSCREEN_HEIGHT;
    CGFloat BtnWitdh = (130.0/375.0)*kSCREEN_WIDTH;
    hButton *button = [[hButton alloc]initWithFrame:CGRectMake(0, 0, BtnWitdh, 34)];
    button.enableHighlightedAnimation = YES;
    [button setTitle:@"进入APP" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexSystem:@"fed061"] forState:UIControlStateNormal];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = CGRectGetHeight(button.bounds)/2;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor colorWithHexSystem:@"fed061"].CGColor;
    [button addTarget:self action:@selector(checkLoadBootLogic) forControlEvents:UIControlEventTouchUpInside];
    button.center = CGPointMake(guideScrol.bounds.size.width/2+kSCREEN_WIDTH*3, kSCREEN_HEIGHT-bottomSpace-20);
    
    [guideScrol addSubview:button];
    
    return guideViewController;
    
}

#pragma mark - 首页
- (void) showIndexViewController
{
    
    [kUserDefaults setBool:NO forKey:BOOTLOGIC_START];
    if ([self.oldRootController isKindOfClass:[BaseNavigationController class]]) {
        if (![self.window.rootViewController isKindOfClass:[BaseNavigationController class]]){
            self.window.rootViewController = self.oldRootController;
        }
    }
    else{
        BaseNavigationController *tabVC = [[BaseNavigationController alloc]init];
        self.window.rootViewController = tabVC;
    }
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int num = scrollView.contentOffset.x/kSCREEN_WIDTH;
    self.page.currentPage = num;
}

- (UIPageControl *)page
{
    return objc_getAssociatedObject(self, _page);
}
- (void)setPage:(UIPageControl *)page
{
    objc_setAssociatedObject(self, _page, page, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
