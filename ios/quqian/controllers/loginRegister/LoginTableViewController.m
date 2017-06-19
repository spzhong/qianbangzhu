//
//  LoginTableViewController.m
//  quqian
//
//  Created by apple on 15/3/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LoginTableViewController.h"
#import "RegisterTableViewController.h"
#import "UserModel.h"
#import "MBProgressHUD+Add.h"
#import "EGOImageView.h"
#import "VerificationMobileViewController.h"
#import "NewWangjiCode.h"


@interface LoginTableViewController ()
{
    NSString *name;
    NSString *code;
}
@end

@implementation LoginTableViewController
@synthesize delagete;

- (instancetype)initWithStyle:(UITableViewStyle)style{
    return self = [super initWithStyle:UITableViewStyleGrouped];
}

-(void)back{
    
    //清空数据
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"curLoginUserId"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"cookieValue"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //清空数据
    
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    [self.delagete loginCanel];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dengluquxiaotongzhi" object:nil];
    
}
-(void)zhuce{
    RegisterTableViewController *zhuce = [[RegisterTableViewController alloc] init];
    zhuce.title = @"注册";
    [self.navigationController pushViewController:zhuce animated:YES];
    
}


//设置导航栏
-(void) setNavBarItemDIY{
    self.navigationController.navigationBar.titleTextAttributes = [NSMutableDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:20],UITextAttributeFont, [UIColor blackColor],UITextAttributeTextColor,nil];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    //取消手势返回的操作
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]];
    
    
    //设置状态栏目
    [self setNavBarItemDIY];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *rightBtnItem1 = [[UIBarButtonItem alloc] initWithTitle:@" 取消" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    NSArray *buttonItemArray1 = [NSArray arrayWithObjects:rightBtnItem1, nil];
    self.navigationItem.leftBarButtonItems =buttonItemArray1;
    
    UIBarButtonItem *rightBtnItem2 = [[UIBarButtonItem alloc] initWithTitle:@"注册 " style:UIBarButtonItemStylePlain target:self action:@selector(zhuce)];
    NSArray *buttonItemArray2 = [NSArray arrayWithObjects:rightBtnItem2, nil];
    self.navigationItem.rightBarButtonItems=buttonItemArray2;
  
    name = @"";
    code = @"";
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //表的尾部
    [self makefootView];
}


//生称footview
-(void)makefootView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];

     //登录
    UIButton *but3 = [Tool ButtonProductionFunction:@"登录" Frame:CGRectMake(0, 0, ScreenWidth, 45) bgImgName:@"" FontFl:20];
    [bgView addSubview:but3];
    [but3 setBackgroundColor:[UIColor colorWithRed:2/255.0 green:160/255.0 blue:219/255.0 alpha:1]];
    [but3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but3 addTarget:self action:@selector(denglu) forControlEvents:UIControlEventTouchUpInside];

    self.tableView.tableFooterView = bgView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
        return 2;
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
            
            imgView.image = [UIImage imageNamed:@"icon20.png"];
            //lab123.text = @"账号";
            textField.frame = CGRectMake(55,0, [Tool adaptation:180 with6:55 with6p:94], 45);
            textField.placeholder = @"用户名/手机号/邮箱";
            textField.tag = 100;
            textField.text = name;
            
        }else if (row==1){
            
            imgView.image = [UIImage imageNamed:@"icon16.png"];
            //lab123.text = @"密码";
            textField.frame = CGRectMake(55,0, [Tool adaptation:180 with6:55 with6p:94], 45);
            textField.placeholder = @"登录密码";
            textField.tag = 101;
            textField.text = code;
            textField.secureTextEntry = YES;
            
            UIControl *con = [[UIControl alloc] initWithFrame:CGRectMake(230, 0, 70, 45)];
            //[con setBackgroundColor:[UIColor redColor]];
            [con addTarget:self action:@selector(wangjicode) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:con];
            lab1234.text = @"忘记密码?";
            lab1234.textColor = [UIColor colorWithRed:2/255.0 green:160/255.0 blue:219/255.0 alpha:1];
            
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
        [self denglu];
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



//忘记密码
-(void)wangjicode{
    
    
    NewWangjiCode *wangji = [[NewWangjiCode alloc] init];
    wangji.title = @"找回密码";
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:wangji animated:YES];
    
    
    return;
    
    //验证通过后
//    VerificationMobileViewController *verification = [[VerificationMobileViewController alloc] init];
//    verification.wangjimima = @"忘记密码";
//    verification.title = @"请输入手机号";
//    //返回
//    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
//    backItem.title=@"返回";
//    self.navigationItem.backBarButtonItem=backItem;
//    self.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:verification animated:YES];
}



-(void)Success:(NSString *)doting{
    //登录成功后的回调
    [self.navigationController dismissViewControllerAnimated:NO completion:NULL];
}
-(void)Failure:(NSString *)doting{
    
}






//等录
-(void)denglu{
    UITextField *textField1 = (UITextField *)[self getCellSubObjectwithTag:100 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField *textField2 = (UITextField *)[self getCellSubObjectwithTag:101 withIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [textField1 resignFirstResponder];
    [textField2 resignFirstResponder];
    
    NSLog(@"name:%@",name);
    NSLog(@"coed:%@",code);
    
    
//    [self doSameThing:nil];
//    return;
//    
    
    
    //判断信息
    if (name.length==0) {
        [Tool myalter:@"请输入账号"];
        return;
    }
    if (name.length<6 || name.length>18) {
        [Tool myalter:@"账号长度为6-18个字符"];
        return;
    }
    if (code.length==0) {
        [Tool myalter:@"请输入密码"];
        return;
    }
    if (code.length<6 || code.length>16) {
        [Tool myalter:@"账号长度为6-16个字符"];
        return;
    }
    
  
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/login.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:name forKey:@"userName"];
    [postDic setObject:code forKey:@"password"];
    
    
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"yes",@"isshowHUD",
                                           @"yes",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   
                                  // [self doSameThing:nil];
                                   
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





//网络请求后的操作
-(void)doSameThing:(NSMutableDictionary *)dic{
    
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
   
    
    
    
    //设置手势密码
    if ([newUser.code length]==0) {
        
        DemoViewController *demo = [[DemoViewController alloc] init];
        demo.title = @"输入密码";
        demo.type = 0;
        demo.doting = @"newCode";
        demo.deleagete = self;
        UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
        backItem.title=@"返回";
        self.navigationItem.backBarButtonItem=backItem;
        [self.navigationController pushViewController:demo animated:YES];
        
    }else{
        //离开登录
        [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    }
    
    //通知刷新
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginAfterDoSometing" object:nil];
}



@end
