//
//  TTScrollRulerView.m
//  标尺
//
//  Created by 天天理财 on 16/12/27.
//  Copyright © 2016年 天天理财. All rights reserved.
//

#import "TTScrollRulerView.h"

@interface TTScrollRulerView()<UIScrollViewDelegate>
@property (nonatomic) CGFloat unit;
@property (nonatomic) int i;
@property (nonatomic,strong) RullerView *rView;
@end

@implementation TTScrollRulerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)drawRuler {
    //检查初始值
    if (self.lockMin == 0) {
        self.lockMin = 10;
    }
    if (self.lockMax == 0) {
        self.lockMax = 360;
    }
    if (self.lockDefault == 0) {
        self.lockDefault = 30;
    }
    
    //一屏横向最长放40个单位长度
    self.unit = fit(14);
    //总长度为360+2个单位长度
    self.contentSize = CGSizeMake(self.unit*(self.lockMin+self.lockMax+2)+[UIScreen mainScreen].bounds.size.width,0);
    //定位到30
    self.contentOffset = CGPointMake(self.unit*(self.lockDefault+1), 0);
    //初始不能滚动
    self.scrollEnabled = NO;
    
    //开始绘制
    self.rView = [[RullerView alloc] initWithFrame:CGRectMake(0, 0, self.unit*(self.lockMin+self.lockMax+2)+self.frame.size.width, self.bounds.size.height) andLockMax:self.lockMax];
    [self addSubview:self.rView];
    self.delegate = self;
}

- (void)reSetRulerMinMaxDefWithLockMin:(NSInteger)lockMin andLockMax:(NSInteger)lockMax andLockDef:(NSInteger)lockDef {
    self.lockMin = lockMin;
    self.lockMax = lockMax;
    self.lockDefault = lockDef;
    
    self.contentOffset = CGPointMake(self.unit*(self.lockDefault+1), 0);
    self.contentSize = CGSizeMake(self.unit*(self.lockMin+self.lockMax+2)+[UIScreen mainScreen].bounds.size.width,0);
    [self.rView reDrawWith:self.lockMax];
}

- (void)unselectedAction {
    self.rView.txtColor = UIColorFromRGB(0xDDDDDD);
    self.rView.lineColor = lineColorMake(221, 221, 221);
    [self.rView setNeedsDisplay];
    self.scrollEnabled = NO;
}
- (void)selectedAction {
    self.rView.txtColor = UIColorFromRGB(0x39495F);
    self.rView.lineColor = lineColorMake(200, 203, 210);
    [self.rView setNeedsDisplay];
    self.scrollEnabled = YES;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x <= self.unit*(self.lockMin+1)) {
        self.contentOffset = CGPointMake(self.unit*(self.lockMin+1), 0);
        [self.rulerDelegate rulerWith:self.lockMin];
    }
    if (scrollView.contentOffset.x >= self.unit*(self.lockMax+1)) {
        self.contentOffset = CGPointMake(self.unit*(self.lockMax+1), 0);
        [self.rulerDelegate rulerWith:self.lockMax];
    }
    self.i = (int)(self.contentOffset.x/self.unit+0.5);
    [self.rulerDelegate rulerWith:self.i-1];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate) {
        
    }else {
        self.i = (int)(self.contentOffset.x/self.unit+0.5);
        [self setContentOffset: CGPointMake(self.unit*self.i, 0) animated:YES];
        [self.rulerDelegate rulerWith:self.i-1];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.i = (int)(self.contentOffset.x/self.unit+0.5);
    [self setContentOffset: CGPointMake(self.unit*self.i, 0) animated:YES];
    [self.rulerDelegate rulerWith:self.i-1];
}



@end
