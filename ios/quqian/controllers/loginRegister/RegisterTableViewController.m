//
//  RegisterTableViewController.m
//  quqian
//
//  Created by apple on 15/3/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "RegisterTableViewController.h"
#import "MBProgressHUD+Add.h"
#import "UserModel.h"
#import "DemoViewController.h"
#import "EGOImageView.h"
#import "WebController.h"
#import "Zhucehoukaitongcunguanyinhang.h"

@interface RegisterTableViewController ()<DemoViewControllerDeleagete>
{
    NSString *lastMobile;
    
    NSString *moblie;
    NSString *code;
    NSString *reCode;
    NSString *messageCode;
    NSString *serviceCode;
    
    NSString *isSelect;
}
@end

@implementation RegisterTableViewController
@synthesize myTimer;
@synthesize from;

- (instancetype)initWithStyle:(UITableViewStyle)style{
    return self = [super initWithStyle:UITableViewStyleGrouped];
}


-(void)back{
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}



//设置导航栏
-(void) setNavBarItemDIY{
    self.navigationController.navigationBar.titleTextAttributes = [NSMutableDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:20],UITextAttributeFont, [UIColor blackColor],UITextAttributeTextColor,nil];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置状态栏目
   // [self setNavBarItemDIY];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    self.title = @"快速注册";
    
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"登录背景.jpg"]]];
    
    
    
    if ([from isEqualToString:@"FirstViewController"]) {
        
        UIBarButtonItem *rightBtnItem1 = [[UIBarButtonItem alloc] initWithTitle:@" 取消" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        NSArray *buttonItemArray1 = [NSArray arrayWithObjects:rightBtnItem1, nil];
        self.navigationItem.leftBarButtonItems =buttonItemArray1;
    }
     
    
    [self.tableView setSeparatorColor:[UIColor clearColor]];
 
    
    count = 60;
    isHuoqu = YES;
    
    lastMobile = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastMobile"];
    if (lastMobile==nil) {
        lastMobile = @"";
    }

    
    
    //初始化
    moblie = @"";
    code = @"";
    reCode = @"";
    messageCode = @"";
    serviceCode = @"";
    isSelect = @"yes";
    
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //表的尾部
    [self makefootView];
    
    UILabel *lab = [Tool LablelProductionFunction:@"您的资金由广东华兴银行直接存管" Frame:CGRectMake(0, 0, ScreenWidth, 50) Alignment:NSTextAlignmentCenter FontFl:12];
    [lab sizeToFit];
    lab.textColor = [UIColor whiteColor];
    lab.frame = CGRectMake((ScreenWidth-lab.frame.size.width)/2, ScreenHeight-64-30, lab.frame.size.width, lab.frame.size.height);
    
    
    UIImageView *logoicn2 = [Tool ImgProductionFunctionFrame:CGRectMake(-20, 0, 16, 16) bgImgName:@"广东华兴银行LOGO2"];
    [lab addSubview:logoicn2];
    
    
    [self.view addSubview:lab];
    lab.textColor = [UIColor whiteColor];

    
}


//生称footview
-(void)makefootView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 90)];
    
    //是否选中同意
    UIButton *but1 = [Tool ButtonProductionFunction:@"" Frame:CGRectMake(20, 13, 13, 13) bgImgName:@"icon19-2.png" FontFl:15];
    [bgView addSubview:but1];
    [but1 addTarget:self action:@selector(isSelect:) forControlEvents:UIControlEventTouchUpInside];
    
    //我同意
    UILabel *lab = [Tool LablelProductionFunction:@"我同意" Frame:CGRectMake(43, 10, 80, 20)  Alignment:NSTextAlignmentLeft FontFl:13];
    [bgView addSubview:lab];
    
    //注册协议
    UIButton *but2 = [Tool ButtonProductionFunction:@"《钱帮主注册协议》" Frame:CGRectMake(83, 10, 150, 20) bgImgName:@"" FontFl:15];
    [bgView addSubview:but2];
    [but2 setTitleColor:[UIColor colorWithRed:2/255.0 green:160/255.0 blue:219/255.0 alpha:1] forState:UIControlStateNormal];
    [but2 addTarget:self action:@selector(quqianxieyi:) forControlEvents:UIControlEventTouchUpInside];
    [but2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //注册
    UIButton *but3 = [Tool ButtonProductionFunction:@"注册" Frame:CGRectMake(20, 45, ScreenWidth-40, 45) bgImgName:@"" FontFl:20];
    [bgView addSubview:but3];
    [but3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but3 addTarget:self action:@selector(zhuce) forControlEvents:UIControlEventTouchUpInside];
    [but3 setBackgroundColor:[UIColor colorWithRed:249/255.0 green:85/255.0 blue:86/255.0 alpha:1]];
    [but3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    
    self.tableView.tableFooterView = bgView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 4;
    }else if (section==1){
        return 2;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        [cell setBackgroundColor:[UIColor clearColor]];
        
    }
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    NSArray *viewArray = [cell.contentView subviews];
    for (int i = 0; i < [viewArray count]; i++) {
        UIView *view = [viewArray objectAtIndex:i];
        [view removeFromSuperview];view=nil;
    }
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (section==0) {
        
        UITextField *textField = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(20,8, ScreenWidth-40, 44)  FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
        [cell.contentView addSubview:textField];
        [textField setBackgroundColor:[UIColor colorWithRed:151/255.0 green:235/255.0 blue:236/255.0 alpha:1.0]];
        textField.textColor = [UIColor whiteColor];
        textField.textAlignment = NSTextAlignmentCenter;
        
        EGOImageView*imgView =[[EGOImageView alloc] init];
        imgView.frame = CGRectMake(18, 8, 106/2, 45);
        [cell.contentView addSubview:imgView];
    
        
        if (row==0) {
            //lab123.text = @"手机号";
            
            imgView.image = [UIImage imageNamed:@"手机号.png"];
            
            //textField.frame = CGRectMake(55,0, [Tool adaptation:190 with6:55 with6p:94], 45);
            textField.placeholder = @"手机号";
            textField.tag = 100;
            textField.text = moblie;
            
        }else if (row==1){
            imgView.image = [UIImage imageNamed:@"密码.png"];
            
            //lab123.text = @"登录密码";
            //textField.frame = CGRectMake(55,0, [Tool adaptation:190 with6:55 with6p:94], 45);
            textField.placeholder = @"输入登录密码";
            textField.tag = 101;
            textField.text = code;
            textField.secureTextEntry = YES;
        } else if (row==2){
            //lab123.text = @"短信验证码";
            
            imgView.image = [UIImage imageNamed:@"手机验证码.png"];
            
            UIButton *buton = [UIButton buttonWithType:UIButtonTypeCustom];
            buton.tag = 10005;
            buton.frame = CGRectMake(ScreenWidth-111, 10, 91, 44);
            buton.titleLabel.font = [UIFont systemFontOfSize:12];
            [buton setTitle:@"获取验证码" forState:UIControlStateNormal];
            [cell.contentView addSubview:buton];
            [buton addTarget:self action:@selector(getPhoneCode_startRequest:) forControlEvents:UIControlEventTouchUpInside];
          
            if (isHuoqu) {
                
                [buton setTitleColor:[UIColor colorWithRed:2/255.0 green:160/255.0 blue:219/255.0 alpha:1] forState:UIControlStateNormal];
                buton.enabled = YES;
                [buton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
            }else{
                [buton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                buton.enabled = NO;
                [buton setBackgroundImage:[UIImage imageNamed:@"button6.png"] forState:UIControlStateNormal];
            }
            
            //textField.frame = CGRectMake(55,0, [Tool adaptation:150 with6:55 with6p:94], 45);
            textField.placeholder = @"短信验证码";
            textField.tag = 102;
            textField.text = messageCode;
            
        }else if (row==3){
            imgView.image = [UIImage imageNamed:@"服务码.png"];
            
            //lab123.text = @"服务码";
            //textField.frame = CGRectMake(55,0, [Tool adaptation:190 with6:55 with6p:94], 45);
            textField.placeholder = @"推荐人服务码（选填）";
            textField.tag = 103;
            textField.text = serviceCode;

        }
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
}



//点击查看钱帮主协议
-(void)quqianxieyi:(UIButton *)bu{
    
    WebController *web = [[WebController alloc] init];
    web.urlString = [NSString stringWithFormat:@"%@/m/zcxy.html?f_app=app",BASE_URL_head];
    web.title = @"钱帮主注册协议";
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:web animated:YES];
     
    
}


//是否选中
-(void)isSelect:(UIButton *)but{
    if ([isSelect isEqualToString:@"yes"]) {
        [but setBackgroundImage:[UIImage imageNamed:@"icon19-1.png"] forState: UIControlStateNormal];
        isSelect = @"no";
    }else{
        isSelect = @"yes";
        [but setBackgroundImage:[UIImage imageNamed:@"icon19-2.png"] forState: UIControlStateNormal];
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
    UIButton *huoqu = (UIButton *)[self getCellSubObjectwithTag:10005 withIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    [huoqu setTitle:@"重新获取(59)秒" forState:UIControlStateNormal];
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dynamicAnimatorShowlab) userInfo:nil repeats:YES];
    huoqu.enabled = NO;
    
}

//开始降低数据－60
-(void)dynamicAnimatorShowlab{
    
    UIButton *huoqu = (UIButton *)[self getCellSubObjectwithTag:10005 withIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
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



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField.tag==101) {
        
        long textLen;
        
        NSLog(@"string%@",string);
        if ([string isEqualToString:@""]) {
            textLen = textField.text.length-1;
        }else{
            textLen = [NSString stringWithFormat:@"%@%@",textField.text,string].length;
        }
        
        if (textLen>11) {
            return false;
        }
        if (textLen == 11) {
            
            UIButton *huoqus = (UIButton *)[self getCellSubObjectwithTag:10005 withIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
            huoqus.enabled = YES;
            
        }
        
    }
    
    if (textField.tag == 103) {
        
        long textLen;
        
        NSLog(@"string%@",string);
        if ([string isEqualToString:@""]) {
            textLen = textField.text.length-1;
        }else{
            textLen = [NSString stringWithFormat:@"%@%@",textField.text,string].length;
        }
        
        if (textLen>6) {
            return false;
        }
        if (textLen == 6) {
            //可以点击操作
//            UILabel *labe2 = (UILabel *)[self getCellSubObjectwithTag:10002 withIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
//            labe2.textColor = [UIColor whiteColor];
//            [labe2 setBackgroundColor:[UIColor brownColor]];
        }else{
//            UILabel *labe2 = (UILabel *)[self getCellSubObjectwithTag:10002 withIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
//            [labe2 setBackgroundColor:[UIColor lightGrayColor]];
//            labe2.textColor = [UIColor whiteColor];
        }
    }
    
    return YES;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    UITextField *textField1 = (UITextField *)[self getCellSubObjectwithTag:100 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField *textField2 = (UITextField *)[self getCellSubObjectwithTag:101 withIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UITextField *textField3 = (UITextField *)[self getCellSubObjectwithTag:102 withIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    UITextField *textField4 = (UITextField *)[self getCellSubObjectwithTag:103 withIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    
    [textField1 resignFirstResponder];
    [textField2 resignFirstResponder];
    [textField3 resignFirstResponder];
    [textField4 resignFirstResponder];
}



- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag>100) {
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag==100) {
        moblie = textField.text;
    }else if (textField.tag==101){
        code = textField.text;
    }else if (textField.tag==102){
        messageCode = textField.text;
    }else if (textField.tag==103){
        serviceCode = textField.text;
    }
}




-(void)Success:(NSString *)doting{
    //登录成功后的回调
    [self.navigationController dismissViewControllerAnimated:NO completion:NULL];
}
-(void)Failure:(NSString *)doting{
    
}




//注册
-(void)zhuce{
    UITextField *textField1 = (UITextField *)[self getCellSubObjectwithTag:100 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField *textField2 = (UITextField *)[self getCellSubObjectwithTag:101 withIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UITextField *textField3 = (UITextField *)[self getCellSubObjectwithTag:102 withIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    UITextField *textField4 = (UITextField *)[self getCellSubObjectwithTag:103 withIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    [textField1 resignFirstResponder];
    [textField2 resignFirstResponder];
    [textField3 resignFirstResponder];
    [textField4 resignFirstResponder];
    
    NSLog(@"moblie:%@",moblie);
    NSLog(@"coed:%@",code);
    NSLog(@"reCode:%@",reCode);
    NSLog(@"messageCode:%@",messageCode);
    NSLog(@"serviceCode:%@",serviceCode);
    
    
    if (![isSelect isEqualToString:@"yes"]) {
        [Tool myalter:@"请选择同意钱帮主注册协议"];
        return;
    }

    //手机号码
    if (![Tool isMobilePhone:moblie]) {
        return;
    }
    //密码
    if (code.length<6 || code.length>16) {
        [Tool myalter:@"密码长度为6-16个字符"];
        return;
    }
    if (messageCode.length==0) {
        [Tool myalter:@"请输入验证码"];
        return;
    }
    
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/register.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:moblie forKey:@"phone"];
    [postDic setObject:code forKey:@"password"];
    [postDic setObject:messageCode forKey:@"verifyCode"];
    [postDic setObject:serviceCode forKey:@"code"];
    
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"yes",@"isshowHUD",
                                           @"yes",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   
                                   if (kk==0) {
                                       
                                       NSMutableDictionary *dic = [data JSONValue];
                                       if ([[dic objectForKey:@"code"] intValue] == 0) {
                                           
                                           [[NSUserDefaults standardUserDefaults] synchronize];
                                           [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"cookieValue"] forKey:@"cookieValue"];
                                           [[NSUserDefaults standardUserDefaults] synchronize];
                                           
                                           [self doSameThing:[dic objectForKey:@"rvalue"]];
                                           
                                       }else{
                                           [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:nil];
                                       }
                                       
                                   }else{
                                       
                                   }
                               }];
    
    
    
}






#pragma startRequest
//获取手机验证码
-(void)getPhoneCode_startRequest:(UIButton *)button{
  
    if (!isHuoqu) {
        return;
    }
    UITextField *textField = (UITextField *)[self getCellSubObjectwithTag:100 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField *textField2 = (UITextField *)[self getCellSubObjectwithTag:101 withIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UITextField *textField3 = (UITextField *)[self getCellSubObjectwithTag:102 withIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    UITextField *textField4 = (UITextField *)[self getCellSubObjectwithTag:103 withIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    UITextField *textField5 = (UITextField *)[self getCellSubObjectwithTag:104 withIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    
    [textField resignFirstResponder];
    [textField2 resignFirstResponder];
    [textField3 resignFirstResponder];
    [textField4 resignFirstResponder];
    [textField5 resignFirstResponder];
    
    
    if ([Tool isMobilePhone:textField.text]) {
        NSString *url =[NSString stringWithFormat:@"%@/sendMsg.htm",BASE_URL];
        NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
        [postDic setObject:@"0" forKey:@"type"];
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
                                               
                                               [MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:nil];
                                               
                                           }else{
                                               
                                               [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:nil];
                                           }
                                       }else{
                                           
                                       }
                                   }];
    }
}




//网络请求后的操作
-(void)doSameThing:(NSMutableDictionary *)dic{
    
    NSString *SS = [Tool toString:[dic objectForKey:@"rvalue"]];
    if ([SS isEqualToString:@"<null>"]) {
        return;
    } 
    
    NSString *where = [NSString stringWithFormat:@"userId='%@'",[dic objectForKey:@"yhzh"]];
    UserModel *newUser = [Tool selcetOneData:@"UserModel" withWhere:where];
    
    if (newUser==nil) {
        //创建一个user对象
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserModel"inManagedObjectContext:[Tool getDele].managedObjectContext];
        UserModel *user = [[UserModel alloc]initWithEntity:entity insertIntoManagedObjectContext:[Tool getDele].managedObjectContext];
        //进行赋予值
        [user makeInData:dic];
        user.codeError = @"0";
       
        
    }else{
        //进行更新数据
        [newUser makeInData:dic];
        newUser.codeError = @"0";
    }
    
    [Tool savecoredata];
    
    
    //保存数据
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"yhzh"] forKey:@"curLoginUserId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginAfterDoSometing" object:nil];
    
    Zhucehoukaitongcunguanyinhang *zhanghu = [[Zhucehoukaitongcunguanyinhang alloc] init];
    zhanghu.title = @"开通存管账户";
    [self.navigationController pushViewController:zhanghu animated:YES];
    
    
}

 

@end
