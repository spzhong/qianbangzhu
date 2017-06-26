//
//  WebViewController.m
//  qianbangzhu
//
//  Created by 宋培众 on 2017/6/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CGWebViewController.h"
#import "HelpDownloader.h"

@interface CGWebViewController ()<UIWebViewDelegate>
{
    UIWebView *web;
}
@end

@implementation CGWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
    web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    [web loadHTMLString:[self makehHTML] baseURL:nil];
    web.delegate = self;
    [self.view addSubview:web];
}

-(NSString *)makehHTML{
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"<!doctype html><html lang=\"en\"><head><meta charset=\"UTF-8\"><meta name=\"Generator\" content=\"EditPlus®\">"];
    [string appendString:@"<meta name=\"Author\" content=\"\"><meta name=\"Keywords\" content=\"\"><meta name=\"Description\" content=\"\"><title>Document</title></head><body><form  id=\"cgForm\" method=\"post\" action=\""];
    [string appendString:self.sendUrl];
    [string appendString:@"\">"];
    [string appendString:@"<input type=\"hidden\" name=\"RequestData\" id=\"RequestData\" value=\""];
    [string appendString:self.sendStr];
    [string appendString:@"\" />"];
    [string appendString:@"<input type=\"hidden\" name=\"transCode\" id=\"transCode\" value=\""];
    [string appendString:self.transCode];
    [string appendString:@"\" />"];
    [string appendString:@"</form><script type=\"text/javascript\">window.onload= function(){document.getElementById('cgForm').submit();}</script></body></html>"];
    return string;
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSURL *surl = request.URL;
    
    //存管投标的返回
    if ([surl.resourceSpecifier containsString:@"app/sbtz/tbBack.htm"]) {
        [self reloadweb_sbtz_tbBack:@"sbtz/tbBack.htm"];
        return NO;
    }
    //充值的返回
    if ([surl.resourceSpecifier containsString:@"app/user/deal/payCgBack.htm"]) {
        [self reloadweb_sbtz_tbBack:@"user/deal/payCgBack.htm"];
        return NO;
    }
    //提现的返回
    if ([surl.resourceSpecifier containsString:@"app/user/deal/withCgBack.htm"]) {
        [self reloadweb_sbtz_tbBack:@"user/deal/withCgBack.htm"];
        return NO;
    }
    //开通存管账户
    if ([surl.resourceSpecifier containsString:@"app/user/bankcard/regCgBack.htm"]) {
        [self reloadweb_sbtz_tbBack:@"user/bankcard/regCgBack.htm"];
        return NO;
    }
    //绑定银行账户
    if ([surl.resourceSpecifier containsString:@"app/user/bankcard/regCgBkBack.htm"]) {
        [self reloadweb_sbtz_tbBack:@"user/bankcard/regCgBkBack.htm"];
        return NO;
    }
    return YES;
}



//投资确认回调
-(void)reloadweb_sbtz_tbBack:(NSString *)string{
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/%@",BASE_URL,string];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:self.seqNum forKey:@"seqNum"];
    
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"no",@"isshowHUD",
                                           @"no",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   NSString *ss = data;
                                   if ([ss containsString:@"sendCode('0000')"]) {
                                       
                                       if (self.tag==100) {
                                             [[NSNotificationCenter defaultCenter] postNotificationName:@"kaitoncungforzhuce" object:nil];
                                           return;
                                       }
                                       
                                       if (self.tag==1) {
                                           //通知投资的列表刷新
                                           [[NSNotificationCenter defaultCenter] postNotificationName:@"gengxinshuju" object:nil];
                                       }
                                       [self.navigationController popToRootViewControllerAnimated:YES];
                                     
                                       [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadzhanghaoyuexinxi" object:nil];
                                   }else{
                                       [self.navigationController popViewControllerAnimated:YES];
                                   }
                               }];
    
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
