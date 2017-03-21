//
//  UIView+JHExtension.h
//  LionFM
//
//  Created by 赖锦浩 on 2017/3/14.
//  Copyright © 2017年 会跳舞的狮子. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JHExtension)
@property (nonatomic, assign) CGFloat jh_x;
@property (nonatomic, assign) CGFloat jh_y;
@property (nonatomic, assign) CGFloat jh_width;
@property (nonatomic, assign) CGFloat jh_height;
@property (nonatomic, assign) CGFloat jh_centerX;
@property (nonatomic, assign) CGFloat jh_centerY;
//从xib里面加载View
+ (instancetype)jh_viewWithXib;

@end
