//
//  WoyaojiekuanViewController.m
//  qianbangzhu
//
//  Created by 宋培众 on 2017/6/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WoyaojiekuanViewController.h"
#import "Tool.h"
#import "MBProgressHUD.h"
#import "HelpDownloader.h"
#import "MBProgressHUD+Add.h"

@interface WoyaojiekuanViewController ()<UIActionSheetDelegate>
{
    NSString *jiekuanleixing;
    
    NSString *text01;
    NSString *text02;
    NSString *text03;
    NSString *text04;
    NSString *text05;
    NSString *text06;
}
@end

@implementation WoyaojiekuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *bgHead = [Tool ViewProductionFunction:CGRectMake(0, 0, ScreenWidth, 200) BgColor:nil];
    UIImageView *img =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"我要借款banner.jpg"]];
    img.frame = CGRectMake(0, 0, ScreenWidth, 150);
    [bgHead addSubview:img];
    
    UILabel *labInfo = [Tool LablelProductionFunction:@"目前只接受广东地区的借款申请" Frame:CGRectMake(0, 150, ScreenWidth, 50) Alignment:NSTextAlignmentCenter  FontFl:15];
    labInfo.textColor = RGB(51, 51, 51);
    [labInfo setBackgroundColor:RGB(240, 253, 255)];
    [bgHead addSubview:labInfo];
    self.tableView.tableHeaderView = bgHead;
    
    
    
    UIButton *but = [Tool ButtonProductionFunction:@"立即申请" Frame:CGRectMake(0, 0, ScreenWidth, 50) bgImgName:nil FontFl:15];
    [but setBackgroundColor:RGB(60, 154, 235)];
    [but addTarget:self action:@selector(butPress) forControlEvents:UIControlEventTouchUpInside];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.tableView.tableFooterView = but;
    self.tableView.tableFooterView.userInteractionEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)butPress{
    [self.view endEditing:YES];
    
    UITableViewCell *cell0 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITableViewCell *cell1 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UITableViewCell *cell2 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    UITableViewCell *cell3 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    UITableViewCell *cell4 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    
    UITextField *text0 = [cell0 viewWithTag:100];
    UITextField *text1 = [cell1 viewWithTag:101];
    UITextField *text2 = [cell2 viewWithTag:102];
    UITextField *text3 = [cell3 viewWithTag:103];
    UITextField *text4 = [cell4 viewWithTag:104];
    
    if (text0.text.length==0) {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:nil message:@"请输入您的姓名" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [al show];
        return;
    }
    if (text1.text.length==0) {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:nil message:@"请输入您的手机号" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [al show];
        return;
    }
    if (text2.text.length==0) {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:nil message:@"请输入借款金额" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [al show];
        return;
    }
    if (text3.text.length==0) {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:nil message:@"请预期筹款期限" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [al show];
        return;
    }
    if (text4.text.length==0) {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:nil message:@"请输入您所在的城市" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [al show];
        return;
    }
    
    if (jiekuanleixing==nil) {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:nil message:@"请选择借款类型" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [al show];
        return;
    }
    
   
    
    NSString *url =[NSString stringWithFormat:@"%@/wyjk.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:text0.text forKey:@"xm"];
    [postDic setObject:text1.text forKey:@"sjh"];
    [postDic setObject:text2.text forKey:@"jkje"];
    [postDic setObject:text3.text forKey:@"ckqx"];
    [postDic setObject:text4.text forKey:@"cs"];
    [postDic setObject:jiekuanleixing forKey:@"jklx"];
     
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"no",@"isshowHUD",
                                           @"no",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   if (kk==0) {
                                       
                                       if ([[data JSONValue][@"code"] intValue] ==0) {
                                        [self.navigationController popViewControllerAnimated:YES];
                                        
                                           [MBProgressHUD  showSuccess:[data JSONValue][@"msg"] toView:nil];
                                           
                                       }else{
                                           [Tool myalter:[data JSONValue][@"msg"]];
                                       }
                                   }
                               }];
    
}





- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    NSInteger row = [indexPath row];
    
    NSArray *viewArray = [cell.contentView subviews];
    for (int i = 0; i < [viewArray count]; i++) {
        UIView *view = [viewArray objectAtIndex:i];
        [view removeFromSuperview];view=nil;
    }
    
    UILabel *lab123 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(0, 0, ScreenWidth/2-20, 56) Alignment:NSTextAlignmentRight  FontFl:15];
    [cell.contentView addSubview:lab123];
    
    UITextField *text = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(ScreenWidth/2, 0, ScreenWidth/2, 56) FontFl:15 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    text.tag = 100 + indexPath.row;
    [cell.contentView addSubview:text];
    
    if (row==0) {
        lab123.text = @"姓名";
        text.placeholder = @"请输入您的姓名";
        if (text01.length>0) {
            text.text = text01;
        }
    }else if (row==1) {
        lab123.text = @"手机号";
        text.placeholder = @"请输入您的手机";
        if (text02.length>0) {
            text.text = text02;
        }
    }else if (row==2) {
        lab123.text = @"借款金额";
        text.placeholder = @"请输入借款金额（元）";
        if (text03.length>0) {
            text.text = text03;
        }
    }else if (row==3) {
        lab123.text = @"预期筹款期限";
        text.placeholder = @"请输入筹款期限（天）";
        if (text04.length>0) {
            text.text = text04;
        }
    }else if (row==4) {
        lab123.text = @"所在城市";
        text.placeholder = @"请输入您所在的城市";
        if (text05.length>0) {
            text.text = text05;
        }
    }else if (row==5) {
        lab123.text = @"借款类型";
        text.placeholder = @"请选择借款类型";
        text.enabled = NO;
        if (text06.length>0) {
            text.text = text06;
        }
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row==5) {
        // 按钮比较多时,将按钮标题放在数组中遍历插入
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: nil];
        [actionSheet addButtonWithTitle:@"个人借款"];
        [actionSheet addButtonWithTitle:@"企业借款"];
        [actionSheet showInView:self.view];
    }
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        jiekuanleixing = @"GRKH";
        text06 = @"个人借款";
    }else if (buttonIndex==1) {
        jiekuanleixing = @"QYKH";
        text06 = @"企业借款";
    }
    [self.tableView reloadData];
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag==100) {
        text01 = textField.text;
    }else if (textField.tag==101) {
        text02 = textField.text;
    }else if (textField.tag==102) {
        text03 = textField.text;
    }else if (textField.tag==103) {
        text04 = textField.text;
    }else if (textField.tag==104) {
        text05 = textField.text;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
