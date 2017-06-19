//
//  ZBarScanWGXViewController.m
//  wqkj
//
//  Created by WANGGUANXIAO on 14-2-13.
//  Copyright (c) 2014年 WANGGUANXIAO. All rights reserved.
//


#import "ZBarScanWGXViewController.h"
#import "Tool.h"


#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height



@interface ZBarScanWGXViewController ()

@end

@implementation ZBarScanWGXViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)back
{
    if (youTimer) {
        if ([youTimer isValid]) {
            [youTimer invalidate];
            youTimer=nil;
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)takePicture
{
//    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择二维码", nil];
//    actionSheet.tag = 909;
//    [actionSheet showInView:((AppDelegate*)[UIApplication sharedApplication].delegate).window];

}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 909) {
        if (buttonIndex==0) {
            
           
        }
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    wgxAddB=NO;
    self.view.backgroundColor = [UIColor blackColor];
 
    self.title = @"扫一扫";
    
 
//    //照相机
//    UIBarButtonItem *rightBtnItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePicture)];
//    NSArray *buttonItemArray = [NSArray arrayWithObjects:rightBtnItem1, nil];
//    self.navigationItem.rightBarButtonItems=buttonItemArray;
//    
    
    //开始
    [self setupCamera];
    
    
    // 开始轮
    activiIndicatorV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activiIndicatorV.center = CGPointMake(320/2, SCREEN_HEIGHT/2);
    [self.view addSubview:activiIndicatorV];
    [activiIndicatorV startAnimating];
    [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(beginRunTheQR) userInfo:nil repeats:NO];

}
-(void)beginRunTheQR
{
    [self LoadOK];
    
}




- (void)setupCamera
{
    // Device
//    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    
//    // Input
//    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
//    
//    // Output
//    self.output = [[AVCaptureMetadataOutput alloc]init];
//    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
//    
//    // Session
//    _session = [[AVCaptureSession alloc]init];
//    [_session setSessionPreset:AVCaptureSessionPresetHigh];
//    if ([_session canAddInput:self.input])
//    {
//        [_session addInput:self.input];
//    }
//    
//    if ([_session canAddOutput:self.output])
//    {
//        [_session addOutput:self.output];
//    }
//    
//    
//    //_output
//    // 条码类型 AVMetadataObjectTypeQRCode
//    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
//    
    
    
    
    NSError *error;
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        
        [Tool myalter:@"无法使用照相机"];
        
        return;
    }
    
    _session = [[AVCaptureSession alloc] init];
    // Set the input device on the capture session.
    [_session addInput:input];
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_session addOutput:captureMetadataOutput];
    
    // Create a new serial dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =CGRectMake(20,115,280,260);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    
    
    [_session startRunning];
    
 
    
    return;
    
    
    
//    // Preview
//    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
//    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
//    _preview.frame =CGRectMake(20,115,280,260);
//    [self.view.layer insertSublayer:self.preview atIndex:0];
//    
//    
//    
//    // Start
//    [_session startRunning];
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];
    
    //回调
    [self successToScan:stringValue];
    
}








-(void)LoadOK
{
    //中间区
    [activiIndicatorV stopAnimating];
    [activiIndicatorV removeFromSuperview];
   
    UIControl *midControl = [[UIControl alloc] init];
    midControl.frame = CGRectMake(50,130,220,220);
    [midControl.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [midControl.layer setBorderWidth:.5f];
    [self.view addSubview:midControl];
    // 四个角
    for (int i=0; i<4; i++) {
        NSString *imgString = [NSString stringWithFormat:@"ScanQR%d.png",i+1];
        UIImage *img = [UIImage imageNamed:imgString];
        UIImageView *imgV = [[UIImageView alloc] initWithImage:img];
        // 0-1 0-1  w0 0w ww (i+1)/2
        float pianX = 0.0;
        float pianY = 0.0;
        if (i==0) {
            pianX=0.5;
            pianY=0.5;
        }
        if (i==1) {
            pianX=img.size.width;
            pianY=0.5;
        }
        if (i==2) {
            pianX=0.5;
            pianY=img.size.height;
        }
        if (i==3) {
            pianX=img.size.width;
            pianY=img.size.height;
        }
        
        imgV.frame = CGRectMake(i%2*220-pianX, i/2*220-pianY, img.size.width, img.size.height);
        [midControl addSubview:imgV];
    }
    
    UIImage *runImg = [UIImage imageNamed:@"ff_QRCodeScanLine.png"];
    runImg = [runImg stretchableImageWithLeftCapWidth:runImg.size.width/2 topCapHeight:runImg.size.height/2];
    runGreenLingImgV = [[UIImageView alloc] initWithImage:runImg];
    runGreenLingImgV.frame = CGRectMake(0,135,320,runImg.size.height);
    [self.view addSubview:runGreenLingImgV];
    // 加黑色部分
    for (int i=0; i<4; i++) {
        UIControl *control = [[UIControl alloc] init];
        control.backgroundColor = [UIColor blackColor];
        control.alpha = 0.6f;
        if (i==0) {
            control.frame = CGRectMake(0, 0, 320, 120);
        }else if (i==1) {
            control.frame = CGRectMake(0, 130+220, 320, 220);
        }else if (i==2) {
            control.frame = CGRectMake(0, 130, 50, 220);
        }else if (i==3) {
            control.frame = CGRectMake(320-50, 130, 320, 220);
        }
        [self.view addSubview:control];

    }
    // 最下面的
    UIView *bottomView = [[UIView alloc] init];
    bottomView.frame = CGRectMake(0, SCREEN_HEIGHT-100, 320, 100);
    bottomView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bottomView];
    // 开关闪光灯
    //MainButton_Off@2x   MainButton_On@2x
//    UIImage *lightImage = [UIImage imageNamed:@"MainButton_Off.png"];
//    UIImage *lightOnImage = [UIImage imageNamed:@"MainButton_On.png"];
//    
//    UIButton *lightBtn = [Tool ButtonProductionFunction:@"" Frame:CGRectMake(0, 0, lightImage.size.width/2, lightImage.size.height/2) bgImgName:@"" FontFl:0];
//    lightBtn.center = CGPointMake(320/2, 60);
//    [lightBtn setBackgroundImage:lightImage forState:UIControlStateNormal];
//    [lightBtn setBackgroundImage:lightOnImage forState:UIControlStateSelected];
//    [lightBtn addTarget:self action:@selector(lighKaiGuan:) forControlEvents:UIControlEventTouchUpInside];
//    [bottomView addSubview:lightBtn];
    
    // 开始动画
    youTimer=[NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(comcom) userInfo:nil repeats:YES];
}

-(void)lighKaiGuan:(id)sender
{
    UIButton *buttoner = (UIButton*)sender;
    if ([buttoner isSelected]) {
        [buttoner setSelected:NO];
        
    }else {
        [buttoner setSelected:YES];
        
    }
}
-(void)comcom
{
    greenLineH+=2;
    if (!wgxAddB&&greenLineH==12) {
        wgxAddB=YES;
    }
    runGreenLingImgV.frame = CGRectMake(0,115+greenLineH,320,12);
    if (greenLineH==220) {
        greenLineH=0;
    }
}

// 播放声音
-(void)playAudio
{
    // 声音文件准备
    NSString *pathAudiostr = [NSString stringWithFormat:@"%@/qrcode_found.m4a",[[NSBundle mainBundle] resourcePath]];
    NSData *data = [NSData dataWithContentsOfFile:pathAudiostr];
    self.player= [[AVAudioPlayer alloc] initWithData:data error:nil];
    [self.player prepareToPlay];
    [self.player play];
    
}
-(void)successToScan:(NSString*)resultStr
{
    if (youTimer) {
        if ([youTimer isValid]) {
            [youTimer invalidate];
            youTimer=nil;
        }
    }
    //[self playAudio];
    [self performSelector:@selector(backTo) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GoToZbarBackToMakeTheResult" object:resultStr];
    
}


-(void)backTo{
    [self.navigationController popViewControllerAnimated:NO];
}






@end

