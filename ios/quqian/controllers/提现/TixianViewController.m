//
//  TixianViewController.m
//  qianbangzhu
//
//  Created by 宋培众 on 2017/6/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TixianViewController.h"
#import "TixianjiluViewController.h"
#import "HelpDownloader.h"
#import "Tool.h"
#import "UserModel.h"
#import "UtilityUI.h"
#import "CGWebViewController.h"
#import "PTWEBViewController.h"
#import "CGkaitongViewController.h"
#import "BangYinHangViewController.h"


@interface TixianViewController ()
{
    UserModel *user;
    NSMutableDictionary *alldic;
    UIButton *cgkaitong_but;
    UIButton *ptkaitong_but;
    UIView *selcteView;
    UIView *cgView;
    UIView *ptView;
    UITextField *textFile_cg;
    UITextField *textFile_pt;
}
@end

@implementation TixianViewController


-(void)enditNSUS{
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:RGB(236, 243, 246)];
    
    UIControl *bg = [[[UIControl alloc] init] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [bg addTarget:self action:@selector(enditNSUS) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bg];
    
    
    user =  (UserModel *)[Tool getUser];
    
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/user/deal/getwithdraw.htm",BASE_URL];
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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提现记录" style:UIBarButtonItemStylePlain target:self action:@selector(ChongjiluViewController)];
    
}

-(void)ChongjiluViewController{
    TixianjiluViewController *chognzhi = [[TixianjiluViewController alloc] init];
    chognzhi.title = @"提现记录";
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:chognzhi animated:YES];
}



-(void)createview:(NSMutableDictionary *)dic{
    cgkaitong_but = [Tool ButtonProductionFunction:@"存管提现" Frame:CGRectMake(ScreenWidth/2, 0, ScreenWidth/2, 45) bgImgName:nil FontFl:15];
    [cgkaitong_but addTarget:self action:@selector(cgkaitong_but_p) forControlEvents:UIControlEventTouchUpInside];
    [cgkaitong_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [cgkaitong_but setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:cgkaitong_but];
    
    ptkaitong_but = [Tool ButtonProductionFunction:@"普通提现" Frame:CGRectMake(0, 0, ScreenWidth/2, 45) bgImgName:nil FontFl:15];
    [ptkaitong_but addTarget:self action:@selector(ptkaitong_but_p) forControlEvents:UIControlEventTouchUpInside];
    [ptkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [ptkaitong_but setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:ptkaitong_but];
    
    selcteView = [[UIView alloc] initWithFrame:CGRectZero];
    [selcteView setBackgroundColor:KTHCOLOR];
    [self.view addSubview:selcteView];
    
    [self ptkaitong_but_p];
}


-(void)cgkaitong_but_p{
    selcteView.frame = CGRectMake(ScreenWidth/2,43, ScreenWidth/2, 2);
    [cgkaitong_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [ptkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [self CGtixian:alldic[@"cg"]];
}


-(void)ptkaitong_but_p{
    selcteView.frame = CGRectMake(0,43, ScreenWidth/2, 2);
    [ptkaitong_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [cgkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [self PTtixian:alldic[@"pt"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)CGtixian:(NSMutableDictionary *)dic{
    ptView.hidden = YES;
    if (cgView) {
        cgView.hidden = NO;
        return;
    }
    
    cgView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, ScreenHeight)];
    
    //开通了存管账户
    if ([dic[@"cgzt"] isEqualToString:@"S"]) {
        
        UIView *bg1 = [self createCell:@"可用余额" withValue:[NSString stringWithFormat:@"%@元",user.cgkyye] withClor:YES withinput:NO];
        bg1.frame = CGRectMake(0, 5, ScreenWidth, 40);
        [cgView addSubview:bg1];
        
        
        UIView *bg2 = [self createCell:@"华兴E账户" withValue:@"6236882280000375472" withClor:NO withinput:NO];
        bg2.frame = CGRectMake(0, 40+5, ScreenWidth, 40);
        [cgView addSubview:bg2];
        
        UIView *bg3 = [self createCell:@"提现金额" withValue:@"请输入提现金额" withClor:NO withinput:YES];
        bg3.frame = CGRectMake(0, 2*40+5, ScreenWidth, 40);
        [cgView addSubview:bg3];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 45, ScreenWidth, 0.5)];
        [line1 setBackgroundColor:RGB(155, 155, 155)];
        [cgView addSubview:line1];
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 85, ScreenWidth, 0.5)];
        [line2 setBackgroundColor:RGB(155, 155, 155)];
        [cgView addSubview:line2];
        
        
        UIButton *cgkaitong = [Tool ButtonProductionFunction:@"立即提现" Frame:CGRectMake(20, 145, ScreenWidth-40, 45) bgImgName:nil FontFl:15];
        [cgkaitong addTarget:self action:@selector(lijitixian) forControlEvents:UIControlEventTouchUpInside];
        [cgkaitong setBackgroundColor:KTHCOLOR];
        [cgView addSubview:cgkaitong];
        [cgkaitong setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [UtilityUI setBorderOnView:cgkaitong borderColor:KTHCOLOR borderWidth:1 cornerRadius:4];
        
        UILabel *labInfo = [Tool LablelProductionFunction:@"重要提示\n1.提现不收取任何费用，请选择合适的提现方式；\n2.可选择提现至华兴银行资金存管E账户，提现实时到账；\n3.可选择提现至已绑定银行卡内；\n网银互联：小于5万元的实时到账\n小额：5-50万以内，2小时到账\n大额：50万以上8:30~16:19工作日内实时到账，其余时间不受理\n4.资金回款当日（包括双休日和法定节假日）均可发起提现申请;\n5.用户首次提现，需通过华兴投融资APP完成实名认证后方可进行操作；\n认证步骤：①下载华兴投融资APP；②APP左上角(图标“≡”)-个人中心-实名认证；③进行人脸扫描、身份证正反面照、手持身份证照上传。\n认证时间：工作日17:00前提出认证申请的，当天完成； 17：00后的，T+1完成；非工作日T+1完成(节假日顺延)\n6.如您在提现过程中遇到任何问题，可直接致电400-8535-666或咨询在线客服。" Frame:CGRectMake(15, 200, ScreenWidth-30, 999)  Alignment:NSTextAlignmentLeft FontFl:14];
        [labInfo sizeToFit];
        labInfo.textColor = RGB(90, 90, 90);
        [cgView addSubview:labInfo];
        
    }else{
        
        UILabel *lab = [Tool LablelProductionFunction:@"您尚未开通存管账户，现在去开通？" Frame:CGRectMake(0, 100, ScreenWidth, 45) Alignment:NSTextAlignmentCenter  FontFl:14];
        [cgView addSubview:lab];
        
        UIButton *cgkaitong = [Tool ButtonProductionFunction:@"前往开通" Frame:CGRectMake(80, 145, ScreenWidth-160, 45) bgImgName:nil FontFl:15];
        [cgkaitong addTarget:self action:@selector(cgkaitong) forControlEvents:UIControlEventTouchUpInside];
        [cgkaitong setBackgroundColor:KTHCOLOR];
        [cgView addSubview:cgkaitong];
        [cgkaitong setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [UtilityUI setBorderOnView:cgkaitong borderColor:KTHCOLOR borderWidth:1 cornerRadius:4];
    }
    [self.view addSubview:cgView];
}

-(void)PTtixian:(NSMutableDictionary *)dic{
    cgView.hidden = YES;
    if (ptView) {
        ptView.hidden = NO;
        return;
    }
    
    ptView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth, ScreenHeight)];
    //开通了富有
    if ([dic[@"ptzt"] isEqualToString:@"S"]) {
        
        UIView *cell1 = [self createCell:@"第三方合作机构" withValue:@"富友"];
        [ptView addSubview:cell1];
        [cell1 setBackgroundColor:[UIColor whiteColor]];
        
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 45, ScreenWidth, 160)];
        [bg setBackgroundColor:[UIColor whiteColor]];
        [ptView addSubview:bg];
        
        UILabel *labTile = [Tool LablelProductionFunction:@"可用余额" Frame:CGRectMake(30, 0, 120, 40) Alignment:NSTextAlignmentLeft  FontFl:14];
        labTile.textColor = RGB(51, 51, 51);
        [bg addSubview:labTile];
        
        UILabel *labValue = [Tool LablelProductionFunction:[NSString stringWithFormat:@"%@元",user.keyong_money] Frame:CGRectMake(120, 0, ScreenWidth-20, 40) Alignment:NSTextAlignmentLeft  FontFl:14];
        labValue.textColor = KTHCOLOR;
        [bg addSubview:labValue];
        
        
        textFile_pt = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(30,40,ScreenWidth-60, 40) FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumberPad];
        [bg addSubview:textFile_pt];
        textFile_pt.textAlignment = NSTextAlignmentCenter;
        textFile_pt.placeholder = @"请输入提现金额 最少100元";
        [textFile_pt setBackgroundColor:RGB(236, 243, 246)];
        
        
        UILabel *labTile2 = [Tool LablelProductionFunction:@"银行卡尾号：3075" Frame:CGRectMake(30, 80, 120, 40) Alignment:NSTextAlignmentLeft  FontFl:14];
        labTile2.textColor = RGB(51, 51, 51);
        [bg addSubview:labTile2];
        
        UILabel *labValue2 = [Tool LablelProductionFunction:@"提现费用：2元/笔" Frame:CGRectMake(0, 80, ScreenWidth-30, 40) Alignment:NSTextAlignmentRight  FontFl:14];
        labValue2.textColor = RGB(51, 51, 51);
        [bg addSubview:labValue2];
        
        UILabel *labValue3 = [Tool LablelProductionFunction:@"实际扣除金额：0.00元" Frame:CGRectMake(30, 120, ScreenWidth-30, 40) Alignment:NSTextAlignmentLeft  FontFl:14];
        labValue3.textColor = RGB(51, 51, 51);
        [bg addSubview:labValue3];
        
        
        UIButton *cgkaitong = [Tool ButtonProductionFunction:@"立即提现" Frame:CGRectMake(30, 190+45, ScreenWidth-60, 45) bgImgName:nil FontFl:15];
        [cgkaitong addTarget:self action:@selector(ptlijichongzhi) forControlEvents:UIControlEventTouchUpInside];
        [cgkaitong setBackgroundColor:KTHCOLOR];
        [ptView addSubview:cgkaitong];
        [cgkaitong setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [UtilityUI setBorderOnView:cgkaitong borderColor:KTHCOLOR borderWidth:1 cornerRadius:4];
        
        
        UILabel *labInfo = [Tool LablelProductionFunction:@"温馨提示\n1.双休日和法定节假日期间，用户可以申请提现，资金托管方会在下一个工作日进行处理。由此造成的不便，请多多谅解！\n2.平台禁止洗钱、信用卡套现、虚假交易等行为，一经发现并确认，将终止该账户的使用。" Frame:CGRectMake(15, 260+45, ScreenWidth-30, 999)  Alignment:NSTextAlignmentLeft FontFl:14];
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


-(UIView *)createCell:(NSString *)title withValue:(NSString *)value withClor:(BOOL)y withinput:(BOOL)yput{
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    [bg setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *labTile = [Tool LablelProductionFunction:title Frame:CGRectMake(30, 0, 120, 40) Alignment:NSTextAlignmentLeft  FontFl:14];
    labTile.textColor = RGB(51, 51, 51);
    [bg addSubview:labTile];
    
    if ([title isEqualToString:@"签约充值"]) {
        UIImageView *img1 = [Tool ImgProductionFunctionFrame:CGRectMake(15, 10, 20, 20) bgImgName:@"签约充值"];
        [bg addSubview:img1];
        labTile.frame = CGRectMake(50, 0, 120, 40);
    }
    if ([title isEqualToString:@"快捷充值"]) {
        UIImageView *img1 = [Tool ImgProductionFunctionFrame:CGRectMake(15, 10, 20, 20) bgImgName:@"快捷充值"];
        [bg addSubview:img1];
        labTile.frame = CGRectMake(50, 0, 120, 40);
    }
    
    if (yput) {
        textFile_cg = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(120, 0, 200, 40) FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumberPad];
        [bg addSubview:textFile_cg];
        textFile_cg.placeholder = @"请输入提现金额";
    }else{
        UILabel *labValue = [Tool LablelProductionFunction:value Frame:CGRectMake(120, 0, 200, 40) Alignment:NSTextAlignmentLeft  FontFl:14];
        labValue.textColor = RGB(51, 51, 51);
        [bg addSubview:labValue];
        if (y) {
            labValue.textColor = KTHCOLOR;
        }
    }
    
    return bg;
}


-(UIView *)createCell:(NSString *)title withValue:(NSString *)value {
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    [bg setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *labTile = [Tool LablelProductionFunction:title Frame:CGRectMake(30, 0, 120, 40) Alignment:NSTextAlignmentLeft  FontFl:14];
    labTile.textColor = RGB(51, 51, 51);
    [bg addSubview:labTile];
    
    UILabel *labValue = [Tool LablelProductionFunction:value Frame:CGRectMake(0, 0, ScreenWidth-20, 40) Alignment:NSTextAlignmentRight  FontFl:14];
    labValue.textColor = RGB(51, 51, 51);
    [bg addSubview:labValue];
    
    return bg;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//开通存管
-(void)cgkaitong{
    CGkaitongViewController *cg = [[CGkaitongViewController alloc] init];
    cg.title = @"开通存管";
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:cg animated:YES];
}

//立即绑定
-(void)lijibangding{
    if ([alldic[@"zhlx"] isEqualToString:@"QYZH"]) {
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

//立即提现--存管
-(void)lijitixian{
    
    [textFile_cg resignFirstResponder];
    [textFile_pt resignFirstResponder];
    // 存管充值按钮
    NSString *JIN = textFile_cg.text;
    if ([JIN length] == 0) {
        [Tool myalter:@"请输入提现金额"];
        return;
    }
//    double JINdd = [JIN doubleValue];
//    if(JINdd>=100 && JINdd < 1000000){
//    } else{
//        [Tool myalter:@"提现金额必须大于100"];
//        return;
//    }
    NSString *url =[NSString stringWithFormat:@"%@/user/deal/withdraw.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    [postDic setObject:textFile_cg.text forKey:@"amount"];
    [postDic setObject:@"CGTX" forKey:@"type"];
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
                                       
                                       NSMutableDictionary *dicData = [dic[@"rvalue"] firstObject];
                                       user.keyong_money = [NSString stringWithFormat:@"%@",dicData[@"amount"]];
                                       [Tool savecoredata];
                                       //进入web的确认页面
                                       CGWebViewController *web = [[CGWebViewController alloc] init];
                                       web.title = @"提现";
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

//立即提现--富有
-(void)ptlijichongzhi{
 
    [textFile_cg resignFirstResponder];
    [textFile_pt resignFirstResponder];
    // 存管充值按钮
    NSString *JIN = textFile_pt.text;
    if ([JIN length] == 0) {
        [Tool myalter:@"请输入提现金额"];
        return;
    }
//    double JINdd = [JIN doubleValue];
//    if(JINdd>=100 && JINdd < 1000000){
//    } else{
//        [Tool myalter:@"提现金额必须大于100"];
//        return;
//    }
    NSString *url =[NSString stringWithFormat:@"%@/user/deal/withdraw.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    [postDic setObject:textFile_pt.text forKey:@"amount"];
    [postDic setObject:@"PTTX" forKey:@"type"];
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"no",@"isshowHUD",
                                           @"no",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   if (kk==0) {
                                       NSMutableDictionary *dic = [data JSONValue][@"rvalue"];
                                       
                                       user.keyong_money = [NSString stringWithFormat:@"%@",dic[@"amount"]];
                                       [Tool savecoredata];
                                       
                                       
                                       PTWEBViewController *pt = [[PTWEBViewController alloc] init];
                                       pt.title = self.title;
                                       pt.mchnt_cd = dic[@"mchnt_cd"];
                                       pt.mchnt_txn_ssn = dic[@"mchnt_txn_ssn"];
                                       pt.amt = dic[@"amt"];
                                       pt.login_id = dic[@"login_id"];
                                       pt.page_notify_url = dic[@"page_notify_url"];
                                       pt.back_notify_url = dic[@"back_notify_url"];
                                       pt.signatureStr = dic[@"signature"];
                                       pt.fyUrl = dic[@"fyUrl"];
                                       
                                       //返回
                                       UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
                                       backItem.title=@"返回";
                                       self.navigationItem.backBarButtonItem=backItem;
                                       self.hidesBottomBarWhenPushed=YES;
                                       [self.navigationController pushViewController:pt animated:YES];
                                       
                                       
                                       
                                   }
                               }];
    
}

@end
