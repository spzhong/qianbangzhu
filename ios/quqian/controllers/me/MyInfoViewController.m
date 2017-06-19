//
//  MyInfoViewController.m
//  quqian
//
//  Created by apple on 15/3/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MyInfoViewController.h"
#import "EGOImageView.h"
#import "SaveInfoViewController.h"
#import "erCodeController.h"
#import "HelpDownloader.h"
#import "MBProgressHUD+Add.h"
#import "UserModel.h"
#import "LXActionSheet.h"
#import "InputGeneralViewController.h"


@interface MyInfoViewController ()<LXActionSheetDelegate,InputGeneralViewControllerDelegate>{
    UIDatePicker *date;
    UserModel *user;
}

@end

@implementation MyInfoViewController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    return self = [super initWithStyle:UITableViewStyleGrouped];
}


#pragma InputGeneralViewControllerDelegate
-(void)saveMessage:(NSString *)str withTag:(int)tag{
    user.nickName = str;
    [Tool savecoredata];
    [self.tableView reloadData];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
 
    if (buttonIndex==1) {
        user.gender = @"1";
    }else if (buttonIndex==0){
        user.gender = @"0";
    }
    [Tool savecoredata];
    [self.tableView reloadData];
}


-(void)selectDate:(UIDatePicker *)datePicker{
    NSDate *select  = [datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateAndTime = [dateFormatter stringFromDate:select];
    user.birthDay = dateAndTime;
    [Tool savecoredata];
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]];
    
    
    user = [Tool getUser];
    //获取
    [self userInfo__startRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return 20;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 3;
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
    imgView.frame = CGRectMake(15, 15, 50, 50);
    UILabel *lab123 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(16.5, 0, [Tool adaptation:200 with6:55 with6p:94], 45) Alignment:NSTextAlignmentLeft  FontFl:15];
    lab123.font = FOUR_CONTROL_FONT;
    UILabel *lab1234 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(100, 0, [Tool adaptation:200 with6:55 with6p:94], 45) Alignment:NSTextAlignmentRight  FontFl:14];
    [cell.contentView addSubview:lab123];
    [cell.contentView addSubview:lab1234];
    [cell.contentView addSubview:imgView];
    [lab1234 setTextColor:[UIColor darkGrayColor]];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if (section==0) {
        
        if (row==0) {
            lab123.text = @"安全信息";
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if (section==1) {
        
        if (row==0) {
            lab123.text = @"用户名";
            lab1234.text = user.userId;
        }else if (row==1){
            lab123.text = @"性别";
            
            lab1234.text = user.gender;
            
            
        }else if (row==2){
            lab123.text = @"出生日期";
            lab1234.text = user.birthDay;
        }
        
    }else if (section==2) {
        
        if (row==0) {
            lab123.text = @"我的服务码";
            lab1234.text = user.wdfwm;
            
        }
    }else if (section==3) {
        
        if (row==0) {
            lab123.text = @"我的二维码";
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if (section==4){
        
        lab123.text = @"退出";
        lab123.textColor = [UIColor whiteColor];
        [lab123 setBackgroundColor:[UIColor colorWithRed:2/255.0 green:160/255.0 blue:219/255.0 alpha:1]];
        lab123.textAlignment = NSTextAlignmentCenter;
        lab123.frame = CGRectMake(0, 0, [Tool adaptation:320 with6:55 with6p:94], 45);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
 
    if (section==0) {
        SaveInfoViewController *save = [[SaveInfoViewController alloc] init];
        save.title = @"安全信息";
        //返回
        UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
        backItem.title=@"返回";
        self.navigationItem.backBarButtonItem=backItem;
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:save animated:YES];
    }
    
    if(section==1){
        if (row==0) {
//            InputGeneralViewController *input = [[InputGeneralViewController alloc] init];
//            input.delegate = self;
//            input.tag=101;
//            input.lines = 1;
//            input.text = user.name;
//            input.titleName = @"昵称";
//            input.allCount = 20;
//            UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:input];
//            [self presentViewController:na animated:YES completion:NULL];
            
        }else if (row==1){
        
//            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"选择性别" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"男",@"女", @"取消",nil];
//            [alter show];
            
        }else if (row==2){
            //[self showDatePicker];
        }
    }
 
    if (section==3) {
        
        erCodeController *er = [[erCodeController alloc] init];
        er.title = @"我的二维码";
        //返回
        UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
        backItem.title=@"返回";
        self.navigationItem.backBarButtonItem=backItem;
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:er animated:YES];
    }
    
    if (section==4) {
        
        LXActionSheet *actionSheet = [[LXActionSheet alloc]initWithTitle:@"退出后不会删除任何历史数据,下次登录依然可以使用本账号" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出登录" otherButtonTitles:nil];
        [actionSheet showInView:self.view];
        
    }
    
}

//退出操作
- (void)didClickOnButtonIndex:(NSInteger *)buttonIndex{
    if (buttonIndex==0) {
        [self tuichu];
    }
}



//取消
-(void)quxiao{
    UIView *bg = [self.view viewWithTag:1001];
    [bg removeFromSuperview];
    [date removeFromSuperview];
    date = nil;
}

//显示
-(void)showDatePicker{
    
    if (date != nil) {
        return;
    }
    
    UIControl *all = [[UIControl  alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [all setBackgroundColor:[UIColor blackColor]];
    all.alpha = 0.0;
    [self.view addSubview:all];
    all.tag = 1001;
    [all addTarget:self action:@selector(quxiao) forControlEvents:UIControlEventTouchUpInside];
    
    
    date = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 280)];
    [date addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventValueChanged];
    date.datePickerMode = UIDatePickerModeDate;
    [self.view addSubview:date];
    [date setBackgroundColor:[UIColor whiteColor]];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0.25];
    
    all.alpha = 0.5;
    date.frame = CGRectMake(0, self.view.frame.size.height-280,self.view.frame.size.width, 280);
    
    [UIView commitAnimations];
    

}





//用户信息
-(void)userInfo__startRequest{
    
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
                                       if ([[dic objectForKey:@"code"] intValue] == 0) {
                                           
                                           [self doSameThing:dic];
                                           
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
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginAfterDoSometing" object:nil];
    
    
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
                                           
                                           [self.navigationController popToRootViewControllerAnimated:NO];
                                          
                                       }else{
                                           [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:nil];
                                       }
                                       
                                   }else{
                                       
                                   }
                               }];
    
}






@end
