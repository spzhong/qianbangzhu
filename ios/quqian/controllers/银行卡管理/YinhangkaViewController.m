//
//  YinhangkaViewController.m
//  qianbangzhu
//
//  Created by 宋培众 on 2017/6/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YinhangkaViewController.h"
#import "HelpDownloader.h"
#import "Tool.h"
#import "UtilityUI.h"
#import "CGkaitongViewController.h"
#import "BangYinHangViewController.h"
#import "CGWebViewController.h"


@interface YinhangkaViewController ()
{
    UIButton *cgkaitong_but;
    UIButton *ptkaitong_but;
    UIView *selcteView;
    UIView *cgView;
    UIView *ptView;
    NSMutableDictionary *alldic;
}
@end

@implementation YinhangkaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:RGB(236, 243, 246)];
    
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/user/bankcard/list.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"no",@"isshowHUD",
                                           @"no",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   if (kk==0) {
                                       alldic = [[data JSONValue][@"rvalue"] mutableCopy];
                                       [self createview:alldic];
                                   }
                               }];
}



-(void)createview:(NSMutableDictionary *)dic{
    cgkaitong_but = [Tool ButtonProductionFunction:@"存管账户" Frame:CGRectMake(0, 0, ScreenWidth/2, 45) bgImgName:nil FontFl:15];
    [cgkaitong_but addTarget:self action:@selector(cgkaitong_but_p) forControlEvents:UIControlEventTouchUpInside];
    [cgkaitong_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [cgkaitong_but setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:cgkaitong_but];
    
    ptkaitong_but = [Tool ButtonProductionFunction:@"普通账户" Frame:CGRectMake(ScreenWidth/2, 0, ScreenWidth/2, 45) bgImgName:nil FontFl:15];
    [ptkaitong_but addTarget:self action:@selector(ptkaitong_but_p) forControlEvents:UIControlEventTouchUpInside];
    [ptkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [ptkaitong_but setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:ptkaitong_but];
    
    selcteView = [[UIView alloc] initWithFrame:CGRectZero];
    [selcteView setBackgroundColor:KTHCOLOR];
    [self.view addSubview:selcteView];
    
    [self cgkaitong_but_p];
}


-(void)cgkaitong_but_p{
    selcteView.frame = CGRectMake(0,43, ScreenWidth/2, 2);
    [cgkaitong_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [ptkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [self CGguanli:alldic[@"cgzh"]];
}


-(void)ptkaitong_but_p{
    selcteView.frame = CGRectMake(ScreenWidth/2,43, ScreenWidth/2, 2);
    [ptkaitong_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [cgkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [self PTguanli:alldic[@"ptzh"]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)CGguanli:(NSMutableDictionary *)dic{

    ptView.hidden = YES;
    if (cgView) {
        cgView.hidden = NO;
        return;
    }
    
    cgView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth, ScreenHeight)];
    
    //开通了存管账户
    if ([alldic[@"cgzt"] isEqualToString:@"S"]) {
        
        UILabel *labTile1 = [Tool LablelProductionFunction:[NSString stringWithFormat:@"      华兴E账户：%@",dic[@"hxzh"]] Frame:CGRectMake(0, 0, ScreenWidth,40) Alignment:NSTextAlignmentLeft  FontFl:14];
        labTile1.textColor = RGB(51, 51, 51);
        [labTile1 setBackgroundColor:[UIColor whiteColor]];
        [cgView addSubview:labTile1];
        
        UILabel *labTile2 = [Tool LablelProductionFunction:[NSString stringWithFormat:@"      开户支行：%@",dic[@"name"]] Frame:CGRectMake(0, 40, ScreenWidth,40) Alignment:NSTextAlignmentLeft  FontFl:14];
        labTile2.textColor = RGB(51, 51, 51);
        [labTile2 setBackgroundColor:[UIColor whiteColor]];
        [cgView addSubview:labTile2];
        
        UILabel *labTile3 = [Tool LablelProductionFunction:[NSString stringWithFormat:@"      开户支行：%@",dic[@"khzh"]] Frame:CGRectMake(0, 80, ScreenWidth,40) Alignment:NSTextAlignmentLeft  FontFl:14];
        labTile3.textColor = RGB(51, 51, 51);
        [labTile3 setBackgroundColor:[UIColor whiteColor]];
        [cgView addSubview:labTile3];
 
        UILabel *labInfo = [Tool LablelProductionFunction:@"重要提示\n1. 华兴银行E账户即华兴银行电子账户，是用户在华兴银行实名开立的、用于办理钱帮主资金业务的账户；\n2.一个用户只能开立一个E账户，且只能绑定一张银行卡；\n3.如需更换绑定银行卡，请按实际情况选择更换；\n（1）E账户资产全部转出，登录华兴银行投融资平台进行更换；\n（2）绑定银行卡挂失或销户销卡，通过投融资APP申请人工审批换卡" Frame:CGRectMake(15, 220, ScreenWidth-30, 999)  Alignment:NSTextAlignmentLeft FontFl:14];
        [labInfo sizeToFit];
        labInfo.textColor = RGB(90, 90, 90);
        [cgView addSubview:labInfo];
        
        if ([dic[@"sfbk"] isEqualToString:@"F"]) {
            UIButton *cgkaitong = [Tool ButtonProductionFunction:@"绑定银行卡" Frame:CGRectMake(80, 150, ScreenWidth-160, 45) bgImgName:nil FontFl:15];
            [cgkaitong addTarget:self action:@selector(cunguanbangding) forControlEvents:UIControlEventTouchUpInside];
            [cgkaitong setBackgroundColor:KTHCOLOR];
            [cgView addSubview:cgkaitong];
            [cgkaitong setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [UtilityUI setBorderOnView:cgkaitong borderColor:KTHCOLOR borderWidth:1 cornerRadius:4];
            
        }else{
            
            UIButton *cgkaitong = [Tool ButtonProductionFunction:@"已绑定银行卡" Frame:CGRectMake(80, 150, ScreenWidth-160, 45) bgImgName:nil FontFl:15];
            [cgkaitong addTarget:self action:@selector(cunguanbangding) forControlEvents:UIControlEventTouchUpInside];
            [cgkaitong setBackgroundColor:KTHCOLOR];
            [cgView addSubview:cgkaitong];
            [cgkaitong setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [UtilityUI setBorderOnView:cgkaitong borderColor:KTHCOLOR borderWidth:1 cornerRadius:4];
            cgkaitong.enabled = NO;
        }
        
    }else{
        
        UILabel *lab = [Tool LablelProductionFunction:@"您尚未开通存管账户，现在去开通？" Frame:CGRectMake(0, 100, ScreenWidth, 45) Alignment:NSTextAlignmentCenter  FontFl:14];
        [cgView addSubview:lab];
        
        UIButton *cgkaitong = [Tool ButtonProductionFunction:@"前往开通" Frame:CGRectMake(80, 145, ScreenWidth-160, 45) bgImgName:nil FontFl:15];
        [cgkaitong addTarget:self action:@selector(kaitong) forControlEvents:UIControlEventTouchUpInside];
        [cgkaitong setBackgroundColor:KTHCOLOR];
        [cgView addSubview:cgkaitong];
        [cgkaitong setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [UtilityUI setBorderOnView:cgkaitong borderColor:KTHCOLOR borderWidth:1 cornerRadius:4];
    }
    [self.view addSubview:cgView];
}


-(void)PTguanli:(NSMutableDictionary *)dic{
    cgView.hidden = YES;
    if (ptView) {
        ptView.hidden = NO;
        return;
    }
    
 
    
    ptView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth, ScreenHeight)];
    //开通了富有
    if ([alldic[@"ptzt"] isEqualToString:@"S"]) {
        
        UILabel *labTile1 = [Tool LablelProductionFunction:[NSString stringWithFormat:@"      银行开户行：%@",dic[@"yhkhh"]] Frame:CGRectMake(0, 0, ScreenWidth,40) Alignment:NSTextAlignmentLeft  FontFl:14];
        labTile1.textColor = RGB(51, 51, 51);
        [labTile1 setBackgroundColor:[UIColor whiteColor]];
        [ptView addSubview:labTile1];
        
        UILabel *labTile2 = [Tool LablelProductionFunction:[NSString stringWithFormat:@"      开户行地区：%@",dic[@"khhdq"]] Frame:CGRectMake(0, 40, ScreenWidth,40) Alignment:NSTextAlignmentLeft  FontFl:14];
        labTile2.textColor = RGB(51, 51, 51);
        [labTile2 setBackgroundColor:[UIColor whiteColor]];
        [ptView addSubview:labTile2];
        
        UILabel *labTile3 = [Tool LablelProductionFunction:[NSString stringWithFormat:@"      银行卡号：%@",dic[@"yhkh"]] Frame:CGRectMake(0, 80, ScreenWidth,40) Alignment:NSTextAlignmentLeft  FontFl:14];
        labTile3.textColor = RGB(51, 51, 51);
        [labTile3 setBackgroundColor:[UIColor whiteColor]];
        [ptView addSubview:labTile3];
        
        UILabel *labInfo = [Tool LablelProductionFunction:@"重要提示\n1. 该提现银行卡仅作为普通账户资金提现使用；\n2.如需更换银行卡，请前往电脑版-银行卡管理页面更换；\n3.如有疑问，请致电客服400-8535-666。" Frame:CGRectMake(15, 150, ScreenWidth-30, 999)  Alignment:NSTextAlignmentLeft FontFl:14];
        [labInfo sizeToFit];
        labInfo.textColor = RGB(90, 90, 90);
        [ptView addSubview:labInfo];

        
    }else{
        UILabel *lab = [Tool LablelProductionFunction:@"您尚未完成普通账户绑定卡，现在去绑定？" Frame:CGRectMake(0, 100, ScreenWidth, 45) Alignment:NSTextAlignmentCenter  FontFl:14];
        [ptView addSubview:lab];
        
        UIButton *cgkaitong = [Tool ButtonProductionFunction:@"立即绑定" Frame:CGRectMake(80, 145, ScreenWidth-160, 45) bgImgName:nil FontFl:15];
        [cgkaitong addTarget:self action:@selector(lijibangding) forControlEvents:UIControlEventTouchUpInside];
        [cgkaitong setBackgroundColor:KTHCOLOR];
        [ptView addSubview:cgkaitong];
        [cgkaitong setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [UtilityUI setBorderOnView:cgkaitong borderColor:KTHCOLOR borderWidth:1 cornerRadius:4];
        
    }
    [self.view addSubview:ptView];
}


-(void)kaitong{
    CGkaitongViewController *kaitong = [[CGkaitongViewController alloc] init];
    kaitong.title = @"开通存管账户";
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:kaitong animated:YES];
}

-(void)lijibangding{
    
    if ([alldic[@"zhlx"] isEqualToString:@"QYKH"]) {
        [Tool myalter:@"企业账户请到web上进行绑定"];
        return;
    }
    BangYinHangViewController *bangidng = [[BangYinHangViewController alloc] init];
    bangidng.title = @"绑定银行卡";
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:bangidng animated:YES];
}


//存管绑定银行卡
-(void)cunguanbangding{

    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/user/bankcard/regCgBk.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
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
                                       
                                       NSMutableDictionary *dicData = dic[@"rvalue"];
                                        
                                       [Tool savecoredata];
                                       //进入web的确认页面
                                       CGWebViewController *web = [[CGWebViewController alloc] init];
                                       web.title = @"绑定银行卡";
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
