//
//  TiXianTableViewController.m
//  quqian
//
//  Created by apple on 15/4/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "TiXianTableViewController.h"
#import "EGOImageView.h"
#import "UserModel.h"
#import "OkTiXianTableViewController.h"
#import "BangYinHangViewController.h"
#import "HelpDownloader.h"



@interface TiXianTableViewController ()
{
    UserModel *user;
    NSString *money;
    NSString *code;
    NSString *bankAndNumber;
    NSString *shijizhifujine;
    NSString *tixianshouxufei;
    NSString *bankCardId;
}
@end

@implementation TiXianTableViewController
@synthesize dic;

- (instancetype)initWithStyle:(UITableViewStyle)style{
    return self = [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    money=@"";
    code=@"";
    shijizhifujine = @"0.00";
    tixianshouxufei = @"0.00";
    
    if ([[self.dic objectForKey:@"bankCardId"] isEqualToString:@""]) {
        bankAndNumber = @"";
    }else{
        bankAndNumber = [NSString stringWithFormat:@"%@ %@",[self.dic objectForKey:@"bankName"],[self.dic objectForKey:@"bankNumber"]];
        bankCardId = [self.dic objectForKey:@"bankCardId"];
    }
    
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]];
    
    user = [Tool getUser];
    
    //超时
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bangdingbankname:) name:@"bangdingbankname" object:nil];
  
}

//绑定后的通知
-(void)bangdingbankname:(NSNotification *)not{
    NSDictionary *dicbank = [not userInfo];
    bankCardId = [dicbank objectForKey:@"bankCardId"];
    [self.dic setObject:bankCardId forKey:@"bankCardId"];
    [self.dic setObject:[dicbank objectForKey:@"bankName"] forKey:@"bankName"];
    [self.dic setObject:[dicbank objectForKey:@"bankNum"] forKey:@"bankNumber"];
    bankAndNumber = [NSString stringWithFormat:@"%@ %@",[dicbank objectForKey:@"bankName"],[dicbank objectForKey:@"bankNum"]];
    [self.dic setObject:@"1" forKey:@"isFull"];
    
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 45;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==2) {
        return 35;
    }
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }else if (section==1){
        return 2;
    }else if (section==2){
        return 1;
    }else if (section==3){
        return 1;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;{
    
    if (section==0) {
        
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
        UILabel *lab = [Tool LablelProductionFunction:@"提现银行卡" Frame:CGRectMake(15, 0, [Tool adaptation:200 with6:55 with6p:94], 45) Alignment:NSTextAlignmentLeft  FontFl:15];
        lab.font= FOUR_CONTROL_FONT;
        [bg addSubview:lab];
        return bg;
  
    }else if (section==3){
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
        UILabel *lab = [Tool LablelProductionFunction:@"1-2个工作日到账（双休日和法定节假日除外）" Frame:CGRectMake(0, -35, [Tool adaptation:320 with6:55 with6p:94], 45) Alignment:NSTextAlignmentCenter  FontFl:12];
        lab.textColor = [UIColor grayColor];
        [bg addSubview:lab];
        return bg;
        
    }
    
    return nil;
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
    imgView.frame = CGRectMake(15, 12, 21, 21);
    UILabel *lab123 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(16.5, 0, [Tool adaptation:200 with6:55 with6p:94], 45) Alignment:NSTextAlignmentLeft  FontFl:15];
    lab123.font = FOUR_CONTROL_FONT;
    UILabel *lab1234 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(125, 0, [Tool adaptation:200 with6:55 with6p:94], 45) Alignment:NSTextAlignmentLeft  FontFl:14];
    [cell.contentView addSubview:lab123];
    [cell.contentView addSubview:lab1234];
    [cell.contentView addSubview:imgView];
    [lab1234 setTextColor:[UIColor darkGrayColor]];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    UILabel *lab2= [Tool LablelProductionFunction:@"" Frame:CGRectMake(110, 0, [Tool adaptation:200 with6:55 with6p:94], 45) Alignment:NSTextAlignmentRight  FontFl:14];
    [cell.contentView addSubview:lab2];
    
    
    if (section==0) {
        
        
        if (row==0) {
            
            
            if ([[self.dic objectForKey:@"bankCardId"] isEqualToString:@""]) {
                lab1234.text = @"绑定银行卡";
                lab1234.textColor = [UIColor colorWithRed:2/255.0 green:160/255.0 blue:219/255.0 alpha:1];
                imgView.image = [UIImage imageNamed:@"icon27.png"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else{
                lab1234.text = bankAndNumber;
                lab1234.frame = CGRectMake(45, 0, 320, 45);
                imgView.image = [UIImage imageNamed:@"icon27.png"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            
            
            
            //未签约
            if ([[self.dic objectForKey:@"isBound"] isEqualToString:@"0"]) {
              
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
                
            }
        
            
            
        }else if (row==1){
            
            lab123.text = @"可用余额";
            lab1234.text = user.keyong_money;
            lab2.text = @"元";
            
        }
        
        
    }else if (section==1) {
        
        if (row==0) {
            
            lab123.text = @"提现金额";
            
            UITextField *textField = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(22.5+42,8, [Tool adaptation:275-52 with6:55 with6p:94], 44)  FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
            [cell.contentView addSubview:textField];
            textField.frame = CGRectMake(125,0, [Tool adaptation:170 with6:55 with6p:94], 45);
            textField.placeholder = [NSString stringWithFormat:@"请输入体现金额，至少%@",[self.dic objectForKey:@"withdrawMin"]];
            textField.tag = 100;
            textField.text = money;
            lab2.text = @"元";
            
            
        }else if (row==1){
            
            lab123.text = @"提现手续费";
            lab1234.text = tixianshouxufei;
            lab1234.tag = 109;
            lab2.text = @"元";
        }
  
    }else if (section==2) {
        
        if (row==0) {
            
            lab123.text = @"实际扣除金额";
            lab1234.text = shijizhifujine;
            lab1234.tag = 200;
            lab1234.textColor = [UIColor colorWithRed:244/255.0 green:151/255.0 blue:0/255.0 alpha:1.0];
            lab2.text = @"元";
        }
        
    }else if (section==3) {
        
        if (row==0) {
            
            lab123.text = @"提现密码";
            
            UITextField *textField = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(22.5+42,8, [Tool adaptation:275-52 with6:55 with6p:94], 44)  FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
            [cell.contentView addSubview:textField];
            textField.frame = CGRectMake(125,0, [Tool adaptation:170 with6:55 with6p:94], 45);
            textField.placeholder = @"请输入提现密码";
            textField.tag = 101;
            textField.text = code;
            textField.secureTextEntry = YES;
        }
        
    }else{
        
        lab123.textColor = [UIColor whiteColor];
        lab123.textAlignment = NSTextAlignmentCenter;
        lab123.frame = CGRectMake(0, 0, 320, 45);
        lab123.text = @"下一步";
        [lab123 setBackgroundColor:[UIColor colorWithRed:2/255.0 green:160/255.0 blue:219/255.0 alpha:1]];
    }
    
    return cell;
}


//获取输入框的tag值
-(UIView *)getCellSubObjectwithTag:(int)tag withIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UIView *view = [cell.contentView viewWithTag:tag];
    return view;
}


//拖动键盘消失
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    UITextField *moet = (UITextField *)[self getCellSubObjectwithTag:100 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    UITextField *card = (UITextField *)[self getCellSubObjectwithTag:101 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
    [moet resignFirstResponder];
    [card resignFirstResponder];
    
    money = moet.text;
    code = card.text;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag==100) {
        money = textField.text;
    }else if (textField.tag==101){
        code = textField.text;
    }
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    //体现密码
    if (textField.tag==101) {
        return YES;
    }
    
    
    //取消
    NSString *newString = textField.text;
    if (string.length==0) {
        if (newString.length>0) {
            newString = [newString substringToIndex:[newString length]-1];
        }
    }else{
        newString = [NSString stringWithFormat:@"%@%@",newString,string];
    }
    if ([newString intValue] > [[dic objectForKey:@"withdrawMax"] intValue]) {
        [Tool myalter:[NSString stringWithFormat:@"体现金额最大不超过%@",[dic objectForKey:@"withdrawMax"]]];
        [textField resignFirstResponder];
        return false;
    }
    
    
    //体现手续费
    UILabel *la = (UILabel *)[self getCellSubObjectwithTag:109 withIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    if ([newString intValue]< 5000) {
        la.text=  [dic objectForKey:@"withdrawFactorage_1"];
    }else{
        la.text=  [dic objectForKey:@"withdrawFactorage_2"];
    }
    tixianshouxufei = la.text;
    
    //实际扣除金额
    double shuji = [newString intValue] + [la.text doubleValue];
    shijizhifujine = [NSString stringWithFormat:@"%0.2lf",shuji];
    UILabel *la200 = (UILabel *)[self getCellSubObjectwithTag:200 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    la200.text = shijizhifujine;
    
    return YES;
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if (section==0) {
        if (row==0) {
            
            //未签约
            if ([[self.dic objectForKey:@"isBound"] isEqualToString:@"0"]) {
            
                //银行卡信息
                if ([[self.dic objectForKey:@"bankCardId"] isEqualToString:@""]) {
                    
                    BangYinHangViewController *bang = [[BangYinHangViewController alloc] init];
                    bang.title = @"绑定银行卡";
                    bang.typeTag = 0;
                    //返回
                    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
                    backItem.title=@"返回";
                    self.navigationItem.backBarButtonItem=backItem;
                    self.hidesBottomBarWhenPushed=YES;
                    [self.navigationController pushViewController:bang animated:YES];
                    return;
                    
                }else{
                    //修改银行卡信息
                    BangYinHangViewController *bang = [[BangYinHangViewController alloc] init];
                    bang.title = @"修改银行卡";
                    bang.typeTag = 2;
                    //返回
                    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
                    backItem.title=@"返回";
                    self.navigationItem.backBarButtonItem=backItem;
                    self.hidesBottomBarWhenPushed=YES;
                    [self.navigationController pushViewController:bang animated:YES];
                    return;
                }

                
            }else{
                return;
            }
        
        
            
            
        }
    }
    
 
    if (section==4) {
    
        //银行卡信息
        if ([[self.dic objectForKey:@"bankCardId"] isEqualToString:@""]) {
            
            BangYinHangViewController *bang = [[BangYinHangViewController alloc] init];
            bang.title = @"绑定银行卡";
            bang.typeTag = 0;
            //返回
            UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
            backItem.title=@"返回";
            self.navigationItem.backBarButtonItem=backItem;
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:bang animated:YES];
            return;
            
        }

        
        //不完善信息
        if ([[self.dic objectForKey:@"isFull"] isEqualToString:@"0"]) {
            
            //去修改银行信息
            BangYinHangViewController *bang = [[BangYinHangViewController alloc] init];
            bang.title = @"完善银行卡";
            bang.typeTag = 1;
            //返回
            UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
            backItem.title=@"返回";
            self.navigationItem.backBarButtonItem=backItem;
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:bang animated:YES];
            return;
        }

        
        
        //判断是否输入了体现的密码
        UITextField *textAmount = (UITextField *)[self getCellSubObjectwithTag:100 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        if (textAmount.text.length==0) {
            [Tool myalter:@"请输入提现金额"];
            return;
        }
        
        NSLog(@"textAmount.text %@",textAmount.text);
        
        
        if ([textAmount.text integerValue] <[[self.dic objectForKey:@"withdrawMin"] integerValue]) {
            [Tool myalter:[NSString stringWithFormat:@"提现金额至少是%@",[self.dic objectForKey:@"withdrawMin"]]];
            return;
        }
        
        if ([textAmount.text integerValue]>[[self.dic objectForKey:@"withdrawMax"] integerValue]) {
            [Tool myalter:[NSString stringWithFormat:@"提现金额最大不超过%@",[self.dic objectForKey:@"withdrawMax"]]];
            return;
        }
        
        
        //判断是否输入了体现的密码
        UITextField *text = (UITextField *)[self getCellSubObjectwithTag:101 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
        if (text.text.length==0) {
            [Tool myalter:@"请输入体现密码"];
            return;
        }
        
        
        
        //获取网络请求
        [self yanzhengtixianmima__startRequest:text.text withamount:textAmount.text];
        
   
    }
    
}





//验证提现密码
-(void)yanzhengtixianmima__startRequest:(NSString *)code1 withamount:(NSString *)amount{
    
  
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/checkWpassword.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:code1 forKey:@"password"];
    
    
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"yes",@"isshowHUD",
                                           @"no",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   
                                   if (kk==0) {
                                       NSMutableDictionary *dicO = [data JSONValue];
                                       if ([[dicO objectForKey:@"code"] intValue]  == 0) {
                                           
                                           
                                           //手续费
                                           UILabel *la = (UILabel *)[self getCellSubObjectwithTag:109 withIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
                                           //实际扣除金额
                                           UILabel *la200 = (UILabel *)[self getCellSubObjectwithTag:200 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
                                           
                                           OkTiXianTableViewController *oktixian = [[OkTiXianTableViewController alloc] init];
                                           oktixian.title = @"确认提现";
                                           oktixian.bankCardId = bankCardId;
                                           oktixian.amount = amount;
                                           oktixian.password = code;
                                           oktixian.shouxufei = la.text;
                                           oktixian.shijikouchujine = la200.text;
                                           oktixian.bankNameAndAdress = bankAndNumber;
                                           //返回
                                           UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
                                           backItem.title=@"返回";
                                           self.navigationItem.backBarButtonItem=backItem;
                                           self.hidesBottomBarWhenPushed=YES;
                                           [self.navigationController pushViewController:oktixian animated:YES];
                                           
                                           
                                           
                                       }else{
                                           
                                           [Tool myalter:[dicO objectForKey:@"msg"]];
                                       }
                                   }
                               }];
}




@end
