//
//  WebController.m
//  quqian
//
//  Created by apple on 15/3/30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "WebController.h"
#import "MBProgressHUD+Add.h"
#import "AppDelegate.h"
#import "Tool.h"

@interface WebController ()<UIWebViewDelegate>
{
    MBProgressHUD *HUD;
    UIWebView *web;
}
@end

@implementation WebController
@synthesize urlString;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    web.delegate = self;
    [self.view addSubview:web];
    NSURLRequest *requ = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.urlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    [web loadRequest:requ];
    
    
    UIBarButtonItem *rightBtnItem2 = [[UIBarButtonItem alloc] initWithTitle:@"刷新 " style:UIBarButtonItemStylePlain target:self action:@selector(shuaxin)];
    NSArray *buttonItemArray2 = [NSArray arrayWithObjects:rightBtnItem2, nil];
    self.navigationItem.rightBarButtonItems=buttonItemArray2;
    
    NSLog(@"%@",self.urlString);
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    HUD = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 45, app.window.frame.size.width, app.window.frame.size.height)];
    HUD.alpha = 0.9;
    HUD.labelText = @"Loading...";
    HUD.mode = MBProgressHUDModeIndeterminate;
    [app.window addSubview:HUD];
    
}

//刷新
-(void)shuaxin{
    NSURLRequest *requ = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.urlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    [web loadRequest:requ];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    HUD = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 45, app.window.frame.size.width, app.window.frame.size.height)];
    HUD.alpha = 0.9;
    HUD.labelText = @"Loading...";
    HUD.mode = MBProgressHUDModeIndeterminate;
    [app.window addSubview:HUD];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
     [HUD removeFromSuperview];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [HUD removeFromSuperview];
    [Tool myalter:@"加载失败"];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
