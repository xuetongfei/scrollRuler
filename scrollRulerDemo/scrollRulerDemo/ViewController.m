//
//  ViewController.m
//  scrollRulerDemo
//
//  Created by 天天理财 on 17/2/3.
//
//

#import "ViewController.h"
#import "TTScrollRulerView.h"

@interface ViewController ()<rulerDelegate>

@property (nonatomic,strong) TTScrollRulerView *ruler;
@property (nonatomic,strong) UIView *line;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //添加到当前视图
    [self.view addSubview:self.ruler];
    //设置样式
    [self.ruler selectedAction];
    
    //添加中央红色刻度线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-0.5,fit(465*2+12) , 0.5, fit(70))];
    [self.view addSubview:line];
    line.backgroundColor = UIColorFromRGB(0xFF8519);
}

- (TTScrollRulerView *)ruler {
    if (!_ruler) {
        _ruler = [[TTScrollRulerView alloc] initWithFrame:CGRectMake(0,fit(465*2+22-90), ScreenW, fit(60+90))];
        //设置代理
        _ruler.rulerDelegate = self;
        //设置最小值
        _ruler.lockMin = 10;
        //设置最大值
        _ruler.lockMax = 360;
        //设置默认值
        _ruler.lockDefault = 30;
        //开始绘制
        [_ruler drawRuler];
    }
    return _ruler;
}
#pragma mark 标尺代理方法
- (void)rulerWith:(NSInteger)days {
    //即时打印出标尺滑动位置的数值
    NSLog(@"当前刻度值：%ld",days);
}


@end
