//
//  ChongZhiTableViewController.m
//  quqian
//
//  Created by apple on 15/4/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ChongZhiTableViewController.h"
#import "UserModel.h"
#import "Tool.h"
#import "EGOImageView.h"
#import "LLPaySdk.h"
#import "JSONKit.h"
#import "JSON.h"
#import "HelpDownloader.h"
#import "LLPaySdk.h"


@interface ChongZhiTableViewController ()
{
    UserModel *user;
    NSString *money;
    NSString *code;
    NSString *bankNumber;
    NSString *bankAndNumber;
    NSString *shijizhifujine;
}
@end

@implementation ChongZhiTableViewController
@synthesize sdk,bLLPayState,bTestServer,dic;


- (instancetype)initWithStyle:(UITableViewStyle)style{
    return self = [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    money=@"";
    code=@"";
    shijizhifujine = @"0.00";
    bankAndNumber = @"";
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]];
    
    user = [Tool getUser];
   
    if ([dic objectForKey:@"bankNumber"]==nil || [[dic objectForKey:@"bankNumber"] isEqualToString:@""]) {
        bankAndNumber = @"";
    }else{
        bankNumber = [dic objectForKey:@"bankNumber"];
        bankAndNumber = [NSString stringWithFormat:@"%@%@",[dic objectForKey:@"bankName"],[dic objectForKey:@"bankNumber"]];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 20;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==1) {
        return 35;
    }
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 2;
    }else if (section==2){
        return 1;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;{
    
    
    if (section==2){
        
        
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
        UILabel *lab = [Tool LablelProductionFunction:[NSString stringWithFormat:@"充值费率%@，由第三方平台收取",[dic objectForKey:@"rechargeFactorage"]] Frame:CGRectMake(0, -35, [Tool adaptation:320 with6:55 with6p:94], 45) Alignment:NSTextAlignmentCenter  FontFl:12];
        lab.textColor = [UIColor grayColor];
        [bg addSubview:lab];
        return bg;
        
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    NSArray *viewArray = [cell.contentView subviews];
    for (int i = 0; i < [viewArray count]; i++) {
        UIView *view = [viewArray objectAtIndex:i];
        [view removeFromSuperview];view=nil;
    }
    
    EGOImageView*imgView =[[EGOImageView alloc] init];
    imgView.frame = CGRectMake(15, 12, 21, 21);
    UILabel *lab123 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(16.5, 0, [Tool adaptation:200 with6:55 with6p:94], 45) Alignment:NSTextAlignmentLeft  FontFl:15];
    lab123.font = FOUR_CONTROL_FONT;
    UILabel *lab1234 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(125, 0, [Tool adaptation:200 with6:55 with6p:94], 45) Alignment:NSTextAlignmentLeft  FontFl:14];
    [cell.contentView addSubview:lab123];
    [cell.contentView addSubview:lab1234];
    [cell.contentView addSubview:imgView];
    [lab1234 setTextColor:[UIColor darkGrayColor]];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    UILabel *lab2= [Tool LablelProductionFunction:@"" Frame:CGRectMake(110, 0, [Tool adaptation:200 with6:55 with6p:94], 45) Alignment:NSTextAlignmentRight  FontFl:14];
    [cell.contentView addSubview:lab2];
    
    
    if (section==0) {
        
        
        if (row==0) {
            
            
            //未签约
            if ([[self.dic objectForKey:@"isBound"] isEqualToString:@"0"]) {
                
                lab123.text= @"银行卡号";
                
                UITextField *textField = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(22.5+42,8, [Tool adaptation:275-52 with6:55 with6p:94], 44)  FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
                textField.frame = CGRectMake(125,0, [Tool adaptation:170 with6:55 with6p:94], 45);
                [cell.contentView addSubview:textField];
                textField.placeholder = @"请输入银行卡号";
                textField.tag = 100;
                textField.text = bankNumber;
                
            }else{
                lab1234.text = bankAndNumber;
                lab1234.frame = CGRectMake(80, 0, 320, 45);
                imgView.image = [UIImage imageNamed:@"icon27.png"];
            }
            
        }
        
        
    }else if (section==1) {
        
        if (row==0) {
            
            lab123.text = @"充值金额";
            
            UITextField *textField = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(22.5+42,8, [Tool adaptation:275-52 with6:55 with6p:94], 44)  FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
            [cell.contentView addSubview:textField];
            textField.frame = CGRectMake(125,0, [Tool adaptation:170 with6:55 with6p:94], 45);
            textField.placeholder = [NSString stringWithFormat:@"请输入充值金额，至少%@",[dic objectForKey:@"rechargeMin"]];
            textField.tag = 101;
            textField.text = money;
            lab2.text = @"元";
            
            
        }else if (row==1){
            
            lab123.text = @"充值手续费";
            lab1234.text = @"0.00";
            lab1234.tag = 109;
            lab2.text = @"元";
        }
        
    }else if (section==2) {
        
        if (row==0) {
            
            lab123.text = @"实际支付金额";
            lab1234.text = shijizhifujine;
            lab1234.tag = 200;
            lab1234.textColor = [UIColor colorWithRed:244/255.0 green:151/255.0 blue:0/255.0 alpha:1.0];
            lab2.text = @"元";
        }
        
    }else if (section==3) {
        
        lab123.textColor = [UIColor whiteColor];
        lab123.textAlignment = NSTextAlignmentCenter;
        lab123.frame = CGRectMake(0, 0, 320, 45);
        lab123.text = @"下一步";
        [lab123 setBackgroundColor:[UIColor colorWithRed:2/255.0 green:160/255.0 blue:219/255.0 alpha:1]];

        
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if (section==3) {
        
        //充值
        [self chongzhi__startRequest];
        
    }
    
}



//获取输入框的tag值
-(UIView *)getCellSubObjectwithTag:(int)tag withIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UIView *view = [cell.contentView viewWithTag:tag];
    return view;
}



- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag==100) {
        bankNumber = textField.text;
    }else if (textField.tag==101){
        money = textField.text;
    }
}


//拖动键盘消失
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    UITextField *moet = (UITextField *)[self getCellSubObjectwithTag:101 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    UITextField *card = (UITextField *)[self getCellSubObjectwithTag:100 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [moet resignFirstResponder];
    [card resignFirstResponder];
    
    bankNumber = card.text;
    money = moet.text;
}




- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    if (textField.tag==100) {
        return YES;
    }
    
    

    //取消
    NSString *newString = textField.text;
    if (string.length==0) {
        if (newString.length>0) {
            newString = [newString substringToIndex:[newString length]-1];
        }
    }else{
        newString = [NSString stringWithFormat:@"%@%@",newString,string];
    }
    if ([newString intValue] > [[dic objectForKey:@"rechargeMax"] intValue]) {
        [Tool myalter:[NSString stringWithFormat:@"充值金额最大不超过%@",[dic objectForKey:@"rechargeMax"]]];
        [textField resignFirstResponder];
        return false;
    }

    
    //手续费
    UILabel *la = (UILabel *)[self getCellSubObjectwithTag:109 withIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    la.text = [NSString stringWithFormat:@"%0.2lf",[newString doubleValue] * [[dic objectForKey:@"rechargeFactorage"] doubleValue]];
    if ([la.text doubleValue] > [[dic objectForKey:@"freeFactorageAmount"] doubleValue]) {
        la.text = [dic objectForKey:@"freeFactorageAmount"];
    }
    
    
    //实际支付金额
    double shuji = [newString doubleValue] + [la.text doubleValue];
    shijizhifujine = [NSString stringWithFormat:@"%0.2lf",shuji];
    UILabel *la200 = (UILabel *)[self getCellSubObjectwithTag:200 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    la200.text = shijizhifujine;
    
    return YES;
}





//充值的接口判断
-(void)chongzhi__startRequest{
    
    UITextField *moet = (UITextField *)[self getCellSubObjectwithTag:101 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    [moet resignFirstResponder];
 
    //银行卡号
    if ([[self.dic objectForKey:@"isBound"] isEqualToString:@"0"]) {
        UITextField *card = (UITextField *)[self getCellSubObjectwithTag:100 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [card resignFirstResponder];
        bankNumber = card.text;
        if (card.text.length==0) {
            [Tool myalter:@"请输入银行卡号"];
            return;
        }
        
    }else{
        bankNumber = [dic objectForKey:@"bankNumber"];
    }
    
    
    if (moet.text.length == 0){
        //[Tool myalter:[NSString stringWithFormat:@"充值金额至少%@元",[dic objectForKey:@"rechargeMin"]]];
        [Tool myalter:@"请输入金额"];
        return;
    }
    
    
    
    
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/user/deal/pay.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:moet.text  forKey:@"amount"];
    [postDic setObject:bankNumber forKey:@"bankNumber"];
    [postDic setObject:@"LL" forKey:@"type"];
    
    
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"yes",@"isshowHUD",
                                           @"no",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   
                                   if (kk==0) {
                                       NSMutableDictionary *dic1 = [data JSONValue];
                                       if ([[dic1 objectForKey:@"code"] intValue] == 0) {
                                       
                                           [self payWithSignedOrder:[[dic1 objectForKey:@"rvalue"] objectForKey:@"sdkParameter"]];
                                           
                                       }else{
                                           
                                           [Tool myalter:[dic1 objectForKey:@"msg"]];
                                           
                                       }
                                   }
                               }];
}




//开始支付
- (void)payWithSignedOrder:(NSDictionary*)signedOrder
{
    self.sdk = [[LLPaySdk alloc] init];
    self.sdk.sdkDelegate = self;
    //认证支付、快捷支付、预授权切换，0快捷 1认证 2预授权。假如不需要切换，可以不调用这个方法
    [LLPaySdk setLLsdkPayState:1];
    
    NSString *risk_item = [signedOrder objectForKey:@"risk_item"];
  
    NSMutableDictionary *newdic = [NSMutableDictionary dictionaryWithDictionary:signedOrder];
//    NSData *stringData = [NSJSONSerialization dataWithJSONObject:risk_item
//                                                         options:0
//                                                           error: nil];
//    NSString *str = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    
    NSString *str = [risk_item substringToIndex:[risk_item length]-3];
    [newdic setObject:[NSString stringWithFormat:@"%@}",str] forKey:@"risk_item"];
    
    [self.sdk presentVerifyPaySdkInViewController:self withTraderInfo:newdic];
    
}


#pragma -mark 支付结果 LLPaySdkDelegate
// 订单支付结果返回，主要是异常和成功的不同状态
- (void)paymentEnd:(LLPayResult)resultCode withResultDic:(NSDictionary *)dic
{
    NSString *msg = @"支付异常";
    switch (resultCode) {
        case kLLPayResultSuccess:
        {
            msg = @"支付成功";
            
            NSString* result_pay = dic[@"result_pay"];
            if ([result_pay isEqualToString:@"SUCCESS"])
            {
                //
                NSString *payBackAgreeNo = dic[@"agreementno"];
                
                
                //保存充值的金额
                UITextField *moet = (UITextField *)[self getCellSubObjectwithTag:101 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
                UserModel *userm = [Tool getUser];
                userm.keyong_money = [NSString stringWithFormat:@"%0.2lf",[userm.keyong_money doubleValue]+[moet.text doubleValue]];
                [Tool savecoredata];
                
            
            }
            else if ([result_pay isEqualToString:@"PROCESSING"])
            {
                msg = @"支付单处理中";
            }
            else if ([result_pay isEqualToString:@"FAILURE"])
            {
                msg = @"支付单失败";
            }
            else if ([result_pay isEqualToString:@"REFUND"])
            {
                msg = @"支付单已退款";
            }
        }
            break;
        case kLLPayResultFail:
        {
            msg = @"支付失败";
        }
            break;
        case kLLPayResultCancel:
        {
            msg = @"支付取消";
        }
            break;
        case kLLPayResultInitError:
        {
            msg = @"sdk初始化异常";
        }
            break;
        case kLLPayResultInitParamError:
        {
            msg = dic[@"ret_msg"];
        }
            break;
        default:
            break;
    }
    [[[UIAlertView alloc] initWithTitle:@"结果"
                                message:msg
                               delegate:nil
                      cancelButtonTitle:@"确认"
                      otherButtonTitles:nil] show];
}


@end
