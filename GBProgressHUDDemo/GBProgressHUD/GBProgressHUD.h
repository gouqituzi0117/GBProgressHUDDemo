//
//  GBProgressHUD.h
//  GBProgressHUDDemo
//
//  Created by 高斌 on 2019/8/30.
//  Copyright © 2019年 dhst. All rights reserved.
//

//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                           O\  =  /O
//                        ____/`---'\____
//                      .'  \\|     |//  `.
//                     /  \\|||  :  |||//  \
//                    /  _||||| -:- |||||-  \
//                    |   | \\\  -  /// |   |
//                    | \_|  ''\---/''  |   |
//                    \  .-\__  `-`  ___/-. /
//                   ___`. .'  /--.--\  `. . __
//                ."" '<  `.___\_<|>_/___.'  >'"".
//              | | :  `- \`.;`\ _ /`;.`/ - ` : | |
//              \  \ `-.   \_ __\ /__ _/   .-` /  /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？

//建议找自己公司UI做一套适用的图

//如果觉得imageView与detailsLabel之间的距离太短,可以修改MBProgressHUD里的MBDefaultPadding(默认是4.f,当前已修改为10.f)

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>

typedef NS_ENUM(NSInteger,GBProgressMode){
    GBProgressModeOnlyText,              //①纯文本
    GBProgressModeSuccess,               //②成功提示
    GBProgressModeFailure,               //③失败提示
    GBProgressModeLoading,               //④加载中(菊花)
    GBProgressModeCircle,                //⑤加载中(环形)
    GBProgressModeCircleDownloading,     //⑥加载圆形-要处理进度值
    GBProgressModeCustomerImage,         //⑦自定义图片，含文字
    GBProgressModeCustomAnimation,       //⑧自定义动画（序列帧实现）
    GBProgressModeClearChrysanthemum     //⑨透明菊花
};
static UIView *_indicator;
// 公用显示时长
static const float durationTime = 1.5f;

@interface GBProgressHUD : NSObject

/*=========================   属性   =================================*/

@property (nonatomic,strong) MBProgressHUD  *hud;


/*=========================  本类自己调用 方法   ========================*/

+(instancetype)shareinstance;
//显示
+(void)show:(NSString *)msg inView:(UIView *)view mode:(GBProgressMode)myMode;



/*=========================  自己可调用 方法   ==========================*/

//①纯文本
+(void)showMessage:(NSString *)msg;
+(void)showMessage:(NSString *)msg inView:(UIView *)view;
//纯文本（N秒后消失）
+(void)showMessage:(NSString *)msg inView:(UIView *)view afterDelayTime:(NSInteger)delay;

//②成功提示
+ (void)showSuccess:(NSString *)msg;
+ (void)showSuccess:(NSString *)msg inview:(UIView *)view;


//③失败提示
+ (void)showFailure:(NSString *)msg;
+ (void)showFailure:(NSString *)msg inview:(UIView *)view;


//④加载中(菊花)
+(void)showLoadingWithMsg:(NSString *)msg;
+(void)showLoadingWithMsg:(NSString *)msg inView:(UIView *)view;


//⑤加载中(环形)
+(void)showCircleLoadingWithMsg:(NSString *)msg;
+(void)showCircleLoadingWithMsg:(NSString *)msg inView:(UIView *)view ;


//⑥加载/下载进度(转圈-要处理数据加载进度)
+(MBProgressHUD *)showProgressCircle:(NSString *)msg;
+(MBProgressHUD *)showProgressCircle:(NSString *)msg inView:(UIView *)view;


//⑦提示、带静态图片，比如失败，用失败图片即可，警告用警告图片等
+(void)showCustomImageWithMsg:(NSString *)msg imageName:(NSString *)imageName;
+(void)showCustomImageWithMsg:(NSString *)msg imageName:(NSString *)imageName inview:(UIView *)view;

//⑧自定义动画(自定义动画序列帧  找UI做就可以了 gif的本质也是多个静态图组成)
+(void)showCustomAnimation:(NSString *)msg withImgArry:(NSArray *)imgArry;
+(void)showCustomAnimation:(NSString *)msg withImgArry:(NSArray *)imgArry inview:(UIView *)view;


//⑨透明菊花
+ (void)showClearChrysanthemum:(NSString *)msg;
+ (void)showClearChrysanthemum:(NSString *)msg inview:(UIView *)view;


//⑩隐藏
+(void)hide;

@end
