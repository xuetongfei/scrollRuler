//
//  RullerView.m
//  标尺
//
//  Created by 天天理财 on 16/12/27.
//  Copyright © 2016年 天天理财. All rights reserved.
//

#import "RullerView.h"

#define RULERHEIGHT fit(60)

@interface RullerView()
@property (nonatomic) CGFloat unit;//标尺单位长度
@property (nonatomic) CGFloat width_x;//标尺粗
@property (nonatomic) CGFloat width_y;//
@property (nonatomic) CGFloat y_r_bottom;//标尺底部y轴位置
@property (nonatomic) CGFloat y_r_middle;//标尺中部y轴位置
@property (nonatomic) CGFloat y_r_top;//标尺上部y轴位置
@property (nonatomic) CGFloat y_n_height;//数字高度
@property (nonatomic) CGFloat y_n_top;//数字上不y轴位置

@end

@implementation RullerView

- (instancetype)initWithFrame:(CGRect)frame andLockMax:(NSInteger)lockMax {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //一屏横向最长放50个单位长度
        self.unit = fit(14);
        
        //标尺纵坐标
        self.y_r_bottom = self.frame.size.height;
        self.y_r_middle = self.frame.size.height-fit(12);
        self.y_r_top = self.frame.size.height-fit(24);
        self.y_n_height = fit(24);
        self.y_n_top = self.frame.size.height - RULERHEIGHT + fit(10);
        
        //标尺粗0.5像素
        self.width_x = fit(1);
        self.width_y = fit(2);
        
        //初始数字颜色
        self.txtColor = UIColorFromRGB(0xDDDDDD);
        //初始标尺线的颜色
        self.lineColor = lineColorMake(221, 221, 221);
        //初始标尺的最大值
        self.lockMax = lockMax;
        
        //开始绘制
        [self setNeedsDisplay];
    }
    return self;
}

//绘制方法
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context,self.lineColor.R,self.lineColor.G,self.lineColor.B,1.0);
    CGContextSetLineWidth(context, self.width_x);
    //画x轴
    CGPoint aPoints[2];//X轴
    aPoints[0] =CGPointMake(0, self.y_r_bottom);//起始点
    aPoints[1] =CGPointMake(self.bounds.size.width, self.y_r_bottom);//终点
    CGContextAddLines(context, aPoints, 2);//添加线
    CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
    
    //画纵轴
    for (int i=0; i<(self.lockMax+1); i++) {
        CGContextSetRGBStrokeColor(context,self.lineColor.R,self.lineColor.G,self.lineColor.B,1.0);
        CGContextSetLineWidth(context, self.width_y);
        CGPoint aPoints[2];//X轴
        aPoints[0] =CGPointMake([UIScreen mainScreen].bounds.size.width/2+self.unit+self.unit*i, i%10==0?self.y_r_top:self.y_r_middle);//起始点
        aPoints[1] =CGPointMake([UIScreen mainScreen].bounds.size.width/2+self.unit+self.unit*i, self.y_r_bottom);//终点
        CGContextAddLines(context, aPoints, 2);//添加线
        CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
        
        if (i%10==0) {
            NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
            textStyle.lineBreakMode = NSLineBreakByWordWrapping;
            textStyle.alignment = NSTextAlignmentCenter;
            UIFont  *font = [UIFont systemFontOfSize:fit(24)];
            NSDictionary *attributes = @{NSForegroundColorAttributeName:self.txtColor,NSFontAttributeName:font, NSParagraphStyleAttributeName:textStyle};
            [@(i).stringValue drawInRect:CGRectMake([UIScreen mainScreen].bounds.size.width/2+self.unit*(i-4)+self.unit, self.y_n_top, self.unit*8, self.y_n_height) withAttributes:attributes];
        }
    }
}

- (void)reDrawWith:(NSInteger)lockMax {
    self.lockMax = lockMax;
    [self setNeedsDisplay];
}

//c 函数构造结构体
LineColor lineColorMake(CGFloat R,CGFloat G,CGFloat B) {
    LineColor l;l.R = R/255.0;l.G = G/255.0;l.B = B/255.0; return l;
}

@end
