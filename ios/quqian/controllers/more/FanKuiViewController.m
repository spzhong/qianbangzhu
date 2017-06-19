//
//  FanKuiViewController.m
//  quqian
//
//  Created by apple on 15/3/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "FanKuiViewController.h"
#import "HelpDownloader.h"
#import "MBProgressHUD+Add.h"

@interface FanKuiViewController ()
{
    NSString *text;
    NSString *lianxi;
}
@end

@implementation FanKuiViewController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    return self = [super initWithStyle:UITableViewStyleGrouped];
}


//提交 -- 意见反馈
-(void)tijiao{
    [self yijianfankui__startRequest];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIBarButtonItem *rightBtnItem2 = [[UIBarButtonItem alloc] initWithTitle:@"提交 " style:UIBarButtonItemStylePlain target:self action:@selector(tijiao)];
    NSArray *buttonItemArray2 = [NSArray arrayWithObjects:rightBtnItem2, nil];
    self.navigationItem.rightBarButtonItems=buttonItemArray2;
    
    
    text = @"10~200字以内";
    lianxi = @"";
    
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
    
    if ([Tool getUser] != nil) {
        return 1;
    }
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
    if (indexPath.section==0) {
        return 120;
    }
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
    
    UILabel *lab123 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(16.5, 0, [Tool adaptation:200 with6:55 with6p:94], 45) Alignment:NSTextAlignmentLeft  FontFl:15];
    lab123.font = FOUR_CONTROL_FONT;
    UILabel *lab1234 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(16.5, 0, [Tool adaptation:280 with6:55 with6p:94], 45) Alignment:NSTextAlignmentRight  FontFl:12];
    [cell.contentView addSubview:lab123];
    [cell.contentView addSubview:lab1234];
    [lab1234 setTextColor:[UIColor darkGrayColor]];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (section==0) {
        
        UITextView *textView = [Tool TextViewProductionFunction:@"" Frame:CGRectMake(15,10, 290, 80) FontFl:15];
        [cell.contentView addSubview:textView];
        textView.text = text;
        textView.delegate = self;
        textView.tag = 100;
        if ([textView.text isEqualToString:@"10~200字以内"]) {
            textView.textColor = [UIColor grayColor];
        }
       
    }else if (section==1) {
        
        UITextField *textField = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(22.5+42,8, [Tool adaptation:275-52 with6:55 with6p:94], 44)  FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
        [cell.contentView addSubview:textField];
        textField.frame = CGRectMake(15,0, [Tool adaptation:2650 with6:55 with6p:94], 45);
        textField.placeholder = @"请留下您的联系方式  QQ/手机/邮箱";
        textField.tag = 101;
        textField.text = lianxi;
        
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
}


//获取输入框的tag值
-(UIView *)getCellSubObjectwithTag:(int)tag withIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UIView *view = [cell.contentView viewWithTag:tag];
    return view;
}



//结束的操作
- (void)textFieldDidEndEditing:(UITextField *)textField{
    lianxi = textField.text;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    
    if ([textView.text isEqualToString:@"10~200字以内"]) {
         textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length==0) {
         text = @"10~200字以内";
        [self.tableView reloadData];
    }else{
        text = textView.text;
    }
}


//意见反馈
-(void)yijianfankui__startRequest{

    UITextView *text2 = (UITextView *)[self getCellSubObjectwithTag:100 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [text2 resignFirstResponder];
    UITextField *text1 = (UITextField *)[self getCellSubObjectwithTag:101 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    [text1 resignFirstResponder];
    
    if (text2.text.length < 10 || text2.text.length >200  || [text2.text isEqualToString:@"10~200字以内"]) {
        [Tool myalter:@"反馈信息字数在10~200字以内"];
        return;
    }
    
    
    //数据为空－－－需要登录啊
    if ([Tool getUser]==nil) {
        if (text1.text.length==0) {
            [Tool myalter:@"请输入您的联系方式"];
            return;
        }
    }
    
     
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/yjfk.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
   
    [postDic setObject:text2.text forKey:@"yjnr"];
    
    if (text1.text.length>0) {
        [postDic setObject:text1.text forKey:@"lxfs"];
    }
    
    
    
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"yes",@"isshowHUD",
                                           @"no",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   
                                   if (kk==0) {
                                       
                                       
                                       if ([[[data JSONValue] objectForKey:@"code"] intValue] ==0) {
                                           
                                           [MBProgressHUD showSuccess:[[data JSONValue] objectForKey:@"msg"]  toView:nil];
                                           
                                       }else{
                                           
                                           //提交信息
                                           [Tool myalter:[[data JSONValue] objectForKey:@"msg"]];
                                       }
                                       
                                       
                                   }else{
                                       
                                   }
                                   
                               }];
    
}





@end
