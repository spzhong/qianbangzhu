//
//  Zhucehoukaitongcunguanyinhang.m
//  qianbangzhu
//
//  Created by 宋培众 on 2017/6/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Zhucehoukaitongcunguanyinhang.h"
#import "DemoViewController.h"
#import "UserModel.h"
#import "Tool.h"
#import "HelpDownloader.h"
#import "CGWebViewController.h"


@interface Zhucehoukaitongcunguanyinhang ()<DemoViewControllerDeleagete>
{
    UITextField *textField1;
    UITextField *textField2;
}
@end

@implementation Zhucehoukaitongcunguanyinhang

-(void)touchbg{
    [self.view endEditing:YES];
}


-(void)kaitoncungforzhuce{
    [self okovredostring];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kaitoncungforzhuce) name:@"kaitoncungforzhuce" object:nil];
    
    
    UIControl *bg = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:bg];
    [bg addTarget:self action:@selector(touchbg) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *zhucesuns = [Tool LablelProductionFunction:@"恭喜您注册成功" Frame:CGRectMake(0, 30, ScreenWidth, 18) Alignment:NSTextAlignmentCenter FontFl:20];
    [self.view addSubview:zhucesuns];
    
    UILabel *zhucesuns2 = [Tool LablelProductionFunction:@"开通华兴银行存管账户保障资金安全" Frame:CGRectMake(0, 60, ScreenWidth, 15) Alignment:NSTextAlignmentCenter FontFl:13];
    [self.view addSubview:zhucesuns2];
    
    
    
    textField1 = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(20,140, ScreenWidth-40, 44)  FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [self.view addSubview:textField1];
    [textField1 setBackgroundColor:[UIColor clearColor]];
    textField1.textColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
    textField1.textAlignment = NSTextAlignmentCenter;
    textField1.placeholder = @"输入您的真实姓名";

    
    UIView *line1 = [Tool ViewProductionFunction:CGRectMake(20, 183, ScreenWidth-40, 1) BgColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0]];
    [self.view addSubview:line1];
    
    
    textField2 = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(20,184, ScreenWidth-40, 44)  FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [self.view addSubview:textField2];
    [textField2 setBackgroundColor:[UIColor clearColor]];
    textField2.textColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
    textField2.textAlignment = NSTextAlignmentCenter;
    textField2.placeholder = @"输入您的身份证号";

    
    UIView *line2 = [Tool ViewProductionFunction:CGRectMake(20, 183+44, ScreenWidth-40, 1) BgColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0]];
    [self.view addSubview:line2];
    
    
    
    UIButton *kaitong = [Tool ButtonProductionFunction:@"开通华兴银行存管账户" Frame:CGRectMake(20,183+44+50, ScreenWidth-40, 40) bgImgName:nil FontFl:15];
    [kaitong setBackgroundColor:KTHCOLOR];
    [kaitong setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:kaitong];
    [kaitong addTarget:self action:@selector(kaitong) forControlEvents:UIControlEventTouchUpInside];
 
    
    UIButton *zankaitong = [Tool ButtonProductionFunction:@"暂不开通" Frame:CGRectMake(20,183+44+50+40, ScreenWidth-40, 40) bgImgName:nil FontFl:15];
    [zankaitong setBackgroundColor:[UIColor clearColor]];
    [zankaitong setTitleColor:[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.view addSubview:zankaitong];
    [zankaitong addTarget:self action:@selector(zankaitong) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    UILabel *lab = [Tool LablelProductionFunction:@"您的资金由广东华兴银行直接存管" Frame:CGRectMake(0, 0, ScreenWidth, 50) Alignment:NSTextAlignmentCenter FontFl:12];
    [lab sizeToFit];
    lab.textColor = [UIColor whiteColor];
    lab.frame = CGRectMake((ScreenWidth-lab.frame.size.width)/2, ScreenHeight-64-30, lab.frame.size.width, lab.frame.size.height);
    
    
    UIImageView *logoicn2 = [Tool ImgProductionFunctionFrame:CGRectMake(-20, 0, 16, 16) bgImgName:@"广东华兴银行LOGO2"];
    [lab addSubview:logoicn2];
    
    
    [self.view addSubview:lab];
    lab.textColor = [UIColor whiteColor];

}


-(void)okovredostring{
    
    UserModel *newUser = [Tool getUser];
    //设置手势密码
    if ([newUser.code length]==0) {
        
        DemoViewController *demo = [[DemoViewController alloc] init];
        demo.title = @"输入密码";
        demo.type = 0;
        demo.doting = @"newCode";
        demo.deleagete = self;
        UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
        backItem.title=@"返回";
        self.navigationItem.backBarButtonItem=backItem;
        [self.navigationController pushViewController:demo animated:YES];
        
    }else{
        //离开登录
        [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    }

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

-(void)Success:(NSString *)doting{
    //登录成功后的回调
    [self.navigationController dismissViewControllerAnimated:NO completion:NULL];
}
-(void)Failure:(NSString *)doting{
    
}

-(void)kaitong{

    [self.view endEditing:YES];
    
    if (textField1.text.length==0) {
        [Tool myalter:@"请输入您的真实姓名"];
        return;
    }
    if (textField2.text.length==0) {
        [Tool myalter:@"请输入您的身份证号码"];
        return;
    }
    
    NSString *url =[NSString stringWithFormat:@"%@/user/bankcard/regCg.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:textField1.text forKey:@"realname"];
    [postDic setObject:textField2.text forKey:@"idcard"];
    
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
                                       web.tag = 100;
                                       web.sendUrl = dicData[@"sdkParameter"][@"url"];
                                       web.sendStr = dicData[@"sdkParameter"][@"requestData"];
                                       web.transCode = dicData[@"sdkParameter"][@"transCode"];
                                       web.seqNum = dicData[@"sdkParameter"][@"seqNum"];
                                       UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
                                       backItem.title=@"返回";
                                       self.navigationItem.backBarButtonItem=backItem;
                                       self.hidesBottomBarWhenPushed=YES;
                                       [self.navigationController pushViewController:web animated:YES];
                                   }
                               }];
    
    
    
}

-(void)zankaitong{
    [self okovredostring];
}

@end
