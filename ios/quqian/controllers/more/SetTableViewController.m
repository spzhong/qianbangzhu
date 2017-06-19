//
//  SetTableViewController.m
//  quqian
//
//  Created by apple on 15/3/24.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SetTableViewController.h"
#import "EGOImageView.h"
#import "DemoViewController.h"
#import "LXActionSheet.h"
#import "MBProgressHUD+Add.h"
#import "LoginTableViewController.h"


@interface SetTableViewController ()<DemoViewControllerDeleagete,LXActionSheetDelegate>

@end

@implementation SetTableViewController
- (instancetype)initWithStyle:(UITableViewStyle)style{
    return self = [super initWithStyle:UITableViewStyleGrouped];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */





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
    }else if (section==1){
        return 1;
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
    
    EGOImageView*imgView =[[EGOImageView alloc] init];
    imgView.frame = CGRectMake(15, 15, 50, 50);
    UILabel *lab123 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(16.5, 0, [Tool adaptation:200 with6:55 with6p:94], 45) Alignment:NSTextAlignmentLeft  FontFl:15];
    lab123.font = FOUR_CONTROL_FONT;
    UILabel *lab1234 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(80, 0, [Tool adaptation:200 with6:55 with6p:94], 45) Alignment:NSTextAlignmentRight  FontFl:14];
    [cell.contentView addSubview:lab123];
    [cell.contentView addSubview:lab1234];
    [cell.contentView addSubview:imgView];
    [lab1234 setTextColor:[UIColor darkGrayColor]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    if (section==0) {
        
        
        if (row==0) {
            
            lab123.text = @"修改手势密码";
            
            
        }else if (row==1){
            
            lab123.text = @"检查更新";
            
        }
        
        
    }else if (section==1) {
//        
//        lab123.text = @"退出";
//        lab123.textColor = [UIColor whiteColor];
//        [lab123 setBackgroundColor:[UIColor colorWithRed:2/255.0 green:160/255.0 blue:219/255.0 alpha:1]];
//        lab123.textAlignment = NSTextAlignmentCenter;
//        lab123.frame = CGRectMake(0, 0, [Tool adaptation:320 with6:55 with6p:94], 45);
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.accessoryType = UITableViewCellAccessoryNone;
//      
        
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if (section==0) {
        if (row==0) {
            
            //判断是否已经登录了
            //数据为空－－－需要登录啊
            if ([Tool getUser]==nil) {
                LoginTableViewController *loginView = [[LoginTableViewController alloc] init];
                loginView.title = @"登录";
                UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:loginView];
                [self presentViewController:na animated:YES completion:NULL];
                return;
            }
            
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
            
        }else if (row==1){
            
            [MBProgressHUD showSuccess:@"当前版本是最新版本" toView:nil];
            
        }
    }
    
    
    if ( section==1 ) {
        
        LXActionSheet *actionSheet = [[LXActionSheet alloc]initWithTitle:@"退出后不会删除任何历史数据,下次登录依然可以使用本账号" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出登录" otherButtonTitles:nil];
        [actionSheet showInView:self.view];
        
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


//退出操作
- (void)didClickOnButtonIndex:(NSInteger *)buttonIndex{
    if (buttonIndex==0) {
        
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"curLoginUserId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    
        [self.navigationController popToRootViewControllerAnimated:YES];
        [MBProgressHUD showSuccess:@"成功退出" toView:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginAfterDoSometing" object:nil];
    }
}


//退出
-(void)tuichu{
    
    //[self.tabBarController setSelectedIndex:0];
}



@end
