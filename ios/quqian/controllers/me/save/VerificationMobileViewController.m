//
//  VerificationMobileViewController.m
//  quqian
//
//  Created by apple on 15/3/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "VerificationMobileViewController.h"
#import "EGOImageView.h"
#import "UserModel.h"
#import "Tool.h"
#import "MBProgressHUD+Add.h"
#import "HelpDownloader.h"
#import "ReCodeTableViewController.h"


@interface VerificationMobileViewController ()
{
    NSString *moblie;
    NSString *code;
    BOOL isHuoqu;
    int count;

}
@end

@implementation VerificationMobileViewController
@synthesize wangjimima;
@synthesize myTimer;
@synthesize xiugaiOldMobile;
@synthesize key;


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
    
    
    count = 60;
    moblie = @"";
    code = @"";
    isHuoqu = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"";
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
    
    UILabel *lab123 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(0, 0, [Tool adaptation:320 with6:55 with6p:94], 45) Alignment:NSTextAlignmentCenter  FontFl:15];
    lab123.font = FOUR_CONTROL_FONT;
    [cell.contentView addSubview:lab123];
    
    
    if (section==0) {
        
        
        if (row==0) {
         
            
            imgView.image = [UIImage imageNamed:@"icon15.png"];
            
            UITextField *textField = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(22.5+42,8, [Tool adaptation:275-52 with6:55 with6p:94], 44)  FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
            [cell.contentView addSubview:textField];
            textField.frame = CGRectMake(60,0, [Tool adaptation:190 with6:55 with6p:94], 45);
            textField.placeholder = @"请输入新的手机号";
            textField.tag = 100;
            textField.text = moblie;
            
            
        }else if (row==1) {
            
            imgView.image = [UIImage imageNamed:@"icon16.png"];
            
            UITextField *textField = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(60,0, [Tool adaptation:120 with6:55 with6p:94], 45)  FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
            [cell.contentView addSubview:textField];
            textField.placeholder = @"请输入验证码";
            textField.tag = 101;
            textField.text = code;
            
            UIButton *buton = [UIButton buttonWithType:UIButtonTypeCustom];
            buton.tag = 10005;
            buton.frame = CGRectMake(210, 8.5, 91, 28);
            buton.titleLabel.font = [UIFont systemFontOfSize:12];
            [buton setTitle:@"获取验证码" forState:UIControlStateNormal];
            [cell.contentView addSubview:buton];
            [buton addTarget:self action:@selector(getPhoneCode_startRequest:) forControlEvents:UIControlEventTouchUpInside];
            
            if (isHuoqu) {
                
                [buton setTitleColor:[UIColor colorWithRed:2/255.0 green:160/255.0 blue:219/255.0 alpha:1] forState:UIControlStateNormal];
                buton.enabled = YES;
                [buton setBackgroundImage:[UIImage imageNamed:@"button5.png"] forState:UIControlStateNormal];
            }else{
                [buton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                buton.enabled = NO;
                [buton setBackgroundImage:[UIImage imageNamed:@"button6.png"] forState:UIControlStateNormal];
            }
        }
        
    }else if(section==1){
       
        lab123.text = @"完成";
        lab123.textColor = [UIColor whiteColor];
        [lab123 setBackgroundColor:[UIColor colorWithRed:2/255.0 green:160/255.0 blue:219/255.0 alpha:1]];
        lab123.textAlignment = NSTextAlignmentCenter;
        lab123.frame = CGRectMake(0, 0, [Tool adaptation:320 with6:55 with6p:94], 45);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    
    if (section==1) {
        //保存
        [self finsh_startRequest];
    }
    
}



//获取输入框的tag值
-(UIView *)getCellSubObjectwithTag:(int)tag withIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UIView *view = [cell.contentView viewWithTag:tag];
    return view;
}




//获取验证码成功后
-(void)getPhoneCodeSece{
    isHuoqu = NO;
    UIButton *huoqu = (UIButton *)[self getCellSubObjectwithTag:10005 withIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [huoqu setTitle:@"重新获取(59)秒" forState:UIControlStateNormal];
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dynamicAnimatorShowlab) userInfo:nil repeats:YES];
    huoqu.enabled = NO;
    
    
}

//开始降低数据－60
-(void)dynamicAnimatorShowlab{
    
    UIButton *huoqu = (UIButton *)[self getCellSubObjectwithTag:10005 withIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    count--;
    if (count==0) {
        [self.myTimer invalidate];
        self.myTimer= nil;
        count = 60;
        isHuoqu = YES;
        [huoqu setTitle:@"获取验证码" forState:UIControlStateNormal];
        huoqu.enabled = YES;
    }else{
        huoqu.enabled = NO;
        [huoqu setTitle:[NSString stringWithFormat:@"重新获取(%d)秒",count] forState:UIControlStateNormal];
    }
    //[self.tableView reloadData];
}





- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag==100) {
        moblie = textField.text;
    }else if (textField.tag==101){
        code = textField.text;
    }
}




//获取手机验证码
-(void)getPhoneCode_startRequest:(UIButton *)button{
    
    UITextField *textField = (UITextField *)[self getCellSubObjectwithTag:100 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [textField resignFirstResponder];
    
    
    if ([Tool isMobilePhone:textField.text]) {
        NSString *url =[NSString stringWithFormat:@"%@/sendMsg.htm",BASE_URL];
        NSLog(@"url %@",url);
        
        
        NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
        //忘记密码
        if ([wangjimima length]>0) {
            [postDic setObject:@"1" forKey:@"type"];
        }else{
            if ([xiugaiOldMobile length]>0) {
                [postDic setObject:@"3" forKey:@"type"];
            }else{
                [postDic setObject:@"2" forKey:@"type"];
            }
            
        }
        
        [postDic setObject:textField.text forKey:@"phone"];
        
        
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
                                               [self getPhoneCodeSece];
                                               
                                               [MBProgressHUD showSuccess:[rootDic objectForKey:@"msg"] toView:nil];
                                               
                                           }else{
                                               
                                               [MBProgressHUD showError:[rootDic objectForKey:@"msg"] toView:nil];
                                           }
                                       }else{
                                           
                                       }
                                   }];
    }
}


//完成
-(void)finsh_startRequest{
    //修改新手机
    if (xiugaiOldMobile.length>0) {
        
        [self xiugaixindeshoujihaoma];
        
    }else{
        [self yanzhengPhoneCode_startRequest];
    }
}





//验证手机验证码
-(void)yanzhengPhoneCode_startRequest{
    
    UITextField *textField = (UITextField *)[self getCellSubObjectwithTag:100 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [textField resignFirstResponder];
    UITextField *textField1 = (UITextField *)[self getCellSubObjectwithTag:101 withIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [textField1 resignFirstResponder];
    
    if (textField1.text.length==0) {
        [Tool myalter:@"请输入短信验证码"];
        return;
    }
    
    if ([Tool isMobilePhone:textField.text]) {
        NSString *url =[NSString stringWithFormat:@"%@/verifyMsg.htm",BASE_URL];
        NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
        //忘记密码
        if ([wangjimima length]>0) {
            [postDic setObject:@"1" forKey:@"type"];
        }else{
          
            [postDic setObject:@"2" forKey:@"type"];
            
        }

        [postDic setObject:textField1.text forKey:@"code"];
        [postDic setObject:textField.text forKey:@"phone"];
        
        
        
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
                                               
                                               UITextField *textField1 = (UITextField *)[self getCellSubObjectwithTag:100 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                                               UITextField *textField2 = (UITextField *)[self getCellSubObjectwithTag:101 withIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                                               [textField1 resignFirstResponder];
                                               [textField2 resignFirstResponder];
                                               
                                               
                                               if ([wangjimima length]>0) {
                                                   
                                                   ReCodeTableViewController *queren = [[ReCodeTableViewController alloc] init];
                                                   queren.phone = textField1.text;
                                                   queren.key = [dic objectForKey:@"rvalue"];
                                                   queren.title = @"设置新的密码";
                                                   UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
                                                   backItem.title=@"返回";
                                                   self.navigationItem.backBarButtonItem=backItem;
                                                   [self.navigationController pushViewController:queren animated:YES];
                                                   
                                               }else{
                                                   //返回
                                                   NSArray *contr = self.navigationController.viewControllers;
                                                   UIViewController *con = [contr objectAtIndex:[contr count]-3];
                                                   [self.navigationController popToViewController:con animated:YES];
                                               }
                                               
                                             
                                           }else{
                                               
                                               [MBProgressHUD showError:[rootDic objectForKey:@"msg"] toView:nil];
                                           }
                                       }else{
                                           
                                       }
                                   }];
    }
}




//修改手机号
-(void)xiugaixindeshoujihaoma{
    
    UITextField *textField = (UITextField *)[self getCellSubObjectwithTag:100 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [textField resignFirstResponder];
    UITextField *textField1 = (UITextField *)[self getCellSubObjectwithTag:101 withIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [textField1 resignFirstResponder];
    
    if (textField1.text.length==0) {
        [Tool myalter:@"请输入短信验证码"];
        return;
    }
    
    if ([Tool isMobilePhone:textField.text]) {
        NSString *url =[NSString stringWithFormat:@"%@/user/zhaq/xgsjNew.htm",BASE_URL];
        NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
     
        [postDic setObject:textField1.text forKey:@"yzm"];
        [postDic setObject:textField.text forKey:@"sjh"];
        
        
        UserModel *user = [Tool getUser];
        [postDic setObject:user.mobile  forKey:@"lsj"];
        [postDic setObject:@"2"  forKey:@"type"];
        
        [postDic setObject:[Tool md5:[NSString stringWithFormat:@"%@%@%@",user.mobile,@"2",key]]  forKey:@"key"];
        
        
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
                                               
                                               UITextField *textField1 = (UITextField *)[self getCellSubObjectwithTag:100 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                                               UITextField *textField2 = (UITextField *)[self getCellSubObjectwithTag:101 withIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                                               [textField1 resignFirstResponder];
                                               [textField2 resignFirstResponder];
                                               
                                               
                                               if ([wangjimima length]>0) {
                                                   
                                                   ReCodeTableViewController *queren = [[ReCodeTableViewController alloc] init];
                                                   queren.phone = textField1.text;
                                                   queren.key = [dic objectForKey:@"rvalue"];
                                                   queren.title = @"设置新的密码";
                                                   UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
                                                   backItem.title=@"返回";
                                                   self.navigationItem.backBarButtonItem=backItem;
                                                   [self.navigationController pushViewController:queren animated:YES];
                                                   
                                               }else{
                                                   
                                                   
                                                   UserModel *user = [Tool getUser];
                                                   user.mobile = textField.text;
                                                   [Tool savecoredata];
                                 
                                                   //返回
                                                   NSArray *contr = self.navigationController.viewControllers;
                                                   UIViewController *con = [contr objectAtIndex:[contr count]-3];
                                                   [self.navigationController popToViewController:con animated:YES];
                                               }
                                               
                                               
                                           }else{
                                               
                                               [MBProgressHUD showError:[rootDic objectForKey:@"msg"] toView:nil];
                                           }
                                       }else{
                                           
                                       }
                                   }];
    }
    
}

@end
