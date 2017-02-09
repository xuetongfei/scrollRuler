# scrollRuler

![Image text](https://github.com/clarkIsMe/image/blob/master/rulerScrollDemo.gif)

#### 1、下载Demo到本地 
#### 2、把`scrollRuler`导入到工程中
## 在工程中的使用方法

```objective-c
//初始化
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
```
```objective-c
//设置一根红线标识
[self.view addSubview:self.ruler];
//设置样式
[self.ruler selectedAction];

//添加中央红色刻度线
UIView *line = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-0.5,fit(465*2+12) , 0.5, fit(70))];
[self.view addSubview:line];
line.backgroundColor = UIColorFromRGB(0xFF8519);
```
```objective-c
#pragma mark 标尺代理方法
- (void)rulerWith:(NSInteger)days {
    //即时打印出标尺滑动位置的数值
    NSLog(@"当前刻度值：%ld",days);
}
```
