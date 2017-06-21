//
//  BangYinHangViewController.m
//  quqian
//
//  Created by apple on 15/5/6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BangYinHangViewController.h"
#import "EGOImageView.h"
#import "UserModel.h"
#import "HelpDownloader.h"
#import "ZHPickView.h"
#import "BangKHAdressViewController.h"
#import "MBProgressHUD+Add.h"


@interface BangYinHangViewController ()<ZHPickViewDelegate>
{
    UserModel *user;
    
    NSString *bankCardId;
    
    NSString *bank;
    NSString *bankId;
    
    NSString *bankArdess;
    NSString *bankKH;
    NSString *bankNum;
    
    NSString *city;
    NSString *cityId;
    
    NSString *shengId;
    
    NSMutableArray *array1;
    NSMutableArray *array2;
    
    NSString *iskeshuruyinhang;
    NSString *iskexuanzeyinhang;
    
    
    
    NSString *realname;
    NSString *shenfenId;
    NSString *banknumber;
    NSString *bankname;
}
@end

@implementation BangYinHangViewController
@synthesize typeTag;

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
    
    
    bankCardId = @"";
    bank = @"";
    bankArdess = @"";
    bankKH = @"";
    bankNum = @"";
    city = @"";
    cityId = @"";
    
    array1 = [[NSMutableArray alloc] init];
    array2 = [[NSMutableArray alloc] init];
    
    user = [Tool getUser];
    
//   
//    if (typeTag==0) {//绑定银行卡
//        
//    }else if (typeTag==1){//修改银行卡信息
//        [self huoqubangdingdeyinghangka__startRequest];
//    }else if (typeTag==2){//完善银行卡信息
//        [self huoqubangdingdeyinghangka__startRequest];
//    }
    
    
    //选择开户地址
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xuanzekaihudi:) name:@"xuanzekaihudi" object:nil];
    
}

//绑定后的通知
-(void)xuanzekaihudi:(NSNotification *)not{
    NSDictionary *dicbank = [not userInfo];
    
    bankArdess  = [dicbank objectForKey:@"title"];
    cityId = [NSString stringWithFormat:@"%@",[dicbank objectForKey:@"cityId"]];
    shengId= [NSString stringWithFormat:@"%@",[dicbank objectForKey:@"shengId"]];
    [self.tableView reloadData];
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
    if (section==1) {
        return 35;
    }
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 5;
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
            //lab123.text = @"开户名";
            //if (typeTag==0) {//绑定银行卡
                UITextField *textField = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(30,0,ScreenWidth-60,44)  FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
                textField.frame = CGRectMake(30,0, [Tool adaptation:170 with6:55 with6p:94], 45);
                [cell.contentView addSubview:textField];
                textField.placeholder = @"银行卡开户姓名";
            if (realname.length>0) {
                textField.text = realname;
            }
                textField.tag = 100;
            //}
        }else if (row==1){
            //lab123.text = @"";
            UITextField *textField = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(30,8, [Tool adaptation:275-52 with6:55 with6p:94], 44)  FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
            textField.frame = CGRectMake(30,0, [Tool adaptation:170 with6:55 with6p:94], 45);
            [cell.contentView addSubview:textField];
            textField.placeholder = @"银行卡开户身份证号";
            textField.tag = 101;
            if (shenfenId.length>0) {
                textField.text = shenfenId;
            }
           
        } else if (row==2){
           
                UITextField *textField = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(30,8, [Tool adaptation:275-52 with6:55 with6p:94], 44)  FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
                textField.frame = CGRectMake(30,0, [Tool adaptation:170 with6:55 with6p:94], 45);
                [cell.contentView addSubview:textField];
                textField.placeholder = @"请选择银行卡";
                textField.enabled = NO;
                textField.userInteractionEnabled = NO;
                textField.tag = 102;
                textField.text = bank;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            
        }else if (row==3){
        
                UITextField *textField = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(22.5+42,8, [Tool adaptation:275-52 with6:55 with6p:94], 44)  FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
                textField.frame = CGRectMake(30,0, [Tool adaptation:170 with6:55 with6p:94], 45);
                [cell.contentView addSubview:textField];
                textField.placeholder = @"请选择省市区";
                textField.enabled = NO;
                textField.userInteractionEnabled = NO;
                textField.tag = 103;
                if (bankArdess.length > 0) {
                    textField.text = bankArdess;
                }
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }else if (row==4){
            
            UITextField *textField = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(22.5+42,8, [Tool adaptation:275-52 with6:55 with6p:94], 44)  FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
            textField.frame = CGRectMake(30,0, [Tool adaptation:170 with6:55 with6p:94], 45);
            [cell.contentView addSubview:textField];
            textField.placeholder = @"请输入银行卡号";
            textField.enabled = YES;
            textField.userInteractionEnabled = YES;
            textField.tag = 104;
            if (banknumber.length > 0) {
                textField.text = banknumber;
            }
            
        }
    }else if (section==1) {
        
        lab123.textColor = [UIColor whiteColor];
        lab123.textAlignment = NSTextAlignmentCenter;
        lab123.frame = CGRectMake(0, 0, ScreenWidth, 45);
        
        if (typeTag==0) {//绑定银行卡
            lab123.text = @"确认绑定";
        }else{
            lab123.text = @"确认";
        }
        [lab123 setBackgroundColor:[UIColor colorWithRed:2/255.0 green:160/255.0 blue:219/255.0 alpha:1]];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    
    
    if (section==0) {
        //选择银行
        if (row==2) {
            
            if ([iskeshuruyinhang isEqualToString:@"1"]) {
                
            }else{
                
                [self huoquyinhangka__startRequest];
            }
            
        } else if (row==3){//选择开户所在地q
            
          
            [self huoqusuozaidi__startRequest];
        }
    }else if (section==1){
    
        //绑定银行卡
        [self bangdingandXiugai__startRequest];
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
        realname = textField.text;
    }else if (textField.tag==101) {
        shenfenId = textField.text;
    }else if (textField.tag==104) {
        banknumber = textField.text;
    }
}

//拖动键盘消失
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.view endEditing:YES];
}




-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    if (pickView.tag==100) {
        bank = resultString;
        //
        for (NSMutableDictionary *dicN in array1) {
            if ([[dicN objectForKey:@"bankName"] isEqualToString:resultString]) {
                bankId = [dicN objectForKey:@"bankId"];
                break;
            }
        }
    }else{
        bankArdess = resultString;
        
    }
    
    [self.tableView reloadData];
    
}





//获取我自己的绑定的银行卡信息
-(void)huoqubangdingdeyinghangka__startRequest{
    
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/user/bankcard/get.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    
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
                                       if ([[dic objectForKey:@"code"] intValue]  == 0) {
                                           
                                           NSMutableDictionary *rvalue = [dic objectForKey:@"rvalue"];
                                           
                                           bankCardId = [rvalue objectForKey:@"bankCardId"];
                                           
                                           bankId = [rvalue objectForKey:@"bankId"];
                                           bank = [rvalue objectForKey:@"bankName"];
                                           bankArdess = [rvalue objectForKey:@"city"];
                                           cityId = [rvalue objectForKey:@"cityId"];
                                           bankKH = [rvalue objectForKey:@"subbranch"];
                                           bankNum = [rvalue objectForKey:@"bankNumber"];
                                           city = [rvalue objectForKey:@"city"];
                                           
                                           
                                           if ([[rvalue objectForKey:@"isBound"] isEqualToString:@"1"]) {
                                               iskeshuruyinhang = @"1";
                                               iskexuanzeyinhang = @"1";
                                           }
                                           
                                           [self.tableView reloadData];
                                           
                                           
                                       }else{
                                           
                                           
                                       }
                                   }
                               }];
}




//获取银行卡的接口
-(void)huoquyinhangka__startRequest{
    
    [self.view endEditing:YES];
    
 
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/user/bankcard/getbank.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:@"" forKey:@"bankCardId"];
    
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
                                       if ([[dic objectForKey:@"code"] intValue]  == 0) {
                                           
                                           
                                           [array1 removeAllObjects];
                                           
                                           NSMutableArray *array = [[NSMutableArray alloc] init];
                                           for (NSMutableDictionary *dic12 in [dic objectForKey:@"rvalue"]) {
                                               [array addObject:[dic12 objectForKey:@"bankName"]];
                                               [array1 addObject:dic12];
                                           }
                                            
                                           
                                           ZHPickView *_pickview=[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:YES];
                                           _pickview.tag = 100;
                                           [_pickview setPickViewColer:[UIColor whiteColor]];
                                           _pickview.delegate=self;
                                           [_pickview show];
                                           
                                           
                                       }else{
                                        
                                           
                                       }
                                   }
                               }];
}

//获取开户行的所在地址
-(void)huoqusuozaidi__startRequest{
    
    [self.view endEditing:YES];

    if (bankId==nil || bankId.length==0) {
        [Tool myalter:@"请选择银行卡"];
        return;
    }
    

    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/user/bankcard/region.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
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
                                       if ([[dic objectForKey:@"code"] intValue]  == 0) {
                                           
                                           
                                           BangKHAdressViewController *bang = [[BangKHAdressViewController alloc] init];
                                           bang.title = @"选择省份";
                                           bang.typeString = @"0";
                                           bang.dataArray = [dic objectForKey:@"rvalue"];
                                           UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
                                           backItem.title=@"返回";
                                           self.navigationItem.backBarButtonItem=backItem;
                                           self.hidesBottomBarWhenPushed=YES;
                                           [self.navigationController pushViewController:bang animated:YES];
                                           
                                           
                                       }else{
                                           
                                           
                                       }
                                   }
                               }];
}




//绑定或修改银行卡信息
-(void)bangdingandXiugai__startRequest{
 
    [self.view endEditing:YES];
    
 
    
    if (realname == nil || realname.length==0) {
        [Tool myalter:@"请输入真实姓名"];
        return;
    }
    if (shenfenId == nil || shenfenId.length==0) {
        [Tool myalter:@"请输入开户身份证号"];
        return;
    }
    
    
    if (bankId==nil || bankId.length==0) {
        [Tool myalter:@"请选择银行卡"];
        return;
    }

    if (bankId==nil || bankId.length==0) {
        [Tool myalter:@"请选择银行卡"];
        return;
    }
    
    //区域
    if (cityId.length==0) {
        [Tool myalter:@"请选择开户所在地"];
        return;
    }
    
    if (banknumber.length==0) {
        [Tool myalter:@"请填写银行卡号"];
        return;
    }

    
    
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/user/bankcard/regJin.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    
    [postDic setObject:realname  forKey:@"realname"];
    [postDic setObject:banknumber forKey:@"banknumber"];
    [postDic setObject:bankId forKey:@"bankname"];
    [postDic setObject:cityId forKey:@"shi"];
    [postDic setObject:shengId forKey:@"sheng"];
    [postDic setObject:@"GRKH" forKey:@"type"];
    [postDic setObject:shenfenId forKey:@"idcard"];
    
    
    
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
                                       if ([[dic objectForKey:@"code"] intValue]  == 0) {
                                           
                                           [MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:nil];
 
                                           
                                           [self.navigationController popToRootViewControllerAnimated:YES];
                                            
                                           
                                       }else{
                                           
                                           [Tool myalter:[dic objectForKey:@"msg"]];
                                       }
                                   }
                               }];
}





@end
