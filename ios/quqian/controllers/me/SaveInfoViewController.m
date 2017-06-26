

//
//  SaveInfoViewController.m
//  quqian
//
//  Created by apple on 15/3/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SaveInfoViewController.h"
#import "Tool.h"
#import "UserModel.h"
#import "TrueNameViewController.h"
#import "LXActionSheet.h"
#import "ChangeMoblieViewController.h"
#import "ChangeTiKuanCodeViewController.h"
#import "ReCodeTableViewController.h"
#import "MBProgressHUD.h"


@interface SaveInfoViewController ()<LXActionSheetDelegate>
{
    UserModel *user;
}
@end

@implementation SaveInfoViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tableView reloadData];
}


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
    
     user = [Tool getUser];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    UIButton *but = [Tool ButtonProductionFunction:@"退出" Frame:CGRectMake(15, 0, ScreenWidth-30, 50) bgImgName:nil FontFl:15];
    [but setBackgroundColor:KTHCOLOR];
    [bgView addSubview:but];
    [but addTarget:self action:@selector(tuichu) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.tableView.tableFooterView = bgView;
    
}

-(void)tuichu{
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"curLoginUserId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [Tool myalters:@"成功退出"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginAfterDoSometing" object:nil];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    }
    return 0;
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
 
    UILabel *lab123 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(16.5, 0, [Tool adaptation:200 with6:55 with6p:94], 45) Alignment:NSTextAlignmentLeft  FontFl:15];
    lab123.font = FOUR_CONTROL_FONT;
    UILabel *lab1234 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(0, 0, [Tool adaptation:320 with6:55 with6p:94], 45) Alignment:NSTextAlignmentCenter  FontFl:14];
    
    UILabel *lab12345 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(80, 0, [Tool adaptation:210 with6:55 with6p:94], 45) Alignment:NSTextAlignmentRight  FontFl:14];
    
    [cell.contentView addSubview:lab12345];
    [cell.contentView addSubview:lab123];
    [cell.contentView addSubview:lab1234];
    [lab1234 setTextColor:[UIColor darkGrayColor]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    if (section==0) {
        
        if (row==0) {
            lab123.text = @"实名认证";
            if ([user.sfzsfrz isEqualToString:@"false"]) {
                lab1234.text = @"未设置" ;
                lab1234.textColor = [UIColor redColor];
                lab12345.text = @"设置";
            }else{
                lab1234.text = [user new_cardNum];
                lab12345.text = [user new_trueName];
                [lab1234 setTextColor:[UIColor darkGrayColor]];
                [lab12345 setTextColor:[UIColor darkGrayColor]];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }else if (row==1) {
            lab123.text = @"修改手机";
            if ([user.sjsfsz isEqualToString:@"false"]) {
                lab1234.text = @"未设置" ;
                lab1234.textColor = [UIColor redColor];
                lab12345.text = @"设置";
            }else{
                lab1234.text = [user new_mobile];
                [lab1234 setTextColor:[UIColor darkGrayColor]];
                lab12345.text = @"修改";
                [lab12345 setTextColor:[UIColor colorWithRed:0 green:130/255.0 blue:182/255.0 alpha:1.0]];
            }
        }else if (row==2){
            lab123.text = @"提现密码";
            if ([user.txmmsfsz isEqualToString:@"false"]) {
                lab1234.text = @"未设置" ;
                lab1234.textColor = [UIColor redColor];
                lab12345.text = @"设置";
            }else{
                lab1234.text = @"已设置";
                lab12345.text = @"修改/找回";
                [lab1234 setTextColor:[UIColor darkGrayColor]];
                [lab12345 setTextColor:[UIColor colorWithRed:0 green:130/255.0 blue:182/255.0 alpha:1.0]];
            }
        }else if (row==2){
            lab123.text = @"退出";
        }
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    //NSInteger section = indexPath.section;
    
    if (row==0) {
        
        if ([user.sfzsfrz isEqualToString:@"false"]) {
            TrueNameViewController *trueName = [[TrueNameViewController alloc] init];
            trueName.title = @"实名认证";
            //返回
            UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
            backItem.title=@"返回";
            self.navigationItem.backBarButtonItem=backItem;
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:trueName animated:YES];
        }
        
    }else if (row==1){
    
        if ([user.sjsfsz isEqualToString:@"false"]) {
            
            ChangeMoblieViewController *change = [[ChangeMoblieViewController alloc] init];
            change.title = @"修改手机";
            //返回
            UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
            backItem.title=@"返回";
            self.navigationItem.backBarButtonItem=backItem;
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:change animated:YES];
            
        }else{
            ChangeMoblieViewController *change = [[ChangeMoblieViewController alloc] init];
            change.title = @"修改手机";
            //返回
            UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
            backItem.title=@"返回";
            self.navigationItem.backBarButtonItem=backItem;
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:change animated:YES];
        }
        
        
        
    }else if (row==2){
    
        if ([user.txmmsfsz isEqualToString:@"false"]) {
            ReCodeTableViewController *queren = [[ReCodeTableViewController alloc] init];
            queren.type = 2;
            queren.title = @"设置提现密码";
            UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
            backItem.title=@"返回";
            self.navigationItem.backBarButtonItem=backItem;
            [self.navigationController pushViewController:queren animated:YES];
            
        }else{
             LXActionSheet *actionSheet = [[LXActionSheet alloc]initWithTitle:@"修改/找回提现密码" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:[NSArray arrayWithObjects:@"修改",@"找回", nil]];
            [actionSheet showInView:self.view];
        }
    }else if (row==3){
    
        
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"curLoginUserId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.navigationController popToRootViewControllerAnimated:YES];
        [Tool myalters:@"成功退出"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginAfterDoSometing" object:nil];
    }
    
}

//提现密码
- (void)didClickOnButtonIndex:(NSInteger *)buttonIndex{
    if (buttonIndex==0) {
        ChangeTiKuanCodeViewController *change = [[ChangeTiKuanCodeViewController alloc] init];
        change.title = @"修改提现密码";
        UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
        backItem.title=@"返回";
        self.navigationItem.backBarButtonItem=backItem;
        [self.navigationController pushViewController:change animated:YES];
    }else if (buttonIndex==1){
        ChangeMoblieViewController *change = [[ChangeMoblieViewController alloc] init];
        change.type = 1;
        change.title = @"找回提现密码";
        //返回
        UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
        backItem.title=@"返回";
        self.navigationItem.backBarButtonItem=backItem;
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:change animated:YES];
    }
}




@end
