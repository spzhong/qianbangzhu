//
//  CGkaitongViewController.m
//  qianbangzhu
//
//  Created by 宋培众 on 2017/6/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CGkaitongViewController.h"
#import "Tool.h"
#import "HelpDownloader.h"
#import "UtilityUI.h"
#import "CGWebViewController.h"


@interface CGkaitongViewController ()
{
    UITextField *realName;
    UITextField *realNum;
}
@end

@implementation CGkaitongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:RGB(236, 243, 246)];
    
    realName = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(20, 20, ScreenWidth-40, 40) FontFl:15 backgroundImg:nil UIKeyboardType:UIKeyboardTypeDefault];
    [self.view addSubview:realName];
    realName.placeholder = @"请输入您的真实姓名";
    [realName setBackgroundColor:[UIColor whiteColor]];
    
    realNum = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(20, 80, ScreenWidth-40, 40) FontFl:15 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [self.view addSubview:realNum];
    realNum.placeholder = @"请输入您的身份证号码";
    [realNum setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *cgkaitong = [Tool ButtonProductionFunction:@"立即开通" Frame:CGRectMake(20, 140, ScreenWidth-40, 45) bgImgName:nil FontFl:15];
    [cgkaitong addTarget:self action:@selector(lijikaitong) forControlEvents:UIControlEventTouchUpInside];
    [cgkaitong setBackgroundColor:KTHCOLOR];
    [self.view addSubview:cgkaitong];
    [cgkaitong setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [UtilityUI setBorderOnView:cgkaitong borderColor:KTHCOLOR borderWidth:1 cornerRadius:4];
    
}


-(void)lijikaitong{
    if (realName.text.length==0) {
        [Tool myalter:@"请输入您的真实姓名"];
        return;
    }
    if (realNum.text.length==0) {
        [Tool myalter:@"请输入您的身份证号码"];
        return;
    }
    
    NSString *url =[NSString stringWithFormat:@"%@/user/bankcard/regCg.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:realName.text forKey:@"realname"];
    [postDic setObject:realNum.text forKey:@"idcard"];
    
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"no",@"isshowHUD",
                                           @"no",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   if (kk==0) {
                                       NSMutableDictionary *dic = [data JSONValue];
                                       
                                       if ([dic[@"rvalue"] isKindOfClass:[NSNull class]]) {
                                           [Tool myalter:dic[@"msg"]];
                                           return;
                                       }
                                       NSMutableDictionary *dicData = dic[@"rvalue"];
                                       //进入web的确认页面
                                       CGWebViewController *web = [[CGWebViewController alloc] init];
                                       web.title = @"开通存管账户";
                                       web.sendUrl = dicData[@"asydata"][@"sendUrl"];
                                       web.sendStr = dicData[@"asydata"][@"sendStr"];
                                       web.transCode = dicData[@"asydata"][@"transCode"];
                                       web.seqNum = dicData[@"asydata"][@"seqNum"];
                                       UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
                                       backItem.title=@"返回";
                                       self.navigationItem.backBarButtonItem=backItem;
                                       self.hidesBottomBarWhenPushed=YES;
                                       [self.navigationController pushViewController:web animated:YES];
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
