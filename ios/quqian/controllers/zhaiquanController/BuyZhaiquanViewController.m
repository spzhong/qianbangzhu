//
//  BuyZhaiquanViewController.m
//  quqian
//
//  Created by apple on 15/3/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BuyZhaiquanViewController.h"
#import "Tool.h"
#import "RCLabel.h"
#import "UserModel.h"
#import "HelpDownloader.h"
#import "MBProgressHUD+Add.h"
#import "AHAlertView.h"
#import "WebController.h"
#import "TrueNameViewController.h"
#import "ReCodeTableViewController.h"
#import "ZijinMangerViewController.h"
#import "CGWebViewController.h"


@interface BuyZhaiquanViewController ()
{
    UserModel *user;
    UITextField *textField;
    AHAlertView *alert;
    BOOL isArgee;
    RCLabel *rcLabjisuan;
    NSMutableArray *arrayJiaxika;
    int kegoumaifenshu;
    NSString *jiaxikaId;
}
@end

@implementation BuyZhaiquanViewController
@synthesize typeTag;
@synthesize allDic;

- (instancetype)initWithStyle:(UITableViewStyle)style{
    return self = [super initWithStyle:UITableViewStyleGrouped];
}

 
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tableView reloadData];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    user = [Tool getUser];
    jiaxikaId = @"";
    
    arrayJiaxika = [NSMutableArray arrayWithCapacity:0];
    
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //表的尾部
    [self makefootView];
    isArgee = YES;
    
    
    //散标投资
    if ([typeTag isEqualToString:@"1"]) {
        //判断最小的数据
        double syfs = [[allDic objectForKey:@"syje"] doubleValue];
        double keyong = [user.keyong_money doubleValue];
        double tbxe = [[allDic objectForKey:@"tbxe"] doubleValue];
        if (syfs<keyong) {
            if (syfs<tbxe) {
                kegoumaifenshu = syfs/100;
            }else{
                kegoumaifenshu = tbxe/100;
            }
        }else{
            if (keyong> tbxe) {
                kegoumaifenshu = tbxe/100;
            }else{
                kegoumaifenshu = keyong/100;
            }
        }
        
        //特殊的判断
        if (tbxe==0.0) {
            if (syfs<keyong) {
                kegoumaifenshu = syfs/100;
            }else{
                kegoumaifenshu = keyong/100;
            }
        }
     
    }else{
        kegoumaifenshu = [[self.allDic objectForKey:@"syfs"] intValue];
    }
    
    
    
    [self sanInfo__startRequest];
    
}


//生称footview
-(void)makefootView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 170)];
    
    
    UILabel *lab = [Tool LablelProductionFunction:@"请输入购买份数" Frame:CGRectMake(15,0,200,45) Alignment:NSTextAlignmentLeft FontFl:15];
    [bgView addSubview:lab];
    
    UIButton *buton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    buton1.frame = CGRectMake(15, 45, 32, 32);
    [buton1 setTitle:@"-" forState:UIControlStateNormal];
    [buton1 setBackgroundImage:[UIImage imageNamed:@"icon24.png"] forState:UIControlStateNormal];
    [buton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bgView addSubview:buton1];
    [buton1 addTarget:self action:@selector(jianyu) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    buton2.frame = CGRectMake(ScreenWidth-32-15, 45, 32, 32);
    [buton2 setTitle:@"+" forState:UIControlStateNormal];
    [bgView addSubview:buton2];
    [buton2 setBackgroundImage:[UIImage imageNamed:@"icon24.png"] forState:UIControlStateNormal];
    [buton2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buton2 addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lab2 = [Tool LablelProductionFunction:@"份" Frame:CGRectMake(290,40,20,45) Alignment:NSTextAlignmentLeft FontFl:15];
    [bgView addSubview:lab2];
    
    //输入框
    textField  = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectZero FontFl:15 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumberPad];
    [bgView addSubview:textField];
    textField.frame = CGRectMake(56,45, ScreenWidth-50-64, 32);
    textField.tag = 100;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.text = @"1";
    [textField setBackground:[UIImage imageNamed:@"icon25.png"]];
    
    //登录
    UIButton *but3 = [Tool ButtonProductionFunction:@"立即投标" Frame:CGRectMake(0, 115, ScreenWidth, 45) bgImgName:@"" FontFl:20];
    [bgView addSubview:but3];
    [but3 setBackgroundColor:[UIColor colorWithRed:2/255.0 green:160/255.0 blue:219/255.0 alpha:1]];
    [but3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but3 addTarget:self action:@selector(lijitoubiao) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.tableView.tableFooterView = bgView;
}



//减少
-(void)jianyu{
    
    if ([textField.text intValue]-10 < 0) {
        [MBProgressHUD showError:@"至少1份" toView:nil];
        textField.text = @"1";
    }else{
        textField.text = [NSString stringWithFormat:@"%d",[textField.text intValue]-10];
    }
    //计算
    if ([typeTag isEqualToString:@"1"]) {
        rcLabjisuan.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=left><font size=15 >预计收益%0.2lf元，奖%0.2lf元</font></p>",[Tool suanfa:allDic withFenshu:[textField.text intValue]  withType:0],[Tool suanfa:allDic withFenshu:[textField.text intValue]  withType:1]]];
    }else{
        rcLabjisuan.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=left><font size=15 >预计收益%0.2lf元</font></p>",[textField.text intValue]*([[allDic objectForKey:@"dsbx"] doubleValue] - 100)]];
        
//        RCLabel *lab = (RCLabel *)[self getCellSubObjectwithTag:101 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
//        lab.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=right><font size=15 >%0.2lf</font><font size=15>元</font></p>",[textField.text intValue]*([[allDic objectForKey:@"zqjg"] doubleValue])]];
    }
}
//添加
-(void)add{
    
    if ([textField.text intValue]+10 > [[self.allDic objectForKey:@"syfs"] intValue]) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"最多%d份",[[self.allDic objectForKey:@"syfs"] intValue]] toView:nil];
    }else{
        textField.text = [NSString stringWithFormat:@"%d",[textField.text intValue]+10];
        if ([typeTag isEqualToString:@"1"]) {
            rcLabjisuan.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=left><font size=15 >预计收益%0.2lf元，奖%0.2lf元</font></p>",[Tool suanfa:allDic withFenshu:[textField.text intValue]  withType:0],[Tool suanfa:allDic withFenshu:[textField.text intValue]  withType:1]]];
        }else{
            rcLabjisuan.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=left><font size=15 >预计收益%0.2lf元</font></p>",[textField.text intValue]*([[allDic objectForKey:@"dsbx"] doubleValue] - 100)]];
        }
    }
    
    RCLabel *lab = (RCLabel *)[self getCellSubObjectwithTag:101 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    lab.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=right><font size=15 >%0.2lf</font><font size=15>元</font></p>",[textField.text intValue]*([[allDic objectForKey:@"zqjg"] doubleValue])]];

    
}






//
//map.put("isLock", "0");// 0不锁，1是锁
//map.put("id", pId);


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

#pragma mark - Table view data source


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        if (self.iscunguan==0) {
            return 4;
        }
        return 3;
    }else if (section==1){
        return 1;
    }
    return 1;
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
   
    
    UILabel *lab123 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(16.5, 0, ScreenWidth-30, 45) Alignment:NSTextAlignmentLeft  FontFl:15];
    lab123.font = FOUR_CONTROL_FONT;
    [cell.contentView addSubview:lab123];
    
    //右边
    RCLabel *rcLab = [[RCLabel alloc] initWithFrame:CGRectMake(80, 15, ScreenWidth-95, 20)];
    [cell.contentView addSubview:rcLab];
    
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if (section==0) {
        
            if (row==0) {
                lab123.text = @"剩余金额";
                rcLab.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=right><font size=15>%@</font></p>",[NSString stringWithFormat:@"%@",self.allDic[@"syje"]]]];
            }else if (row==1){
                lab123.text = @"可用金额";
                rcLab.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=right><font size=15 color='333333'>%@</font>  充值</p>",self.allDic[@"amount"]]];
            }else if (row==2){
                lab123.text = @"可购买份数";
                rcLab.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=right><font size=15 color='333333'>%.0lf</font></p>",[self  kegoumai]]];
            }else if (row==3){
                lab123.text = @"请选择加息卡";
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
            }

      
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row==3) {
        NSString *url =[NSString stringWithFormat:@"%@/sbtz/getJxkList.htm",BASE_URL];
        NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
        [postDic setObject:[allDic objectForKey:@"id"] forKey:@"id"];
        [[HelpDownloader shared] startRequest:url withbody:postDic
                                       isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                               @"yes",@"isConnectedToNetwork",
                                               @"yes",@"isshowHUD",
                                               @"no",@"islockscreen",
                                               @"post",@"isrequesType",
                                               nil]
                                   completion:^void(id data,int kk){
                                       if (kk==0) {
                                           
                                           NSMutableDictionary *dic = [data JSONValue];
                                           if (![dic[@"rvalue"] isKindOfClass:[NSNull class]]) {
                                               [arrayJiaxika addObjectsFromArray: dic[@"rvalue"]];
                                               //进行弹框
                                               UIAlertView *al = [[UIAlertView alloc] init];
                                               al.delegate = self;
                                               al.tag = 101;
                                               for (NSMutableDictionary *dicone in arrayJiaxika) {
                                                                                              [al addButtonWithTitle:dicone[@"jxkNum"]];
                                                   
                                               }
                                               [al addButtonWithTitle:@"取消"];
                                               [al show];
                                               
                                           }else{
                                               [Tool myalter:@"暂无加息卡"];
                                           }
                                       }
                                   }];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==arrayJiaxika.count) {
        return;
    }
    NSMutableDictionary *dic = arrayJiaxika[buttonIndex];
    jiaxikaId = dic[@"id"];
    
}

//获取输入框的tag值
-(UIView *)getCellSubObjectwithTag:(int)tag withIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UIView *view = [cell.contentView viewWithTag:tag];
    return view;
}




- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    
    //取消
    NSString *newString = textField.text;
    if (string.length==0) {
        if (newString.length>0) {
            newString = [newString substringToIndex:[newString length]-1];
        }
    }else{
        newString = [NSString stringWithFormat:@"%@%@",newString,string];
    }
    
    if ([newString intValue] > [[self.allDic objectForKey:@"syfs"] intValue]) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"最多%d份",[[self.allDic objectForKey:@"syfs"] intValue]] toView:nil];
        return false;
    }
    
    if ([typeTag isEqualToString:@"1"]) {
        rcLabjisuan.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=left><font size=15 >预计收益%0.2lf元，奖%0.2lf元</font></p>",[Tool suanfa:allDic withFenshu:[newString intValue]  withType:0],[Tool suanfa:allDic withFenshu:[newString intValue]  withType:1]]];
        
    }else{
        
        rcLabjisuan.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=left><font size=15 >预计收益%0.2lf元</font></p>",[newString intValue]*([[allDic objectForKey:@"dsbx"] doubleValue] - 100)]];
        
        
        
//        RCLabel *lab = (RCLabel *)[self getCellSubObjectwithTag:101 withIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
//        lab.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=right><font size=15 >%0.2lf</font><font size=15>元</font></p>",[newString intValue]*([[allDic objectForKey:@"zqjg"] doubleValue])]];
 
    }
    
    return YES;
}

//开始编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationDuration:0.3f];
//    self.tableView.frame = CGRectMake(0, 0, 320, self.view.frame.size.height-210);
//    if (iPhone4) {
//        self.tableView.contentOffset = CGPointMake(0, self.tableView.frame.size.height);
//    }else{
//        self.tableView.contentOffset = CGPointZero;
//    }
//    [UIView commitAnimations];
    
    return YES;
}


//拖动键盘消失
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [textField resignFirstResponder];
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationDuration:0.2f];
//    self.tableView.frame = CGRectMake(0, 0, 320, [Tool getDele].window.frame.size.height);
//    [UIView commitAnimations];
    
    if ([typeTag isEqualToString:@"1"]) {
        rcLabjisuan.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=left><font size=15 >预计收益%0.2lf元，奖%0.2lf元</font></p>",[Tool suanfa:allDic withFenshu:[textField.text intValue]  withType:0],[Tool suanfa:allDic withFenshu:[textField.text intValue]  withType:1]]];
        
    }else{
        
        rcLabjisuan.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=left><font size=15 >预计收益%0.2lf元</font></p>",[textField.text intValue]*([[allDic objectForKey:@"dsbx"] doubleValue] - 100)]];
    }
}








//立即投标
-(void)lijitoubiao{
    
 
    [textField resignFirstResponder];
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationDuration:0.2f];
//    self.tableView.frame = CGRectMake(0, 0, 320, [Tool getDele].window.frame.size.height);
//    [UIView commitAnimations];
//    
 

    
    
    //判断是否手机认证了
    //UserModel *userModel = [Tool getUser];
    //    if ([userModel.sjsfsz isEqualToString:@"false"]) {
    //        [Tool myalter:@"请设置手机认证"];
    //        return;
    //    }
    
//    //判断是否实名认证了
//    if ([userModel.sfzsfrz isEqualToString:@"false"]) {
//        //[Tool myalter:@"请设置实名认证"];
//        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请设置实名认证" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
//        al.tag = 900;
//        [al show];
//        
//        return;
//    }
//    
//    //提现密码是否设置
//    if ([userModel.txmmsfsz isEqualToString:@"false"]) {
//        //[Tool myalter:@"请设置提现密码"];
//        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请设置提现密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
//        al.tag = 901;
//        [al show];
//        return;
//    }
    
    
    //进行开始投标
    [self makeAlter];
    
}
 
-(void)makeAlter{
    
    [textField resignFirstResponder];
    
    isArgee = YES;
    
    
//    //判断余额
    int keyong = [textField.text intValue] * 100;
//    if ([user.keyong_money intValue]-keyong < 0) {
//        
//        [MBProgressHUD showError:@"您的账户余额不足，请充值" toView:nil];
//        
//        //进入个人账户的页面
//        ZijinMangerViewController *manger = [[ZijinMangerViewController alloc] init];
//        manger.title = @"资金管理";
//        //返回
//        UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
//        backItem.title=@"返回";
//        self.navigationItem.backBarButtonItem=backItem;
//        self.hidesBottomBarWhenPushed=YES;
//        [self.navigationController pushViewController:manger animated:YES];
//        
//        return;
//    }
//    
//    
//    
//    
//       //判断可购买的份数
//    if ([textField.text intValue] > kegoumaifenshu) {
//        if (typeTag==0) {
//            [MBProgressHUD showError:@"您的购买份数大于剩余份数" toView:nil];
//        }else{
//            [MBProgressHUD showError:@"你的投标份数大于可购买份数" toView:nil];
//        }
//        
//        return;
//    }
    
    
    
    NSString *title = @"<p align=cneter><font size=18 >购买确认</font></p>";
     NSString *message = [NSString stringWithFormat:@"<p align=left>\n<font size=15 >您此次购买的份数为</font><font size=15 color='#F08F00'>%@</font><font size=15>份，</font>\n<font size=15>每份价格</font><font size=15 color='#F08F00'>100</font><font size=15>元，</font><font size=15>总需</font><font size=15 color='#F08F00'>%d</font><font size=15>元</font></p>",textField.text,keyong];
    
    alert = [[AHAlertView alloc] initWithTitle:title message:message];
    [alert setCancelButtonTitle:@"取消" block:^{
        //alert.dismissalStyle = AHAlertViewDismissalStyleTumble;
    }];
    [alert addButtonWithTitle:@"确认" block:^{
        
    }];
    [alert show];
    [alert setBackgroundColor:[UIColor clearColor]];
    
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, alert.frame.size.width, alert.frame.size.height+40)];
    [bgView setBackgroundColor:[UIColor whiteColor]];
    //设置圆角边框
    bgView.layer.cornerRadius = 8;
    bgView.layer.masksToBounds = YES;
    //设置边框及边框颜色
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor =[ [UIColor grayColor] CGColor];
    
    
    //标题
    UILabel *labTitle = [Tool LablelProductionFunction:@"购买确认" Frame:CGRectMake(0,20,alert.frame.size.width,30) Alignment:NSTextAlignmentCenter FontFl:20];
    labTitle.font = [UIFont boldSystemFontOfSize:18];
    //信息
    RCLabel *lab = [[RCLabel alloc] initWithFrame:CGRectMake(40, 33, alert.frame.size.width, 70)];
    lab.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=left>\n<font size=15 >您此次购买的份数为</font><font size=15 color='#F08F00'>%@</font><font size=15>份，</font>\n<font size=15>每份价格</font><font size=15 color='#F08F00'>100</font><font size=15>元，</font><font size=15>总需</font><font size=15 color='#F08F00'>%d</font><font size=15>元</font></p>",textField.text,keyong]];
    [bgView addSubview:labTitle];
    [bgView addSubview:lab];
    //选中
    UIButton*checkbox=[[UIButton alloc]initWithFrame:CGRectZero];
    [bgView addSubview:checkbox];
    checkbox.frame=CGRectMake(75,102,13,13) ;
    [checkbox setImage:[UIImage imageNamed:@"icon19-1.png"]forState:UIControlStateNormal];
    //设置正常时图片为    check_off.png
    [checkbox setImage:[UIImage imageNamed:@"icon19-2.png"]forState:UIControlStateSelected];
    //设置点击选中状态图片为check_on.png
    [checkbox addTarget:self action:@selector(checkboxClick:)forControlEvents:UIControlEventTouchUpInside];
    [checkbox setSelected:YES];//设置按钮得状态是否为选中（可在此根据具体情况来设置按钮得初始状态）
    
    //我同意
    UILabel *lab12 = [Tool LablelProductionFunction:@"我同意" Frame:CGRectMake(92, 98, 80, 20)  Alignment:NSTextAlignmentLeft FontFl:13];
    [bgView addSubview:lab12];
    //注册协议
    NSString *stringName = @"";
    if ([typeTag isEqualToString:@"0"]) {
        stringName = @"《债权转让及受让协议》";
    }else if ([typeTag isEqualToString:@"1"]){
        stringName = @"《借款协议》";
    }
    
    UIButton *but2 = [Tool ButtonProductionFunction:stringName Frame:CGRectMake(105, 98, 120, 20) bgImgName:@"" FontFl:13];
    if ([typeTag isEqualToString:@"0"]) {
        but2.frame = CGRectMake(105, 98, 150, 20);
        lab12.frame = CGRectMake(72, 98, 80, 20);
        checkbox.frame =CGRectMake(55,102,13,13) ;
    }
    
    [bgView addSubview:but2];
    [but2 setTitleColor:[UIColor colorWithRed:2/255.0 green:160/255.0 blue:219/255.0 alpha:1] forState:UIControlStateNormal];
    [but2 addTarget:self action:@selector(quqianxieyi:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:lab];
    [bgView addSubview:but2];
    
    //线
    UILabel *line1 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(0, 120, alert.frame.size.width, 0.5) Alignment:NSTextAlignmentLeft FontFl:15];
    [line1 setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    [bgView addSubview:line1];
    UILabel *line2 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(alert.frame.size.width/2, 120, 0.5, 50) Alignment:NSTextAlignmentLeft FontFl:15];
    [line2 setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    [bgView addSubview:line2];
    
    
    NSLog(@"%lf",alert.frame.size.width);
    
    
    //按钮
    UIButton *but11 = [Tool ButtonProductionFunction:@"取消" Frame:CGRectMake(10, 130, alert.frame.size.width/2, 30) bgImgName:nil FontFl:15];
    [but11 addTarget:self action:@selector(quxiao) forControlEvents:UIControlEventTouchUpInside];
    UIButton *but22 = [Tool ButtonProductionFunction:@"确认" Frame:CGRectMake(alert.frame.size.width/2, 130, alert.frame.size.width/2, 30) bgImgName:nil FontFl:15];
    [but22 addTarget:self action:@selector(ok) forControlEvents:UIControlEventTouchUpInside];
    
    [bgView addSubview:but11];
    [bgView addSubview:but22];
    //按钮取消
    [alert addSubview:bgView];
}



//打勾选中
-(void)checkboxClick:(UIButton *)btn{
    
    if(btn.selected){
        
        isArgee = NO;
        
    }else{
        
        isArgee = YES;
        //在此实现打勾时的方法
        
    }
    
    btn.selected=!btn.selected;//每次点击都改变按钮的状态
    
}

//借款协议
-(void)quqianxieyi:(UIButton *)but{
    
    //取消弹框
    [self quxiao];
    
    

    WebController *web = [[WebController alloc] init];
    if ([typeTag isEqualToString:@"0"]) {
        web.urlString = [NSString stringWithFormat:@"%@/term/ZQZRXY.html",web_URL];
        web.title = @"债权转让及受让协议";
    }else if ([typeTag isEqualToString:@"1"]){
        web.urlString = [NSString stringWithFormat:@"%@/term/SDRZBXY.html",web_URL];
        web.title = @"借款协议";
    }

    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:web animated:YES];
     
    
}


-(void)quxiao{
    [alert dismiss];
}


-(void)ok{
    [alert dismiss];
    [self wangluogoumai];
}



//网络购买
-(void)wangluogoumai{
    
    
    if (!isArgee) {
        
        NSString *stringName = @"";
        if ([typeTag isEqualToString:@"0"]) {
            stringName = @"请选择同意债权转让及受让协议";
        }else if ([typeTag isEqualToString:@"1"]){
            stringName = @"请选择同意借款协议";
        }
        [MBProgressHUD showError:stringName toView:nil];
        return;
    }

    
    
    //进行有效登录确认
    NSString *url = @"";
    url =[NSString stringWithFormat:@"%@/sbtz/tb.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    NSString *pid = [allDic objectForKey:@"id"];
    if (self.iscunguan==0) {
        [postDic setObject:@"PTTZ" forKey:@"tbtype"];
    }else{
        [postDic setObject:@"CGTZ" forKey:@"tbtype"];
    }
    
    if (pid==nil) {
        return;
    }
    
    if ([jiaxikaId length]>0) {
        [postDic setObject:jiaxikaId forKey:@"jxkid"];
    }
    
    [postDic setObject:pid forKey:@"id"];
    [postDic setObject:textField.text forKey:@"fs"];
     
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"no",@"isshowHUD",
                                           @"no",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   
                                   if (kk==0) {
                                       
                                       NSMutableDictionary *dic = [data JSONValue];
                                       if ([[dic objectForKey:@"code"] intValue] == 0) {
                                        

                                           if (self.iscunguan==0) {
                                               
                                               //保存数据
                                               user.keyong_money = [NSString stringWithFormat:@"%@",dic[@"rvalue"][@"amount"]];
                                               [Tool savecoredata];
                                               
                                               [[NSNotificationCenter defaultCenter] postNotificationName:@"gengxinshuju" object:nil];
                                               
                                               //返回散标的列表中
                                               [self.navigationController popViewControllerAnimated:YES];
                                               
                                               [MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:nil];
                                               
                                           }else{
                                               
                                               NSMutableDictionary *dicData = [dic[@"rvalue"] firstObject];
                                               user.keyong_money = [NSString stringWithFormat:@"%@",dicData[@"amount"]];
                                               [Tool savecoredata];
                                               //进入web的确认页面
                                               CGWebViewController *web = [[CGWebViewController alloc] init];
                                               web.title = @"投标确认";
                                               web.tag = 1;
                                               web.sendUrl = dicData[@"asydata"][@"sendUrl"];
                                               web.sendStr = dicData[@"asydata"][@"sendStr"];
                                               web.transCode = dicData[@"asydata"][@"transCode"];
                                               web.seqNum = dicData[@"asydata"][@"seqNum"];
                                               UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
                                               backItem.title=@"返回";
                                               self.navigationItem.backBarButtonItem=backItem;
                                               self.hidesBottomBarWhenPushed=YES;
                                               [self.navigationController pushViewController:web animated:YES];
                                                
                                           }
                                            
                                       }else{
                                           
                                           if([[dic objectForKey:@"msg"] isEqualToString:@"你的账户余额不足进行本次购买 ，请充值"]){
                                               ZijinMangerViewController *manger = [[ZijinMangerViewController alloc] init];
                                                   manger.title = @"资金管理";
                                                   //返回
                                                   UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
                                                   backItem.title=@"返回";
                                                   self.navigationItem.backBarButtonItem=backItem;
                                                   self.hidesBottomBarWhenPushed=YES;
                                                   [self.navigationController pushViewController:manger animated:YES];
                                           }
                                           
                                           [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:nil];
                                       }
                                     
                                   }else{
                                       
                                   }
                                   
                               }];
}





//组装数据
-(void)makeData:(NSMutableDictionary *)dic{
    
    NSString *SS = [Tool toString:[dic objectForKey:@"rvalue"]];
    
    if ([SS isEqualToString:@"<null>"] || [SS isEqualToString:@"null"]) {
        return;
    }
    
    allDic = [dic objectForKey:@"rvalue"];
    
    //刷新数据
    //表的尾部
    [self makefootView];
    //散标投资
    if ([typeTag isEqualToString:@"1"]) {
        //判断最小的数据
        double syfs = [[allDic objectForKey:@"syje"] doubleValue];
        double keyong = [user.keyong_money doubleValue];
        double tbxe = [[allDic objectForKey:@"tbxe"] doubleValue];
        if (syfs<keyong) {
            if (syfs<tbxe) {
                kegoumaifenshu = syfs/100;
            }else{
                kegoumaifenshu = tbxe/100;
            }
        }else{
            if (keyong> tbxe) {
                kegoumaifenshu = tbxe/100;
            }else{
                kegoumaifenshu = keyong/100;
            }
        }
        
        //特殊的判断
        if (tbxe==0.0) {
            if (syfs<keyong) {
                kegoumaifenshu = syfs/100;
            }else{
                kegoumaifenshu = keyong/100;
            }
        }
        
    }else{
        kegoumaifenshu = [[self.allDic objectForKey:@"syfs"] intValue];
    }
    

    
    user = [Tool getUser];
    user.keyong_money = [allDic objectForKey:@"amount"];
    [Tool savecoredata];
    
    [self.tableView reloadData];
}







#pragma 网络请求
//散标列表
-(void)sanInfo__startRequest{
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/sbtz/get.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
   
    [postDic setObject:[allDic objectForKey:@"id"] forKey:@"id"];
    
    
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"yes",@"isshowHUD",
                                           @"no",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   
                                   if (kk==0) {
                                       
                                       [self makeData:[data JSONValue]];
                                       
                                       
                                   }else{
                                       
                                   }
                                   
                               }];
    
}





//债权转让
-(void)zhaiquanInfo__startRequest{
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/zqzr/get.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    [postDic setObject:[allDic objectForKey:@"id"] forKey:@"id"];
    
    
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"yes",@"isshowHUD",
                                           @"no",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   
                                   if (kk==0) {
                                       
                                       [self makeData:[data JSONValue]];
                                       
                                       
                                   }else{
                                       
                                   }
                                   
                               }];
    
}




-(double)kegoumai{
    double kegoumai = 0.0;
    // 判断最小的数据
    
    UserModel *model = [Tool getUser];
    
    
    double syfsa = [[self.allDic objectForKey:@"syje"] doubleValue];
    double keyongs =  [model.keyong_money doubleValue];
    
    double tbxe = 0.0;
    if ([self.allDic[@"tbxe"] isEqualToString:@"不限"]) {
    } else {
        tbxe = [self.allDic[@"tbxe"] doubleValue];
    }
    
    if (syfsa < keyongs) {
        if (syfsa < tbxe) {
            kegoumai = syfsa / 100;
        } else {
            kegoumai = tbxe / 100;
        }
    } else {
        if (keyongs > tbxe) {
            kegoumai = tbxe / 100;
        } else {
            kegoumai = keyongs / 100;
        }
    }
    // 特殊的判断
    if (tbxe == 0.0) {
        if (syfsa < keyongs) {
            kegoumai = syfsa / 100;
        } else {
            kegoumai = keyongs / 100;
        }
    }
    
    return kegoumai;
}








@end











