//
//  PTWEBViewController.m
//  qianbangzhu
//
//  Created by 宋培众 on 2017/6/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PTWEBViewController.h"
#import "HelpDownloader.h"

@interface PTWEBViewController ()<UIWebViewDelegate>
{
    UIWebView *web;
}
@end

@implementation PTWEBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    [web loadHTMLString:[self makehHTML] baseURL:nil];
    web.delegate = self;
    [self.view addSubview:web];
}

-(NSString *)makehHTML{
    NSMutableString *string = [NSMutableString string];
    [string appendFormat:@"<!DOCTYPE HTML><html><head><meta charset=\"UTF-8\"></head><body><form id='sbform' action='%@' method='post'>",self.fyUrl];
    [string appendFormat:@"<input type='hidden' name='mchnt_cd' value='%@'>\n",self.mchnt_cd];
    [string appendFormat:@"<input type='hidden' name='mchnt_txn_ssn' value='%@'>\n",self.mchnt_txn_ssn];
    [string appendFormat:@"<input type='hidden' name='amt' value='%@'>\n",self.amt];
    [string appendFormat:@"<input type='hidden' name='login_id' value='%@'>\n",self.login_id];
    [string appendFormat:@"<input type='hidden' name='page_notify_url' value='%@'>\n",self.page_notify_url];
    [string appendFormat:@"<input type='hidden' name='back_notify_url' value='%@'>\n",self.back_notify_url];
    [string appendFormat:@"<input type='hidden' name='signature' value='%@'>\n",self.signatureStr];
    [string appendString:@"</form><script type='text/javascript'>document.getElementById('sbform').submit();</script></body></html>"];
    return string;
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSURL *surl = request.URL;
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSString *lJs = @"document.documentElement.innerHTML";
    NSString *lHtml1 = [webView stringByEvaluatingJavaScriptFromString:lJs];
    NSLog(@"lHtml1 %@",lHtml1);
    if ([lHtml1 containsString:@"onclick=\"sendCode('0000')"]) {
        [Tool myalters:@"交易成功"];
         [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadzhanghaoyuexinxi" object:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
         
    }else if ([lHtml1 containsString:@"onclick=\"sendCode("]) {
        [Tool myalter:@"交易失败"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    return YES;
}



//投资确认回调
-(void)reloadweb_sbtz_tbBack:(NSString *)string{
    
     [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadzhanghaoyuexinxi" object:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
