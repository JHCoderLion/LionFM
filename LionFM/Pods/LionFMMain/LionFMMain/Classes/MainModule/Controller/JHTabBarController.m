//
//  JHTabBarController.m
//  LionFM
//
//  Created by 赖锦浩 on 2017/3/14.
//  Copyright © 2017年 会跳舞的狮子. All rights reserved.
//

#import "JHTabBarController.h"
#import "JHNavigationController.h"
#import "JHTabBar.h"
#import "UIImage+JHExtension.h"
#import "JHMiddleView.h"
@interface JHTabBarController ()

@end

@implementation JHTabBarController

+ (instancetype)shareInstance
{   //单例
    static JHTabBarController *tabBarVC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        tabBarVC = [[JHTabBarController alloc] init];
        
    });
    return tabBarVC;
    
}

+ (instancetype)tabBarControllerWithAddChildVCsBlock:(void (^)(JHTabBarController *))addVCBlock
{
    JHTabBarController *tabBarVC = [[JHTabBarController alloc] init];
    //严谨的做法
    if (addVCBlock) {
        addVCBlock(tabBarVC);
    }
    return tabBarVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTabBar];

}

- (void)setupTabBar
{
    
    [self setValue:[[JHTabBar alloc] init] forKey:@"tabBar"];

}


/**
 *  根据参数, 创建并添加对应的子控制器
 *
 *  @param vc                需要添加的控制器
 *  @param isRequired             标题
 *  @param normalImageName   一般图片名称
 *  @param selectedImageName 选中图片名称
 */
- (void)addChildVC:(UIViewController *)vc normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName isRequiredNavController:(BOOL)isRequired
{
    if (isRequired) {
        //包装导航栏控制器
        JHNavigationController *nav = [[JHNavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage originImageWithName:normalImageName] selectedImage:[UIImage originImageWithName:selectedImageName]];
        [self addChildViewController:nav];
    }else{
        [self addChildViewController:vc];
    }

}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    
    UIViewController *vc = self.childViewControllers[selectedIndex];
    if (vc.view.tag == 666) {
        vc.view.tag = 888;
        
        JHMiddleView *middleView = [JHMiddleView middleView];
        middleView.middleClickBlock = [JHMiddleView shareInstance].middleClickBlock;
        middleView.isPlaying = [JHMiddleView shareInstance].isPlaying;
        middleView.middleImg = [JHMiddleView shareInstance].middleImg;
        CGRect frame = middleView.frame;
        frame.size.width = 65;
        frame.size.height = 65;
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        frame.origin.x = (screenSize.width - 65) * 0.5;
        frame.origin.y = screenSize.height - 65;
        middleView.frame = frame;
        [vc.view addSubview:middleView];
        
    }
}
 
@end
