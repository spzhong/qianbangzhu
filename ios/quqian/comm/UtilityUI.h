//
//  UtilityUI.h
//

#import <Foundation/Foundation.h>

#define  kUtilityUIDefaultBorderWidth                    0.5f
#define  kUtilityUIDefaultBorderCornerRadius             4.0f

@interface UtilityUI : NSObject

// 代码设置设置边界和圆角，默认是view的背景色,1.0f borderWidth,5.0f cornerRadius
+ (void)setBorderOnView:(UIView *)view;
+ (void)setBorderOnView:(UIView *)view borderColor:(UIColor *)borderColor;
+ (void)setBorderOnView:(UIView *)view cornerRadius:(CGFloat)cornerRadius;
+ (void)setBorderOnView:(UIView *)view borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius;

+(CGFloat)getHightByString:(NSString *)str andWidth:(CGFloat)width andFont:(CGFloat)font;
+ (void)setLineOnView:(UIView *)view andSize:(CGSize)size;
//隐藏导航分割线
+ (void) hideNavigationBarLine:(UIViewController *)baseVc;
//设置用法用量 type == 1 ,咨询记录
+ (NSString *) setUsageandDosagePatients:(NSString *)patients num:(NSString *)num periodTimes:(NSString *)periodTimes times:(NSString *)times quantity:(NSString *)quantity unit:(NSString *)unit method:(NSString *)method days:(NSString *)days type:(NSString *)type;

 

+ (CGFloat)getSizeOfString5:(NSString *)str
                    strFont:(UIFont *)font
                     CGSize:(CGSize)rectSie;

@end
