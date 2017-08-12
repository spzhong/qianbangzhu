//
//  SecondViewController.m
//  quqian
//
//  Created by apple on 15/3/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SecondViewController.h"
#import "EGOImageView.h"
#import "LoginTableViewController.h"

#import "MyInfoViewController.h"
#import "JiaoYiViewController.h"
#import "SaveInfoViewController.h"
#import "ZijinMangerViewController.h"
#import "NoticeViewController.h"
#import "MySanViewController.h"
#import "MyWenZhuanViewController.h"
#import "MyTiYanViewController.h"
#import "RCLabel.h"
#import "TiXianTableViewController.h"
#import "ChongZhiTableViewController.h"

#import "TrueNameViewController.h"
#import "ReCodeTableViewController.h"

#import "MBProgressHUD+Add.h"

#import "UtilityUI.h"

#import "ChongzhiViewController.h"
#import "TixianViewController.h"
#import "YinhangkaViewController.h"
#import "TuiGuangjiliViewController.h"
#import "ZhanghuzonglanViewController.h"
#import "YaoqinghaoyuViewController.h"
#import "WotoubiaoViewController.h"
#import "JiaoyijiluViewController.h"
#import "WodejiaxikaViewController.h"


@interface SecondViewController ()<LoginViewControllerDelegate>
{
    UserModel *user;
    UIButton *but1;
    UIButton *but2;
    UILabel *lab1;
    UILabel *lab2;
    UILabel *name;
}
@end

@implementation SecondViewController


- (instancetype)initWithStyle:(UITableViewStyle)style{
    return self = [super initWithStyle:UITableViewStyleGrouped];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    UIView *lab = [[Tool getDele].window viewWithTag:999910];
    lab.hidden = YES;
}







//登录成功的回调
-(void)loginSuccess{
   
}
//登录失败的回调
-(void)loginCanel{
    [self.tabBarController setSelectedIndex:0];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self.tableView reloadData];
    self.navigationController.navigationBar.hidden = NO;
    
    //用户信息
    user = (UserModel*)[Tool getUser];
    
    //数据为空－－－需要登录啊
    if (user==nil) {
        
        //self.tableView.alpha = 0.0;
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        LoginTableViewController *loginView = [[LoginTableViewController alloc] init];
        loginView.delagete = self;
        loginView.title = @"登录";
        UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:loginView];
        [self presentViewController:na animated:NO completion:NULL];
        return;
        
    }
    //self.tableView.alpha = 1.0;
    [self.tableView reloadData];
    [self tableviewHeadView];

    [self setbheadvue];
}



//通知
-(void)tongzhi{
    NoticeViewController *notice = [[NoticeViewController alloc] init];
    notice.title = @"通知";
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:notice animated:YES];
    self.hidesBottomBarWhenPushed=NO;

}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    user = (UserModel*)[Tool getUser];
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]];
    
    [self setbheadvue];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadzhanghaoyuexinxi) name:@"reloadzhanghaoyuexinxi" object:nil];
    
}


-(void)setbheadvue{
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    [bg setBackgroundColor:[UIColor clearColor]];
    UIImageView *head = [Tool ImgProductionFunctionFrame:CGRectMake(15, 7, 30, 30) bgImgName:@"用户头像.png"];
    [bg addSubview:head];
    
    
    if (user.userId.length==0) {
        name = [Tool LablelProductionFunction:[NSString stringWithFormat:@"您好,%@", user.mobile] Frame:CGRectMake(60, 0, 200, 44) Alignment:NSTextAlignmentLeft FontFl:15];
    }else{
        name = [Tool LablelProductionFunction:[NSString stringWithFormat:@"您好,%@",user.userId] Frame:CGRectMake(60, 0, 200, 44) Alignment:NSTextAlignmentLeft FontFl:15];
    }
    
    [bg addSubview:name];
    name.textColor = [UIColor whiteColor];
    
    UIButton *setbut =  [Tool ButtonProductionFunction:nil Frame:CGRectMake(ScreenWidth-50, (44-18)/2, 25, 25) bgImgName:@"设置" FontFl:0];
    [setbut addTarget:self action:@selector(setView) forControlEvents:UIControlEventTouchUpInside];
    [bg addSubview:setbut];
    
    
    
    if ([user.znxwdts intValue] > 0) {
        UIButton *xiaoxibut =  [Tool ButtonProductionFunction:nil Frame:CGRectMake(ScreenWidth-56-35, (44-16)/2, 21*1.2, 16*1.2) bgImgName:@"消息-未读" FontFl:0];
        [xiaoxibut addTarget:self action:@selector(xiaoxibut) forControlEvents:UIControlEventTouchUpInside];
        [bg addSubview:xiaoxibut];
    }else{
        UIButton *xiaoxibut =  [Tool ButtonProductionFunction:nil Frame:CGRectMake(ScreenWidth-56-35, (44-16)/2, 21*1.2, 16*1.2) bgImgName:@"消息-已读" FontFl:0];
        [xiaoxibut addTarget:self action:@selector(xiaoxibut) forControlEvents:UIControlEventTouchUpInside];
        [bg addSubview:xiaoxibut];
    }
    
    
    self.navigationItem.titleView = bg;
    [self tableviewHeadView];

}


//重新获取一下账户的余额
-(void)reloadzhanghaoyuexinxi{
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/getUser.htm",BASE_URL];
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
                                       
                                       NSMutableDictionary *dic = [data JSONValue];
                                       [self doSameThing:[dic objectForKey:@"rvalue"]];
                                       [self tableviewHeadView];
  
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
        UserModel *user1 = [[UserModel alloc]initWithEntity:entity insertIntoManagedObjectContext:[Tool getDele].managedObjectContext];
        //进行赋予值
        [user1 makeInData:dic];
        
    }else{
        //进行更新数据
        [newUser makeInData:dic];
    }
    [Tool savecoredata];
 
}



-(void)tableviewHeadView{
    
    if (user.userId.length==0) {
        name.text = [NSString stringWithFormat:@"您好,%@", user.mobile];
    }else{
        name.text = [NSString stringWithFormat:@"您好,%@", user.userId];
    }

    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 190+68*2+10)];
    [bg setBackgroundColor:KTHCOLOR];
    
    but1 =  [Tool ButtonProductionFunction:@"存管账户" Frame:CGRectMake(3*ScreenWidth/5, 30, ScreenWidth/5, 30) bgImgName:nil FontFl:15];
    [but1 addTarget:self action:@selector(but1P) forControlEvents:UIControlEventTouchUpInside];
    [bg addSubview:but1];
    [but1 setBackgroundColor:[UIColor clearColor]];
    [but1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [UtilityUI setBorderOnView:but1 borderColor:[UIColor whiteColor] borderWidth:1 cornerRadius:15];
 
    
    but2 =  [Tool ButtonProductionFunction:@"普通账户" Frame:CGRectMake(ScreenWidth/5, 30, ScreenWidth/5, 30) bgImgName:nil FontFl:15];
    [but2 addTarget:self action:@selector(but2P) forControlEvents:UIControlEventTouchUpInside];
    [bg addSubview:but2];
    [but2 setBackgroundColor:[UIColor whiteColor]];
    [but2 setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [UtilityUI setBorderOnView:but2 borderColor:KTHCOLOR borderWidth:1 cornerRadius:15];
    
    
    lab1  = [Tool LablelProductionFunction:[NSString stringWithFormat:@"%@\n\n可用余额(元)",user.keyong_money] Frame:CGRectMake(0, 70,ScreenWidth/2, 90) Alignment:NSTextAlignmentCenter  FontFl:15];
    [bg addSubview:lab1];
    [lab1 setBackgroundColor:[UIColor clearColor]];
    lab1.textColor = [UIColor whiteColor];
    
    lab2  = [Tool LablelProductionFunction:[NSString stringWithFormat:@"%@\n\n已赚总额(元)",user.zhuanqu_money] Frame:CGRectMake(ScreenWidth/2, 70,ScreenWidth/2, 90) Alignment:NSTextAlignmentCenter  FontFl:15];
    [bg addSubview:lab2];
    [lab2 setBackgroundColor:[UIColor clearColor]];
    lab2.textColor = [UIColor whiteColor];
    
    
    
    UIButton *but11 =  [Tool ButtonProductionFunction:@"充值" Frame:CGRectMake(0, 160, ScreenWidth/2, 40) bgImgName:nil FontFl:15];
    [but11 addTarget:self action:@selector(chongzhi) forControlEvents:UIControlEventTouchUpInside];
    [bg addSubview:but11];
    [but11 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but11 setBackgroundColor:RGB(31, 106, 172)];
    
    UIButton *but22 =  [Tool ButtonProductionFunction:@"提现" Frame:CGRectMake(ScreenWidth/2, 160, ScreenWidth/2, 40) bgImgName:nil FontFl:15];
    [but22 addTarget:self action:@selector(tikuan) forControlEvents:UIControlEventTouchUpInside];
    [bg addSubview:but22];
    [but22 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but22 setBackgroundColor:RGB(31, 106, 172)];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/2, 165, 0.5, 30)];
    [line setBackgroundColor:[UIColor whiteColor]];
    [bg addSubview:line];
    
    //200的高度
    [self makecre:0 withName:@"账户总览" withPic:@"账户总额" withSup:bg];
    [self makecre:1 withName:@"交易记录" withPic:@"交易记录" withSup:bg];
    
    [self makecre:2 withName:@"我的投标" withPic:@"我的投标" withSup:bg];
    [self makecre:3 withName:@"邀请好友" withPic:@"邀请好友" withSup:bg];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 200+68, ScreenWidth, 0.5)];
    [line2 setBackgroundColor:RGB(155, 155, 155)];
    [bg addSubview:line2];
    
    self.tableView.tableHeaderView = bg;
}


-(void)makecre:(int)index withName:(NSString *)name withPic:(NSString *)pic withSup:(UIView *)bg{

    UIButton *but =  [Tool ButtonProductionFunction:@"" Frame:CGRectMake(ScreenWidth/2, 160, ScreenWidth/2, 68) bgImgName:nil FontFl:15];
    [but setBackgroundColor:[UIColor whiteColor]];
    [bg addSubview:but];
    
    UILabel *labbbb  = [Tool LablelProductionFunction:name Frame:CGRectMake(-10 +ScreenWidth/4,0,ScreenWidth/4, 68) Alignment:NSTextAlignmentLeft  FontFl:15];
    [but addSubview:labbbb];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/4-33-20, (68-33)/2, 33, 33)];
    img.image = [UIImage imageNamed:pic];
    [but addSubview:img];
    
    if (index==0) {
        but.frame = CGRectMake(0, 200, ScreenWidth/2, 68);
        [but addTarget:self action:@selector(zhanghuzonglan) forControlEvents:UIControlEventTouchUpInside];
    }else if (index==1) {
        but.frame = CGRectMake(ScreenWidth/2, 200, ScreenWidth/2, 68);
        [but addTarget:self action:@selector(jiaoyijilu) forControlEvents:UIControlEventTouchUpInside];
    }else if (index==2) {
        but.frame = CGRectMake(0, 200+68, ScreenWidth/2, 68);
        [but addTarget:self action:@selector(wodetoubiao) forControlEvents:UIControlEventTouchUpInside];
    }else if (index==3) {
        but.frame = CGRectMake(ScreenWidth/2, 200+68, ScreenWidth/2, 68);
        [but addTarget:self action:@selector(yaoqinghaoyou) forControlEvents:UIControlEventTouchUpInside];
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
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
    
    NSArray *viewArray = [cell.contentView subviews];
    for (int i = 0; i < [viewArray count]; i++) {
        UIView *view = [viewArray objectAtIndex:i];
        [view removeFromSuperview];view=nil;
    }
    
    EGOImageView*imgView =[[EGOImageView alloc] init];
    imgView.frame = CGRectMake(15, 12, 20, 20);
    UILabel *lab123 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(50, 0, 160, 44) Alignment:NSTextAlignmentLeft  FontFl:15];
        [cell.contentView addSubview:lab123];
    [cell.contentView addSubview:imgView];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell setBackgroundView:nil];
    
    
    if (indexPath.row==0) {
        lab123.text = @"推广记录";
        imgView.image = [UIImage imageNamed:@"推广记录"];
    }else if (indexPath.row==1){
        lab123.text = @"我的加息卡";
        imgView.image = [UIImage imageNamed:@"我的加息卡"];
    }else if (indexPath.row==2){
        lab123.text = @"银行卡管理";
        imgView.image = [UIImage imageNamed:@"银行卡管理"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //推广记录
    if (indexPath.row==0) {
        TuiGuangjiliViewController *tuiguang = [[TuiGuangjiliViewController alloc] init];
        tuiguang.title = @"推广记录";
        //返回
        UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
        backItem.title=@"返回";
        self.navigationItem.backBarButtonItem=backItem;
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:tuiguang animated:YES];
        self.hidesBottomBarWhenPushed=NO;
        
    }else if (indexPath.row==1){//我的加息卡
        WodejiaxikaViewController *wode = [[WodejiaxikaViewController alloc] init];
        wode.title = @"我的加息卡";
        //返回
        UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
        backItem.title=@"返回";
        self.navigationItem.backBarButtonItem=backItem;
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:wode animated:YES];
        self.hidesBottomBarWhenPushed=NO;

    }else if (indexPath.row==2){//银行卡管理
        YinhangkaViewController *bangding = [[YinhangkaViewController alloc] init];
        bangding.title = @"银行卡管理";
        //返回
        UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
        backItem.title=@"返回";
        self.navigationItem.backBarButtonItem=backItem;
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:bangding animated:YES];
        self.hidesBottomBarWhenPushed=NO;
        
    }
}


//退出操作
- (void)didClickOnButtonIndex:(NSInteger *)buttonIndex{
    if (buttonIndex==0) {
        [self tuichu];
    }
}





- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        if (alertView.tag==900) {
            TrueNameViewController *trueName = [[TrueNameViewController alloc] init];
            trueName.title = @"实名认证";
            //返回
            UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
            backItem.title=@"返回";
            self.navigationItem.backBarButtonItem=backItem;
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:trueName animated:YES];
            self.hidesBottomBarWhenPushed=NO;
        }else if (alertView.tag==901){
            ReCodeTableViewController *queren = [[ReCodeTableViewController alloc] init];
            queren.type = 2;
            queren.title = @"设置提现密码";
            UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
            backItem.title=@"返回";
            self.navigationItem.backBarButtonItem=backItem;
            [self.navigationController pushViewController:queren animated:YES];
            self.hidesBottomBarWhenPushed=NO;
        }
    }
}



 





//体现的接口判断
-(void)tikuan__startRequest{
    
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/user/deal/getwithdraw.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"yes",@"isshowHUD",
                                           @"no",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   
                                   if (kk==0) {
                                       NSMutableDictionary *dic = [data JSONValue];
                                       if ([[dic objectForKey:@"code"] intValue]  == 0) {
                                           
                                           TiXianTableViewController *project = [[TiXianTableViewController alloc] init];
                                           project.title = @"提现";
                                           project.dic = [dic objectForKey:@"rvalue"];
                                           //返回
                                           UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
                                           backItem.title=@"返回";
                                           self.navigationItem.backBarButtonItem=backItem;
                                           self.hidesBottomBarWhenPushed=YES;
                                           [self.navigationController pushViewController:project animated:YES];
                                           self.hidesBottomBarWhenPushed=NO;
 
                                       }else{
                                           
                                           
                                           
                                       }
                                   }
                               }];
}






//推出
-(void)tuichu{
    
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/logout.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
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
                                           [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"curLoginUserId"];
                                           [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"cookieValue"];
                                           [[NSUserDefaults standardUserDefaults] synchronize];
                                           
                                           [MBProgressHUD showSuccess:@"成功退出" toView:nil];
                                           [[NSNotificationCenter defaultCenter] postNotificationName:@"loginAfterDoSometing" object:nil];
                                           
                                           [self.tabBarController setSelectedIndex:0];
                                           
                                          // [self.navigationController popToRootViewControllerAnimated:NO];
                                           
                                       }else{
                                           [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:nil];
                                       }
                                       
                                   }else{
                                       
                                   }
                               }];
    
}







//设置
-(void)setView{
    SaveInfoViewController *sa = [[SaveInfoViewController alloc] init];
    sa.title = @"设置";
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:sa animated:YES];
    self.hidesBottomBarWhenPushed=NO;

    
}

//消息
-(void)xiaoxibut{
    NoticeViewController *nob = [[NoticeViewController alloc] init];
    nob.title = @"消息";
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:nob animated:YES];
    self.hidesBottomBarWhenPushed=NO;
    
}


-(void)but1P{
    [but1 setBackgroundColor:[UIColor whiteColor]];
    [but1 setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [UtilityUI setBorderOnView:but1 borderColor:KTHCOLOR borderWidth:1 cornerRadius:15];
    
    [but2 setBackgroundColor:[UIColor clearColor]];
    [but2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [UtilityUI setBorderOnView:but2 borderColor:[UIColor whiteColor] borderWidth:1 cornerRadius:15];
    
    lab1.text  = [NSString stringWithFormat:@"%@\n\n可用余额(元)",user.cgkyye];
    lab2.text  = [NSString stringWithFormat:@"%@\n\n已赚总额(元)",user.cgyzze];
}

-(void)but2P{
    [but2 setBackgroundColor:[UIColor whiteColor]];
    [but2 setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [UtilityUI setBorderOnView:but2 borderColor:KTHCOLOR borderWidth:1 cornerRadius:15];
    
    [but1 setBackgroundColor:[UIColor clearColor]];
    [but1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [UtilityUI setBorderOnView:but1 borderColor:[UIColor whiteColor] borderWidth:1 cornerRadius:15];
    
    lab1.text  = [NSString stringWithFormat:@"%@\n\n可用余额(元)",user.keyong_money];
    lab2.text  = [NSString stringWithFormat:@"%@\n\n已赚总额(元)",user.zhuanqu_money];
}


//充值
-(void)chongzhi{
    ChongzhiViewController *chonzhi = [[ChongzhiViewController alloc] init];
    chonzhi.title = @"充值";
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:chonzhi animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

//提款
-(void)tikuan{
    TixianViewController *tixian = [[TixianViewController alloc] init];
    tixian.title = @"提现";
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:tixian animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}


//账户总览
-(void)zhanghuzonglan{
    ZhanghuzonglanViewController *za = [[ZhanghuzonglanViewController alloc]initWithNibName:@"ZhanghuzonglanViewController" bundle:nil];
    za.title = @"账户总览";
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:za animated:YES];
    self.hidesBottomBarWhenPushed=NO;
 
}

//交易记录
-(void)jiaoyijilu{
    JiaoyijiluViewController *jiaoyi = [[JiaoyijiluViewController alloc]init];
    jiaoyi.title = @"交易记录";
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:jiaoyi animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

//我的投标
-(void)wodetoubiao{
    WotoubiaoViewController *wode = [[WotoubiaoViewController alloc]init];
    wode.title = @"我的投标";
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:wode animated:YES];
    self.hidesBottomBarWhenPushed=NO;

}

//邀请好友
-(void)yaoqinghaoyou{
    YaoqinghaoyuViewController *yaoqing = [[YaoqinghaoyuViewController alloc] init];
    yaoqing.title = @"邀请好友";
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:yaoqing animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

@end
