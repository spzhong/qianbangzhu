//
//  erCodeViewController.m
//  chaping
//
//  Created by apple on 14/12/16.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "erCodeController.h"
#import "ZXMultiFormatWriter.h"
#import "ZXEncodeHints.h"
#import "ZXImage.h"
#import "Tool.h"
#import "JSONKit.h"
#import "MBProgressHUD+Add.h"
#import "EGOImageView.h"
#import "UserModel.h"
#import "HelpDownloader.h"


@interface erCodeController ()<EGOImageViewDelegate>
{
    NSString *returnString;
    UIImageView *showImg;
}
@end

@implementation erCodeController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    self.title = @"我的二维码";
    
    UIBarButtonItem *rightBtnItem2 = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveImageToPhotos)];
    NSArray *buttonItemArray2 = [NSArray arrayWithObjects:rightBtnItem2, nil];
    self.navigationItem.rightBarButtonItems=buttonItemArray2;
    
    
//    UserModel *user = [Tool getUser];
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"c",user.userId,@"id",user.name,@"n",nil];
    
    UserModel *user = [Tool getUser];
    
    returnString = [NSString stringWithFormat:@"%@",user.fwmlj];
    
    
    //生成图片
    showImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 120, 280, 280)];
    showImg.image = [self makeERcode:returnString];
    showImg.tag = 67;
    [self.view addSubview:showImg];
    
    
}

- (void)saveImageToPhotos
{
    UIImageView *QRCodeImageView=showImg;
    UIGraphicsBeginImageContext(QRCodeImageView.bounds.size ); //currentView 当前的 view
    [QRCodeImageView.layer  renderInContext: UIGraphicsGetCurrentContext()];
    UIImage *viewImage =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    UIImageWriteToSavedPhotosAlbum(viewImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
}
// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
        [MBProgressHUD showError:msg toView:nil];
    }else{
        msg = @"保存到相册" ;
        [MBProgressHUD showSuccess:msg toView:nil];
    }
}





-(UIImage *)makeERcode:(NSString *)text{
    NSError* error = nil;
    ZXMultiFormatWriter* writer = [ZXMultiFormatWriter writer];
    
    ZXEncodeHints* hints = [ZXEncodeHints hints];
    hints.errorCorrectionLevel = [ZXErrorCorrectionLevel errorCorrectionLevelH];//容错性设成最高，二维码里添加图片
    hints.encoding =  NSUTF8StringEncoding;// 加上这两句，可以用中文了
    
    
    ZXBitMatrix* result = [writer encode:text
                                  format:kBarcodeFormatQRCode width:800 height:800 hints:hints error:&error];
    /* ZXBitMatrix* result = [writer encode:self.txt.text
     format:kBarcodeFormatQRCode    //编码
     width:500  //图片大小
     height:500
     error:&error];
     */
    if (result) {
        CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
        
        UIImage *img = [[UIImage alloc] initWithCGImage:image];
    
        return  img;
        //UIImage *image1 =   [UIImage imageWithCGImage:image];//二维码原图
        return nil;
    }
    return nil;
}



//-(UIImage *)addSubImage:(UIImage *)img sub:(UIImage *) subImage
//{
//    if (img==nil) {
//        return nil;
//    }
//    if (subImage==nil) {
//        return img;
//    }
//    //get image width and height
//    int w = img.size.width;
//    int h = img.size.height;
//    int subWidth = subImage.size.width;
//    int subHeight = subImage.size.height;
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    //create a graphic context with CGBitmapContextCreate
//    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
//    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
//    CGContextDrawImage(context, CGRectMake( (w-subWidth)/2, (h - subHeight)/2, subWidth, subHeight), [subImage CGImage]);
//    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
//    CGContextRelease(context);
//    CGColorSpaceRelease(colorSpace);
//    return [UIImage imageWithCGImage:imageMasked];
//    //  CGContextDrawImage(contextRef, CGRectMake(100, 50, 200, 80), [smallImg CGImage]);
//}



@end
