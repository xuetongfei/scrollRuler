//
//  RullerView.h
//  标尺
//
//  Created by 天天理财 on 16/12/27.
//  Copyright © 2016年 天天理财. All rights reserved.
//  马春雨 qq：943051580

#import <UIKit/UIKit.h>

typedef struct LineColor {
    
    CGFloat R;
    CGFloat G;
    CGFloat B;
    
} LineColor;

//c 函数构造结构体
LineColor lineColorMake(CGFloat R,CGFloat G,CGFloat B);

@interface RullerView : UIView

@property (nonatomic) NSInteger lockMax;//标尺的最大值，用于绘制
@property (nonatomic,strong) UIColor *txtColor;//标尺上数字的颜色
@property (nonatomic) LineColor lineColor;//标尺线的颜色

- (instancetype)initWithFrame:(CGRect)frame andLockMax:(NSInteger)lockMax;

- (void)reDrawWith:(NSInteger)lockMax;

#pragma 自定义的宏
//屏幕尺寸
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

//px宏除2
#define px(value) (value)/2.0
//按宽度适配
#define fit(value) (px(value))*ScreenW/375.0

// RGB颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

@end

