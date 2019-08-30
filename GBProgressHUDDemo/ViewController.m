//
//  ViewController.m
//  GBProgressHUDDemo
//
//  Created by 高斌 on 2019/8/30.
//  Copyright © 2019年 dhst. All rights reserved.
//

#import "ViewController.h"
#import "GBProgressHUD.h"

@interface ViewController ()
@property (nonatomic, strong) UIView * testView;

@end

@implementation ViewController{
    MBProgressHUD *HUD;
    float pro;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _testView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 200, 450)];
    //    _testView.center = self.view.center;
    _testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_testView];
    
    
    UIButton * btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 200, 20)];
    [btn1 addTarget:self action:@selector(btn_testView:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"纯文本" forState:UIControlStateNormal];
    btn1.tag = 1001;
    [_testView addSubview:btn1];
    
    UIButton * btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 90, 200, 20)];
    [btn2 addTarget:self action:@selector(btn_testView:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"成功" forState:UIControlStateNormal];
    btn2.tag = 1002;
    [_testView addSubview:btn2];
    
    UIButton * btn3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 130, 200, 20)];
    [btn3 addTarget:self action:@selector(btn_testView:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setTitle:@"失败" forState:UIControlStateNormal];
    btn3.tag = 1003;
    [_testView addSubview:btn3];
    
    UIButton * btn4 = [[UIButton alloc] initWithFrame:CGRectMake(0, 170, 200, 20)];
    [btn4 addTarget:self action:@selector(btn_testView:) forControlEvents:UIControlEventTouchUpInside];
    [btn4 setTitle:@"加载中（菊花）" forState:UIControlStateNormal];
    btn4.tag = 1004;
    [_testView addSubview:btn4];
    
    UIButton * btn5 = [[UIButton alloc] initWithFrame:CGRectMake(0, 210, 200, 20)];
    [btn5 addTarget:self action:@selector(btn_testView:) forControlEvents:UIControlEventTouchUpInside];
    [btn5 setTitle:@"加载中（环形）" forState:UIControlStateNormal];
    btn5.tag = 1005;
    [_testView addSubview:btn5];
    
    UIButton * btn6 = [[UIButton alloc] initWithFrame:CGRectMake(0, 250, 200, 20)];
    [btn6 addTarget:self action:@selector(btn_testView:) forControlEvents:UIControlEventTouchUpInside];
    [btn6 setTitle:@"加载中（下载进度）" forState:UIControlStateNormal];
    btn6.tag = 1006;
    [_testView addSubview:btn6];
    
    UIButton * btn7 = [[UIButton alloc] initWithFrame:CGRectMake(0, 290, 200, 20)];
    [btn7 addTarget:self action:@selector(btn_testView:) forControlEvents:UIControlEventTouchUpInside];
    [btn7 setTitle:@"自定义图片+文字" forState:UIControlStateNormal];
    btn7.tag = 1007;
    [_testView addSubview:btn7];
    
    UIButton * btn8 = [[UIButton alloc] initWithFrame:CGRectMake(0, 330, 200, 20)];
    [btn8 addTarget:self action:@selector(btn_testView:) forControlEvents:UIControlEventTouchUpInside];
    [btn8 setTitle:@"自定义动画" forState:UIControlStateNormal];
    btn8.tag = 1008;
    [_testView addSubview:btn8];
    
    UIButton * btn9 = [[UIButton alloc] initWithFrame:CGRectMake(0, 370, 200, 20)];
    [btn9 addTarget:self action:@selector(btn_testView:) forControlEvents:UIControlEventTouchUpInside];
    [btn9 setTitle:@"透明菊花" forState:UIControlStateNormal];
    btn9.tag = 1009;
    [_testView addSubview:btn9];
    
}


-(void)btn_testView:(UIButton *)sender{
    switch (sender.tag) {
        case 1001:{
            
            [GBProgressHUD showMessage:@"我是纯文本1号"];
//            [GBProgressHUD showMessage:@"显示文字，1s隐藏" inView:self.view];
            //如果想设置N秒隐藏，用这个
//            [GBProgressHUD showMessage:@"显示文字，Ns隐藏" inView:self.view afterDelayTime:5.0];
            break;
        }
        case 1002:{
            
            [GBProgressHUD showSuccess:@"成功测试1号"];
//            [GBProgressHUD showSuccess:@"成功" inview:_testView];
            break;
        }
        case 1003:{
            
            [GBProgressHUD showFailure:@"失败测试1号" ];
            break;
        }
        case 1004:{
            
            //菊花加载
            [GBProgressHUD showLoadingWithMsg:@"菊花loading"];
            break;
        }
        case 1005:{
            
            //环形加载（图片不喜欢可以自己换）
            [GBProgressHUD showCircleLoadingWithMsg:@"环形loading"];
            break;
        }
        case 1006:{
            
            //加载进度，类似下载进度
            HUD = [GBProgressHUD showProgressCircle:@"Loading..."];
            //用定时器模拟数据，下面对HUD进行设置进度值即可，正式使用时，获取到afn下载的进度，同理设置就行
            pro = 0.01;
            [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
            break;
        }
        case 1007:{
            
            //加载自定义图片，含文字
            [GBProgressHUD showCustomImageWithMsg:@"自定义图片" imageName:@"rocket"];
            break;
        }
        case 1008:{
            
            //使用这种，必须保证Assets里，添加了图片组(本项目没有)，这里提示内容不写（用@""），就只显示动画，写了内容，是一起显示
//            [GBProgressHUD showCustomAnimation:@"" withImgArry:[self getRandomImgArry] inview:self.view];
            NSMutableArray * array = [NSMutableArray array];
            for (NSInteger i = 1; i <= 6; i++) {
                [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"wildcat_gif_%zd",i]]];
            }
            [GBProgressHUD showCustomAnimation:@"拼命加载中.." withImgArry:array];
            break;
        }
        case 1009:{
            
            //透明菊花
            [GBProgressHUD showClearChrysanthemum:@"透明菊花测试1号"];
            break;
        }
        default:
            break;
    }
    
    //这里是我手动设置的停止动画，实际使用时，可以在数据请求结束时，用 [GBProgressHUD hide]; 结束动画
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [GBProgressHUD hide];
    //    });
}

-(void)updateProgress{
    if (pro>=1) {
        [HUD hideAnimated:YES];
        HUD = nil;
    }
    
    pro = pro + 0.01;
    HUD.progress = pro;
}


/**
 自己构造随机一种动画，实际使用，不用这样
 */
-(NSArray *)getRandomImgArry{
    NSMutableArray *imageArr = [NSMutableArray array];
    //1 - 8 的随机数
    int y = (arc4random() % 8) + 1;
    
    int I = 0;
    
    if (y == 1) {
        
        I = 12 + 1;
        
    } else if (y == 2) {
        
        I = 8 + 1;
        
    }else if (y == 3) {
        
        I = 16 + 1;
        
    }else if (y == 4) {
        
        I = 50 + 1;
        
    }else if (y == 5) {
        
        I = 23 + 1;
        
    }else if (y == 6) {
        
        I = 13 + 1;
        
    }else if (y == 7) {
        
        I = 22 + 1;
        
    }else if (y == 8) {
        
        I = 70 + 1;
    }
    
    
    for (int i = 1; i < I; i ++ ) {
        
        [imageArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading_%d_%d",y,i]]];
    }
    
    return [imageArr copy];
}
@end
