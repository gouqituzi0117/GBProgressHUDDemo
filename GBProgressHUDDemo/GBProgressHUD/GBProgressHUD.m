//
//  GBProgressHUD.m
//  GBProgressHUDDemo
//
//  Created by 高斌 on 2019/8/30.
//  Copyright © 2019年 dhst. All rights reserved.
//

#import "GBProgressHUD.h"

@implementation GBProgressHUD

+(instancetype)shareinstance{
    
    static GBProgressHUD *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GBProgressHUD alloc] init];
    });
    
    return instance;
}

+(void)show:(NSString *)msg inView:(UIView *)view mode:(GBProgressMode)myMode{
    [self show:msg inView:view mode:myMode customImgView:nil];
}

+(void)show:(NSString *)msg inView:(UIView *)view mode:(GBProgressMode)myMode customImgView:(UIImageView *)customImgView{
    //如果已有弹框，先消失
    if ([GBProgressHUD shareinstance].hud != nil) {
        [[GBProgressHUD shareinstance].hud hideAnimated:YES];
        [GBProgressHUD shareinstance].hud = nil;
    }
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    //4\4s屏幕避免键盘存在时遮挡
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        [view endEditing:YES];
    }
    
    //赋值
    [GBProgressHUD shareinstance].hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    //这里设置是否显示全屏遮罩层
//    [GBProgressHUD shareinstance].hud.dimBackground = YES;    //是否显示透明背景(半透明)
    
    //四周边距 默认是20,内容较少时使之生效,请先删除设置的MinSize
//    [[GBProgressHUD shareinstance].hud setMargin:20.f];
    
    //hud的显示位置,正数时在中间位置的下方,负数时在中间位置的上方
    //    [[GBProgressHUD shareinstance].hud setOffset:CGPointMake(0, 250)];
    
    //bezelView.style有2个枚举值
    //1.MBProgressHUDBackgroundStyleSolidColor,这个枚举值是实心颜色的意思，在这个枚举的基础上，你可以设置任意你想要的颜色。
    //需要注意的是：设置半透明，不要用hud.alpha，因为设置alpha会导致子控件或者内容全部跟着一起alpha，比如你hud上文字，那么文字也会变成透明的。
    //2.MBProgressHUDBackgroundStyleBlur，意思是毛玻璃，如果设置了这个枚举值，那么不管设置什么颜色都不会有半透明效果。
    [GBProgressHUD shareinstance].hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    
    //是否设置黑色背景，这两句配合使用,设置透明度
    [GBProgressHUD shareinstance].hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [GBProgressHUD shareinstance].hud.contentColor = [UIColor whiteColor];
    
    [[GBProgressHUD shareinstance].hud setRemoveFromSuperViewOnHide:YES];
    [GBProgressHUD shareinstance].hud.detailsLabel.text = msg;
    [GBProgressHUD shareinstance].hud.detailsLabel.font = [UIFont systemFontOfSize:15];
    
    switch ((NSInteger)myMode) {
        case GBProgressModeOnlyText:
            [GBProgressHUD shareinstance].hud.mode = MBProgressHUDModeText;
            break;
            
        case GBProgressModeSuccess:
            [[GBProgressHUD shareinstance].hud setMinSize:CGSizeMake(120, 120)];
            [GBProgressHUD shareinstance].hud.mode = MBProgressHUDModeCustomView;
            [GBProgressHUD shareinstance].hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
            break;
            
        case GBProgressModeFailure:
            [[GBProgressHUD shareinstance].hud setMinSize:CGSizeMake(120, 120)];
            [GBProgressHUD shareinstance].hud.mode = MBProgressHUDModeCustomView;
            [GBProgressHUD shareinstance].hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fail"]];
            break;
            
        case GBProgressModeLoading:
            [[GBProgressHUD shareinstance].hud setMinSize:CGSizeMake(120, 120)];
            [GBProgressHUD shareinstance].hud.mode = MBProgressHUDModeIndeterminate;
            break;

        case GBProgressModeCircle:{
            [[GBProgressHUD shareinstance].hud setMinSize:CGSizeMake(120, 120)];
            [GBProgressHUD shareinstance].hud.mode = MBProgressHUDModeCustomView;
            UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading"]];
            CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            animation.toValue = [NSNumber numberWithFloat:M_PI*2];
            animation.duration = 1.0;
            animation.repeatCount = 100;
            [img.layer addAnimation:animation forKey:nil];
            [GBProgressHUD shareinstance].hud.customView = img;
            break;
        }
        
        case GBProgressModeCircleDownloading:
            [[GBProgressHUD shareinstance].hud setMinSize:CGSizeMake(120, 120)];
            [GBProgressHUD shareinstance].hud.mode = MBProgressHUDModeAnnularDeterminate;
            break;
            
        case GBProgressModeCustomerImage:
            [[GBProgressHUD shareinstance].hud setMinSize:CGSizeMake(120, 120)];
            [GBProgressHUD shareinstance].hud.mode = MBProgressHUDModeCustomView;
            [GBProgressHUD shareinstance].hud.customView = customImgView;
            break;

        case GBProgressModeCustomAnimation:
            [[GBProgressHUD shareinstance].hud setMinSize:CGSizeMake(120, 120)];
            [GBProgressHUD shareinstance].hud.mode = MBProgressHUDModeCustomView;
            [GBProgressHUD shareinstance].hud.customView = customImgView;
            break;

        case GBProgressModeClearChrysanthemum:
            [[GBProgressHUD shareinstance].hud setMinSize:CGSizeMake(120, 120)];
            [GBProgressHUD shareinstance].hud.mode = MBProgressHUDModeIndeterminate;
            [GBProgressHUD shareinstance].hud.bezelView.backgroundColor = [UIColor clearColor];
            //设置hud上指示器和两个label,detailsLabel的字体颜色
            [GBProgressHUD shareinstance].hud.contentColor = [UIColor blackColor];
            //可单独设置detailsLabel的字体颜色
//            [GBProgressHUD shareinstance].hud.detailsLabel.textColor = [UIColor yellowColor];
            break;
            
        default:
            break;
    }
}
    

/**
 ①纯文本
 */
+(void)showMessage:(NSString *)msg {
    [self show:msg inView:nil mode:GBProgressModeOnlyText];
    [[GBProgressHUD shareinstance].hud hideAnimated:YES afterDelay:durationTime];
}
+(void)showMessage:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:view mode:GBProgressModeOnlyText];
    [[GBProgressHUD shareinstance].hud hideAnimated:YES afterDelay:durationTime];
}
+(void)showMessage:(NSString *)msg inView:(UIView *)view afterDelayTime:(NSInteger)delay{
    [self show:msg inView:view mode:GBProgressModeOnlyText];
    [[GBProgressHUD shareinstance].hud hideAnimated:YES afterDelay:delay];
}


/**
 ②显示成功提示
 */
+ (void)showSuccess:(NSString *)msg {
    [self show:msg inView:nil mode:GBProgressModeSuccess];
    [[GBProgressHUD shareinstance].hud hideAnimated:YES afterDelay:durationTime];
}
+(void)showSuccess:(NSString *)msg inview:(UIView *)view{
    [self show:msg inView:view mode:GBProgressModeSuccess];
    [[GBProgressHUD shareinstance].hud hideAnimated:YES afterDelay:durationTime];
}


/**
 ③显示失败提示
 */
+ (void)showFailure:(NSString *)msg {
    [self show:msg inView:nil mode:GBProgressModeFailure];
    [[GBProgressHUD shareinstance].hud hideAnimated:YES afterDelay:durationTime];
}
+ (void)showFailure:(NSString *)msg inview:(UIView *)view {
    [self show:msg inView:view mode:GBProgressModeFailure];
    [[GBProgressHUD shareinstance].hud hideAnimated:YES afterDelay:durationTime];
}


/**
 ④加载中(菊花)
 */
+(void)showLoadingWithMsg:(NSString *)msg {
    [self show:msg inView:nil mode:GBProgressModeLoading];
    [[GBProgressHUD shareinstance].hud hideAnimated:YES afterDelay:durationTime];
}
+(void)showLoadingWithMsg:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:view mode:GBProgressModeLoading];
    [[GBProgressHUD shareinstance].hud hideAnimated:YES afterDelay:durationTime];
}


/**
 ⑤加载中(环形)
 */
+(void)showCircleLoadingWithMsg:(NSString *)msg {
    [self show:msg inView:nil mode:GBProgressModeCircle];
    [[GBProgressHUD shareinstance].hud hideAnimated:YES afterDelay:durationTime];
}
+(void)showCircleLoadingWithMsg:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:view mode:GBProgressModeCircle];
    [[GBProgressHUD shareinstance].hud hideAnimated:YES afterDelay:durationTime];
}


/**
 ⑥加载/下载进度
 */
+(MBProgressHUD *)showProgressCircle:(NSString *)msg {
    [self show:msg inView:nil mode:GBProgressModeCircleDownloading];
    return [GBProgressHUD shareinstance].hud;
}
+(MBProgressHUD *)showProgressCircle:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:view mode:GBProgressModeCircleDownloading];
    return [GBProgressHUD shareinstance].hud;
}


/**
 ⑦自定义图片，含文字
 */
+(void)showCustomImageWithMsg:(NSString *)msg imageName:(NSString *)imageName {
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [self show:msg inView:nil mode:GBProgressModeCustomerImage customImgView:img];
    [[GBProgressHUD shareinstance].hud hideAnimated:YES afterDelay:durationTime];
}
+(void)showCustomImageWithMsg:(NSString *)msg imageName:(NSString *)imageName inview:(UIView *)view{
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [self show:msg inView:view mode:GBProgressModeCustomerImage customImgView:img];
    [[GBProgressHUD shareinstance].hud hideAnimated:YES afterDelay:durationTime];
}


/**
 ⑧自定义动画
 */
+(void)showCustomAnimation:(NSString *)msg withImgArry:(NSArray *)imgArry {
    UIImageView *showImageView = [[UIImageView alloc] init];
    showImageView.animationImages = imgArry;
    [showImageView setAnimationRepeatCount:0];
    [showImageView setAnimationDuration:(imgArry.count + 1) * 0.075];
    [showImageView startAnimating];
    
    [self show:msg inView:nil mode:GBProgressModeCustomAnimation customImgView:showImageView];
    [[GBProgressHUD shareinstance].hud hideAnimated:YES afterDelay:durationTime];
}
+(void)showCustomAnimation:(NSString *)msg withImgArry:(NSArray *)imgArry inview:(UIView *)view{
    
    UIImageView *showImageView = [[UIImageView alloc] init];
    showImageView.animationImages = imgArry;
    [showImageView setAnimationRepeatCount:0];
    [showImageView setAnimationDuration:(imgArry.count + 1) * 0.075];
    [showImageView startAnimating];
    
    [self show:msg inView:view mode:GBProgressModeCustomAnimation customImgView:showImageView];
    [[GBProgressHUD shareinstance].hud hideAnimated:YES afterDelay:durationTime];
}


/**
 ⑨背景色透明的菊花
 */
+ (void)showClearChrysanthemum:(NSString *)msg {
    
    [self show:msg inView:nil mode:GBProgressModeClearChrysanthemum customImgView:nil];
    [[GBProgressHUD shareinstance].hud hideAnimated:YES afterDelay:durationTime];
}
+ (void)showClearChrysanthemum:(NSString *)msg inview:(UIView *)view{
    
    [self show:msg inView:nil mode:GBProgressModeClearChrysanthemum customImgView:nil];
    [[GBProgressHUD shareinstance].hud hideAnimated:YES afterDelay:durationTime];
}


+(void)hide{
    if ([GBProgressHUD shareinstance].hud != nil) {
        [[GBProgressHUD shareinstance].hud hideAnimated:YES];
    }
}
@end
