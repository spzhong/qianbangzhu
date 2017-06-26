//
//  ProjectInfoViewController.m
//  quqian
//
//  Created by apple on 15/3/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ProjectInfoViewController.h"
#import "EGOImageView.h"
#import "WebController.h"

#import "Project.h"
#import "SanProject.h"
#import "TiYanProject.h"
#import "WenZhuanProject.h"
#import "ZhaiQuanProject.h"

#import "BuyZhaiquanViewController.h"
#import "ReserveWenViewController.h"
#import "ApplyTiYanViewController.h"

#import "RCLabel.h"
#import "HelpDownloader.h"
#import "Tool.h"





@interface ProjectInfoViewController ()
{
    Project *projectInfo;
    
    NSMutableArray *dataArray;
    NSMutableArray *dataArray1;
    NSMutableArray *secondArray;

    double cellHeight;
    
    NSMutableDictionary *allDic;
    
    UIButton *but3;
    
    NSString *licai_lcsm_url;
    
   // NSString *ssasdf;
    
}
@end

@implementation ProjectInfoViewController
@synthesize projectTag,projectId;
@synthesize tableView;
@synthesize myTimer;





-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    if (self.myTimer!=nil) {
        [self.myTimer invalidate];
        self.myTimer = nil;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    if (self.myTimer!=nil) {
        [self.myTimer invalidate];
        self.myTimer = nil;
    }
}



//立即加入
-(void)jiaru{
    
    if (projectTag==0) {//散标投注
        BuyZhaiquanViewController *buy = [[BuyZhaiquanViewController alloc] init];
        buy.title = @"立即投标";
        buy.allDic = allDic;
        buy.typeTag = @"1";
        buy.iscunguan = [self.bdlx intValue];
        //返回
        UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
        backItem.title=@"返回";
        self.navigationItem.backBarButtonItem=backItem;
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:buy animated:YES];
    }else if (projectTag==1){
        ReserveWenViewController *reserve = [[ReserveWenViewController alloc] init];
        reserve.title = @"立即预定";
        //返回
        UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
        backItem.title=@"返回";
        self.navigationItem.backBarButtonItem=backItem;
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:reserve animated:YES];
    }else if (projectTag==2){//债权转让
        BuyZhaiquanViewController *buy = [[BuyZhaiquanViewController alloc] init];
        buy.title = @"立即购买";
        buy.typeTag = @"0";
        buy.allDic = allDic;
        //返回
        UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
        backItem.title=@"返回";
        self.navigationItem.backBarButtonItem=backItem;
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:buy animated:YES];
    }else if (projectTag==3){//理财体验
        ApplyTiYanViewController *apply = [[ApplyTiYanViewController alloc] init];
        apply.title = @"立即申请";
        apply.allDic = allDic;
        //返回
        UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
        backItem.title=@"返回";
        self.navigationItem.backBarButtonItem=backItem;
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:apply animated:YES];
    }
    
}



//生称makeHeadView
-(void)makeHeadView_0:(NSMutableDictionary *)san{
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 210)];
    [bgView setBackgroundColor:KTHCOLOR];
    
    
    RCLabel *yearlilv = [[RCLabel alloc] initWithFrame:CGRectMake(0, 30, ScreenWidth, 80)];
    [bgView addSubview:yearlilv];
    if ([[san objectForKey:@"jlll"] isEqualToString:@"-1"]) {
        yearlilv.componentsAndPlainText = [RCLabel extractTextStyle:[Tool exchage:[NSString stringWithFormat:@"%@%%",[san objectForKey:@"nll"]] withDanwei:@"" withName:@"年利率"]];
    }else{
        yearlilv.componentsAndPlainText = [RCLabel extractTextStyle:[Tool exchage:[NSString stringWithFormat:@"%@％+",[san objectForKey:@"nll"]] withDanwei:[NSString stringWithFormat:@"%@％",[san objectForKey:@"jlll"]] withName:@"年利率"]];
    }
    
    
    
    RCLabel *planAllMoney = [[RCLabel alloc] initWithFrame:CGRectMake(0, 130, ScreenWidth/3, 60)];
    [bgView addSubview:planAllMoney];
    if ([san[@"bdze"] isEqualToString:@""]) {
        planAllMoney.componentsAndPlainText = [RCLabel extractTextStyle:[Tool exchage:@"0.00" withDanwei:@"元" withName:@"借款金额"]];
    } else {
        if ([san[@"bdze"] doubleValue] < 10000) {
            planAllMoney.componentsAndPlainText = [RCLabel extractTextStyle:[Tool exchage:san[@"bdze"] withDanwei:@"元" withName:@"借款金额"]];
        }else if ([san[@"bdze"] doubleValue] > 1000000000) {
            planAllMoney.componentsAndPlainText = [RCLabel extractTextStyle:[Tool exchage:[NSString stringWithFormat:@"%lf",[san[@"bdze"] doubleValue]/1000000000] withDanwei:@"亿" withName:@"借款金额"]];
        }else {
            planAllMoney.componentsAndPlainText = [RCLabel extractTextStyle:[Tool exchage:[NSString stringWithFormat:@"%lf",[san[@"bdze"] doubleValue]/10000] withDanwei:@"万" withName:@"借款金额"]];
        }
    }
     
    
    RCLabel *JIEKUAN = [[RCLabel alloc] initWithFrame:CGRectMake(1*ScreenWidth/3, 130, ScreenWidth/3, 60)];
    [bgView addSubview:JIEKUAN];
    JIEKUAN.componentsAndPlainText = [RCLabel extractTextStyle:[Tool exchage:allDic[@"jkqx"] withDanwei:@"" withName:@"借款期限"]];
    
    
    RCLabel *lastTime = [[RCLabel alloc] initWithFrame:CGRectMake(2*ScreenWidth/3, 130, ScreenWidth/3, 60)];
    [bgView addSubview:lastTime];
    lastTime.componentsAndPlainText = [RCLabel extractTextStyle:[Tool exchage:allDic[@"syje"] withDanwei:@"元" withName:@"剩余可投"]];
    
    float w =  [allDic[@"tbjd"] doubleValue]/100*ScreenWidth;
    if (w==0) {
        w = 3;
    }
    UIView *jindu = [[UIView alloc] initWithFrame:CGRectMake(0, 210-1,w, 1)];
    [jindu setBackgroundColor:RGB(250, 148, 39)];
    [bgView addSubview:jindu];

    if (![allDic[@"tjf"] isEqualToString:@""] && allDic[@"tjf"] != nil) {
        bgView.frame = CGRectMake(0, 210, ScreenWidth, 250);
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 210, ScreenWidth, 40)];
        [lab setBackgroundColor:[UIColor whiteColor]];
        lab.font = [UIFont systemFontOfSize:14];
        lab.textColor = RGB(51, 51, 51);
        lab.text = [NSString stringWithFormat:@"         %@",allDic[@"tjf"]];
        [bgView addSubview:lab];
        
        UIImageView *head = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"信-logo"]];
        head.frame = CGRectMake(15, 210+13, 13, 13);
        [bgView addSubview:head];
    }
    
    self.tableView.tableHeaderView = bgView;
}








//生称footview
-(void)makefootView{
  
    
    NSString *string = @"";
    BOOL isTouch = YES;
    
    if ([[allDic objectForKey:@"zt"] isEqualToString:@"预售中"]) {
        
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        
        isTouch = NO;
        
    }else if ([[allDic objectForKey:@"zt"] isEqualToString:@"立即投标"]) {
        string = @"立即投标";
        isTouch = YES;
    }else if ([[allDic objectForKey:@"zt"] isEqualToString:@"敬请期待"]) {
        string = @"敬请期待";
        isTouch = NO;
        
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        
    }else{
        isTouch = NO;
        string = [allDic objectForKey:@"zt"];
    }
    
    
   
    but3 = [Tool ButtonProductionFunction:string Frame:CGRectMake(0, ScreenHeight-45-64, ScreenWidth, 45) bgImgName:@"" FontFl:16];
    [but3 setBackgroundColor:[UIColor colorWithRed:2/255.0 green:160/255.0 blue:219/255.0 alpha:1]];
    [but3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    but3.tag = 190011;
    [self.view  addSubview:but3];
    if (isTouch==NO) {
        //but3.enabled = NO;
        //[but3 addTarget:self action:@selector(jiaru1) forControlEvents:UIControlEventTouchUpInside];
        [but3 setBackgroundColor:[UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0]];
        [but3 addTarget:self action:@selector(jiaru1) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [but3 addTarget:self action:@selector(jiaru) forControlEvents:UIControlEventTouchUpInside];
    }
  
}

//什么都不做
-(void)jiaru1{
    
}

//-(void)jishsi{
//    
//    //开始倒计时
//   
//    [[NSRunLoop currentRunLoop] addTimer:timerToSendUDP forMode:NSDefaultRunLoopMode]; 
//    [[NSRunLoop currentRunLoop] run];
//}



- (void)timerFireMethod:(NSTimer *)timer
{
 
    
    NSString *rzsysj = @"";
    if (projectTag==3) {
        rzsysj = [allDic objectForKey:@"fbsj"];
    }else{
        rzsysj = [allDic objectForKey:@"fbsj"];
    }
    
    int year = [[rzsysj substringToIndex:4] intValue];
    int moth = [[rzsysj substringWithRange:NSMakeRange(5,2)] intValue];
    int day = [[rzsysj substringWithRange:NSMakeRange(8,2)] intValue];
    int hour = [[rzsysj substringWithRange:NSMakeRange(11,2)] intValue];
    int minute = [[rzsysj substringWithRange:NSMakeRange(14,2)] intValue];
    int second = [[rzsysj substringWithRange:NSMakeRange(17,2)] intValue];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:moth];
    [components setDay:day];
    [components setHour:hour];
    [components setMinute:minute];
    [components setSecond:second];
    
    NSDate *fireDate = [calendar dateFromComponents:components];//目标时间
    NSDate *today = [NSDate date];//当前时间
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *d = [calendar components:unitFlags fromDate:today toDate:fireDate  options:0];//计算时间差
  
    
    //NSLog(@"%@",[NSString stringWithFormat:@"距离开始：%ld天%ld小时%ld分%ld秒", [d day], [d hour], [d minute], [d second]]);
    
    //特殊的判断
    if ([d second] <= 0 && [d minute]<=0 && [d hour] <=0 && [d day]<=0) {
     
        //[timer invalidate];
        //timer = nil;
        
//        [dataArray removeAllObjects];
//        [dataArray1 removeAllObjects];
//        [secondArray removeAllObjects];
//        
//        //发起网络请求
//        if (projectTag==0) {
//            [self sanInfo__startRequest];
//        }else if (projectTag==3){
//            [self tiYanInfo__startRequest];
//        }else if (projectTag==2){
//            [self zhaiquanInfo__startRequest];
//        }
        
        UIButton *button = (UIButton *)[[Tool getDele].window viewWithTag:190011];
        [button setTitle:[NSString stringWithFormat:@"距离开始：%d天%d小时%d分%d秒", 0,0,0,0] forState:UIControlStateNormal];
        
        
    }else{
        UIButton *button = (UIButton *)[[Tool getDele].window viewWithTag:190011];
        [button setTitle:[NSString stringWithFormat:@"距离开始：%ld天%ld小时%ld分%ld秒", [d day], [d hour], [d minute], [d second]] forState:UIControlStateNormal];
    }
}






- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataArray = [[NSMutableArray alloc] init];
    dataArray1 = [[NSMutableArray alloc] init];
    secondArray = [[NSMutableArray alloc] init];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    self.tableView = [Tool TableProductionFunction:self Frame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-45)];
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    [self.view addSubview:self.tableView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showmakefootView) name:@"showmakefootView" object:nil];
    
    
    
    //发起网络请求
    if (projectTag==0) {
        [self sanInfo__startRequest];
    }
    
    //更新数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gengxinshuju) name:@"gengxinshuju" object:nil];
  
}


// 更新数据
-(void)gengxinshuju{
    
    dataArray = [[NSMutableArray alloc] init];
    dataArray1 = [[NSMutableArray alloc] init];
    secondArray = [[NSMutableArray alloc] init];
    
    //发起网络请求
    if (projectTag==0) {
        [self sanInfo__startRequest];
    }
}




//显示样式
-(void)showmakefootView{
    [self makefootView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, 320, 40)];
    
    NSString *title = @"";
    
    
    if (section==0) {
        if (projectTag==2) {
            title=@"转让信息";
        }
    }
    
    if (section==1) {
        if (projectTag==3) {
            title=@"计划介绍";
        }
        if (projectTag==2) {
            title=@"标的信息";
        }
    }
    
    if (section==2) {
        if (projectTag==2) {
            title=@"标的介绍";
        }
    }
    
    
    
    if ([title length]==0) {
        return nil;
    }
    UILabel *lab = [Tool LablelProductionFunction:title Frame:CGRectMake(15,-20,200,40) Alignment:NSTextAlignmentLeft FontFl:14.5];
    [bgView addSubview:lab];
    //lab.font = FOUR_CONTROL_FONT;
    
    //债权转让
    if (projectTag==2) {
        if (section==0) {
            lab.frame = CGRectMake(15,0,200,40);
        }
    }
    
    
    return bgView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        if (projectTag==2) {
            return 40;
        }
        return 0.01;
    }
     return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    //债权转让
    if (projectTag==2) {
        if (section==2) {
            return 45;
        }else if (section==1){
            return 20;
        }
    }
    if (section==1) {
        return 45;
    }
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    //债权转让
    if (projectTag==2) {
        return 3;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    //债权转让
    if (projectTag==2) {
        if (section==0) {
            return [dataArray count];
        }else if (section==1){
            return [dataArray1 count];
        }else if (section==2){
            return secondArray.count;
        }
        
    }
    
    if (section==0) {
        return [dataArray count];
    }else if (section==1){
        return secondArray.count;
    }
    
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (projectTag==3){//理财体验
        
        if (indexPath.section==0) {
            
            if ([dataArray count]-1==indexPath.row) {
                return 40;
            }
            
            return 30;
        }else if (indexPath.section==1) {
            return cellHeight+20;
        }
        
    }
    
    //债权转让
    if (projectTag==2) {
        
        if (indexPath.section==0) {
            
            if ([dataArray count]-1==indexPath.row || indexPath.row==0) {
                return 40;
            }
        }
        if (indexPath.section==1) {
            if ([dataArray1 count]-1==indexPath.row || indexPath.row==0) {
                return 40;
            }
            return 30;
        }else if (indexPath.section==2){
            return 45;
        }
        
    }
   
    
    if (indexPath.section==1) {
        return 45;
    }
    
    if ([indexPath section]==0) {
        
        if ([dataArray count]-1==indexPath.row) {
            return 40;
        }
        
        return 30;
    }
    
    return 30;
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
    UILabel *lab123 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(15, 0, [Tool adaptation:200 with6:55 with6p:94], 30) Alignment:NSTextAlignmentLeft  FontFl:14.5];
    UILabel *lab1234 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(80, 40, ScreenWidth-80, 30) Alignment:NSTextAlignmentLeft  FontFl:12];
    [cell.contentView addSubview:lab123];
    [cell.contentView addSubview:lab1234];
    [cell.contentView addSubview:imgView];
    [lab1234 setTextColor:[UIColor darkGrayColor]];
    
    RCLabel *keyong = [[RCLabel alloc] initWithFrame:CGRectMake(120, 7, 160, 30)];
    [cell.contentView addSubview:keyong];
    
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (projectTag==0) {
        
        if (section==0) {//散标
            
            NSMutableDictionary *dic = [dataArray objectAtIndex:row];
            lab123.text = [dic objectForKey:@"left"];
            
            
            if ([lab123.text isEqualToString:@"投标进度"]) {
                
                // 进度
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(125, 12, 160, 6)];
                imgView.image = [UIImage imageNamed:@"line3-320.png"];
                [cell.contentView addSubview:imgView];
                
                //填充度
                UILabel *showjindu = [Tool LablelProductionFunction:@"" Frame:CGRectZero Alignment:NSTextAlignmentCenter FontFl:12];
                [imgView addSubview:showjindu];
                [showjindu setBackgroundColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]];
                [showjindu.layer setCornerRadius:2.0];
                [showjindu.layer setMasksToBounds:YES];
                showjindu.frame = CGRectMake(0,0,0,6);
                //[UIView beginAnimations:nil context:nil];
                //[UIView setAnimationDelay:2.0];
                showjindu.frame = CGRectMake(showjindu.frame.origin.x,showjindu.frame.origin.y,([[dic objectForKey:@"right"] intValue]/100.0) * 160,6);
                //[UIView commitAnimations];
            
                lab1234.text = [NSString stringWithFormat:@"%@%%",[dic objectForKey:@"right"]];
                lab1234.font = [UIFont systemFontOfSize:10];
                lab1234.frame = CGRectMake(125+162, 0, 200, 30);
                
                
            }else{
              
                keyong.componentsAndPlainText = [RCLabel extractTextStyle:[dic objectForKey:@"right"]];
            }
        
        }else if (section==1) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            NSMutableDictionary *dic = [secondArray objectAtIndex:row];
            lab123.text = [dic objectForKey:@"left"];
            lab123.font = [UIFont systemFontOfSize:15];
            lab123.frame = CGRectMake(15, 0, 320, 45);
            
            //边线
            if (row != 0) {
                UILabel *lab = [Tool LablelProductionFunction:@"" Frame:CGRectMake(15, 0, 320, 0.5) Alignment:NSTextAlignmentLeft FontFl:13];
                [lab setBackgroundColor:[UIColor lightGrayColor]];
                lab.alpha = 0.5;
                [cell.contentView addSubview:lab];
            }
        }
        
    }
 
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    //理财体验
    if (projectTag==3) {
        
        if (section==0) {
            
            
            NSMutableDictionary *dic = [dataArray objectAtIndex:row];
            if ([[dic objectForKey:@"left"] isEqualToString:@"理财说明"]) {
                WebController *web = [[WebController alloc] init];
                web.urlString = licai_lcsm_url;
                web.title = @"理财体验说明书";
                //返回
                UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
                backItem.title=@"返回";
                self.navigationItem.backBarButtonItem=backItem;
                self.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:web animated:YES];
                
            }
            
        }
        return;
    }
    
    //债权转让
    if (projectTag==2) {
        
        //web跳转
        if (section==2) {
            NSMutableDictionary *dic = [secondArray objectAtIndex:row];
            WebController *web = [[WebController alloc] init];
            web.urlString = [dic objectForKey:@"right"];
            web.title = [dic objectForKey:@"left"];
            //返回
            UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
            backItem.title=@"返回";
            self.navigationItem.backBarButtonItem=backItem;
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:web animated:YES];
            
        }
        
    }else{
        
        //web跳转
        if (section==1) {
            NSMutableDictionary *dic = [secondArray objectAtIndex:row];
            WebController *web = [[WebController alloc] init];
            web.urlString = [dic objectForKey:@"right"];
            web.title = [dic objectForKey:@"left"];
            //返回
            UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
            backItem.title=@"返回";
            self.navigationItem.backBarButtonItem=backItem;
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:web animated:YES];
            
        }
        
    }
}



//组装数据
-(void)makeData:(NSMutableDictionary *)dic{
    
    NSString *SS = [Tool toString:[dic objectForKey:@"rvalue"]];
    
    if ([SS isEqualToString:@"<null>"] || [SS isEqualToString:@"null"]) {
        return;
    }
    
    allDic = [dic objectForKey:@"rvalue"];
    if (allDic== Nil) {
        return;
    }
    
    SanProject *san = [[SanProject alloc] init];
    [san makeData:allDic withArray:dataArray withBgUrl:secondArray];
    [self makeHeadView_0:allDic];
    
    
    //低端
    [self makefootView];
    
    [self.tableView reloadData];
}



#pragma 网络请求
//散标列表
-(void)sanInfo__startRequest{
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/sbtz/get.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    if (self.projectId==nil) {
        return;
    }
    [postDic setObject:projectId forKey:@"id"];
    
    
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






@end
