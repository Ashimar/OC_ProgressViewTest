//
//  ViewController.m
//  ProgressViewOfTabbar
//
//  Created by Ashimar on 16/11/14.
//  Copyright © 2016年 ZHZ. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
{
    NSTimer *timer; // 计时器
    int count;      // 记录长度
    AppDelegate *appdelegate;
}
@property (nonatomic, strong)UIProgressView *myProgressView;
@property (nonatomic, strong)UIProgressView *progressView;
@property (nonatomic, strong) UIProgressView *naviProgressView;
@property (nonatomic, strong) UIButton *reloadBtn;  // 重新加在的button
@end

@implementation ViewController

- (void)dealloc {
    timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    count = 0;
   
    appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    [appdelegate.window addSubview:self.progressView];  // 状态栏后面加入进度条
    
    [self.navigationController.navigationBar addSubview:self.naviProgressView]; // 导航栏加入进度条
    
    [self.view addSubview:self.myProgressView];
    
    [self.view addSubview:self.reloadBtn];
    
    
    /**
     *  开启一个计时器
     *
     *  @param timerAdvanced: 时间
     *
     *  @return timer
     */
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerAdvanced:) userInfo:nil repeats:YES];
}

- (void)timerAdvanced:(NSTimer *)sender//这个函数将会执行一个循环的逻辑
{
    count ++;
    
    CGFloat aProgress = count/10.0;
    [self.progressView setProgress:aProgress animated:YES];  // 有动画效果
    [self.naviProgressView setProgress:aProgress animated:YES];
    self.myProgressView.progress = aProgress;    // 无动画效果
    
    if (count > 10) {
        
        [timer setFireDate:[NSDate distantFuture]]; // 关闭计时器
    
        [self.progressView removeFromSuperview];
        [self.naviProgressView removeFromSuperview];
    }
}

- (void)reloadBtnAction: (UIButton *)sender {
    
    [appdelegate.window addSubview:self.progressView];  // 状态栏后面加入进度条
    
    [self.navigationController.navigationBar addSubview:self.naviProgressView]; // 导航栏加入进度条
    
    [timer setFireDate:[NSDate distantPast]];   // 打开计时器
    
    count = 0;
    
    self.progressView.progress = 0.0f;
    self.naviProgressView.progress = 0.0f;
    self.myProgressView.progress = 0.0f;
}

#pragma mark - lazyload
- (UIProgressView *)progressView {
    
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        
        _progressView.frame = CGRectMake(0, 0, self.view.frame.size.width, 20);
        _progressView.backgroundColor = [UIColor yellowColor];
        _progressView.trackTintColor = [UIColor redColor];
        _progressView.tintColor = [UIColor greenColor];
        _progressView.progress = 0.0f;
        //更改进度条高度
        _progressView.transform = CGAffineTransformMakeScale(1.0f,20.0f);
    }
    
    return _progressView;
}


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

- (UIButton *)reloadBtn {
    if (!_reloadBtn) {
        _reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _reloadBtn.frame = CGRectMake(20, 150, 100, 50);
        [_reloadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_reloadBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        _reloadBtn.backgroundColor = [UIColor orangeColor];
        [_reloadBtn addTarget:self action:@selector(reloadBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reloadBtn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
