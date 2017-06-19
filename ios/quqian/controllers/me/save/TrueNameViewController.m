//
//  TrueNameViewController.m
//  quqian
//
//  Created by apple on 15/3/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "TrueNameViewController.h"
#import "EGOImageView.h"
#import "UserModel.h"
#import "HelpDownloader.h"
#import "MBProgressHUD+Add.h"


@interface TrueNameViewController ()
{
    NSString *trueName;
    NSString *cardNum;
}
@end

@implementation TrueNameViewController

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
    
    trueName = @"";
    cardNum = @"";
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
        return 2;
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
    imgView.frame = CGRectMake(15, 10.5, 24, 24);
    [cell.contentView addSubview:imgView];
    
    UILabel *lab123 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(16.5, 0, [Tool adaptation:200 with6:55 with6p:94], 45) Alignment:NSTextAlignmentLeft  FontFl:15];
    lab123.font = FOUR_CONTROL_FONT;
    [cell.contentView addSubview:lab123];

    
 
    
    if (section==0) {
        
        UITextField *textField = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(60,0, [Tool adaptation:220 with6:55 with6p:94], 45)  FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
        [cell.contentView addSubview:textField];
        
        if (row==0) {
            
            imgView.image = [UIImage imageNamed:@"icon20.png"];
            textField.placeholder = @"请输入真实姓名";
            textField.tag = 100;
            textField.text = trueName;
            
        }else if (row==1){
            imgView.image = [UIImage imageNamed:@"icon20.png"];
            textField.placeholder = @"请输入身份证号";
            textField.tag = 101;
            textField.text = cardNum;
        }
    }else{
        lab123.text = @"完成";
        lab123.textColor = [UIColor whiteColor];
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
  
    
    if (section==1) {
        //保存
        [self finshToSave];
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
        trueName = textField.text;
    }else if (textField.tag==101){
        cardNum = textField.text;
    }
}



//判断信息
-(void)finshToSave{
    
    UITextField *textField1 = (UITextField *)[self getCellSubObjectwithTag:100 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField *textField2 = (UITextField *)[self getCellSubObjectwithTag:101 withIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [textField1 resignFirstResponder];
    [textField2 resignFirstResponder];
    
    if (textField1.text.length==0) {
        [Tool myalter:@"请输入真实姓名"];
        return;
    }
    if (textField2.text.length==0) {
        [Tool myalter:@"请输入您的身份证号"];
        return;
    }
    
    //网络请求
    [self trueName_startRequest];
    
}




//实名认证
-(void)trueName_startRequest{
    
    UITextField *textField = (UITextField *)[self getCellSubObjectwithTag:100 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField *textField1 = (UITextField *)[self getCellSubObjectwithTag:101 withIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [textField resignFirstResponder];
    [textField1 resignFirstResponder];
    
 
    NSString *url =[NSString stringWithFormat:@"%@/user/zhaq/smrz.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    [postDic setObject:textField.text forKey:@"zsxm"];
    [postDic setObject:textField1.text forKey:@"sfzh"];
    
    
        
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
                                               
                                               UserModel *user =  [Tool getUser];
                                               user.trueName = trueName;
                                               user.cardNum = cardNum;
                                               user.sfzsfrz = @"true";
                                               [Tool savecoredata];
                                               
                                               [self.navigationController popViewControllerAnimated:YES];
                                           }
                                           
                                           [MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:nil];
                                           
                                       }else{
                                           
                                       }
                                   }];
 
}



@end
