//
//  Tool.h
//  kong
//
//  Created by ytx on 13-3-12.
//  Copyright (c) 2013年 ytx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#include <QuartzCore/QuartzCore.h>
#include <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
#import <CommonCrypto/CommonDigest.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

 

//***宏定义
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)


// 四个模块的列表中字体
#define FOUR_CONTROL_FONT [UIFont boldSystemFontOfSize:15]
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

/*
 控制NSLog的输出
 1 显示输出
 0 不显示输出
 */
#if 1
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)


 

@interface Tool : NSObject


+(UIButton *)BackButtonProductionFunction:(NSString *)title Frame:(CGRect)rect;
+(UIButton *)RightButton:(NSString *)title Frame:(CGRect)rect;

/*创建生成组件--工厂*/
+(UIView *)ViewProductionFunction:(CGRect)rect BgColor:(UIColor *)bgColor;
+(UILabel *)LablelProductionFunction:(NSString *)title Frame:(CGRect)rect Alignment:(NSTextAlignment)alignment FontFl:(float)fl;
+(UIButton *)ButtonProductionFunction:(NSString *)title Frame:(CGRect)rect bgImgName:(NSString *)bgImg FontFl:(float)fl;
+(UIImageView *)ImgProductionFunctionFrame:(CGRect)rect bgImgName:(NSString *)bgImg;
+(UITableView *)TableProductionFunction:(id)delegate Frame:(CGRect)rect;
+(UIScrollView *)ScrollProductionFunction:(id)delegate Frame:(CGRect)rect contentSize:(CGSize)size;
+(UITextField *)TextFiledProductionFunction:(NSString *)title Delegate:(id)delegate Frame:(CGRect)rect FontFl:(float)fl backgroundImg:(NSString *)bgImgName UIKeyboardType:(UIKeyboardType)keyBoarde;
+(UITextView *)TextViewProductionFunction:(NSString *)title Frame:(CGRect)rect FontFl:(float)fl;
+(CALayer *)LayerProductionFunction:(float)cornerRadius BorderWidth:(float)borderWidth BorderColor:(UIColor*)borderColor bgImgName:(NSString *)bgName;
+(UITapGestureRecognizer *)TapGestureRecognizerProductionFunction:(id)delgate TouchesRequired:(int)touchesRequired TapsRequired:(int)tapsRequired action:(SEL)handleSingleFingerEvent;//创建一个点击的事件（addGestureRecognizer）
+(UITapGestureRecognizer *)TapGestureRecognizerProductionFunction:(id)delgate Direction:(UISwipeGestureRecognizerDirection)direction action:(SEL)handleSingleFingerEvent;//创建一个滑动的事件（addGestureRecognizer）
/*创建生成组件--工厂*/



/*实体工具*/

// 根据文本得到大小
+(CGSize)getTheTextSize:(NSString*)inString withFont:(UIFont*)font withRect:(CGSize)textSize;
// X月x日 XX:XX
+(NSString*)broserTheAlumToString:(NSString*)dateString;
+(NSString*)todayYesterdayAndMore:(NSString*)dateString;
+(NSString*)nowDateWeek;
+(NSString*)nowDateYear;
+(NSString*)nowDateMonth;
+(NSString*)nowDateDay;
// 返回年  天   日 
+(NSString*)yearOfDateString:(NSString*)dateString;
+(NSString*)dayOfDateString:(NSString*)dateString;
+(NSString*)monthOfDateString:(NSString*)dateString;
+(NSString*)changeTheNumToChinese:(NSString*)inStr;

+(NSString *)deviceIPAdress;//获取设备的IP地址
+(int)RandomIntNumble:(int)fanwei;//产生一个随机的数字
+(NSString *)CurrentTime;//获取当前的时间（YYYY-MM-dd HH:mm:ss）
+(void)PhotoForBig:(UIImageView *)ImgView;//图片逐渐变大
+(void)ChangeKeyBgColorWhenTextFieldDidBeginEditing:(UITextField *)textField keyBgColor:(UIColor *)bgColor;//改变键盘的颜色
+(NSString *)DeleteStringWhitespace:(NSString *)str;//消除空格
+(BOOL)ConnectedToNetwork;//检测网络是否是正常的
+(BOOL)IsValidateEmail:(NSString *)email;//判断Email是否有效
+(BOOL)IsValidateString:(NSString *)myString withTeshu:(NSString *)teshu;//包含特殊的字符
+(NSString*)IPhone5Pic:(NSString *)str;//修改IPHONE5的图片
+(CGRect)IPhone4Rect:(CGRect)rect4 IPhone5Rect:(CGRect)rect5;//修改IPHONE5的Frame
+(NSString *)md5:(NSString *)str;//MD5加密
+(NSString*)md5HexDigest:(NSString*)input;//md5的十六进制转换
+(UIImage *)ScaleImage:(UIImage *)img toScale:(CGSize)size;
+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize;

+(UIImage *)ImageFangImage:(UIImage*)inImage withHeight:(float)height;
 // 把图片剪成方形，根据长、宽，把最小边做为边长
+(UIImage *)ImageFromImage:(CGRect)myImageRect withImg:(UIImage *)bigImage;
//根据给定得图片，从其指定区域截取一张新得图片
+(UIImage *)ReadImgBundle:(NSString *)imgName;//创建一个UIImage
+(BOOL)FaceDistinguish:(UIImage *)faceImg;//人脸识别技术
+(CABasicAnimation *)opacityForever_Animation:(float)time;//opacity透明度永久闪烁
+(CABasicAnimation *)moveX:(float)time X:(NSNumber *)x;//横向移动
+(CABasicAnimation *)moveY:(float)time Y:(NSNumber *)y;//纵向移动
+(CABasicAnimation *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repeatTimes;//等比缩放/
+(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount;//旋转
+(CAKeyframeAnimation *)keyframeAniamtion:(CGMutablePathRef)path durTimes:(float)time Rep:(float)repeatTimes;//路径动画
+(CAAnimationGroup *)groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes;//组合动画
+(void)LayerbezierPathWithCurvedShadowForRect:(CALayer *)layer;//给一个图片的层添加一个3d背景
+(void)Layertransform:(CALayer *)reflectionLayer Opacity:(float)opacity Rotation:(float)rotation xy:(int)x;//将层进行按照透明度，按照x或y轴进行旋转
+(void)LayerFenGe:(CALayer *)fengeLayer;//对层进行分割一半，且加上白色的背景
+(void)LayerHeardTiaodong:(CALayer *)layer;//类似心脏的跳动
+(NSString *)DocumentDirectoryPath;//获取Document路径
+(BOOL)IsExistfileName:(NSString *)fileName;//判断文件是否已经存在
+(void)CreatNewFile:(NSString *)fileName withisWenJian:(int)tag;//tag 0是创建文件  tag 1是文件夹
+(void)DeleteOldFile:(NSString *)fileName;//删除一个文件



+(NSString *)changeTime:(NSString *)time;


// 通讯录转ABC分组
+(NSMutableDictionary*)ABCfromArray:(NSArray*)inArray;

 

/*检测电话号码 MODIFIED BY HELENSONG*/
+(BOOL)istelPhone:(NSString *)phone;
/*检测手机号码 MODIFIED BY HELENSONG*/
+(BOOL)isMobilePhone:(NSString *)phone;
/*邮箱验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateEmail:(NSString *)email;
/*车牌号验证 MODIFIED BY HELENSONG*/
+(BOOL)validateCarNo:(NSString* )carNo;



+(void)myalter:(NSString*)mes;


#pragma song new
+(AppDelegate*)getDele;

//保存到core data 中
+(void)savecoredata;
//查询db数据
+(NSMutableArray *)selcetAllData:(NSString *)table withWhere:(NSString *)where;
+(id)selcetOneData:(NSString *)table withWhere:(NSString *)whereId;
+(NSMutableArray *)selcetAllData:(NSString *)table withWhere:(NSString *)where  withKey:(NSString *)key withCurPage:(int )currPage;

//插入db数据
+(BOOL)insertData:(NSString*)table withData:(NSDictionary*)data withRelationship:(NSString *)rsTabel;
//更新数据--一个元素
+(id)upData:(NSString *)table withWhere:(NSString *)where;
//删除数据
+(BOOL)deleteData:(NSString*)table where:(NSString*)where;

//判读属性是否存在
+(NSDictionary *)properties_apsWithClass:(NSObject *)obj;

+(NSString *)toString:(NSString *)ss;

//获取用户的信息
+(id)getUser;





+(NSMutableDictionary*)ABCfromArray:(NSArray*)inArray;
+(int)indexFromZiMu:(NSString*)zimu;
+(NSString*)ZiMuFromIndex:(int)index;
+(NSString *)sub:(NSString *)string;

+ (UIColor *) stringTOColor:(NSString *)str;

+ (NSString *)suolvWH:(float)w withH:(float)h;


+(CGFloat)adaptation:(CGFloat)fl with6:(CGFloat)x6 with6p:(CGFloat)x6p;

//算法
+(double)suanfa:(NSMutableDictionary *)dic withFenshu:(int)fenshu withType:(int)type;

+(NSString *)exchage:(NSString *)string withDanwei:(NSString *)danwei withName:(NSString *)name;

@end
