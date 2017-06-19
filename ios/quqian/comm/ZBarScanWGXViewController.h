//
//  ZBarScanWGXViewController.h
//  wqkj
//
//  Created by WANGGUANXIAO on 14-2-13.
//  Copyright (c) 2014年 WANGGUANXIAO. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ZBarScanWGXViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImageView *runGreenLingImgV;
    float greenLineH;
    NSTimer *youTimer;
    
    UIActivityIndicatorView *activiIndicatorV;
    BOOL wgxAddB;
    
    AVCaptureSession * _AVSession;//调用闪光灯的时候创建的类
}

@property(strong,nonatomic)AVAudioPlayer *player;
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;


@end


