//
//  UtilityUI.m
//

#import "UtilityUI.h"

@implementation UtilityUI

+ (void)setBorderOnView:(UIView *)view borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius {
    if (!view) {
        return;
    }
    
    borderColor = borderColor ? borderColor : [UIColor redColor];
    borderWidth = borderWidth >= 0 ? borderWidth : kUtilityUIDefaultBorderWidth;
    cornerRadius = cornerRadius >= 0 ? cornerRadius : kUtilityUIDefaultBorderCornerRadius;
    
    view.layer.borderColor = borderColor.CGColor;
    view.layer.borderWidth = borderWidth;
    view.layer.cornerRadius = cornerRadius;
    if (cornerRadius >= 0) {
        view.clipsToBounds = YES;
    }
}

+ (void)setBorderOnView:(UIView *)view {
    [self setBorderOnView:view borderColor:view.backgroundColor borderWidth:kUtilityUIDefaultBorderWidth cornerRadius:kUtilityUIDefaultBorderCornerRadius];
}

+ (void)setBorderOnView:(UIView *)view cornerRadius:(CGFloat)cornerRadius {
    [self setBorderOnView:view borderColor:view.backgroundColor borderWidth:0.0f cornerRadius:cornerRadius];
}

+ (void)setBorderOnView:(UIView *)view borderColor:(UIColor *)borderColor{
    [self setBorderOnView:view borderColor:borderColor borderWidth:kUtilityUIDefaultBorderWidth cornerRadius:kUtilityUIDefaultBorderCornerRadius];
}

+(CGFloat)getHightByString:(NSString *)str andWidth:(CGFloat)width andFont:(CGFloat)font{
    
    if (str== nil && str.length==0) {
        str = @"";
    }

    
    CGRect frame = [str boundingRectWithSize:CGSizeMake(width, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font]} context:nil];
    frame.origin = CGPointMake(0, 0);
    
    return frame.size.height;
}

+ (CGFloat)getSizeOfString5:(NSString *)str
                  strFont:(UIFont *)font
                    CGSize:(CGSize)rectSie{
    
    if (str== nil && str.length==0) {
        str = @"";
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize size = [str boundingRectWithSize:rectSie options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return size.height;
}

 


+ (void)setLineOnView:(UIView *)view andSize:(CGSize)size
{
    UIView *lineTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, 0.5)];
    lineTop.backgroundColor = KTHCOLOR;
    [view addSubview:lineTop];
    
    UIView *lineBottom = [[UIView alloc]initWithFrame:CGRectMake(0, size.height - 0.5, size.width, 0.5)];
    lineBottom.backgroundColor = KTHCOLOR;
    [view addSubview:lineBottom];
}

+ (void) hideNavigationBarLine:(UIViewController *)baseVc
{
    if ([baseVc.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=baseVc.navigationController.navigationBar.subviews;
        for (id obj in list)
        {
            if ([obj isKindOfClass:[UIImageView class]])
            {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2)
                {
                    if ([obj2 isKindOfClass:[UIImageView class]])
                    {
                        UIImageView *imageView2 = (UIImageView *)obj2;
                        imageView2.hidden = YES;
                    }
                }
            }
        }
    }
}

//设置用法用量
+ (NSString *) setUsageandDosagePatients:(NSString *)patients num:(NSString *)num periodTimes:(NSString *)periodTimes times:(NSString *)times quantity:(NSString *)quantity unit:(NSString *)unit method:(NSString *)method days:(NSString *)days type:(NSString *)type
{
    NSString *str;
    if ([type integerValue] == 1) {
        
        //咨询记录用法用量
        if (StringNotEmpty(method)) {
            if ([quantity isEqualToString:@"适量"]||[quantity isEqualToString:@"0"]) {
                str = [NSString stringWithFormat:@"%@ %@,%@%@%@次,适量%@",patients,method,num,periodTimes,times,days];
            }else{
                str = [NSString stringWithFormat:@"%@ %@,%@%@%@次,每次%@%@%@",patients,method,num,periodTimes,times,quantity,unit,days];
            }
        }else{
            if ([quantity isEqualToString:@"适量"]||[quantity isEqualToString:@"0"]) {
                str = [NSString stringWithFormat:@"%@ %@%@%@次,适量%@",patients,num,periodTimes,times,days];
            }else{
                str = [NSString stringWithFormat:@"%@ %@%@%@次,每次%@%@%@",patients,num,periodTimes,times,quantity,unit,days];
            }
        }
    }else{
        
        //健康关怀用法用量
        if (StringNotEmpty(method)) {
            if ([quantity isEqualToString:@"适量"]||[quantity isEqualToString:@"0"]) {
                str = [NSString stringWithFormat:@"%@;%@%@%@次,适量;%@",patients,num,periodTimes,times,method];
            }else{
                str = [NSString stringWithFormat:@"%@;%@%@%@次,每次%@%@;%@",patients,num,periodTimes,times,quantity,unit,method];
            }
        }else{
            if ([quantity isEqualToString:@"适量"]||[quantity isEqualToString:@"0"]) {
                str = [NSString stringWithFormat:@"%@;%@%@%@次,适量",patients,num,periodTimes,times];
            }else{
                str = [NSString stringWithFormat:@"%@;%@%@%@次,每次%@%@",patients,num,periodTimes,times,quantity,unit];
            }
        }
    }
    return str;
}

 
@end
