//
//  ReCodeTableViewController.m
//  quqian
//
//  Created by apple on 15/3/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ReCodeTableViewController.h"
#import "UserModel.h"
#import "EGOImageView.h"
#import "MBProgressHUD+Add.h"
#import "Zhucehoukaitongcunguanyinhang.h"

@interface ReCodeTableViewController ()
{
    NSString *code;
    NSString *reCode;
}
@end

@implementation ReCodeTableViewController
@synthesize type;
@synthesize typePop;
@synthesize key;
@synthesize phone;

- (instancetype)initWithStyle:(UITableViewStyle)style{
    return self = [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    code = @"";
    reCode = @"";
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
        textField.secureTextEntry = YES;
        
        if (row==0) {
            
            imgView.image = [UIImage imageNamed:@"icon16.png"];
            
            //lab123.text = @"新的密码";
            textField.frame = CGRectMake(60,0, [Tool adaptation:190 with6:55 with6p:94], 45);
            if (type==1 || type==2) {
                textField.placeholder = @"请输入提现密码";
                lab123.text = @"";
            }else{
                textField.placeholder = @"请输入新的密码";
            }
            
            textField.tag = 100;
            textField.text = code;
            
        }else if (row==1){
            
            imgView.image = [UIImage imageNamed:@"icon16.png"];
            
            //lab123.text = @"确认密码";
            textField.frame = CGRectMake(60,0, [Tool adaptation:190 with6:55 with6p:94], 45);
            if (type==1 || type==2) {
                textField.placeholder = @"确认提现密码";
                lab123.text = @"";
            }else{
                textField.placeholder = @"确认新的密码";
            }
            
            textField.tag = 101;
            textField.text = reCode;
            
        }
    }else if (section==1) {
        
        if (row==0) {
            
            lab123.text = @"确认";
            lab123.textColor = [UIColor whiteColor];
            [lab123 setBackgroundColor:[UIColor colorWithRed:2/255.0 green:160/255.0 blue:219/255.0 alpha:1]];
            lab123.textAlignment = NSTextAlignmentCenter;
            lab123.frame = CGRectMake(0, 0, [Tool adaptation:320 with6:55 with6p:94], 45);
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
        code = textField.text;
    }else if (textField.tag==101){
        reCode = textField.text;
    }
}




//确认修改密码
-(void)queren{
    UITextField *textField1 = (UITextField *)[self getCellSubObjectwithTag:100 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField *textField2 = (UITextField *)[self getCellSubObjectwithTag:101 withIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [textField1 resignFirstResponder];
    [textField2 resignFirstResponder];
 
    
    if (type==1 || type==2) {
        
        
        if (textField1.text.length==0) {
            [Tool myalter:@"请输入提现密码"];
            return;
        }
        if (![textField1.text isEqualToString:textField2.text]) {
            [Tool myalter:@"两次输入的提现密码不一致"];
            return;
        }
        
        if (type==1) {
            //重置密码
            [self xiugaitixian_startRequest];
        }else if (type==2){
            //第一次设置体现密码
            [self settixianmima];
        }
        
      
    }else if (type==0){
    
        if (textField1.text.length==0) {
            [Tool myalter:@"请输登录密码"];
            return;
        }
        if (![textField1.text isEqualToString:textField2.text]) {
            [Tool myalter:@"两次输入的登录密码不一致"];
            return;
        }
        
        //修改登录的密码
        [self xiugaidenglu_startRequest];
        
    }
}






//修改登录的密码
-(void)xiugaidenglu_startRequest{
    
    UITextField *textField = (UITextField *)[self getCellSubObjectwithTag:100 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField *textField1 = (UITextField *)[self getCellSubObjectwithTag:101 withIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [textField resignFirstResponder];
    [textField1 resignFirstResponder];
    
    if ([textField.text length]<5 || [textField.text length]>16) {
        [Tool myalter:@"密码须为6-12位英文字母、数字和符号"];
        return;
    }
    
    
    //请求设置
    NSString *url =[NSString stringWithFormat:@"%@/zhmmSet.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:self.phone  forKey:@"phone"];
    [postDic setObject:textField.text  forKey:@"password"];
    [postDic setObject:textField1.text  forKey:@"cpassword"];
    [postDic setObject:[Tool md5:[NSString stringWithFormat:@"%@%@%@",phone,@"1",key]]  forKey:@"key"];
    
    
    NSLog(@"phone:  %@",[NSString stringWithFormat:@"%@%@%@",phone,@"1",key]);
 
     
    [postDic setObject:@"1"  forKey:@"type"];
    
        
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
                                               
                                               
                                               [MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:nil];
                                               //返回登录的页面
                                               if (type==0) {
                                                   [self.navigationController popToRootViewControllerAnimated:YES];
                                               }
                                               
                                               
                                           }else{
                                               
                                               [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:nil];
                                           }
                                       }else{
                                           
                                       }
                                   }];

}





//设置提现密码
-(void)settixianmima{

    
    UITextField *textField = (UITextField *)[self getCellSubObjectwithTag:100 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField *textField1 = (UITextField *)[self getCellSubObjectwithTag:101 withIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [textField resignFirstResponder];
    [textField1 resignFirstResponder];
    
    
    if ([textField.text length]<5 || [textField.text length]>16) {
        [Tool myalter:@"6-16个字符，区分大小写"];
        return;
    }
    
    
    //请求设置
    NSString *url =[NSString stringWithFormat:@"%@/user/zhaq/sztxmm.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    
    [postDic setObject:textField.text  forKey:@"mm"];
    [postDic setObject:textField1.text  forKey:@"cmm"];
    
  
    
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
                                           
                                           
                                           UserModel *user = [Tool getUser];
                                           user.txmmsfsz = @"true";
                                           [Tool savecoredata];
                                        
                                           [self.navigationController popViewControllerAnimated:YES];
                                           
                                           [MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:nil];
                                         
                                       }else{
                                           
                                           [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:nil];
                                       }
                                   }else{
                                       
                                   }
                               }];

    
    
}




//重置提现密码
-(void)xiugaitixian_startRequest{
    
    UITextField *textField = (UITextField *)[self getCellSubObjectwithTag:100 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField *textField1 = (UITextField *)[self getCellSubObjectwithTag:101 withIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [textField resignFirstResponder];
    [textField1 resignFirstResponder];
    

    if ([textField.text length]<5 || [textField.text length]>16) {
        [Tool myalter:@"6-16个字符，区分大小写"];
        return;
    }
    
    
    
    //请求设置
    NSString *url =[NSString stringWithFormat:@"%@/user/zhaq/sjxgtxmm.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    
    [postDic setObject:textField.text  forKey:@"mm"];
    [postDic setObject:textField1.text  forKey:@"cmm"];
    
    
    UserModel *user = [Tool getUser];
    
    [postDic setObject:user.mobile  forKey:@"sjh"];
    [postDic setObject:[Tool md5:[NSString stringWithFormat:@"%@%@%@",user.mobile,@"4",key]]  forKey:@"key"];
    [postDic setObject:@"4"  forKey:@"type"];
    
    NSLog(@"key %@",[NSString stringWithFormat:@"%@%@%@",user.mobile,@"4",key]);

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
                                          
                                           
                                           UserModel *user = [Tool getUser];
                                           user.txmmsfsz = @"true";
                                           [Tool savecoredata];
                                           
 
                                           
                                           //返回
                                           if (typePop==1) {
                                               NSArray *contr = self.navigationController.viewControllers;
                                               UIViewController *con = [contr objectAtIndex:[contr count]-3];
                                               [self.navigationController popToViewController:con animated:YES];
                                           }else{
                                               [self.navigationController popViewControllerAnimated:YES];
                                           }
                                           
                                           
                                           [MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:nil];
                                           
                                           
                                       }else{
                                           
                                           [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:nil];
                                       }
                                   }else{
                                       
                                   }
                               }];
    
}








@end
