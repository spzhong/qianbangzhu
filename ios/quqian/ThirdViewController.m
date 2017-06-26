//
//  ThirdViewController.m
//  quqian
//
//  Created by apple on 15/3/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ThirdViewController.h"
#import "EGOImageView.h"
#import "DemoViewController.h"
#import "MBProgressHUD+Add.h"
#import "SaveInfoViewController.h"
#import "FanKuiViewController.h"
#import "SetTableViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

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
    return 2;
    
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
    imgView.frame = CGRectMake(15, 12.5, 20, 20);
    UILabel *lab123 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(50, 0, [Tool adaptation:200 with6:55 with6p:94], 45) Alignment:NSTextAlignmentLeft  FontFl:15];
    lab123.textColor = RGB(150, 150, 150);
    
    UILabel *lab1234 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(0, 0, ScreenWidth, 45) Alignment:NSTextAlignmentCenter  FontFl:14];
    [cell.contentView addSubview:lab123];
    [cell.contentView addSubview:lab1234];
    [cell.contentView addSubview:imgView];
    [lab1234 setTextColor:KTHCOLOR];
    
    UILabel *lab122 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(0, 0, ScreenWidth-15, 45) Alignment:NSTextAlignmentRight  FontFl:14];
    [cell.contentView addSubview:lab122];
    [lab122 setTextColor:[UIColor darkGrayColor]];
    
    if (row==0) {
        imgView.image = [UIImage imageNamed:@"客服热线"];
        lab123.text = @"客服热线";
        lab1234.text = @"400-880-5306";
        lab122.text = @"客服工作时间\n09:00-21:00";
        
    }else if (row==1){
        lab123.text = @"意见反馈";
        imgView.image = [UIImage imageNamed:@"意见反馈"];
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
         
            UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"是否拨打客服热线" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            [al show];
            
        }else if (row==1){
         
            FanKuiViewController *fankui = [[FanKuiViewController alloc] init];
            fankui.title = @"意见反馈";
            //返回
            UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
            backItem.title=@"返回";
            self.navigationItem.backBarButtonItem=backItem;
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:fankui animated:YES];
            self.hidesBottomBarWhenPushed=NO;
            
        }
    }
    
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        
    }else{
        
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"400-880-5306"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }
}
 



@end
