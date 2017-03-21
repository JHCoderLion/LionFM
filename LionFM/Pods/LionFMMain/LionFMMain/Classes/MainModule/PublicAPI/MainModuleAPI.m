//
//  MainModuleAPI.m
//  主要骨架
//

#import "MainModuleAPI.h"
#import "JHTabBar.h"
#import "JHTabBarController.h"
#import "JHNavBar.h"
#import "JHMiddleView.h"

@implementation MainModuleAPI

+ (JHTabBarController *)rootTabBarCcontroller {
    return [JHTabBarController shareInstance];
}


+ (void)addChildVC:(UIViewController *)vc normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName isRequiredNavController:(BOOL)isRequired {

    [[JHTabBarController shareInstance] addChildVC:vc normalImageName:normalImageName selectedImageName:selectedImageName isRequiredNavController:isRequired];

}


+ (void)setTabbarMiddleBtnClick: (void(^)(BOOL isPlaying))middleClickBlock {

    JHTabBar *tabbar = (JHTabBar *)[JHTabBarController shareInstance].tabBar;
    tabbar.middleClickBlock = middleClickBlock;

}

/**
 *  设置全局的导航栏背景图片
 *
 *  @param globalImg 全局导航栏背景图片
 */
+ (void)setNavBarGlobalBackGroundImage: (UIImage *)globalImg {
    [JHNavBar setGlobalBackGroundImage:globalImg];
}
/**
 *  设置全局导航栏标题颜色, 和文字大小
 *
 *  @param globalTextColor 全局导航栏标题颜色
 *  @param fontSize        全局导航栏文字大小
 */
+ (void)setNavBarGlobalTextColor: (UIColor *)globalTextColor andFontSize: (CGFloat)fontSize {

    [JHNavBar setGlobalTextColor:globalTextColor andFontSize:fontSize];

}

+ (UIView *)middleView {
    return [JHMiddleView middleView];
}


@end
