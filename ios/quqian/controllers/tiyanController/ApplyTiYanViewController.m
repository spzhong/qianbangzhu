//
//  ApplyTiYanViewController.m
//  quqian
//
//  Created by apple on 15/3/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ApplyTiYanViewController.h"
#import "EGOImageView.h"
#import "RCLabel.h"
#import "LoginTableViewController.h"
#import "STAlertView.h"
#import "UserModel.h"
#import "HelpDownloader.h"
#import "MBProgressHUD+Add.h"
#import "TrueNameViewController.h"
#import "ReCodeTableViewController.h"


@interface ApplyTiYanViewController ()
{
    NSMutableArray *tiyanArray;
    UserModel *user;
    int currMaoney;
}
@end

@implementation ApplyTiYanViewController
@synthesize allDic;

- (instancetype)initWithStyle:(UITableViewStyle)style{
    return self = [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]];
    
    
    user = [Tool getUser];
    
    //获取体验券列表
    [self tiYanQuan__startRequest];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    tiyanArray = [[NSMutableArray alloc] initWithCapacity:0];
    //NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject:@"5964t8" forKey:@"bianhao"];
//    [dic setObject:@"1000.00" forKey:@"yuan"];
//    [dic setObject:@"yes" forKey:@"isshow"];
//    [tiyanArray addObject:dic];
//    [tiyanArray addObject:dic];
//    [tiyanArray addObject:dic];
    
    //表的尾部
    [self makefootView];
}


//生称footview
-(void)makefootView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    
    //登录
    UIButton *but3 = [Tool ButtonProductionFunction:@"申请" Frame:CGRectMake(0, 0, 320, 45) bgImgName:@"" FontFl:20];
    [bgView addSubview:but3];
    [but3 setBackgroundColor:[UIColor colorWithRed:2/255.0 green:160/255.0 blue:219/255.0 alpha:1]];
    [but3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but3 addTarget:self action:@selector(shenqing) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableFooterView = bgView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 35;
    }
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }else if (section==1){
        return [tiyanArray count]+1;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        UILabel *lab = [Tool LablelProductionFunction:@"请选择体验券" Frame:CGRectMake(16.5, 0, [Tool adaptation:200 with6:55 with6p:94], 30) Alignment:NSTextAlignmentLeft  FontFl:15];
        [bg addSubview:lab];
        //获取
        UIButton *but = [Tool ButtonProductionFunction:@"(获取)" Frame:CGRectMake(80, 0, 100, 30) bgImgName:nil FontFl:15];
        [bg addSubview:but];
        [but setTitleColor:[UIColor colorWithRed:2/255.0 green:160/255.0 blue:219/255.0 alpha:1] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(lingqutiyanjin) forControlEvents:UIControlEventTouchUpInside];
        
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
    imgView.frame = CGRectMake(15, 15, 50, 50);
    [cell.contentView addSubview:imgView];
    
    UILabel *lab123 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(16.5, 0, [Tool adaptation:200 with6:55 with6p:94], 45) Alignment:NSTextAlignmentLeft  FontFl:15];
    lab123.font = FOUR_CONTROL_FONT;
    [cell.contentView addSubview:lab123];

    //右边
    RCLabel *rcLab = [[RCLabel alloc] initWithFrame:CGRectMake(43, 15, 260, 20)];
    [cell.contentView addSubview:rcLab];
    
    RCLabel *rcLab1 = [[RCLabel alloc] initWithFrame:CGRectMake(120, 15, 260, 20)];
    [cell.contentView addSubview:rcLab1];
    
    if (section==0) {
    
        if (row==0) {
            lab123.text = @"剩余金额";
            rcLab.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=right><font size=15 color='#EA9500'>%@</font><font size=15>元</font></p>",[allDic objectForKey:@"syje"]]];
        }else if (row==1){
            lab123.text = @"每人可加入金额上限";
            rcLab.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=right><font size=15 color='#EA9500'>%@</font><font size=15>元</font></p>",[allDic objectForKey:@"joinLimit"]]];
        }
        
        
    }else if (section==1) {
        
        
        if (row == tiyanArray.count) {
            
            rcLab.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=left><font size=15 >当前选择体验金:</font><font size=15 color='#EA9500'>%d</font><font size=15>元</font></p>",currMaoney]];
            rcLab.frame = CGRectMake(16.5, 15, 250, 20);
            
    
        }else{
            
            UIButton*checkbox=[[UIButton alloc]initWithFrame:CGRectZero];
            checkbox.tag = 100 + row;
            [cell.contentView addSubview:checkbox];
            checkbox.frame=CGRectMake(15,17,13,13) ;
            
            NSMutableDictionary *dic = [tiyanArray objectAtIndex:row];
            if ([[dic objectForKey:@"isshow"] isEqualToString:@"yes"]) {
                [checkbox setImage:[UIImage imageNamed:@"icon19-2.png"]forState:UIControlStateSelected];
            }else {
                [checkbox setImage:[UIImage imageNamed:@"icon19-1.png"]forState:UIControlStateSelected];
            }
            //设置正常时图片为    check_off.png
            //[checkbox setImage:[UIImage imageNamed:@"icon19-2.png"]forState:UIControlStateSelected];
            //设置点击选中状态图片为check_on.png
            [checkbox addTarget:self action:@selector(checkboxClick:)forControlEvents:UIControlEventTouchUpInside];
            [checkbox setSelected:YES];//设置按钮得状态是否为选中（可在此根据具体情况来设置按钮得初始状态）
            
            //值
            
            NSString *bianhao = [dic objectForKey:@"qh"];
            NSString *yuan = [dic objectForKey:@"je"];
            rcLab.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=left><font size=15 >%@</font></font></p>",bianhao]];
            rcLab.frame = CGRectMake(35, 15, 250, 20);
            
            rcLab1.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=left><font size=15 >    (%@元)</font></p>",yuan]];
            rcLab1.frame = CGRectMake(100, 15, 250, 20);
        }
    }
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==1) {
        
         UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
         UIButton *bu =  (UIButton *)[cell.contentView viewWithTag:100+indexPath.row];
        if (bu==nil) {
            return;
        }
        [self checkboxClick:bu];
    }
}



//点击操作
-(void)checkboxClick:(UIButton*)btn{
    
    
    
    NSLog(@"btn.tag %ld",btn.tag);
    NSMutableDictionary *dic = [tiyanArray objectAtIndex:btn.tag-100];
    if ([[dic objectForKey:@"isshow"] isEqualToString:@"yes"]) {
        [dic setObject:@"no" forKey:@"isshow"];
        [btn setImage:[UIImage imageNamed:@"icon19-2.png"]forState:UIControlStateSelected];
    }else {
        [dic setObject:@"yes" forKey:@"isshow"];
        [btn setImage:[UIImage imageNamed:@"icon19-1.png"]forState:UIControlStateSelected];
    }
    
    //计算
    [self jisuan];
}


-(NSString *)jisuan{
    NSMutableString *string = [NSMutableString string];
    
    currMaoney = 0;
    
    for (NSMutableDictionary *dic in tiyanArray) {
        
        NSLog(@"show %@",[dic objectForKey:@"isshow"]);
        
        if ([[dic objectForKey:@"isshow"] isEqualToString:@"yes"]) {
            currMaoney +=  [[dic objectForKey:@"je"] intValue];
            [string appendString:[dic objectForKey:@"qh"]];
            [string appendString:@","];
        }
    }
    
    //刷新数据
    [self.tableView reloadData];
    return string;
}






//领取体验金
-(void)lingqutiyanjin{
    
    //判断是否登录
    UserModel *user = (UserModel*)[Tool getUser];
    
    //数据为空－－－需要登录啊
    if (user==nil) {
        LoginTableViewController *loginView = [[LoginTableViewController alloc] init];
        loginView.title = @"登录";
        UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:loginView];
        [self presentViewController:na animated:YES completion:NULL];
        return;
    }
    
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"获取体验金" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil ];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[alertView textFieldAtIndex:0] setPlaceholder:@"请输入体验金券号"];
    [[alertView textFieldAtIndex:0] setText:@""];
    [alertView show];
    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        
        if (alertView.tag==109) {
            [self shengqing__startRequest];
        }else if (alertView.tag==900) {
            TrueNameViewController *trueName = [[TrueNameViewController alloc] init];
            trueName.title = @"实名认证";
            //返回
            UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
            backItem.title=@"返回";
            self.navigationItem.backBarButtonItem=backItem;
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:trueName animated:YES];
        }else if (alertView.tag==901) {
            ReCodeTableViewController *queren = [[ReCodeTableViewController alloc] init];
            queren.type = 1;
            queren.title = @"设置提现密码";
            UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
            backItem.title=@"返回";
            self.navigationItem.backBarButtonItem=backItem;
            [self.navigationController pushViewController:queren animated:YES];
        }else{
            NSString *text = [alertView textFieldAtIndex:0].text;
            [self performSelector:@selector(addtiYanQuan__startRequest:) withObject:text afterDelay:0.5];
        }
        
    }
}




//申请
-(void)shenqing{
    
    
    if (currMaoney==0) {
        [MBProgressHUD showError:@"请选择体验券" toView:nil];
        return;
    }
    
//    UserModel *userModel = [Tool getUser];
//    //判断是否实名认证了
//    if ([userModel.sfzsfrz isEqualToString:@"false"]) {
//        //[Tool myalter:@"请设置实名认证"];
//        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请设置实名认证" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
//        al.tag = 900;
//        [al show];
//        
//        return;
//    }
//    
//    //提现密码是否设置
//    if ([userModel.txmmsfsz isEqualToString:@"false"]) {
//        //[Tool myalter:@"请设置提现密码"];
//        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请设置提现密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
//        al.tag = 901;
//        [al show];
//        return;
//    }
//    
    
    
    
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"购买确认" message:[NSString stringWithFormat:@"您此次申请理财体验需使用\n%d元体验金",currMaoney] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    al.tag = 109;
    [al show];
    
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
                                       
                                           //重新获取一下
                                           [self tiYanQuan__startRequest];
                                           
                                       }else{
                                           [MBProgressHUD showError:[[data JSONValue] objectForKey:@"msg"] toView:nil];
                                           
                                       }
                                       
                                       
                                       
                                       
                                   }else{
                                       
                                   }
                                   
                               }];
    
}





//获取体验券列表
-(void)tiYanQuan__startRequest{
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/lcty/tyqs.htm",BASE_URL];
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
                                       
                                       //清楚
                                       [tiyanArray removeAllObjects];
                                       
                                       int allData = 0;
                                       
                                       NSMutableDictionary *dic = [data JSONValue];
                                       NSString *SS = [Tool toString:[dic objectForKey:@"rvalue"]];
                                       
                                       if ([SS isEqualToString:@"<null>"]) {
                                           return;
                                       }
                                       
                                       NSArray *array = [[data JSONValue] objectForKey:@"rvalue"];
                                      
                                       
                                       for (NSMutableDictionary *dic in  array) {
                                           NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                                           [newDic setObject:@"no" forKey:@"isshow"];
                                           [tiyanArray addObject:newDic];
                                           
                                           allData += [[newDic objectForKey:@"je"] intValue];
                                       }
                                       
                                       //体验金额
                                       user.tyjze = [NSString stringWithFormat:@"%d",allData];
                                       [Tool savecoredata];
                                    
                                       currMaoney =  0;
                                       
                                       //刷新
                                       [self.tableView reloadData];
                                       
                                   }else{
                                       
                                   }
                                   
                               }];
    
}


//申请加入
-(void)shengqing__startRequest{
    
    //进行有效登录确认
    NSString *string = [self jisuan];
    if (string.length>0) {
        string = [string substringToIndex:string.length-1];
    }
    
    NSString *url =[NSString stringWithFormat:@"%@/lcty/jr.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    if ([allDic objectForKey:@"id"] == nil) {
        return;
    }
    [postDic setObject:[allDic objectForKey:@"id"] forKey:@"id"];
    
    
    [postDic setObject:string forKey:@"qh"];
    
    
    
    [postDic setObject:[NSString stringWithFormat:@"%d",currMaoney] forKey:@"amount"];
    
    
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
                                           
                                           
                                           //保存数据
                                           user.keyong_money = [[dic objectForKey:@"rvalue"] objectForKey:@"amount"];
                                           user.tyjze = [[dic objectForKey:@"rvalue"] objectForKey:@"experienceAmount"];
                                           [Tool savecoredata];
                                           
                                           
                                           [[NSNotificationCenter defaultCenter] postNotificationName:@"gengxinshuju" object:nil];
                                           
                                           
                                           //返回体验列表中
                                           [self.navigationController popViewControllerAnimated:YES];
                                           
                                           
                                           [MBProgressHUD showSuccess:[dic objectForKey:@"msg"]  toView:nil];
                                           
                                       }else{
                                           
                                           [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:nil];
                                       }
                                
                                       
                                   }else{
                                       
                                   }
                                   
                               }];
}



@end
