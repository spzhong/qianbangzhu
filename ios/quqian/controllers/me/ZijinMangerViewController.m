//
//  ZijinMangerViewController.m
//  quqian
//
//  Created by apple on 15/3/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ZijinMangerViewController.h"
#import "Tool.h"
#import "RCLabel.h"
#import "LoginTableViewController.h"
#import "UserModel.h"
#import "STAlertView.h"
#import "HelpDownloader.h"
#import "MBProgressHUD+Add.h"
#import "TrueNameViewController.h"
#import "ReCodeTableViewController.h"
#import "ChongZhiTableViewController.h"
#import "TiXianTableViewController.h"


@interface ZijinMangerViewController ()
{
    UserModel *user;
    NSString *tiyanjine;
}
@end

@implementation ZijinMangerViewController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    return self = [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
     user = [Tool getUser];
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]];
    
    //获取个人的资料
    //[self performSelector:@selector(userInfo__startRequest:) withObject:@"no" afterDelay:1.5];
    
    
    [self userInfo__startRequest:@""];
   
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
    if (section==0) {
        return 3;
    }else if (section==1){
        return 1;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
        return 80;
    }
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
    
 
    UILabel *lab123 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(16.5, 0, [Tool adaptation:200 with6:55 with6p:94], 45) Alignment:NSTextAlignmentLeft  FontFl:15];
    lab123.font = FOUR_CONTROL_FONT;
    [cell.contentView addSubview:lab123];
    
    UILabel *lab1234 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(80, 0, [Tool adaptation:200 with6:55 with6p:94], 45) Alignment:NSTextAlignmentRight  FontFl:14];
    [cell.contentView addSubview:lab1234];
    
    
    //右边
    RCLabel *rcLab = [[RCLabel alloc] initWithFrame:CGRectMake(50, 15, 250, 20)];
    [cell.contentView addSubview:rcLab];
    
 
    
    
    
    if (section==0) {
        
        if (row==0) {
            lab123.text = @"可用金额";
            rcLab.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=right><font size=15 color='#EA9500'>%@</font><font size=15>元</font></p>",user.keyong_money]];
        }else if (row==1){
            lab123.text = @"冻结金额";
            rcLab.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=right><font size=15 color='#EA9500'>%@</font><font size=15>元</font></p>",user.djje]];
        }else if (row==2){
            lab123.text = @"账户总额";
            rcLab.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=right><font size=15 color='#EA9500'>%@</font><font size=15>元</font></p>",user.zhze]];
        }
        
        
    }else if (section==1) {
        
        rcLab.frame = CGRectMake(12.5, 15, 250, 20);
        rcLab.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=left><font size=17 >体验金</font><font size=17 color='#EA9500'>（获取）</font></p>"]];
        rcLab.tag = 100;
        lab1234.text = tiyanjine;
        
        
    } else{
        
        UIButton *buton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        buton1.frame = CGRectMake(15, 15, 130, 50);
        [buton1 setTitle:@"充值" forState:UIControlStateNormal];
        [cell.contentView addSubview:buton1];
        [buton1 setBackgroundImage:[UIImage imageNamed:@"button01.png"] forState:UIControlStateNormal];
        buton1.tag = 100;
        [buton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        UIButton *buton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        buton2.frame = CGRectMake(175, 15, 130, 50);
        [buton2 setTitle:@"体现" forState:UIControlStateNormal];
        [buton2 setBackgroundImage:[UIImage imageNamed:@"button2.png"] forState:UIControlStateNormal];
        [cell.contentView addSubview:buton2];
        buton2.tag = 101;
        [buton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [buton1 addTarget:self action:@selector(buttonpreeschongzhi) forControlEvents:UIControlEventTouchUpInside];
        [buton2 addTarget:self action:@selector(buttonpreestikuan) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger section = indexPath.section;
    
    //领取体验金
    if (section==1) {
    
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"获取体验金" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil ];
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        [[alertView textFieldAtIndex:0] setPlaceholder:@"请输入体验金券号"];
        [[alertView textFieldAtIndex:0] setText:@""];
        [alertView show];
        
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
        }else{
            
            NSString *text = [alertView textFieldAtIndex:0].text;
            [self performSelector:@selector(addtiYanQuan__startRequest:) withObject:text afterDelay:0.5];
        }
        
    }
}




//充值
-(void)buttonpreeschongzhi{
    //判断是否实名认证了
    if ([user.sfzsfrz isEqualToString:@"false"]) {
        //[Tool myalter:@"请设置实名认证"];
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请设置实名认证" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        al.tag = 900;
        [al show];
        
        return;
    }
    
    //提现密码是否设置
    if ([user.txmmsfsz isEqualToString:@"false"]) {
        //[Tool myalter:@"请设置提现密码"];
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请设置提现密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        al.tag = 901;
        [al show];
        return;
    }
  
    [self chongzhi__startRequest];
        
        
}

//体现
-(void)buttonpreestikuan{
    //判断是否实名认证了
    if ([user.sfzsfrz isEqualToString:@"false"]) {
        //[Tool myalter:@"请设置实名认证"];
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请设置实名认证" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        al.tag = 900;
        [al show];
        
        return;
    }
    
    //提现密码是否设置
    if ([user.txmmsfsz isEqualToString:@"false"]) {
        //[Tool myalter:@"请设置提现密码"];
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请设置提现密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        al.tag = 901;
        [al show];
        return;
    }
    
     [self tikuan__startRequest];
    
 
}

 



//获取体验券列表
-(void)addtiYanQuan__startRequest:(NSString *)result{
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/lcty/hq.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:result forKey:@"qh"];
    
    
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"yes",@"isshowHUD",
                                           @"no",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   
                                   if (kk==0) {
                                       
                                       if ([[[data JSONValue] objectForKey:@"code"] intValue]==0) {
                                           
                                           [MBProgressHUD showSuccess:[[data JSONValue] objectForKey:@"msg"] toView:nil];
                                           
                                           [self userInfo__startRequest:@"yes"];
                                           
                                       }else{
                                           [MBProgressHUD showError:[[data JSONValue] objectForKey:@"msg"] toView:nil];
                                           
                                       }
                                       
                                   }else{
                                       
                                   }
                                   
                               }];
    
}




//用户信息
-(void)userInfo__startRequest:(NSString *)isshow{
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/getUser.htm",BASE_URL];
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
                                       if ([[dic objectForKey:@"code"] intValue] == 0) {
                                           
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
        UserModel *user1 = [[UserModel alloc]initWithEntity:entity insertIntoManagedObjectContext:[Tool getDele].managedObjectContext];
        //进行赋予值
        [user1 makeInData:dic];
     
    }else{
        //进行更新数据
        [newUser makeInData:dic];
    }
    [Tool savecoredata];
    
    
    tiyanjine = [[dic objectForKey:@"rvalue"] objectForKey:@"tyjze"];
    
  
    //刷新
    [self.tableView reloadData];
}








//充值的接口判断
-(void)chongzhi__startRequest{
    
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/user/deal/getrecharge.htm",BASE_URL];
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
                                       if ([[dic objectForKey:@"code"] intValue] == 0) {
                                           
                                           ChongZhiTableViewController *project = [[ChongZhiTableViewController alloc] init];
                                           project.dic = [dic objectForKey:@"rvalue"];
                                           project.title = @"充值";
                                           //返回
                                           UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
                                           backItem.title=@"返回";
                                           self.navigationItem.backBarButtonItem=backItem;
                                           self.hidesBottomBarWhenPushed=YES;
                                           [self.navigationController pushViewController:project animated:YES];
                                          
                                           
                                           
                                       }else{
                                           
                                           
                                           
                                       }
                                   }
                               }];
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
                                           
                                           
                                       }else{
                                           
                                           
                                           
                                       }
                                   }
                               }];
}







@end
