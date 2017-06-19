//
//  ForgetCodeTableViewController.m
//  quqian
//
//  Created by apple on 15/3/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ForgetCodeTableViewController.h"
#import "Tool.h"
#import "MBProgressHUD+Add.h"
#import "ReCodeTableViewController.h"
#import "EGOImageView.h"

@interface ForgetCodeTableViewController ()
{
    NSString *name;
    NSString *code;
    int tag;
}
@end

@implementation ForgetCodeTableViewController
- (instancetype)initWithStyle:(UITableViewStyle)style{
    return self = [super initWithStyle:UITableViewStyleGrouped];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]];
    
    
    tag = 0;//输入手机号码
    name = @"";
    code = @"";
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
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }else if (section==1){
        return 1;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
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
    imgView.frame = CGRectMake(15, 10.5, 24, 24);
    [cell.contentView addSubview:imgView];

    
    UILabel *lab123 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(16.5, 0, [Tool adaptation:200 with6:55 with6p:94], 45) Alignment:NSTextAlignmentLeft  FontFl:15];
    lab123.font = FOUR_CONTROL_FONT;
    UILabel *lab1234 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(16.5, 0, [Tool adaptation:280 with6:55 with6p:94], 45) Alignment:NSTextAlignmentRight  FontFl:12];
    [cell.contentView addSubview:lab123];
    [cell.contentView addSubview:lab1234];
    [lab1234 setTextColor:[UIColor darkGrayColor]];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (section==0) {
        
        UITextField *textField = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(22.5+42,8, [Tool adaptation:275-52 with6:55 with6p:94], 44)  FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
        [cell.contentView addSubview:textField];
        
        
        if (row==0) {
            
            //lab123.text = @"手机号";
            textField.frame = CGRectMake(130,0, [Tool adaptation:190 with6:55 with6p:94], 45);
            textField.placeholder = @"请输入手机号";
            textField.tag = 100;
            textField.text = name;
            
        }else if (row==1){
            
            //lab123.text = @"短信验证码";
            
            UIButton *buton = [UIButton buttonWithType:UIButtonTypeSystem];
            [cell.contentView addSubview:buton];
            buton.tag = 10005;
            buton.frame = CGRectMake([Tool adaptation:240 with6:55 with6p:94], 0, 80, 45);
            buton.titleLabel.textColor = [UIColor whiteColor];
            [buton setTitle:@"获取" forState:UIControlStateNormal];
            [cell.contentView addSubview:buton];
            [buton addTarget:self action:@selector(getPhoneCode_startRequest:) forControlEvents:UIControlEventTouchUpInside];
            
            textField.frame = CGRectMake(130,0, [Tool adaptation:190 with6:55 with6p:94], 45);
            textField.placeholder = @"验证码";
            textField.tag = 103;
            textField.text = code;

        }
    }else if (section==1) {
        
        if (row==0) {
            
            lab123.text = @"确认";
            lab123.textColor = [UIColor whiteColor];
            [lab123 setBackgroundColor:[UIColor colorWithRed:221/255.0 green:56/255.0 blue:108/255.0 alpha:1]];
            lab123.textAlignment = NSTextAlignmentCenter;
            lab123.frame = CGRectMake(20, 2.5, [Tool adaptation:280 with6:55 with6p:94], 40);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        }else if (row==1){
            
        }
        
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if (section==1) {
        //进行登录
        [self queren];
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
        name = textField.text;
    }else if (textField.tag==101){
        code = textField.text;
    }
}




//确认
-(void)queren{
    ReCodeTableViewController *queren = [[ReCodeTableViewController alloc] init];
    queren.title = @"设置新的密码";
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    [self.navigationController pushViewController:queren animated:YES];
}






#pragma startRequest
//获取手机验证码
-(void)getPhoneCode_startRequest:(UIButton *)button{
  
    
    UITextField *textField = (UITextField *)[self getCellSubObjectwithTag:101 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    if ([Tool isMobilePhone:textField.text]) {
        NSString *url =[NSString stringWithFormat:@"%@/login.cp",BASE_URL];
        NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
        [postDic setObject:@"sendMobileVerifyCode" forKey:@"type"];
        [postDic setObject:textField.text forKey:@"mobile"];
        
        
        //发送网路请求
        [[HelpDownloader shared] startRequest:url withbody:postDic
                                       isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                               @"yes",@"isConnectedToNetwork",
                                               @"yes",@"isshowHUD",
                                               @"yes",@"islockscreen",
                                               @"post",@"isrequesType",
                                               nil]
                                   completion:^void(id data,int kk){
                                       
                                       NSDictionary *rootDic = [data JSONValue];
                                       NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:rootDic];
                                       
                                       
                                       if (kk==0) {
                                           //之行正确操作
                                           if ([[dic objectForKey:@"code"] intValue] == 0) {
                                               
                                               //获取验证码成功
                                               //[self getPhoneCodeSece];
                                               
                                               [MBProgressHUD showSuccess:@"验证码已发送" toView:nil];
                                               
                                           }else{
                                               
                                               [MBProgressHUD showError:@"获取验证码错误" toView:nil];
                                           }
                                       }else{
                                           
                                       }
                                   }];
    }
}
//进行确认登录的操作
-(void)logInOk_startRequest{
    //    if (isHuoqu) {
    //        return;
    //    }
    //手机有效判断
    UITextField *textField = (UITextField *)[self getCellSubObjectwithTag:101 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //if (![Tool isMobilePhone:textField.text]) {
    //    return;
    //}
    UITextField *textField2 = (UITextField *)[self getCellSubObjectwithTag:102 withIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if (textField2.text.length != 6) {
        [Tool myalter:@"请输入验证码"];
        return;
    }
    
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/login.cp",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:@"loginWithMobileVerifyCode" forKey:@"type"];
    //[postDic setObject:[[[UIDevice  currentDevice] identifierForVendor] UUIDString] forKey:@"deviceId"];
    [postDic setObject:textField2.text forKey:@"mobileVerifyCode"];
    [postDic setObject:textField.text forKey:@"mobile"];
    
    
    
    //发送网路请求
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"yes",@"isshowHUD",
                                           @"yes",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   
                                   
                                   NSDictionary *dic = [data JSONValue];
                                   
                                   if (kk==0) {
                                       //之行正确操作
                                       if ([[dic objectForKey:@"code"] intValue] == 0) {
                                           
                                           
                                       }else{
                                           
                                           [MBProgressHUD showError:[dic objectForKey:@"message"] toView:nil];
                                       }
                                   }else{
                                   }
                               }];
    
}



@end
