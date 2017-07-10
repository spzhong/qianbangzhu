

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
#import "UtilityUI.h"
#import "DemoViewController.h"
#import "XiugaidenglumimViewController.h"


@interface SaveInfoViewController ()<LXActionSheetDelegate,DemoViewControllerDeleagete>
{
    UserModel *user;
}
@end

@implementation SaveInfoViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tableView reloadData];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
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
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    UIButton *but = [Tool ButtonProductionFunction:@"退出账户" Frame:CGRectMake(15, 0, ScreenWidth-30, 35) bgImgName:nil FontFl:15];
    [but setBackgroundColor:RGB(250, 135, 36)];
    [bgView addSubview:but];
    [but addTarget:self action:@selector(tuichu) forControlEvents:UIControlEventTouchUpInside];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [UtilityUI setBorderOnView:but borderColor:nil borderWidth:0 cornerRadius:5];
    
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    }
    if ([user.iscloseshoushimia isEqualToString:@"y"]) {
        return 1;
    }
    return 2;
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
    
    
    
    UIImageView *headview = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12.5, 20, 20)];
    [cell.contentView addSubview:headview];
    
    
    
    UILabel *lab123 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(50, 0, [Tool adaptation:200 with6:55 with6p:94], 45) Alignment:NSTextAlignmentLeft  FontFl:15];
    lab123.textColor = RGB(51, 51, 51);
    UILabel *lab1234 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(0, 0, [Tool adaptation:320 with6:55 with6p:94], 45) Alignment:NSTextAlignmentCenter  FontFl:14];
    
    UILabel *lab12345 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(80, 0, [Tool adaptation:210 with6:55 with6p:94], 45) Alignment:NSTextAlignmentRight  FontFl:14];
    
    [cell.contentView addSubview:lab12345];
    [cell.contentView addSubview:lab123];
    [cell.contentView addSubview:lab1234];
    [lab1234 setTextColor:[UIColor darkGrayColor]];
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (section==0) {
        
        if (row==0) {
            headview.image = [UIImage imageNamed:@"实名认证.png"];
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
            headview.image = [UIImage imageNamed:@"手机号码.png"];
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
            headview.image = [UIImage imageNamed:@"登录密码.png"];
            lab123.text = @"登录密码";
            lab1234.text = @"已设置";
            lab12345.text = @"修改";
            [lab1234 setTextColor:[UIColor darkGrayColor]];
            [lab12345 setTextColor:[UIColor colorWithRed:0 green:130/255.0 blue:182/255.0 alpha:1.0]];
        }
        
    }else{
        if (row==0) {
            lab123.text = @"手势密码";
            cell.accessoryType = UITableViewCellAccessoryNone;
            //开关
            UISwitch *bgColor = [[UISwitch alloc] initWithFrame:CGRectMake(ScreenWidth-70, 7, 60, 30)];
            if ([user.iscloseshoushimia isEqualToString:@"y"]) {
                [bgColor setOn:NO];
            }else{
                [bgColor setOn:YES];
            }
            bgColor.tag = 108;
            bgColor.userInteractionEnabled = YES;
            [bgColor addTarget:self action:@selector(UISwitchPress) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:bgColor];
            
        }else{
            lab123.text = @"修改手势密码";
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    //NSInteger section = indexPath.section;
    
    if (indexPath.section==1) {
        if (row==1) {
            
            DemoViewController *demo = [[DemoViewController alloc] init];
            demo.title = @"输入密码";
            demo.type = 2;
            demo.doting = @"yinchang";
            demo.deleagete = self;
            //返回
            UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
            backItem.title=@"返回";
            self.navigationItem.backBarButtonItem=backItem;
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:demo animated:YES];
        }
        return;
    }
    
    
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
    
        XiugaidenglumimViewController *xiugiisd = [[XiugaidenglumimViewController alloc] init];
        
        xiugiisd.title = @"修改登录密码";
        //返回
        UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
        backItem.title=@"返回";
        self.navigationItem.backBarButtonItem=backItem;
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:xiugiisd animated:YES];
        
    }else if (row==3){
    
          
    }
    
}



//设置手势成功后的操作
-(void)Success:(NSString *)doting{
    
    
    DemoViewController *demo = [[DemoViewController alloc] init];
    demo.title = @"输入新的密码";
    demo.type = 0;
    demo.doting = @"reCode";
    demo.deleagete = self;
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:demo animated:NO];
    
    
}
//设置手势失败的操作
-(void)Failure:(NSString *)doting{
    
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



-(void)UISwitchPress{
    if ([user.iscloseshoushimia isEqualToString:@"y"]) {
        user.iscloseshoushimia = @"n";
    }else{
        user.iscloseshoushimia = @"y";
    }
    [self.tableView reloadData];
}


@end
