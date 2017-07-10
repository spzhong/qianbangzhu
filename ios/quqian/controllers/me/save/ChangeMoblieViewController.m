//
//  ChangeMoblieViewController.m
//  quqian
//
//  Created by apple on 15/3/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ChangeMoblieViewController.h"
#import "EGOImageView.h"
#import "UserModel.h"
#import "Tool.h"
#import "MBProgressHUD+Add.h"
#import "HelpDownloader.h"
#import "VerificationMobileViewController.h"
#import "ReCodeTableViewController.h"


@interface ChangeMoblieViewController ()
{
    NSString *code;
    BOOL isHuoqu;
    int count;
    UserModel *user;
}
@end

@implementation ChangeMoblieViewController
@synthesize type,myTimer;

- (instancetype)initWithStyle:(UITableViewStyle)style{
    return self = [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    user = [Tool getUser];
    isHuoqu = YES;
    count = 60;
    
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 100;
    }
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
    imgView.frame = CGRectMake(ScreenWidth/2-57, 14, 37, 37);
    [cell.contentView addSubview:imgView];
    
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    
    UILabel *lab123 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(-10+ScreenWidth/2, 10,ScreenWidth/2, 45) Alignment:NSTextAlignmentLeft  FontFl:15];
    lab123.font = FOUR_CONTROL_FONT;
    [cell.contentView addSubview:lab123];
    
    
    UILabel *lab1234 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(15, 80,ScreenWidth-30, 45) Alignment:NSTextAlignmentCenter  FontFl:12];
    [lab1234 setTextColor:RGB(150, 150, 150)];
    [cell.contentView addSubview:lab1234];
    
    if (section==0) {
        
        imgView.image = [UIImage imageNamed:@"修改手机号图标.png"];
        
        if (type==1) {
            
            lab123.text = [NSString stringWithFormat:@"%@", [user new_mobile]];
            
        }else{
            lab123.text = [NSString stringWithFormat:@"%@", [user new_mobile]];
        }
        
        lab1234.text = @"如您更换了手机号，请及时修改，以保证账户安全";
        
    }else if(section==1){
    
        UITextField *textField = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(15, 2.5, ScreenWidth-30, 40)  FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
        [cell.contentView addSubview:textField];
        textField.placeholder = @"请输入验证码";
        [textField setBackgroundColor:[UIColor whiteColor]];
        textField.tag = 100;
        textField.text = code;
     
        UIButton *buton = [UIButton buttonWithType:UIButtonTypeCustom];
        buton.tag = 10005;
        buton.frame = CGRectMake(ScreenWidth-116, 8.5, 91, 28);
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

        
    }else if (section==2){
        lab123.text = @"下一步";
        lab123.textColor = [UIColor whiteColor];
        [lab123 setBackgroundColor:[UIColor colorWithRed:2/255.0 green:160/255.0 blue:219/255.0 alpha:1]];
        lab123.textAlignment = NSTextAlignmentCenter;
        lab123.frame = CGRectMake(15, 0, ScreenWidth-30, 45);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if (section==2) {
        [self yanzhengPhoneCode_startRequest];
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
    UIButton *huoqu = (UIButton *)[self getCellSubObjectwithTag:10005 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    [huoqu setTitle:@"重新获取(59)秒" forState:UIControlStateNormal];
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dynamicAnimatorShowlab) userInfo:nil repeats:YES];
    huoqu.enabled = NO;
    
    
}

//开始降低数据－60
-(void)dynamicAnimatorShowlab{
    
    UIButton *huoqu = (UIButton *)[self getCellSubObjectwithTag:10005 withIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
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
        code = textField.text;
    }
}




//获取手机验证码
-(void)getPhoneCode_startRequest:(UIButton *)button{
    
    
    UITextField *textField = (UITextField *)[self getCellSubObjectwithTag:100 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    //if ([Tool isMobilePhone:textField.text]) {
        NSString *url =[NSString stringWithFormat:@"%@/sendMsg.htm",BASE_URL];
        NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    //找回提现密码
    if (type==1) {
        [postDic setObject:@"4" forKey:@"type"];
        [postDic setObject:user.mobile forKey:@"phone"];
    }else{
        [postDic setObject:@"2" forKey:@"type"];
        [postDic setObject:user.mobile forKey:@"phone"];
    }
    
    
   
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
                                               
                                               [MBProgressHUD showSuccess:@"验证码已发送" toView:nil];
                                               
                                           }else{
                                               
                                               [MBProgressHUD showError:@"获取验证码错误" toView:nil];
                                           }
                                       }else{
                                           
                                       }
                                   }];
    //}
}


//下一步
-(void)next_startRequest:(NSString *)key{
    
    
    
    //重置提现密码
    if (type==1) {
        
        ReCodeTableViewController *queren = [[ReCodeTableViewController alloc] init];
        queren.type = 1;
        queren.typePop = 1;
        queren.key = key;
        queren.title = @"重置提现密码";
        UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
        backItem.title=@"返回";
        self.navigationItem.backBarButtonItem=backItem;
        [self.navigationController pushViewController:queren animated:YES];
        
    }else{
        //验证通过后
        VerificationMobileViewController *verification = [[VerificationMobileViewController alloc] init];
        verification.title = @"验证手机";
        verification.xiugaiOldMobile = @"xiugailaode";
        verification.key = key;
        //返回
        UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
        backItem.title=@"返回";
        self.navigationItem.backBarButtonItem=backItem;
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:verification animated:YES];
    }
    
    
}




//验证手机验证码
-(void)yanzhengPhoneCode_startRequest{
    
    UITextField *textField = (UITextField *)[self getCellSubObjectwithTag:100 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    [textField resignFirstResponder];
    
    
    if (textField.text.length==0) {
        [Tool myalter:@"请输入短息验证码"];
        return;
    }
 
        NSString *url =[NSString stringWithFormat:@"%@/verifyMsg.htm",BASE_URL];
        NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
        //提现密码
        if (type==1) {
            [postDic setObject:@"4" forKey:@"type"];
        }else{
            [postDic setObject:@"2" forKey:@"type"];
        }
        [postDic setObject:user.mobile forKey:@"phone"];
        [postDic setObject:textField.text forKey:@"code"];
        
        
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
                                               
                                               [self next_startRequest:[dic objectForKey:@"rvalue"]];
                                               
                                           }else{
                                               
                                               [MBProgressHUD showError:[rootDic objectForKey:@"msg"] toView:nil];
                                           }
                                       }else{
                                           
                                       }
                                   }];
 
}





@end
