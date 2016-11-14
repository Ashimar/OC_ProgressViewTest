#UIProgressView 进度条 (OC)

>


##一、属性及方法
###1、初始化方法


```
- (instancetype)initWithProgressViewStyle:(UIProgressViewStyle)style; // sets the view height according to the style
```

UIProgressViewStyle 是一个枚举:

```
typedef NS_ENUM(NSInteger, UIProgressViewStyle) {
    UIProgressViewStyleDefault,     // 普通样式
    UIProgressViewStyleBar,         // 用于工具条的样式
};
```

可以通过frame 设置进度条的位置，**高度**则需要用 transform 来设置：

```
_naviProgressView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);

```

###2、设置进度条风格样式

	@property(nonatomic) UIProgressViewStyle progressViewStyle; 
	
###3、设置进度条进度(0.0-1.0之间，默认为0.0)


	@property(nonatomic) float progress;
	
###4、设置已走过进度的进度条颜色
	@property(nonatomic, retain) UIColor* progressTintColor;
	
###5、设置未走过进度的进度条颜色
	@property(nonatomic, retain) UIColor* trackTintColor;
	
###6、设置进度条已走过进度的背景图案和为走过进度的背景图案(iOS7后没有效果了)

```
@property(nonatomic, retain) UIImage* progressImage;

@property(nonatomic, retain) UIImage* trackImage;
```

###7、设置进度条进度和是否动画显示(动画显示会平滑过渡)

```
- (void)setProgress:(float)progress animated:(BOOL)animated;
```

##二、应用情景

###1、 普通的进度条 添加到 view 中

```
- (UIProgressView *)myProgressView {
    if (!_myProgressView) {
        _myProgressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        
        _myProgressView.frame = CGRectMake(20, 100, 200, 20);
        
        _myProgressView.backgroundColor = [UIColor grayColor];
        
        _myProgressView.transform = CGAffineTransformMakeScale(1.0f, 10.0f);    // 设置高度
        
        _myProgressView.progressTintColor = [UIColor orangeColor];  // 已走过的颜色
        _myProgressView.trackTintColor = [UIColor whiteColor];  // 为走过的颜色
        
        _myProgressView.progress = 0.4; // 进度 默认为0.0∈[0.0,1.0]
    }
    return _myProgressView;
}
```

###2、添加到 导航栏中

> 添加到导航栏中的x,y点为（0，45），高度为1，宽度为屏幕高度

	[self.navigationController.navigationBar addSubview:self.naviProgressView]; // 导航栏加入进度条


```
- (UIProgressView *)naviProgressView {
    if (!_naviProgressView) {
        _naviProgressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        _naviProgressView.frame = CGRectMake(0, 45, self.view.frame.size.width, 1);     // 添加到导航栏中 的y为45,高度为1
        _naviProgressView.backgroundColor = [UIColor lightGrayColor];
        _naviProgressView.progress = 0.1;
        _naviProgressView.tintColor = [UIColor blueColor];
        _naviProgressView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);   // 设置高度为1;
    }
    return _naviProgressView;
}
```

###3、添加到状态栏中
> 添加到状态栏中的frame为 （0，0，屏幕宽度，20），需要添加到 window中，即

```
appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
 	
[appdelegate.window addSubview:self.progressView];  // 状态栏后面加入进度条

```
高度


	_progressView.transform = CGAffineTransformMakeScale(1.0f,20.0f);


如图：
![这里写图片描述](http://img.blog.csdn.net/20161114235911734)