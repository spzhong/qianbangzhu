//
//  OkTiXianTableViewController.m
//  quqian
//
//  Created by apple on 15/4/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "OkTiXianTableViewController.h"
#import "Tool.h"
#import "EGOImageView.h"
#import "HelpDownloader.h"
#import "MBProgressHUD+Add.h"
#import "UserModel.h"


@interface OkTiXianTableViewController ()

@end

@implementation OkTiXianTableViewController

@synthesize bankCardId;//银行卡信息
@synthesize amount;//金额
@synthesize password;//体现密码
@synthesize shouxufei;//体现手续费
@synthesize shijikouchujine;//实际扣除金额
@synthesize bankNameAndAdress;

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
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 45;
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
    
    if (section==0) {
        
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
        UILabel *lab = [Tool LablelProductionFunction:@"提现银行卡" Frame:CGRectMake(15, 0, [Tool adaptation:200 with6:55 with6p:94], 45) Alignment:NSTextAlignmentLeft  FontFl:15];
        lab.font= FOUR_CONTROL_FONT;
        [bg addSubview:lab];
        return bg;
        
    }else if (section==2){
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
        UILabel *lab = [Tool LablelProductionFunction:@"1-2个工作日到账（双休日和法定节假日除外）" Frame:CGRectMake(0, -35, [Tool adaptation:320 with6:55 with6p:94], 45) Alignment:NSTextAlignmentCenter  FontFl:12];
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
            
            lab1234.frame = CGRectMake(30, 0, 270, 45);
            lab1234.textAlignment=NSTextAlignmentCenter;
            
            lab1234.text = bankNameAndAdress;
            //lab1234.textColor = [UIColor colorWithRed:2/255.0 green:160/255.0 blue:219/255.0 alpha:1];
            imgView.image = [UIImage imageNamed:@"icon27.png"];
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
        
    }else if (section==1) {
        
        if (row==0) {
            
            lab123.text = @"提现金额";
            
            lab1234.text = amount;
           
            lab2.text = @"元";
            
            
        }else if (row==1){
            
            lab123.text = @"提现手续费";
            lab1234.text = shouxufei;
            lab2.text = @"元";
        }
        
    }else if (section==2) {
        
        if (row==0) {
            
            lab123.text = @"实际扣除金额";
            lab1234.text = shijikouchujine;
            lab1234.textColor = [UIColor colorWithRed:244/255.0 green:151/255.0 blue:0/255.0 alpha:1.0];
            lab2.text = @"元";
        }
        
    }else if (section==3) {
        
        lab123.textColor = [UIColor whiteColor];
        lab123.textAlignment = NSTextAlignmentCenter;
        lab123.frame = CGRectMake(0, 0, 320, 45);
        lab123.text = @"确认提现";
        [lab123 setBackgroundColor:[UIColor colorWithRed:2/255.0 green:160/255.0 blue:219/255.0 alpha:1]];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    //确认体现
    if (section==3) {
        [self oktixian__startRequest];
    }
    
}



//绑定或修改银行卡信息
-(void)oktixian__startRequest{
 
    if (bankCardId==nil) {
        bankCardId = @"";
    }
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/user/deal/withdraw.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
 
    [postDic setObject:amount forKey:@"amount"];
    [postDic setObject:password forKey:@"password"];
    [postDic setObject:bankCardId forKey:@"bankCardId"];
  
    
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
                                           
                                           
                                           
                                           
                                           UserModel *user = [Tool getUser];
                                           user.keyong_money = [[dic objectForKey:@"rvalue"] objectForKey:@"amount"];
                                           [Tool savecoredata];
                                           
                                           
                                           [MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:nil];
                                           
                                           [self.navigationController popToRootViewControllerAnimated:YES];
                                        
                                       }else{
                                           
                                           [Tool myalter:[dic objectForKey:@"msg"]];
                                           
                                       }
                                   }
                               }];
}



@end
