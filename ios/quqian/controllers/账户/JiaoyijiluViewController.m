//
//  JiaoyijiluViewController.m
//  qianbangzhu
//
//  Created by 宋培众 on 2017/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "JiaoyijiluViewController.h"
#import "Tool.h"
#import "HelpDownloader.h"
#import "MJRefresh.h"

@interface JiaoyijiluViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    UIButton *cgkaitong_but;
    UIButton *ptkaitong_but;
    UIView *selcteView;
    int page;
    int type;
    NSMutableArray *dataArray;
    NSString *jylx;
    NSString *jysj;
    NSString *jytype;
    
    NSMutableArray *jiaoyileixing;
    NSMutableArray *jiayishijian;
    
    UILabel *lab11;
    UILabel *lab33;
    
    UIImageView *jiantou;
    UIImageView *jiantou2;
}

@property(nonatomic,retain)UITableView *tableView;
@end

@implementation JiaoyijiluViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    jylx = @"";
    jysj = @"";
    jytype = @"1";
    dataArray = [[NSMutableArray alloc] init];
    page = 1;
    
    jiaoyileixing = [NSMutableArray arrayWithCapacity:0];
    jiayishijian = [NSMutableArray arrayWithCapacity:0];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,50, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    [self createview:nil];
    
    
    
    UIView *bgHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    [bgHead setBackgroundColor:[UIColor whiteColor]];
    
    lab11 = [Tool LablelProductionFunction:@"交易类型" Frame:CGRectMake(0, 0, ScreenWidth/3, 44) Alignment:NSTextAlignmentCenter FontFl:15];
    UILabel *lab2 = [Tool LablelProductionFunction:@"交易金额" Frame:CGRectMake(ScreenWidth/3, 0, ScreenWidth/3, 44) Alignment:NSTextAlignmentCenter FontFl:15];
    lab33 = [Tool LablelProductionFunction:@"时间" Frame:CGRectMake(2*ScreenWidth/3, 0, ScreenWidth/3, 44) Alignment:NSTextAlignmentCenter FontFl:15];
    [bgHead addSubview:lab11];
    [bgHead addSubview:lab2];
    [bgHead addSubview:lab33];
    
    jiantou  = [Tool ImgProductionFunctionFrame:CGRectMake(ScreenWidth/3/2+40, 17, 9, 9) bgImgName:@"箭头D"];
    [lab11 addSubview:jiantou];
    jiantou2 = [Tool ImgProductionFunctionFrame:CGRectMake(ScreenWidth/3/2+25, 17, 9, 9) bgImgName:@"箭头D"];
    [lab33 addSubview:jiantou2];
    
    
    lab11.userInteractionEnabled = YES;
    lab33.userInteractionEnabled = YES;
    
    
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jiaoyileixing)];
    [lab11 addGestureRecognizer:tapGesturRecognizer];
    
    UITapGestureRecognizer *tapGesturRecognizer2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shijian)];
    [lab33 addGestureRecognizer:tapGesturRecognizer2];

    
    bgHead.userInteractionEnabled = YES;
    self.tableView.tableHeaderView = bgHead;
    
    
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/user/jyjl/parameters.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
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
                                       NSArray *aray =  dic[@"rvalue"];
                                       if (aray.count==2) {
                                           NSMutableDictionary *dicOne = aray[0];
                                           if ([dicOne[@"selecttype"] isEqualToString:@"0"]) {
                                               [jiaoyileixing addObjectsFromArray:dicOne[@"type"]];
                                               [jiayishijian addObjectsFromArray:aray[1][@"type"]];
                                           }else{
                                               [jiaoyileixing addObjectsFromArray:aray[1][@"type"]];
                                               [jiayishijian addObjectsFromArray:aray[0][@"type"]];
                                           }
                                       }
                                   }
                               }];
    
    
    
    
    
}

-(void)createview:(NSMutableDictionary *)dic{
    
    cgkaitong_but = [Tool ButtonProductionFunction:@"存管账户" Frame:CGRectMake(0, 0, ScreenWidth/2, 45) bgImgName:nil FontFl:15];
    [cgkaitong_but addTarget:self action:@selector(cgkaitong_but_p) forControlEvents:UIControlEventTouchUpInside];
    [cgkaitong_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [cgkaitong_but setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:cgkaitong_but];
    
    ptkaitong_but = [Tool ButtonProductionFunction:@"普通账户" Frame:CGRectMake(ScreenWidth/2, 0, ScreenWidth/2, 45) bgImgName:nil FontFl:15];
    [ptkaitong_but addTarget:self action:@selector(ptkaitong_but_p) forControlEvents:UIControlEventTouchUpInside];
    [ptkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [ptkaitong_but setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:ptkaitong_but];
    
    selcteView = [[UIView alloc] initWithFrame:CGRectZero];
    [selcteView setBackgroundColor:KTHCOLOR];
    [self.view addSubview:selcteView];
    
    [self cgkaitong_but_p];
}

-(void)cgkaitong_but_p{
    selcteView.frame = CGRectMake(0,43, ScreenWidth/2, 2);
    [cgkaitong_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [ptkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    jytype = @"1";
    page = 1;
    [self getData];
}


-(void)ptkaitong_but_p{
    selcteView.frame = CGRectMake(ScreenWidth/2,43, ScreenWidth/2, 2);
    [ptkaitong_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [cgkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    jytype = @"0";
    page = 1;
    [self getData];
}



/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    //[self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableView.headerRefreshingText = @"钱帮主正在刷新中";
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @"钱帮主正在加载中";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    page=1;
    [self getData];
}

- (void)footerRereshing
{
    page++;
    [self getData];
}





-(void)getData{
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/user/jyjl/list.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:jylx forKey:@"jylx"];
    [postDic setObject:jysj forKey:@"jysj"];
    [postDic setObject:jytype forKey:@"jytype"];
    [postDic setObject:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"no",@"isshowHUD",
                                           @"no",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   if (kk==0) {
                                       if (page==1) {
                                           [dataArray removeAllObjects];
                                       }
                                       
                                       NSMutableDictionary *dic = [data JSONValue];
                                       if (![dic[@"rvalue"] isKindOfClass:[NSNull class]]) {
                                           [dataArray addObjectsFromArray:[data JSONValue][@"rvalue"][@"items"]];
                                       }else{
                                           [Tool myalter:@"暂无数据"];
                                       }
                                   }
                                   [self.tableView headerEndRefreshing];
                                   [self.tableView footerEndRefreshing];
                                   [self.tableView reloadData];
                               }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier1 = @"Cell1";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
    }
    for (UIView *subs in cell.contentView.subviews) {
        [subs removeFromSuperview];
    }
    
    UILabel *lab1 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(0, 0, ScreenWidth/3, 44) Alignment:NSTextAlignmentCenter FontFl:15];
    UILabel *lab2 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(ScreenWidth/3, 0, ScreenWidth/3, 44) Alignment:NSTextAlignmentCenter FontFl:15];
    UILabel *lab3 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(2*ScreenWidth/3, 0, ScreenWidth/3, 44) Alignment:NSTextAlignmentCenter FontFl:15];
    [cell.contentView addSubview:lab1];
    [cell.contentView addSubview:lab2];
    [cell.contentView addSubview:lab3];
    
    NSMutableDictionary *dic = dataArray[indexPath.row];
    lab1.text = dic[@"jylx"];
    lab2.text = dic[@"jyje"];
    lab3.text = dic[@"jysj"];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)jiaoyileixing{
    UIAlertView *al = [[UIAlertView alloc] init];
    al.delegate = self;
    al.tag = 100;
    for (NSMutableDictionary *dic in jiaoyileixing) {
        [al addButtonWithTitle:dic[@"value"]];
    }
    [al show];
}

-(void)shijian{
    UIAlertView *al = [[UIAlertView alloc] init];
    al.delegate = self;
    al.tag = 101;
    for (NSMutableDictionary *dic in jiayishijian) {
        [al addButtonWithTitle:dic[@"value"]];
    }
    [al show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==100) {
        NSMutableDictionary *dicone = jiaoyileixing[buttonIndex];
        jylx = dicone[@"key"];
        lab11.text = dicone[@"value"];
        [lab11 sizeToFit];
        jiantou.frame = CGRectMake(lab11.frame.size.width+5, jiantou.frame.origin.y, jiantou.frame.size.width, jiantou.frame.size.height);
    }else{
        NSMutableDictionary *dicone = jiayishijian[buttonIndex];
        jysj = dicone[@"key"];
        lab33.text = dicone[@"value"];
        [lab33 sizeToFit];
        jiantou2.frame = CGRectMake(lab33.frame.size.width+5, jiantou2.frame.origin.y, jiantou2.frame.size.width, jiantou2.frame.size.height);
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
