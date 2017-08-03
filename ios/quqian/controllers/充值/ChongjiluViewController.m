//
//  ChongjiluViewController.m
//  qianbangzhu
//
//  Created by 宋培众 on 2017/6/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ChongjiluViewController.h"
#import "Tool.h"
#import "HelpDownloader.h"
#import "MJRefresh.h"


@interface ChongjiluViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *cgkaitong_but;
    UIButton *ptkaitong_but;
    UIView *selcteView;
    int page;
    int type;
    NSMutableArray *dataArray;
}

@property(nonatomic,retain)UITableView *tableView;

@end

@implementation ChongjiluViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:RGB(236, 243, 246)];
    
    cgkaitong_but = [Tool ButtonProductionFunction:@"存管充值" Frame:CGRectMake(ScreenWidth/2, 0, ScreenWidth/2, 45) bgImgName:nil FontFl:15];
    [cgkaitong_but addTarget:self action:@selector(cgkaitong_but_p) forControlEvents:UIControlEventTouchUpInside];
    [cgkaitong_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [cgkaitong_but setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:cgkaitong_but];
    
    ptkaitong_but = [Tool ButtonProductionFunction:@"普通充值" Frame:CGRectMake(0, 0, ScreenWidth/2, 45) bgImgName:nil FontFl:15];
    [ptkaitong_but addTarget:self action:@selector(ptkaitong_but_p) forControlEvents:UIControlEventTouchUpInside];
    [ptkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [ptkaitong_but setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:ptkaitong_but];
    
    selcteView = [[UIView alloc] initWithFrame:CGRectZero];
    [selcteView setBackgroundColor:KTHCOLOR];
    [self.view addSubview:selcteView];

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,50, ScreenWidth, ScreenHeight-50-64) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setupRefresh];
    
    
    dataArray = [[NSMutableArray alloc] init];
    
    [self ptkaitong_but_p];
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




-(void)cgkaitong_but_p{
    page = 1;
    type = 0;
    selcteView.frame = CGRectMake(ScreenWidth/2,43, ScreenWidth/2, 2);
    [self headerRereshing];
    [cgkaitong_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [ptkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
}


-(void)ptkaitong_but_p{
    page=1;
    type = 1;
    selcteView.frame = CGRectMake(0,43, ScreenWidth/2, 2);
    [self headerRereshing];
    [ptkaitong_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [cgkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
}


-(void)getData{
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/user/deal/payRecord.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    if (type==0) {
        [postDic setObject:@"CGCZ" forKey:@"type"];
    } else {
        [postDic setObject:@"PTCZ" forKey:@"type"];
    }
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
                                       if (![[data JSONValue][@"rvalue"] isKindOfClass:[NSNull class]]) {
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
    return [dataArray count]+1;
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
    
    if (indexPath.row==0) {
        lab1.text = @"交易时间";
        lab2.text = @"充值金额";
        lab3.text = @"状态";
    }else{
        NSMutableDictionary *dic = dataArray[indexPath.row-1];
        lab1.text = dic[@"time"];
        lab2.text = dic[@"je"];
        lab3.text = dic[@"zt"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
