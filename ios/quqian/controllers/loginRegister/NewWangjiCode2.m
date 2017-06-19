//
//  NewWangjiCode2.m
//  quqian
//
//  Created by apple on 15/4/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NewWangjiCode2.h"
#import "EGOImageView.h"
#import "Tool.h"
#import "HelpDownloader.h"
#import "MBProgressHUD+Add.h"
#import "ReCodeTableViewController.h"


@interface NewWangjiCode2 (){
    BOOL isHuoqu;
    int count;
    NSString *code;
}

@end

@implementation NewWangjiCode2
@synthesize myTimer,mobile;


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
 
    isHuoqu = YES;
    count = 60;
    code = @"";
    //倒计时
    [self getPhoneCodeSece];
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
    imgView.frame = CGRectMake(15, 10.5, 24, 24);
    [cell.contentView addSubview:imgView];
    
    UILabel *lab123 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(0, 0, [Tool adaptation:320 with6:55 with6p:94], 45) Alignment:NSTextAlignmentCenter  FontFl:15];
    lab123.font = [UIFont systemFontOfSize:12];
    [cell.contentView addSubview:lab123];
    
    
    if (section==0) {
        
        NSMutableString *string = [NSMutableString string];
        if (self.mobile.length==11) {
            [string appendString:[self.mobile substringToIndex:3]];
            [string appendString:@"****"];
            [string appendString:[self.mobile substringFromIndex:[self.mobile length]-4]];
        }
        
        lab123.text = [NSString stringWithFormat:@"已发送验证码至您的手机号%@", string];
            
       
    }else if(section==1){
        
        imgView.image = [UIImage imageNamed:@"icon15.png"];
        
        
        UITextField *textField = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(60,0, [Tool adaptation:120 with6:55 with6p:94], 45)  FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
        [cell.contentView addSubview:textField];
        textField.placeholder = @"请输入验证码";
        textField.tag = 100;
        textField.text = code;
        
        UIButton *buton = [UIButton buttonWithType:UIButtonTypeCustom];
        buton.tag = 10005;
        buton.frame = CGRectMake(210, 8.5, 91, 28);
        buton.titleLabel.font = [UIFont systemFontOfSize:12];
        [buton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [cell.contentView addSubview:buton];
        [buton addTarget:self action:@selector(getPhoneCode_startRequest:) forControlEvents:UIControlEventTouchUpInside];
        
        if (isHuoqu) {
            
            [buton setTitleColor:[UIColor colorWithRed:2/255.0 green:160/255.0 blue:219/255.0 alpha:1] forState:UIControlStateNormal];
            buton.enabled = YES;
            [buton setBackgroundImage:[UIImage imageNamed:@"button5.png"] forState:UIControlStateNormal];
        }else{
            [buton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            buton.enabled = NO;
            [buton setBackgroundImage:[UIImage imageNamed:@"button6.png"] forState:UIControlStateNormal];
        }
        
        
    }else if (section==2){
        lab123.text = @"下一步";
        lab123.textColor = [UIColor whiteColor];
        lab123.font = FOUR_CONTROL_FONT;
        [lab123 setBackgroundColor:[UIColor colorWithRed:2/255.0 green:160/255.0 blue:219/255.0 alpha:1]];
        lab123.textAlignment = NSTextAlignmentCenter;
        lab123.frame = CGRectMake(0, 0, [Tool adaptation:320 with6:55 with6p:94], 45);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if (section==2) {
        //获取验证码
        [self yanzhengPhoneCode_startRequest];
    }
    
}



//获取输入框的tag值
-(UIView *)getCellSubObjectwithTag:(int)tag withIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UIView *view = [cell.contentView viewWithTag:tag];
    return view;
}



//获取验证码成功后
-(void)getPhoneCodeSece{
    isHuoqu = NO;
    UIButton *huoqu = (UIButton *)[self getCellSubObjectwithTag:10005 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    [huoqu setTitle:@"重新获取(60)秒" forState:UIControlStateNormal];
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dynamicAnimatorShowlab) userInfo:nil repeats:YES];
    huoqu.enabled = NO;
    
    
}

//开始降低数据－60
-(void)dynamicAnimatorShowlab{
    
    UIButton *huoqu = (UIButton *)[self getCellSubObjectwithTag:10005 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    count--;
    if (count==0) {
        [self.myTimer invalidate];
        self.myTimer= nil;
        count = 60;
        isHuoqu = YES;
        [huoqu setTitle:@"获取验证码" forState:UIControlStateNormal];
        huoqu.enabled = YES;
    }else{
        huoqu.enabled = NO;
        [huoqu setTitle:[NSString stringWithFormat:@"重新获取(%d)秒",count] forState:UIControlStateNormal];
    }
    //[self.tableView reloadData];
}



- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag==100) {
        code = textField.text;
    }
}





//获取手机验证码
-(void)getPhoneCode_startRequest:(UIButton *)button{
    
    
    if ([Tool isMobilePhone:self.mobile]) {
        NSString *url =[NSString stringWithFormat:@"%@/sendMsg.htm",BASE_URL];
        NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
        //忘记密码
        [postDic setObject:@"1" forKey:@"type"];
        [postDic setObject:self.mobile forKey:@"phone"];
        
        
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
                                               
                                               //继续倒计时
                                               [self getPhoneCodeSece];
                                               
                                           }else{
                                               
                                               [MBProgressHUD showError:[rootDic objectForKey:@"msg"] toView:nil];
                                           }
                                           
                                   
                                           
                                       }else{
                                           
                                       }
                                   }];
    }
}





//验证手机验证码
-(void)yanzhengPhoneCode_startRequest{
    
    UITextField *textField = (UITextField *)[self getCellSubObjectwithTag:100 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    [textField resignFirstResponder];
    
    if (textField.text.length==0) {
        [Tool myalter:@"请输入短信验证码"];
        return;
    }
    
        NSString *url =[NSString stringWithFormat:@"%@/verifyMsg.htm",BASE_URL];
        NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
        //忘记密码
        [postDic setObject:@"1" forKey:@"type"];
        
        [postDic setObject:self.mobile forKey:@"phone"];
        [postDic setObject:textField.text forKey:@"code"];
        
        
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
                                               
                                              
                                               ReCodeTableViewController *queren = [[ReCodeTableViewController alloc] init];
                                               queren.phone = self.mobile;
                                               queren.key = [dic objectForKey:@"rvalue"];
                                               queren.title = @"设置新的密码";
                                               UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
                                               backItem.title=@"返回";
                                               self.navigationItem.backBarButtonItem=backItem;
                                               [self.navigationController pushViewController:queren animated:YES];
                                               
                                               
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







@end
