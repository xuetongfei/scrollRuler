//
//  TTScrollRulerView.h
//  标尺
//
//  Created by 天天理财 on 16/12/27.
//  Copyright © 2016年 天天理财. All rights reserved.
//  马春雨 qq：943051580

#import <UIKit/UIKit.h>
#import "RullerView.h"

@protocol rulerDelegate <NSObject>

- (void)rulerWith:(NSInteger)days;

@end

@interface TTScrollRulerView : UIScrollView

@property (nonatomic,strong) id<rulerDelegate> rulerDelegate;

@property (nonatomic) NSInteger lockMin;//标尺可用范围的最小值

@property (nonatomic) NSInteger lockMax;//标尺可用范围的最大值

@property (nonatomic) NSInteger lockDefault;//标尺默认值

- (void)selectedAction;//标尺被选中的样式
- (void)unselectedAction;//标尺没有被选中的样式

- (void)drawRuler;//开始绘制标尺
- (void)reSetRulerMinMaxDefWithLockMin:(NSInteger)lockMin andLockMax:(NSInteger)lockMax andLockDef:(NSInteger)lockDef;//重新设置标尺的最小值，最大值和默认值

@end
