//
//  NewWangjiCode.m
//  quqian
//
//  Created by apple on 15/4/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NewWangjiCode.h"
#import "EGOImageView.h"
#import "Tool.h"
#import "NewWangjiCode2.h"
#import "HelpDownloader.h"
#import "MBProgressHUD+Add.h"


@implementation NewWangjiCode


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
    
    
    name = @"";
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 1;
    }
    return 0;
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
    imgView.frame = CGRectMake(15, 10.5, 24, 24);
    [cell.contentView addSubview:imgView];
    
    UILabel *lab123 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(0, 0, [Tool adaptation:320 with6:55 with6p:94], 45) Alignment:NSTextAlignmentCenter  FontFl:15];
    lab123.font = FOUR_CONTROL_FONT;
    [cell.contentView addSubview:lab123];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (section==0) {
        
        imgView.image = [UIImage imageNamed:@"icon15.png"];
        
        UITextField *textField = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(22.5+42,8, [Tool adaptation:275-52 with6:55 with6p:94], 44)  FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
        [cell.contentView addSubview:textField];
        textField.frame = CGRectMake(60,0, [Tool adaptation:190 with6:55 with6p:94], 45);
        textField.placeholder = @"请输入您绑定的手机号";
        textField.tag = 100;
        textField.text = name;
        
        
    }else if (section==1) {
        
        if (row==0) {
            
            lab123.text = @"下一步";
            lab123.textColor = [UIColor whiteColor];
            [lab123 setBackgroundColor:[UIColor colorWithRed:2/255.0 green:160/255.0 blue:219/255.0 alpha:1]];
            lab123.textAlignment = NSTextAlignmentCenter;
            lab123.frame = CGRectMake(0, 0, [Tool adaptation:320 with6:55 with6p:94], 45);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
           
        }
        
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if (section==1) {
        UITextField *text = (UITextField *)[self getCellSubObjectwithTag:100 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [text resignFirstResponder];
    
        //获取验证码
        [self getPhoneCode_startRequest:nil];
    
    }
  
}


//获取输入框的tag值
-(UIView *)getCellSubObjectwithTag:(int)tag withIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UIView *view = [cell.contentView viewWithTag:tag];
    return view;
}



- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag==100) {
        name = textField.text;
    }
}




//获取手机验证码
-(void)getPhoneCode_startRequest:(UIButton *)button{
    
    UITextField *textField = (UITextField *)[self getCellSubObjectwithTag:100 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [textField resignFirstResponder];
    
    
    if ([Tool isMobilePhone:textField.text]) {
        NSString *url =[NSString stringWithFormat:@"%@/sendMsg.htm",BASE_URL];
        NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
        //忘记密码
        [postDic setObject:@"1" forKey:@"type"];
        [postDic setObject:textField.text forKey:@"phone"];
        
        
        //发送网路请求
        [[HelpDownloader shared] startRequest:url withbody:postDic
                                       isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                               @"yes",@"isConnectedToNetwork",
                                               @"yes",@"isshowHUD",
                                               @"yes",@"islockscreen",
                                               @"post",@"isrequesType",
                                               nil]
                                   completion:^void(id data,int kk){
                                       
                                       NSDictionary *rootDic = [data JSONValue];
                                       NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:rootDic];
                                       
                                       
                                       if (kk==0) {
                                           //之行正确操作
                                           if ([[dic objectForKey:@"code"] intValue] == 0) {
                                               
                                               
                                               [MBProgressHUD showSuccess:[rootDic objectForKey:@"msg"] toView:nil];
                                               
                                               //进入输入密码的页面
                                               NewWangjiCode2 *code2 = [[NewWangjiCode2 alloc] init];
                                               code2.title = @"验证手机";
                                               code2.mobile =textField.text;
                                               
                                               //返回
                                               UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
                                               backItem.title=@"返回";
                                               self.navigationItem.backBarButtonItem=backItem;
                                               self.hidesBottomBarWhenPushed=YES;
                                               [self.navigationController pushViewController:code2 animated:YES];
         
                                               //销毁倒数第二个页面
                                               NSMutableArray *newArray = [[NSMutableArray alloc] init];
                                               NSArray *array = [self.navigationController viewControllers];
                                               for (int i = 0; i < [array count] ; i++) {
                                                   if (i == [array count]-2) {
                                                       continue;
                                                   }
                                                   [newArray addObject:[array objectAtIndex:i]];
                                               }
                                               self.navigationController.viewControllers = newArray;
                                               

                                               
                                               
                                           }else{
                                               
                                               [MBProgressHUD showError:[rootDic objectForKey:@"msg"] toView:nil];
                                           }
                                           
                                                                                     
                                           
                                       }else{
                                           
                                       }
                                   }];
    }
}






@end
