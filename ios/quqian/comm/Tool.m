//
//  Tool.m
//  kong
//
//  Created by ytx on 13-3-12.
//  Copyright (c) 2013年 ytx. All rights reserved.
//

#import "Tool.h"
#import <objc/runtime.h>
#import "ChineseToPinyin.h"
#import "MBProgressHUD+Add.h"
#import "UserModel.h"


@implementation Tool
/*微企专用组件*/
//返回按钮
+(UIButton *)BackButtonProductionFunction:(NSString *)title Frame:(CGRect)rect {
    UIImage *backImg = [UIImage imageNamed:@"back.png"];
    backImg = [backImg stretchableImageWithLeftCapWidth:backImg.size.width-8 topCapHeight:backImg.size.height];
    UIButton *button = [UIButton buttonWithType:0];
    [button setBackgroundImage:backImg forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@s",bgImg]] forState:UIControlStateHighlighted];
    [button setTitle:[NSString stringWithFormat:@" %@",title] forState:UIControlStateNormal];
    button.frame = rect;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    return button;
}
+(UIButton *)RightButton:(NSString *)title Frame:(CGRect)rect {
    UIImage *backImg = [UIImage imageNamed:@"RightBarButtonBkg_ios7.png"];
    backImg = [backImg stretchableImageWithLeftCapWidth:backImg.size.width/2 topCapHeight:backImg.size.height/2];
    UIButton *button = [UIButton buttonWithType:0];
    [button setBackgroundImage:backImg forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    button.frame = rect;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    return button;
}


/*创建生成组件--工厂*/
+(UIView *)ViewProductionFunction:(CGRect)rect BgColor:(UIColor *)bgColor{
    UIView *bgView = [[UIView alloc] initWithFrame:rect];
    [bgView setBackgroundColor:bgColor];
    bgView.userInteractionEnabled = YES;
    return bgView;
}

+(UILabel *)LablelProductionFunction:(NSString *)title Frame:(CGRect)rect Alignment:(NSTextAlignment)alignment FontFl:(float)fl {
    //左边的按钮
    UILabel *makeLabel = [[UILabel alloc] initWithFrame:rect];
    makeLabel.textAlignment = alignment;
    makeLabel.text = title;
    //makeLabel.shadowColor = [UIColor whiteColor];
    makeLabel.font = [UIFont systemFontOfSize:fl];
    [makeLabel setTextColor:[UIColor blackColor]];
    [makeLabel setBackgroundColor:[UIColor clearColor]];
    makeLabel.numberOfLines = 0;
    //[makeLabel sizeToFit];
    return makeLabel;
}
+(UIButton *)ButtonProductionFunction:(NSString *)title Frame:(CGRect)rect bgImgName:(NSString *)bgImg FontFl:(float)fl {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:bgImg] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@s",bgImg]] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
   	button.frame = rect;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:fl];
    return button;
}
+(UIImageView *)ImgProductionFunctionFrame:(CGRect)rect bgImgName:(NSString *)bgImg {
    UIImageView *imgview = [[UIImageView alloc] initWithFrame:rect];
    imgview.image = [UIImage imageNamed:bgImg];
    return imgview;
}
+(UITableView *)TableProductionFunction:(id)delegate Frame:(CGRect)rect{
    UITableView *myTableView = [[UITableView alloc]
                                initWithFrame:rect
                                style:UITableViewStyleGrouped];
    [myTableView setDelegate:delegate];
    [myTableView setDataSource:delegate];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    myTableView.backgroundColor = [UIColor clearColor];
    return myTableView;
}
+(UIScrollView *)ScrollProductionFunction:(id)delegate Frame:(CGRect)rect contentSize:(CGSize)size{
    UIScrollView *bgScroView = [[UIScrollView alloc] initWithFrame:rect];
    bgScroView.contentSize = size;
    bgScroView.showsHorizontalScrollIndicator = NO;
    bgScroView.showsVerticalScrollIndicator = NO;
    bgScroView.delegate = delegate;
    bgScroView.pagingEnabled = YES;
    return bgScroView;
}
+(UITextField *)TextFiledProductionFunction:(NSString *)title Delegate:(id)delegate Frame:(CGRect)rect FontFl:(float)fl backgroundImg:(NSString *)bgImgName UIKeyboardType:(UIKeyboardType)keyBoarde{
    UITextField *textFeild = [[UITextField alloc] initWithFrame:rect];
    textFeild.font = [UIFont systemFontOfSize:fl];
    textFeild.clearButtonMode = UITextFieldViewModeWhileEditing;
    textFeild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textFeild.returnKeyType = UIReturnKeyDefault;
    textFeild.keyboardType = keyBoarde;
    textFeild.textColor = [UIColor blackColor];
    textFeild.text = title;
    textFeild.background = [UIImage imageNamed:bgImgName];
    textFeild.delegate = delegate;
    return textFeild;
}
+(UITextView *)TextViewProductionFunction:(NSString *)title Frame:(CGRect)rect FontFl:(float)fl {
    UITextView *textViewLab = [[UITextView alloc] initWithFrame:rect];
    textViewLab.textAlignment = NSTextAlignmentLeft;
    textViewLab.text = title;
    textViewLab.font = [UIFont systemFontOfSize:fl];
    [textViewLab setTextColor:[UIColor blackColor]];
    [textViewLab setBackgroundColor:[UIColor clearColor]];
    textViewLab.editable = YES;
    return textViewLab;
}
+(CALayer *)LayerProductionFunction:(float)cornerRadius BorderWidth:(float)borderWidth BorderColor:(UIColor*)borderColor bgImgName:(NSString *)bgName {
    CALayer *layer = [CALayer layer];
    layer.cornerRadius = cornerRadius;//设置边框的圆角
    layer.masksToBounds = YES;
    layer.borderWidth = borderWidth;//设置一个边框
    layer.borderColor = [borderColor CGColor];//设置边框的颜色
    //添加背景图片
    UIImage *imgContent = [UIImage imageNamed:bgName];
    layer.contents = (id)imgContent.CGImage;
    return layer;
}
+(UITapGestureRecognizer *)TapGestureRecognizerProductionFunction:(id)delgate TouchesRequired:(int)touchesRequired TapsRequired:(int)tapsRequired action:(SEL)handleSingleFingerEvent{
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:delgate action:handleSingleFingerEvent];
    singleFingerOne.numberOfTouchesRequired = touchesRequired; //手指数
    singleFingerOne.numberOfTapsRequired = tapsRequired; //tap次数
    singleFingerOne.delegate = delgate;
    return delgate;
}
+(UISwipeGestureRecognizer *)TapGestureRecognizerProductionFunction:(id)delgate Direction:(UISwipeGestureRecognizerDirection)direction action:(SEL)handleSingleFingerEvent{
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:delgate action:handleSingleFingerEvent];
    [recognizer setDirection:direction];
    recognizer.delegate = delgate;
    return recognizer;
}
/*创建生成组件--工厂*/




/*实体工具*/
+(void)newLineLabel:(UILabel*)oldLabel withLines:(int)lines{
    
}

+(CGSize)getTheTextSize:(NSString*)inString withFont:(UIFont*)font withRect:(CGSize)textSize
{
    CGSize size = CGSizeZero;
    if (!([inString isEqual:[NSNull null]]||!inString||inString==nil)) {
        size = [(inString&&![inString isEqual:[NSNull null]])?inString:@"" sizeWithFont:font constrainedToSize:textSize lineBreakMode:NSLineBreakByTruncatingTail];
    }
    return size;
}

+(NSString*)broserTheAlumToString:(NSString*)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    [dateFormatter setDateFormat:@"M月d日 HH:mm"];
    NSString *MonthStr = [dateFormatter stringFromDate:date];
    return MonthStr;
}

+(NSString *)changeTime:(NSString *)time{
    
    
    if (time.length > 17) {
        time = [time substringToIndex:17];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyyMMdd-H:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:time];
    
    NSDateFormatter *newFormatter = [[NSDateFormatter alloc] init];
    [newFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [newFormatter stringFromDate:date];
    return currentDateStr;
}

// 今天  昨天  前天
+(NSString*)todayYesterdayAndMore:(NSString*)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    int year = [[Tool yearOfDateString:dateString] intValue];
    int month = [[Tool monthOfDateString:dateString] intValue];
    int day = [[Tool dayOfDateString:dateString]intValue];
    int nowYear = [[Tool nowDateYear] intValue];
    int nowMonth = [[Tool nowDateMonth] intValue];
    int nowDay = [[Tool nowDateDay] intValue];
    
    if (year==nowYear&&month==nowMonth&&day==nowDay) {
        [dateFormatter setDateFormat:@"今天 HH:mm"];
    }else if (year==nowYear&&month==nowMonth&&(day+1)==nowDay) {
        [dateFormatter setDateFormat:@"昨天 HH:mm"];
    }else if (year==nowYear&&month==nowMonth&&(day+2)==nowDay) {
        [dateFormatter setDateFormat:@"前天 HH:mm"];
    }else if (year==nowYear&&month==nowMonth&&(nowDay-day)<=6) {
        [dateFormatter setDateFormat:[NSString stringWithFormat:@"星期%@ HH:mm",[Tool nowDateWeek]]];
    }else {
        [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
    }
    NSString *MonthStr = [dateFormatter stringFromDate:date];

    return MonthStr;
}
+(NSString*)nowDateWeek
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"e"];
    NSString *MonthStr = [dateFormatter stringFromDate:[NSDate date]];

    NSString *resultString = nil;
    switch ([MonthStr intValue]) {
        case 1:
            resultString=@"日";
            break;
        case 2:
            resultString=@"一";
            break;
        case 3:
            resultString=@"二";
            break;
        case 4:
            resultString=@"三";
            break;
        case 5:
            resultString=@"四";
            break;
        case 6:
            resultString=@"五";
            break;
        case 7:
            resultString=@"六";
            break;
        default:
            break;
    }
    return resultString;
}
// 是几几年
+(NSString*)nowDateYear
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY"];
    NSString *MonthStr = [dateFormatter stringFromDate:[NSDate date]];

    return MonthStr;
}
//今天是几月
+(NSString*)nowDateMonth
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    NSString *MonthStr = [dateFormatter stringFromDate:[NSDate date]];

    return MonthStr;
}
//今天是几日
+(NSString*)nowDateDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    NSString *MonthStr = [dateFormatter stringFromDate:[NSDate date]];

    return MonthStr;
}
+(NSString*)yearOfDateString:(NSString*)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    [dateFormatter setDateFormat:@"YYYY"];
    NSString *MonthStr = [dateFormatter stringFromDate:date];

    return MonthStr;
}
+(NSString*)dayOfDateString:(NSString*)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    [dateFormatter setDateFormat:@"dd"];
    NSString *MonthStr = [dateFormatter stringFromDate:date];

    return MonthStr;
}
+(NSString*)monthOfDateString:(NSString*)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    [dateFormatter setDateFormat:@"MM"];
    NSString *MonthStr = [dateFormatter stringFromDate:date];

    
    return MonthStr;
}
+(NSString*)changeTheNumToChinese:(NSString*)inStr
{
    int month = [inStr intValue];
    NSString *result = nil;
    switch (month) {
        case 1:
            result = @"一月";
            break;
        case 2:
            result = @"二月";
            break;
        case 3:
            result= @"三月";
            break;
        case 4:
            result = @"四月";
            break;
        case 5:
            result= @"五月";
            break;
        case 6:
            result= @"六月";
            break;
        case 7:
            result= @"七月";
            break;
        case 8:
            result= @"八月";
            break;
        case 9:
            result= @"九月";
            break;
        case 10:
            result= @"十月";
            break;
        case 11:
            result= @"十一月";
            break;
        case 12:
            result= @"十二月";
            break;
            
        default:
            break;
    }
    return result;
}

+(int)RandomIntNumble:(int)fanwei{
    int kk = arc4random()%fanwei + 1;
    return kk;
}
+(NSString *)CurrentTime{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd-H:mm:ss SSS"];
    NSString *currentTime = [dateFormatter stringFromDate:today];

    return currentTime;
}
+(void)PhotoForBig:(UIImageView *)ImgView{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:2.5];
    CGImageRef img = [ImgView.image CGImage];
    [ImgView setFrame:CGRectMake(0, 0, CGImageGetWidth(img), CGImageGetHeight(img))];
    [UIView commitAnimations];
}
+(void)ChangeKeyBgColorWhenTextFieldDidBeginEditing:(UITextField *)textField keyBgColor:(UIColor *)bgColor{
    NSArray *ws = [[UIApplication sharedApplication] windows];
    for(UIView *w in ws){
        NSArray *vs = [w subviews];
        for(UIView *v in vs){
            if([[NSString stringWithUTF8String:object_getClassName(v)] isEqualToString:@"UIPeripheralHostView"]){
                v.backgroundColor = bgColor;
            }
        }
    }
    textField.keyboardAppearance = UIKeyboardAppearanceAlert;//有这个设置属性 才起作用
}
+(NSString *)DeleteStringWhitespace:(NSString *)str{
    NSCharacterSet *whitespace =[NSCharacterSet whitespaceAndNewlineCharacterSet];
    str = [str stringByTrimmingCharactersInSet:whitespace];
    return str;
}
+(BOOL)ConnectedToNetwork{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}
+(BOOL)IsValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
+(BOOL)IsValidateString:(NSString *)myString withTeshu:(NSString *)teshu{
    NSCharacterSet *nameCharacters = [[NSCharacterSet characterSetWithCharactersInString:myString] invertedSet];
    NSRange userNameRange = [teshu rangeOfCharacterFromSet:nameCharacters];
    if (userNameRange.location != NSNotFound) {
        NSLog(@"包含特殊字符");
        return FALSE;
    }else{
        return TRUE;
    }
}
+(NSString*)IPhone5Pic:(NSString *)str{
    if (iPhone5) {
        return [NSString stringWithFormat:@"%@_h.png",str];
    }else{
        return [NSString stringWithFormat:@"%@.png",str];;
    }
}
+(CGRect)IPhone4Rect:(CGRect)rect4 IPhone5Rect:(CGRect)rect5{
    if (iPhone5) {
        return rect4;
    }else{
        return rect5;
    }
}
+(NSString *)md5:(NSString *)str{
	const char *cStr = [str UTF8String];
	unsigned char result[16];
	CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
	return [NSString stringWithFormat:
			@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
			result[0], result[1], result[2], result[3],
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			];
}

+(NSString*)md5HexDigest:(NSString*)input{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH]; //CC_MD5_DIGEST_LENGTH
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}
+(UIImage *)ScaleImage:(UIImage *)img toScale:(CGSize)size{
    
    int h = img.size.height;
    int w = img.size.width;
    
    if(h <= size.height && w <= size.width) {
        return img;
    } else {
        float destWith = 0.0f;
        float destHeight = 0.0f;
        
        float suoFang = (float)w/h;
        float suo = (float)h/w;
        if (w>h) {
            destWith = (float)size.width;
            destHeight = size.width * suo;
        }else {
            destHeight = (float)size.height;
            destWith = size.height * suoFang;
        }
        
        CGSize itemSize = CGSizeMake(destWith, destHeight);
        UIGraphicsBeginImageContext(itemSize);
        CGRect imageRect = CGRectMake(0, 0, destWith, destHeight);
        [img drawInRect:imageRect];
        UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImg;
    }
    
}
// 生成指定大小的缩略图。
+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize

{
    
    UIImage *newimage;
    
    if (nil == image) {
        
        newimage = nil;
        
    }
    
    else{
        CGSize sizeImg = image.size;
        float w = sizeImg.width;
        float h = sizeImg.height;
        //float wAndH=0.0f;
        float x=0.0f;
        float y=0.0f;
        if (w>h) {
            //wAndH=h;
            x = (w-h)/2;
        }else if (w<h){
            //wAndH=w;
            y = (h-w)/2;
        }else if (w==h) {
            //wAndH=w;
        }

        
        UIGraphicsBeginImageContext(asize);
        
        [image drawInRect:CGRectMake(x, y, asize.width, asize.height)];
        
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }
    
    return newimage;
    
}

//2.保持原来的长宽比，生成一个缩略图

+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize

{
    
    UIImage *newimage;
    
    if (nil == image) {
        
        newimage = nil;
        
    }
    
    else{
        
        CGSize oldsize = image.size;
        
        CGRect rect;
        
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            
            rect.size.height = asize.height;
            
            rect.origin.x = (asize.width - rect.size.width)/2;
            
            rect.origin.y = 0;
            
        }
        
        else{
            
            rect.size.width = asize.width;
            
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            
            rect.origin.x = 0;
            
            rect.origin.y = (asize.height - rect.size.height)/2;
            
        }
        
        UIGraphicsBeginImageContext(asize);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        
        [image drawInRect:rect];
        
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }
    
    return newimage;
    
}
+(UIImage *)ImageFangImage:(UIImage*)inImage withHeight:(float)height
{
    CGSize sizeImg = inImage.size;
    float w = sizeImg.width;
    float h = sizeImg.height;
    float wAndH=0.0f;
    float x=0.0f;
    float y=0.0f;
    if (w>h) {
        wAndH=h;
        x = (w-h)/2;
    }else if (w<h){
        wAndH=w;
        y = (h-w)/2;
    }else if (w==h) {
        return inImage;
    }
    return [Tool ImageFromImage:CGRectMake(x,y,wAndH,wAndH) withImg:inImage];
}
+(UIImage *)ImageFromImage:(CGRect)myImageRect withImg:(UIImage *)bigImage{
    //大图bigImage
    //定义myImageRect，截图的区域
    CGImageRef imageRef = bigImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    CGSize size;
    size.width = myImageRect.size.width;
    size.height = myImageRect.size.height;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myImageRect, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    return smallImage;
}
+(UIImage *)ReadImgBundle:(NSString *)imgName{
    NSString *bacString = [[NSBundle mainBundle]pathForResource:imgName ofType:@"png"];
    UIImage *bacImage = [[UIImage alloc]initWithContentsOfFile:bacString];
    return bacImage;
}
+(BOOL)FaceDistinguish:(UIImage *)faceImg{
    CIImage* ciimage = [CIImage imageWithCGImage:faceImg.CGImage];
    NSDictionary* opts = [NSDictionary dictionaryWithObject:
                          CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil options:opts];
    NSArray* features = [detector featuresInImage:ciimage];
    if ([features count] > 0) {
        return YES;
    }else{
        return NO;
    }
}
+(CABasicAnimation *)opacityForever_Animation:(float)time{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];//opacity透明度
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    animation.toValue=[NSNumber numberWithFloat:0.0];
    animation.autoreverses=YES;
    animation.duration=time;
    animation.repeatCount=FLT_MAX;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}
+(CABasicAnimation *)moveX:(float)time X:(NSNumber *)x{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];//横向移动
    animation.toValue=x;
    animation.duration=time;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}
+(CABasicAnimation *)moveY:(float)time Y:(NSNumber *)y{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];//纵向移动
    animation.toValue=y;
    animation.duration=time;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}
+(CABasicAnimation *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repeatTimes{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];//缩放
    animation.fromValue=orginMultiple;
    animation.toValue=Multiple;
    animation.duration=time;
    animation.autoreverses=YES;
    animation.repeatCount=repeatTimes;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}
+(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount{
    CATransform3D rotationTransform  = CATransform3DMakeRotation(degree, 0, 0,direction);
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];//旋转
    animation.toValue= [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration= dur;
    animation.autoreverses= NO;
    animation.cumulative= YES;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.repeatCount= repeatCount;
    animation.delegate= self;
    return animation;
}
+(CAKeyframeAnimation *)keyframeAniamtion:(CGMutablePathRef)path durTimes:(float)time Rep:(float)repeatTimes{
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];//路径动画
    animation.path=path;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.autoreverses=NO;
    animation.duration=time;
    animation.repeatCount=repeatTimes;
    return animation;
}
+(CAAnimationGroup *)groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes{ //组合动画
    CAAnimationGroup *animation=[CAAnimationGroup animation];
    animation.animations=animationAry;
    animation.duration=time;
    animation.repeatCount=repeatTimes;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}
+(void)LayerbezierPathWithCurvedShadowForRect:(CALayer *)layer{
    CGRect rect = layer.bounds;
	UIBezierPath *path = [UIBezierPath bezierPath];
	CGPoint topLeft		 = rect.origin;
	CGPoint bottomLeft	 = CGPointMake(0.0, CGRectGetHeight(rect) + 10);
	CGPoint bottomMiddle = CGPointMake(CGRectGetWidth(rect)/2, CGRectGetHeight(rect) - 5);
	CGPoint bottomRight	 = CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect) + 10);
	CGPoint topRight	 = CGPointMake(CGRectGetWidth(rect), 0.0);
	[path moveToPoint:topLeft];
	[path addLineToPoint:bottomLeft];
	[path addQuadCurveToPoint:bottomRight controlPoint:bottomMiddle];
	[path addLineToPoint:topRight];
	[path addLineToPoint:topLeft];
	[path closePath];
    //显示层的路径
    layer.shadowPath = path.CGPath;
}
+(void)Layertransform:(CALayer *)reflectionLayer Opacity:(float)opacity Rotation:(float)rotation xy:(int)x{
	reflectionLayer.opacity = opacity;//透明度
	// Transform X by 180 degrees
    if (x == 0) {//以X轴为边界
        [reflectionLayer setValue:[NSNumber numberWithFloat:DEGREES_TO_RADIANS(rotation)] forKeyPath:@"transform.rotation.x"];
    }else{//以y轴为边界
        [reflectionLayer setValue:[NSNumber numberWithFloat:DEGREES_TO_RADIANS(rotation)] forKeyPath:@"transform.rotation.y"];
    }
}
+(void)LayerFenGe:(CALayer *)fengeLayer{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
	gradientLayer.bounds = fengeLayer.bounds;
	gradientLayer.position = CGPointMake(fengeLayer.bounds.size.width / 2, fengeLayer.bounds.size.height * 0.65);
	gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor],(id)[[UIColor whiteColor] CGColor], nil];
	gradientLayer.startPoint = CGPointMake(0.5, 0.5);
	gradientLayer.endPoint = CGPointMake(0.5, 1.0);
	// Add gradient layer as a mask
	fengeLayer.mask = gradientLayer;//进行对fengeLayer分割
}
+(void)LayerHeardTiaodong:(CALayer *)layer{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
	animation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
	animation.autoreverses = YES;
	animation.duration = 0.35;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	animation.repeatCount = HUGE_VALF;
	[layer addAnimation:animation forKey:@"pulseAnimation"];
}
+(NSString *)DocumentDirectoryPath{
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // 传递 0 代表是找在Documents 目录下的文件。
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    return documentDirectory;
}
+(BOOL)IsExistfileName:(NSString *)fileName{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentDirectory = [Tool DocumentDirectoryPath];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",documentDirectory,fileName];
    // 用这个方法来判断当前的文件是否存在，如果不存在，就创建一个文件
    if ( ![fileManager fileExistsAtPath:filePath]) {
        return YES;//是不存在的
    }else{
        return NO;//是存在的
    }
}
+(void)CreatNewFile:(NSString *)fileName withisWenJian:(int)tag{
    
    BOOL isHave = [Tool IsExistfileName:fileName];
    //是不存在的,进行创建
    if (isHave) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *documentDirectory = [Tool DocumentDirectoryPath];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",documentDirectory,fileName];
        if (tag == 0) {
            [fileManager createFileAtPath:filePath contents:nil attributes:nil];
        }else{
            [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
}
+(void)DeleteOldFile:(NSString *)fileName{
    BOOL isHave = [Tool IsExistfileName:fileName];
    //是存在的,进行删除
    if (!isHave) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *documentDirectory = [Tool DocumentDirectoryPath];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",documentDirectory,fileName];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}



//检测手机号码
+(BOOL)isMobilePhone:(NSString *)phone{
    
    if (phone.length==0) {
        [Tool myalter:@"请输入手机号"];
        return NO;
    }
    
    if (phone.length!=11) {
        [Tool myalter:@"手机号错误"];
        return NO;
    }
    return YES;
}


/*邮箱验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if ([emailTest evaluateWithObject:email]) {
        return YES;
    }
    UIAlertView* alert12 = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的邮箱" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alert12 show];
    return NO;
}



/*车牌号验证 MODIFIED BY HELENSONG*/
+(BOOL)validateCarNo:(NSString* )carNo
{
    
    if (carNo.length==0) {
        [Tool myalter:@"请输入手机号"];
         return NO;
    }
    
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    if ([carTest evaluateWithObject:carNo]) {
        return YES;
    }
//    UIAlertView* alert12 = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的车牌号" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//    [alert12 show];
//    [alert12 release];
    
    
    [Tool myalter:@"请输入正确的车牌号"];
    
    return NO;
}

 

+(void)myalter:(NSString*)mes{
    [MBProgressHUD  showError:mes toView:nil];
}


+(void)myalters:(NSString*)mes{
    [MBProgressHUD  showSuccess:mes toView:nil];
}

+(NSMutableDictionary *)infoForDic:(NSString *)controller withTitle:(NSString *)title withIcon:(NSString *)icon withDescription:(NSString *)des{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:controller forKey:@"controller"];
    [dic setObject:title forKey:@"title"];
    [dic setObject:icon forKey:@"icon"];
    [dic setObject:des forKey:@"description"];
    return dic;
}



 +(int)indexFromZiMu:(NSString*)zimu
{
    NSString *allString = @"A B C D E F G H I J K L M N O P Q R S T U V W X Y Z #";
    NSArray *ziMuArr =[allString componentsSeparatedByString:@" "];
    if (zimu) {
        NSInteger inde = [ziMuArr indexOfObject:zimu];
        if (inde>26) {
            return 26;
        }
        return (int)inde;
    }
    return 26;
}
+(NSString*)ZiMuFromIndex:(int)index
{
    NSString *allString = @"A B C D E F G H I J K L M N O P Q R S T U V W X Y Z #";
    NSArray *ziMuArr =[allString componentsSeparatedByString:@" "];
    
    return [ziMuArr objectAtIndex:index];
}








#pragma song new
+(AppDelegate*)getDele
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}
//保存到core data 数据中
+(void)savecoredata{
    NSManagedObjectContext *mang = [Tool getDele].managedObjectContext;
    NSError *error = nil;
    if (![mang save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
}
//获取一条的数据
+(id)selcetOneData:(NSString *)table withWhere:(NSString *)whereId{
    NSMutableArray *allArray = [Tool selcetAllData:table withWhere:whereId];
    if ([allArray count]==0) {
        return nil;
    }
    id obj = [allArray objectAtIndex:0];
    return obj;
}


+(NSMutableArray *)selcetAllData:(NSString *)table withWhere:(NSString *)where  withKey:(NSString *)key withCurPage:(int )currPage{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:table inManagedObjectContext:[Tool getDele].managedObjectContext];
    [request setEntity:entity];
    
    
    NSSortDescriptor *sort=nil;
    if ([table isEqualToString:@"MessageModel"]  && [key isEqualToString:@"time"]) {
        sort = [NSSortDescriptor sortDescriptorWithKey:key ascending:YES];
    }else{
        sort = [NSSortDescriptor sortDescriptorWithKey:key ascending:NO];
    }
    
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sort, nil];
    [request setSortDescriptors:sortDescriptors];
    [request setFetchLimit:20];
    [request setFetchOffset:currPage * 20];
    
    
    //
    if (where.length  > 0) {
     
        if ([where hasPrefix:@"sortDescriptor_"]) {
            
            NSArray *array = [where componentsSeparatedByString:@"_"];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:[array objectAtIndex:1] ascending:YES];
            [request setSortDescriptors:[NSArray arrayWithObject:sort]];
            
        }else{
            //查询条件
            NSPredicate * qcmd = [NSPredicate predicateWithFormat:where];
            [request setPredicate:qcmd];
        }
    }
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[[Tool getDele].managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    
    if (mutableFetchResults == nil) {
        //如果结果为空，在这作错误响应
        return nil;
    }
    return mutableFetchResults;
}


//查询db数据
+(NSMutableArray *)selcetAllData:(NSString *)table withWhere:(NSString *)where{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:table inManagedObjectContext:[Tool getDele].managedObjectContext];
    [request setEntity:entity];

    if (where.length  > 0) {
        
        
        if ([table isEqualToString:@"BadCoModel"]) {
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"bcmId" ascending:NO];
            [request setSortDescriptors:[NSArray arrayWithObject:sort]];
        }
    
        if ([table isEqualToString:@"BadCoPushModel"]) {
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"topicId" ascending:NO];
            [request setSortDescriptors:[NSArray arrayWithObject:sort]];
        }
        
        if ([table isEqualToString:@"BadCoPushModel"]) {
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"topicId" ascending:NO];
            [request setSortDescriptors:[NSArray arrayWithObject:sort]];
        }
        
        if ([table isEqualToString:@"PushModel"]) {
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"dialogId" ascending:NO];
            [request setSortDescriptors:[NSArray arrayWithObject:sort]];
        }
        
        if ([table isEqualToString:@"SJModel"]) {
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"sjId" ascending:NO];
            [request setSortDescriptors:[NSArray arrayWithObject:sort]];
        }
        
        if ([table isEqualToString:@"MessageModel"]) {
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES];
            [request setSortDescriptors:[NSArray arrayWithObject:sort]];
        }
        
    
        
        if ([where hasPrefix:@"sortDescriptor_"]) {

            NSArray *array = [where componentsSeparatedByString:@"_"];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:[array objectAtIndex:1] ascending:YES];
            [request setSortDescriptors:[NSArray arrayWithObject:sort]];
            
        }else{
            //查询条件
            NSPredicate * qcmd = [NSPredicate predicateWithFormat:where];
            [request setPredicate:qcmd];
        }
    }

    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[[Tool getDele].managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    

    if (mutableFetchResults == nil) {
        //如果结果为空，在这作错误响应
        return nil;
    }
    return mutableFetchResults;
}
//插入db数据
+(BOOL)insertData:(NSString*)table withData:(NSDictionary*)data withRelationship:(NSString *)rsTabel
{
    @try {
        NSManagedObject *object=[NSEntityDescription insertNewObjectForEntityForName:table inManagedObjectContext:[Tool getDele].managedObjectContext];
        NSArray *array = [data allKeys];
        for (int i=0; i<[array count]; i++) {
            NSString *key = [array objectAtIndex:i];
            NSString *value = [data objectForKey:key];
            
            [object setValue:value forKey:key];
        }
        return [[Tool getDele] saveContext];
    }
    @catch (NSException *exception) {
        return NO;
    }
}
//更新数据--一个元素
+(id)upData:(NSString *)table withWhere:(NSString *)where{
    NSMutableArray *mutableFetchResults = [Tool selcetAllData:table withWhere:where];
    if ([mutableFetchResults count] == 0) {
        return nil;
    }
    return mutableFetchResults[0];
}
//删除数据
+(BOOL)deleteData:(NSString*)table where:(NSString*)where
{
    NSMutableArray *mutableFetchResults =[Tool selcetAllData:table withWhere:where];
    int flag;
    if ([mutableFetchResults count]>0) {
        flag=0;
    }else{
        return YES;
    }
    [[Tool getDele].managedObjectContext deleteObject:[mutableFetchResults objectAtIndex:flag]];
    // 保存更改,如果没保存的话，只是内存中删除了，并没有真正的删除
    NSError *error;
    if (![[Tool getDele].managedObjectContext save:&error]) {
        return NO;
    }
    return YES;
}


//判断属性是否存在
+(NSDictionary *)properties_apsWithClass:(NSObject *)obj{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([obj class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [obj valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}

+(NSString *)toString:(NSString *)ss{
    if (ss==nil) {
        return @"";
    }
    NSString *new = [NSString stringWithFormat:@"%@",ss];
    return new;
}


//获取用户的信息
+(id)getUser{
    NSString *userIDLoc = [[NSUserDefaults standardUserDefaults] valueForKey:@"curLoginUserId"];
    if (userIDLoc == nil) {
        return nil;
    }
    NSString *where = [NSString stringWithFormat:@"userId='%@'",userIDLoc];
    UserModel *user = [Tool selcetOneData:@"UserModel" withWhere:where];
    return user;
}


+(NSString *)sub:(NSString *)string{
    if ([string length] < 10) {
        return string;
    }else{
        return [string substringToIndex:10];
    }
}


+ (UIColor *) stringTOColor:(NSString *)str
{
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}



+ (NSString *)suolvWH:(float)w withH:(float)h{
    int wint = w;
    int winh = h;
    return [NSString stringWithFormat:@"?imageView2/1/w/%d/h/%d/q/100",wint,winh];
}


+(CGFloat)adaptation:(CGFloat)fl with6:(CGFloat)x6 with6p:(CGFloat)x6p{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSLog(@"----   %lf",app.window.screen.bounds.size.width);
    
    if (app.window.screen.bounds.size.width==375) {
        return fl + x6;
    }else if (app.window.screen.bounds.size.width==414){
        return fl + x6p;
    }else{
        return fl;
    }
}





//算法
+(double)suanfa:(NSMutableDictionary *)dic withFenshu:(int)fenshu withType:(int)type{
    
    double value = 0.00;
    
    double nian = 0.00;
    double yue = 0.00;
    double tian = 0.00;
    
    if (type==0) {
        nian = [[dic objectForKey:@"nll"] doubleValue] / 100;
        yue = [[dic objectForKey:@"nll"] doubleValue]/100/12;
        tian = [[dic objectForKey:@"nll"] doubleValue]/100/360;
    }else if(type==1){
        
        if ([[dic objectForKey:@"jllx"] isEqualToString:@"无奖励"]) {
            return value;
        }
        
        nian = [[dic objectForKey:@"jlll"] doubleValue]/100;
        yue = [[dic objectForKey:@"jlll"] doubleValue]/100/12;
        tian = [[dic objectForKey:@"jlll"] doubleValue]/100/360;
    }
    
    
    int hkqx = [[dic objectForKey:@"hkqx"] doubleValue];
    
    
    //月标
    if ([[dic objectForKey:@"jkfs"] intValue]==0) {
        
        if ([[dic objectForKey:@"hkfs"] isEqualToString:@"每月还息到期还本(不扣首期利息)"] || [[dic objectForKey:@"hkfs"] isEqualToString:@"每月还息到期还本(扣首期利息)"]) {
            
            //NSString *ss = [NSString stringWithFormat:@"%.2lf",100*yue];
            value = fenshu * (100*yue) * [[dic objectForKey:@"hkqx"] intValue];
            
        }
        
        if ([[dic objectForKey:@"hkfs"] isEqualToString:@"等额本息"]) {
            
            int newfenshu = 1;
            
            //每份每月还款额
            double a1 = 100 * (yue * pow(1+yue,hkqx)) / (pow((1+yue),hkqx)-1);
            //NSString *sa1 = [NSString stringWithFormat:@"%.2lf",a1];
            //每月还款额
            double a2 = newfenshu * (a1*hkqx-100);
            //每份的总利息
            //double a3 = ((fenshu*100)*yue-a2) * (pow(1+yue,hkqx)-1) / yue + hkqx * a2;
            NSString *sa3 = [NSString stringWithFormat:@"%.2lf",a2];
            value = [sa3 doubleValue] * fenshu;
            
        }
        
        
    }else if ([[dic objectForKey:@"jkfs"] intValue]==1){//天标
        value = fenshu * (100*tian) * [[dic objectForKey:@"hkqx"] intValue];
    }else if ([[dic objectForKey:@"jkfs"] intValue]==2){//秒标
        value = fenshu * (100*nian) * [[dic objectForKey:@"hkqx"] intValue];
    }
    
    return value;
}



//转换
+(NSString *)exchage:(NSString *)string withDanwei:(NSString *)danwei withName:(NSString *)name{
    
    if ([name isEqualToString:@"年利率"]) {
        //return [NSString stringWithFormat:@"<p align=center><font size=30 face='HelveticaNeue' color='#FFFFFF'>%@</font><font size=15 color='#FFFFFF' face='HelveticaNeue'>%@</font>\n<font size =15 color='#FFFFFF' face='HelveticaNeue'>%@</font></p>",string,danwei,@"预期年化利率"];
         return [NSString stringWithFormat:@"<p align=center><font size=30 face='HelveticaNeue' color='#FFFFFF' >%@</font><font size=15 face='HelveticaNeue' color='#FFFFFF'>%@</font>\n<font size =15 color='#FFFFFF' face='HelveticaNeue'>%@</font></p>",string,danwei,name];
    }
    
    return [NSString stringWithFormat:@"<p align=center><font size=15 face='HelveticaNeue' color='#FFFFFF' >%@</font><font size=15 face='HelveticaNeue' color='#FFFFFF'>%@</font>\n<font size =15 color='#FFFFFF' face='HelveticaNeue'>%@</font></p>",string,danwei,name];
}





  @end
