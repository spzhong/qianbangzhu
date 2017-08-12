//
//  FYChongzhiViewController.m
//  qianbangzhu
//
//  Created by 宋培众 on 2017/6/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FYChongzhiViewController.h"
#import "Tool.h"
#import "UserModel.h"
#import "UtilityUI.h"
#import "HelpDownloader.h"
#import "PTWEBViewController.h"
#import "WebController.h"

@interface FYChongzhiViewController ()<UITextViewDelegate>
{
    UserModel *user;
    UITextField *textFile;
}
@end

@implementation FYChongzhiViewController


-(void)enditNSUS{
    [self.view endEditing:YES];
}


#pragma mark - 点击了链接会走这个方法 可以在这里处理操作
-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{

    WebController *web = [[WebController alloc] init];
    web.urlString = [URL absoluteString];
    [self.navigationController pushViewController:web animated:YES];
    NSLog(@"/n/n/n/n/n/n/n/n/n/n   s      /n/n/n/n/n");
    
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:RGB(236, 243, 246)];
    
    UIControl *bgtcou = [[[UIControl alloc] init] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [bgtcou addTarget:self action:@selector(enditNSUS) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bgtcou];
    
    
    user =  (UserModel *)[Tool getUser];
    
    
    UIView *cell1 = [self createCell:@"第三方合作机构" withValue:@"富友"];
    [self.view addSubview:cell1];
    [cell1 setBackgroundColor:[UIColor whiteColor]];
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 45, ScreenWidth, 120)];
    [bg setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bg];
    
    UILabel *labTile = [Tool LablelProductionFunction:@"可用余额" Frame:CGRectMake(30, 0, 120, 40) Alignment:NSTextAlignmentLeft  FontFl:14];
    labTile.textColor = RGB(51, 51, 51);
    [bg addSubview:labTile];
    
    UILabel *labValue = [Tool LablelProductionFunction:[NSString stringWithFormat:@"%@元",user.keyong_money] Frame:CGRectMake(120, 0, ScreenWidth-20, 40) Alignment:NSTextAlignmentLeft  FontFl:14];
    labValue.textColor = KTHCOLOR;
    [bg addSubview:labValue];
    
    
    textFile = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(30,40,ScreenWidth-60, 40) FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumberPad];
    [bg addSubview:textFile];
    textFile.textAlignment = NSTextAlignmentCenter;
    
    
    if ([self.title isEqualToString:@"签约充值"]) {
        textFile.placeholder = @"请输入充值金额 最少2000元";
    }else{
        textFile.placeholder = @"请输入充值金额 最少500元";
    }
    
    [textFile setBackgroundColor:RGB(236, 243, 246)];
    if ([self.title isEqualToString:@"签约充值"]) {
        bg.frame = CGRectMake(0, 45, ScreenWidth, 120);
        UILabel *labTile = [Tool LablelProductionFunction:[NSString stringWithFormat:@"银行卡尾号：%@",self.yhkh] Frame:CGRectMake(30, 40+45, 120, 40) Alignment:NSTextAlignmentLeft  FontFl:14];
        labTile.textColor = RGB(51, 51, 51);
        [bg addSubview:labTile];
        
    }else{
        bg.frame = CGRectMake(0, 45, ScreenWidth, 100);
    }
    
    
    UIButton *cgkaitong = [Tool ButtonProductionFunction:@"立即充值" Frame:CGRectMake(30, 190, ScreenWidth-60, 45) bgImgName:nil FontFl:15];
    [cgkaitong addTarget:self action:@selector(lijichongzhi) forControlEvents:UIControlEventTouchUpInside];
    [cgkaitong setBackgroundColor:KTHCOLOR];
    [self.view addSubview:cgkaitong];
    [cgkaitong setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [UtilityUI setBorderOnView:cgkaitong borderColor:KTHCOLOR borderWidth:1 cornerRadius:4];
    
    if ([self.title isEqualToString:@"签约充值"]) {
        
        UITextView *labInfo = [Tool TextViewProductionFunction:@"温馨提示\n1.签约充值无需输入卡号及验证码。\n2.请注意您的银行卡充值限制，以免造成不便，具体银行卡限额请点击《签约充值限额表》\n3.禁止洗钱、虚假交易等行为，一经发现并确认，将终止该账户的使用。\n4.如果充值金额没有及时到账，请联系客服，400-8535-666" Frame:CGRectMake(15, 250, ScreenWidth-30, 999) FontFl:14];
        labInfo.textColor = RGB(90, 90, 90);
        [self.view addSubview:labInfo];
        labInfo.delegate = self;
       
        
        NSRange ragn = [labInfo.text localizedStandardRangeOfString:@"《签约充值限额表》"];
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:labInfo.text];
        [attr setAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, attr.length)];
        //点击了链接拨打电话
        [attr setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0 green:147/255.0 blue:238/255.0 alpha:1],
                              NSFontAttributeName:[UIFont systemFontOfSize:14],
                              NSLinkAttributeName:self.qyczurl}
                              range:ragn];
        labInfo.editable =NO;
        labInfo.attributedText = attr;
        
    }else{
        cgkaitong.frame = CGRectMake(30, 170, ScreenWidth-60, 45);
        UITextView *labInfo = [Tool TextViewProductionFunction:@"温馨提示\n1.请注意您的银行卡充值限制，以免造成不便，具体银行卡限额请点击《快捷充值限额表》\n2.禁止洗钱、虚假交易等行为，一经发现并确认，将终止该账户的使用。\n3.如果充值金额没有及时到账，请联系客服，400-8535-666" Frame:CGRectMake(15, 230, ScreenWidth-30, 999) FontFl:14];
        [labInfo sizeToFit];
        labInfo.textColor = RGB(90, 90, 90);
        [self.view addSubview:labInfo];
        
        labInfo.delegate = self;
        
        NSRange ragn = [labInfo.text localizedStandardRangeOfString:@"《快捷充值限额表》"];
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:labInfo.text];
        [attr setAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, attr.length)];
        //点击了链接拨打电话
        [attr setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0 green:147/255.0 blue:238/255.0 alpha:1],
                              NSFontAttributeName:[UIFont systemFontOfSize:14],
                              NSLinkAttributeName:self.kjczurl}
                      range:ragn];
        labInfo.editable =NO;
        labInfo.attributedText = attr;

        
    }
    
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
//
-(void)lijichongzhi{
  
    
    
    [textFile resignFirstResponder];
    // 存管充值按钮
    NSString *JIN = textFile.text;
    if ([JIN length] == 0) {
        [Tool myalter:@"请输入充值金额"];
        return;
    }
    double JINdd = [JIN doubleValue];
    
    
    if ([self.title isEqualToString:@"签约充值"]) {
        if(JINdd>=2000 && JINdd < 1000000){
        } else{
            [Tool myalter:@"充值金额必须大于2000"];
            return;
        }
    }else{
        if(JINdd>=500 && JINdd < 1000000){
        } else{
            [Tool myalter:@"充值金额必须大于500"];
            return;
        }
    }
    
    
    NSString *url =[NSString stringWithFormat:@"%@/user/deal/pay.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:textFile.text forKey:@"amount"];
    [postDic setObject:@"PTCZ" forKey:@"type"];
    if ([self.title isEqualToString:@"签约充值"]) {
        [postDic setObject:@"FY-KS" forKey:@"pttype"];
    } else {
        [postDic setObject:@"FY-KJ" forKey:@"pttype"];
    }
    
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"no",@"isshowHUD",
                                           @"no",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   if (kk==0) {
                                       
                                       NSMutableDictionary *dic = [[data JSONValue] objectForKey:@"rvalue"];
                                       
                                       PTWEBViewController *pt = [[PTWEBViewController alloc] init];
                                       pt.title = self.title;
                                       pt.mchnt_cd = dic[@"mchnt_cd"];
                                       pt.mchnt_txn_ssn = dic[@"mchnt_txn_ssn"];
                                       pt.amt = dic[@"amt"];
                                       pt.login_id = dic[@"login_id"];
                                       pt.page_notify_url = dic[@"page_notify_url"];
                                       pt.back_notify_url = dic[@"back_notify_url"];
                                       pt.signatureStr = dic[@"signatureStr"];
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
