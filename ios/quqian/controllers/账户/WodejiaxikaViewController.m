//
//  WodejiaxikaViewController.m
//  qianbangzhu
//
//  Created by 宋培众 on 2017/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WodejiaxikaViewController.h"
#import "Tool.h"
#import "HelpDownloader.h"
#import "MJRefresh.h"
#import "RCLabel.h"


@interface WodejiaxikaViewController ()
{
    UIButton *cgkaitong_but;
    UIButton *ptkaitong_but;
    UIButton *other_but;
    UIView *selcteView;
    NSMutableDictionary *alldic;
    NSMutableArray *arraydata;
    UITableView *myTabview;
    int tag;
    int curPage;
}
@end

@implementation WodejiaxikaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    curPage = 1;
    arraydata = [NSMutableArray arrayWithCapacity:0];
    [self createview];
}

-(void)createview{
    cgkaitong_but = [Tool ButtonProductionFunction:@"未使用" Frame:CGRectMake(0, 0, ScreenWidth/3, 45) bgImgName:nil FontFl:15];
    [cgkaitong_but addTarget:self action:@selector(cgkaitong_but_p) forControlEvents:UIControlEventTouchUpInside];
    [cgkaitong_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [cgkaitong_but setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:cgkaitong_but];
    
    ptkaitong_but = [Tool ButtonProductionFunction:@"已使用" Frame:CGRectMake(ScreenWidth/3, 0, ScreenWidth/3, 45) bgImgName:nil FontFl:15];
    [ptkaitong_but addTarget:self action:@selector(ptkaitong_but_p) forControlEvents:UIControlEventTouchUpInside];
    [ptkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [ptkaitong_but setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:ptkaitong_but];
    
    other_but = [Tool ButtonProductionFunction:@"已过期" Frame:CGRectMake(2*ScreenWidth/3, 0, ScreenWidth/3, 45) bgImgName:nil FontFl:15];
    [other_but addTarget:self action:@selector(other_but_p) forControlEvents:UIControlEventTouchUpInside];
    [other_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [other_but setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:other_but];

    
    
    selcteView = [[UIView alloc] initWithFrame:CGRectZero];
    [selcteView setBackgroundColor:KTHCOLOR];
    [self.view addSubview:selcteView];
    
    myTabview = [Tool TableProductionFunction:self Frame:CGRectMake(0, 50, ScreenWidth, ScreenHeight-64-50)];
    [self.view addSubview:myTabview];
    [myTabview setBackgroundColor:RGB(242, 242, 242)];
    
    [self cgkaitong_but_p];
    
    [self setupRefresh];
}



/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [myTabview addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    //[self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [myTabview addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    myTabview.headerPullToRefreshText = @"下拉可以刷新了";
    myTabview.headerReleaseToRefreshText = @"松开马上刷新了";
    myTabview.headerRefreshingText = @"钱帮主正在刷新中";
    
    myTabview.footerPullToRefreshText = @"上拉可以加载更多数据了";
    myTabview.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    myTabview.footerRefreshingText = @"钱帮主正在加载中";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    curPage=1;
    if (tag==0) {
        [self networkload:@"WSY"];
    }else if (tag==1){
        [self networkload:@"YSY"];
    }else if (tag==2){
        [self networkload:@"YGQ"];
    }
}

- (void)footerRereshing
{
    curPage++;
    if (tag==0) {
        [self networkload:@"WSY"];
    }else if (tag==1){
        [self networkload:@"YSY"];
    }else if (tag==2){
        [self networkload:@"YGQ"];
    }
}



-(void)cgkaitong_but_p{
    selcteView.frame = CGRectMake(0,43, ScreenWidth/3, 2);
    [cgkaitong_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [ptkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [other_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    tag = 0;
    curPage = 1;
    [self networkload:@"WSY"];
}


-(void)ptkaitong_but_p{
    selcteView.frame = CGRectMake(ScreenWidth/3,43, ScreenWidth/3, 2);
    [ptkaitong_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [cgkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [other_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    tag = 1;
    curPage = 1;
    [self networkload:@"YSY"];
}

-(void)other_but_p{
    selcteView.frame = CGRectMake(2*ScreenWidth/3,43, ScreenWidth/3, 2);
    [other_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [ptkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [cgkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    tag = 2;
    curPage = 1;
    [self networkload:@"YGQ"];
}

-(void)networkload:(NSString *)ss{
    NSString *url =[NSString stringWithFormat:@"%@/user/jxk/list.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    [postDic setObject:ss forKey:@"zt"];
    [postDic setObject:[NSString stringWithFormat:@"%d",curPage] forKey:@"page"];
    
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"no",@"isshowHUD",
                                           @"no",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   if (kk==0) {
                                       if (kk==0) {
                                           if (curPage==1) {
                                               [arraydata removeAllObjects];
                                           }
                                           NSMutableDictionary *dic = [data JSONValue];
                                           if (![dic[@"rvalue"] isKindOfClass:[NSNull class]]) {
                                               [arraydata addObjectsFromArray:[data JSONValue][@"rvalue"][@"items"]];
                                           }else{
                                               [Tool myalter:@"暂无数据"];
                                           }
                                       }
                                       [myTabview headerEndRefreshing];
                                       [myTabview footerEndRefreshing];
                                       [myTabview reloadData];
                                   }
                               }];
    
}

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
    return arraydata.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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
    
    NSArray *viewArray = [cell.contentView subviews];
    for (int i = 0; i < [viewArray count]; i++) {
        UIView *view = [viewArray objectAtIndex:i];
        [view removeFromSuperview];view=nil;
    }
    
    
    RCLabel *planAllMoney = [[RCLabel alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth/3, 60)];
    [cell.contentView addSubview:planAllMoney];
    
    RCLabel *yearlilv = [[RCLabel alloc] initWithFrame:CGRectMake(ScreenWidth/3, 10, ScreenWidth/3, 60)];
    [cell.contentView addSubview:yearlilv];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/3, 10, 0.5, 40)];
    [line1 setBackgroundColor:RGB(238, 238, 238)];
    //[cell.contentView addSubview:line1];
    
    RCLabel *lastTime = [[RCLabel alloc] initWithFrame:CGRectMake(2*ScreenWidth/3,10, ScreenWidth/3, 60)];
    [cell.contentView addSubview:lastTime];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(2*ScreenWidth/3, 10, 0.5, 40)];
    [line2 setBackgroundColor:RGB(238, 238, 238)];
    //[cell.contentView addSubview:line2];

    NSMutableDictionary *dicdata = [arraydata objectAtIndex:indexPath.row];

    
    planAllMoney.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:dicdata[@"jxkhm"]  withDanwei:@"" withName:@"加息卡号码"]];
    
    yearlilv.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:@""  withDanwei:dicdata[@"mz"] withName:@"面值"]];
    
    if(tag==0){
        lastTime.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%@至%@",dicdata[@"lqsj"],dicdata[@"dqsj"]]  withDanwei:@"" withName:@"有效期"]];
    }else if (tag==1){
        lastTime.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%@",dicdata[@"sysj"]]  withDanwei:@"" withName:@"使用时间"]];
    }else if (tag==2){
        lastTime.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:dicdata[@"dqsj"]  withDanwei:@"" withName:@"过期时间"]];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//转换
-(NSString *)exchage:(NSString *)string withDanwei:(NSString *)danwei withName:(NSString *)name{
    return [NSString stringWithFormat:@"<p align=center><font size=15 face='HelveticaNeue'>%@</font><font size=12 face='HelveticaNeue'>%@</font>\n<font size =11 color='#8B8B8B' face='HelveticaNeue'>%@</font></p>",string,danwei,name];
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
