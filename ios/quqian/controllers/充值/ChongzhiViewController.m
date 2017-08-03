//
//  ChongzhiViewController.m
//  qianbangzhu
//
//  Created by 宋培众 on 2017/6/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ChongzhiViewController.h"
#import "HelpDownloader.h"
#import "UtilityUI.h"
#import "UserModel.h"
#import "FYChongzhiViewController.h"
#import "CGWebViewController.h"
#import "ChongjiluViewController.h"
#import "CGkaitongViewController.h"
#import "BangYinHangViewController.h"

@interface ChongzhiViewController ()
{
    
    UIButton *cgkaitong_but;
    UIButton *ptkaitong_but;
    UIView *selcteView;
    UIView *cgView;
    UIView *ptView;
    NSMutableDictionary *alldic;
    UITextField *textFile;
    UserModel *user;
}

@end

@implementation ChongzhiViewController


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
    NSString *url =[NSString stringWithFormat:@"%@/user/deal/getrecharge.htm",BASE_URL];
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
    //ChongjiluViewController
 
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"充值记录" style:UIBarButtonItemStylePlain target:self action:@selector(ChongjiluViewController)];
    
}

-(void)ChongjiluViewController{
    ChongjiluViewController *chognzhi = [[ChongjiluViewController alloc] init];
    chognzhi.title = @"充值记录";
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:chognzhi animated:YES];
}



-(void)createview:(NSMutableDictionary *)dic{
    
    cgkaitong_but = [Tool ButtonProductionFunction:@"存管充值" Frame:CGRectMake(ScreenWidth/2, 0, ScreenWidth/2, 45) bgImgName:nil FontFl:15];
    [cgkaitong_but addTarget:self action:@selector(cgkaitong_but_p) forControlEvents:UIControlEventTouchUpInside];
    [cgkaitong_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [cgkaitong_but setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:cgkaitong_but];
    
    ptkaitong_but = [Tool ButtonProductionFunction:@"普通充值" Frame:CGRectMake(0, 0, ScreenWidth/2, 45) bgImgName:nil FontFl:15];
    [ptkaitong_but addTarget:self action:@selector(ptkaitong_but_p) forControlEvents:UIControlEventTouchUpInside];
    [ptkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [ptkaitong_but setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:ptkaitong_but];
    
    selcteView = [[UIView alloc] initWithFrame:CGRectZero];
    [selcteView setBackgroundColor:KTHCOLOR];
    [self.view addSubview:selcteView];
    
    [self ptkaitong_but_p];
}



-(void)CGchongzhi:(NSMutableDictionary *)dic{
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
        
        UIView *bg3 = [self createCell:@"充值金额" withValue:@"请输入充值金额" withClor:NO withinput:YES];
        bg3.frame = CGRectMake(0, 2*40+5, ScreenWidth, 40);
        [cgView addSubview:bg3];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 45, ScreenWidth, 0.5)];
        [line1 setBackgroundColor:RGB(155, 155, 155)];
        [cgView addSubview:line1];
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 85, ScreenWidth, 0.5)];
        [line2 setBackgroundColor:RGB(155, 155, 155)];
        [cgView addSubview:line2];
        
        
        UIButton *cgkaitong = [Tool ButtonProductionFunction:@"立即充值" Frame:CGRectMake(20, 145, ScreenWidth-40, 45) bgImgName:nil FontFl:15];
        [cgkaitong addTarget:self action:@selector(lijichongzhi) forControlEvents:UIControlEventTouchUpInside];
        [cgkaitong setBackgroundColor:KTHCOLOR];
        [cgView addSubview:cgkaitong];
        [cgkaitong setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [UtilityUI setBorderOnView:cgkaitong borderColor:KTHCOLOR borderWidth:1 cornerRadius:4];
        
        
        UILabel *labInfo = [Tool LablelProductionFunction:@"重要提示\n1.充值全程不收取任何手续费;\n2.充值最低金额应大于1元；\n3.请选择合适的充值方式:\n方法一：通过E账户充值，需先通过本人银行卡转账（手机银行、网上银行、银行柜台都可）至您的华兴银行E账户中，然后进行充值，最快T+0到账（推荐）\n方法二：通过已绑定的银行卡直接充值，T+1工作日到账；\n4.通过各大银行手机银行、网上银行可直接转账到华兴E账户；\n5.如您在充值过程中遇到任何问题，可直接致电400-8535-666或咨询在线客服。" Frame:CGRectMake(15, 210, ScreenWidth-30, 999)  Alignment:NSTextAlignmentLeft FontFl:14];
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

-(void)PTchongzhi:(NSMutableDictionary *)dic{
    cgView.hidden = YES;
    if (ptView) {
        ptView.hidden = NO;
        return;
    }
    
    ptView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, ScreenHeight)];
    //开通了富有
    if ([dic[@"ptzt"] isEqualToString:@"S"]) {
        
        UIView *bg1 = [self createCell:@"签约充值" withValue:nil withClor:NO withinput:NO];
        bg1.frame = CGRectMake(0, 5, ScreenWidth, 40);
        [ptView addSubview:bg1];
        bg1.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(qianyuechongzhi)];
        [bg1 addGestureRecognizer:tapGesturRecognizer];
        
        
        UIView *bg2 = [self createCell:@"快捷充值" withValue:nil withClor:NO withinput:NO];
        bg2.frame = CGRectMake(0, 40+5, ScreenWidth, 40);
        [ptView addSubview:bg2];
        bg2.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesturRecognizer2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(kuaijiechognzhi)];
        [bg2 addGestureRecognizer:tapGesturRecognizer2];
        
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 45, ScreenWidth, 0.5)];
        [line1 setBackgroundColor:RGB(155, 155, 155)];
        [ptView addSubview:line1];
        
        
        UILabel *labInfo = [Tool LablelProductionFunction:@"温馨提示\n签约充值\n1.无需开通网银，签约成功后，无需输入卡号及验证码；\n2.签约充值单笔金额最低2000元；\n3.签约支持银行包括中国银行，农业银行，工商银行，建设银行，兴业银行，中信银行，光大银行，民生银行，广发银行，平安银行，招商银行，浦发银行，华夏银行，国家邮政局邮政储蓄局；若您绑定的银行卡不在这十四家银行内，请联系商户进行线下签约或修改绑定卡。\n快捷充值\n需开通银行网银，针对无法签约的用户。" Frame:CGRectMake(15, 210-40-45, ScreenWidth-30, 999)  Alignment:NSTextAlignmentLeft FontFl:14];
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
       textFile = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(120, 0, 200, 40) FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumberPad];
        [bg addSubview:textFile];
        textFile.placeholder = @"请输入充值金额";
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




-(void)cgkaitong_but_p{
    selcteView.frame = CGRectMake(ScreenWidth/2,43, ScreenWidth/2, 2);
    [self CGchongzhi:alldic[@"cg"]];
    [cgkaitong_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [ptkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
}


-(void)ptkaitong_but_p{
    selcteView.frame = CGRectMake(0,43, ScreenWidth/2, 2);
    [self PTchongzhi:alldic[@"pt"]];
    [ptkaitong_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [cgkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
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

//立即充值
-(void)lijichongzhi{
    
    [textFile resignFirstResponder];
    // 存管充值按钮
    NSString *JIN = textFile.text;
    if ([JIN length] == 0) {
        [Tool myalter:@"请输入充值金额"];
        return;
    }
    double JINdd = [JIN doubleValue];
    if(JINdd>=100 && JINdd < 1000000){
    } else{
        [Tool myalter:@"充值金额必须大于100小于1000000"];
        return;
    }
    NSString *url =[NSString stringWithFormat:@"%@/user/deal/pay.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    [postDic setObject:textFile.text forKey:@"amount"];
    [postDic setObject:@"CGCZ" forKey:@"type"];
    
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
                                       web.title = @"充值";
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



//签约充值
-(void)qianyuechongzhi{
    FYChongzhiViewController *fy = [[FYChongzhiViewController alloc] init];
    fy.title = @"签约充值";
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:fy animated:YES];
}


//快捷充值
-(void)kuaijiechognzhi{
    FYChongzhiViewController *fy = [[FYChongzhiViewController alloc] init];
    fy.title = @"快捷充值";
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:fy animated:YES];
}

@end
