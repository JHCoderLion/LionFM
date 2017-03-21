//
//  JHTabBar.m
//  LionFM
//
//  Created by 赖锦浩 on 2017/3/14.
//  Copyright © 2017年 会跳舞的狮子. All rights reserved.
//

#import "JHTabBar.h"
#import "JHMiddleView.h"
#import "UIView+JHExtension.h"
#import "JHNavigationController.h"

#define JHScreenWidth [UIScreen mainScreen].bounds.size.width
#define JHScreenHeight [UIScreen mainScreen].bounds.size.height
@interface JHTabBar ()

@property (nonatomic, weak) JHMiddleView *middleView;

@end

@implementation JHTabBar

#pragma mark - 懒加载
- (JHMiddleView *)middleView
{
    if (!_middleView) {
        JHMiddleView *middleView = [JHMiddleView shareInstance];
        [self addSubview:middleView];
        _middleView = middleView;
    }
    
    return _middleView;
}

/** 初始化 */
-(instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setupInit];
    }
    return self;
}

- (void)setupInit {
    
    // 设置样式, 去除tabbar上面的黑线
    self.barStyle = UIBarStyleBlack;
    
    NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
    NSString *imagePath = [currentBundle pathForResource:@"tabbar_bg@2x.png" ofType:nil   inDirectory:@"LionFMMain.bundle"];
    UIImage *img = [UIImage imageWithContentsOfFile:imagePath];
    // 设置tabbar 背景图片
    self.backgroundImage = img;
    
    
    // 添加一个按钮, 准备放在中间
    CGFloat width = 65;
    CGFloat height = 65;
    self.middleView.frame = CGRectMake((JHScreenWidth - width) * 0.5, (JHScreenHeight - height), width, height);
    
}


-(void)setMiddleClickBlock:(void (^)(BOOL))middleClickBlock {
    self.middleView.middleClickBlock = middleClickBlock;
}

//布局子控件
-(void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger count = self.items.count;
    
    // 1. 遍历所有的子控件
    NSArray *subViews = self.subviews;
    
    // 确定单个控件的大小
    CGFloat btnW = self.jh_width / (count + 1);
    CGFloat btnH = self.jh_height;
    CGFloat btnY = 5;
    
    NSInteger index = 0;
    for (UIView *subView in subViews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (index == count / 2) { //索引是2 就多加一个索引 为中间的按钮留出位置
                index ++;
            }
            
            CGFloat btnX = index * btnW;
            subView.frame = CGRectMake(btnX, btnY, btnW, btnH);
            
            index ++;
        }
    }
    
    self.middleView.jh_width = 65;
    self.middleView.jh_height = 65;
    self.middleView.jh_centerX = self.frame.size.width * 0.5;
    self.middleView.jh_y = self.jh_height - self.middleView.jh_height;
    
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    
    // 设置允许交互的区域
    // 1. 转换点击在tabbar上的坐标点, 到中间按钮上
    CGPoint pointInMiddleBtn = [self convertPoint:point toView:self.middleView];
    
    // 2. 确定中间按钮的圆心
    CGPoint middleBtnCenter = CGPointMake(33, 33);
    
    // 3. 计算点击的位置距离圆心的距离
    CGFloat distance = sqrt(pow(pointInMiddleBtn.x - middleBtnCenter.x, 2) + pow(pointInMiddleBtn.y - middleBtnCenter.y, 2));
    
    // 4. 判定中间按钮区域之外
    if (distance > 33 && pointInMiddleBtn.y < 18) {
        return NO;
    }
    
    return YES;
}



@end
