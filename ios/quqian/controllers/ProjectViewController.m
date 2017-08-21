//
//  ProjectViewController.m
//  quqian
//
//  Created by apple on 15/3/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ProjectViewController.h"
#import "LoginTableViewController.h"
#import "SanProject.h"
#import "WenZhuanProject.h"
#import "ZhaiQuanProject.h"
#import "TiYanProject.h"

#import "SanViewCell.h"
#import "WenZhuanViewCell.h"
#import "ZhaiQuanViewCell.h"

#import "ApplyTiYanViewController.h"
#import "BuyZhaiquanViewController.h"
#import "ReserveWenViewController.h"
#import "MJRefresh.h"
#import "NewSanViewCell.h"


#import "HelpDownloader.h"


@interface ProjectViewController ()
{
    NSMutableArray *dataArray;
    int currPage;
    UISegmentedControl *segment;
    NSString *bdlx;
}
@end

@implementation ProjectViewController
@synthesize projectTag;

- (instancetype)initWithStyle:(UITableViewStyle)style{
    return self = [super initWithStyle:UITableViewStyleGrouped];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    

    //UIView *view=[[UIView alloc] initWithFrame:CGRectMake(200, 20, 80, 44)];
  
    bdlx = @"0";
 
    segment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"精选投资",@"存管投资", nil]];
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(exchange) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView=segment;
    
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]];
    
    
    currPage = 1;
    dataArray = [[NSMutableArray alloc] init];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NewSanViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    //集成下拉刷新的动画
    [self setupRefresh];
    
    
    //更新数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gengxinshuju) name:@"gengxinshuju" object:nil];
    
    //更新数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:@"reloadData" object:nil];
    
}


-(void)reloadData{
    NSString *project = [[NSUserDefaults standardUserDefaults] objectForKey:@"projectTag"];
    if ([project isEqualToString:@"0"]) {
        segment.selectedSegmentIndex = 0;
        bdlx = @"0";
    }else if ([project isEqualToString:@"1"]) {
        segment.selectedSegmentIndex = 1;
        bdlx = @"1";
    }
    currPage = 1;
    [self.tableView  headerBeginRefreshing];
}


-(void)exchange{
    if ([bdlx isEqualToString:@"0"]) {
         bdlx = @"1";
    }else{
         bdlx = @"0";
    }
    currPage = 1;
    [self.tableView  headerBeginRefreshing];
}



// 更新数据
-(void)gengxinshuju{
    [self.tableView headerBeginRefreshing];
}



/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    [self.tableView headerBeginRefreshing];
    
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
    [self san__startRequest:0];
}

- (void)footerRereshing
{
   [self san__startRequest:1];
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectio
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [dataArray count];;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    //散标
    NewSanViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSInteger row = [indexPath section];
    NSMutableDictionary *san = [dataArray objectAtIndex:row];
    [cell initMakeData:san withType:bdlx];
    
    cell.bid.tag = 100+row;
    [cell.bid addTarget:self action:@selector(bid_SanPress:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
  
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.section;

    if ([Tool getUser]==nil) {
        LoginTableViewController *loginView = [[LoginTableViewController alloc] init];
        loginView.title = @"登录";
        UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:loginView];
        [self presentViewController:na animated:YES completion:NULL];
        return;
    }
    
    
    NSMutableDictionary *dic = [dataArray objectAtIndex:row];
    
    ProjectInfoViewController *project = [[ProjectInfoViewController alloc] init];
    project.projectId = [dic objectForKey:@"id"];
    project.projectTag = 0;
    project.title = dic[@"bdbt"];
    project.bdlx = bdlx;
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:project animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}



//散标投资
-(void)bid_SanPress:(UIButton *)but{
    
    if ([Tool getUser]==nil) {
        LoginTableViewController *loginView = [[LoginTableViewController alloc] init];
        loginView.title = @"登录";
        UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:loginView];
        [self presentViewController:na animated:YES completion:NULL];
        return;
    }
    
    BuyZhaiquanViewController *buy = [[BuyZhaiquanViewController alloc] init];
    buy.title = @"立即投标";
    buy.allDic = [dataArray objectAtIndex:but.tag-100];
    buy.typeTag = @"1";
    
    if ([bdlx isEqualToString:@"0"]) {
        buy.iscunguan = 0;
    }else{
        buy.iscunguan = 1;
    }
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:buy animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}


//稳赚保
-(void)bid_WenzhuanPress:(UIButton *)but{
    if ([Tool getUser]==nil) {
        LoginTableViewController *loginView = [[LoginTableViewController alloc] init];
        loginView.title = @"登录";
        UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:loginView];
        [self presentViewController:na animated:YES completion:NULL];
        return;
    }
    ReserveWenViewController *reserve = [[ReserveWenViewController alloc] init];
    reserve.title = @"立即预定";
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:reserve animated:YES];
}

//债权转让
-(void)bid_ZhaiquanPress:(UIButton *)but{
    if ([Tool getUser]==nil) {
        LoginTableViewController *loginView = [[LoginTableViewController alloc] init];
        loginView.title = @"登录";
        UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:loginView];
        [self presentViewController:na animated:YES completion:NULL];
        return;
    }
    BuyZhaiquanViewController *buy = [[BuyZhaiquanViewController alloc] init];
    buy.title = @"立即购买";
    buy.typeTag = @"0";
    buy.allDic = [dataArray objectAtIndex:but.tag-100];
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:buy animated:YES];
}

//投资体验
-(void)bid_TiYanPress:(UIButton *)but{
    if ([Tool getUser]==nil) {
        LoginTableViewController *loginView = [[LoginTableViewController alloc] init];
        loginView.title = @"登录";
        UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:loginView];
        [self presentViewController:na animated:YES completion:NULL];
        return;
    }
    ApplyTiYanViewController *apply = [[ApplyTiYanViewController alloc] init];
    apply.title = @"立即申请";
    apply.allDic = [dataArray objectAtIndex:but.tag-100];
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:apply animated:YES];
}








//刷新页面
-(void)reloadViews:(int)isUp withDic:(NSMutableDictionary *)allDic{
    
    NSString *SS = [Tool toString:[allDic objectForKey:@"rvalue"]];
    
    if ([SS isEqualToString:@"<null>"]) {
        return;
    }
    
    //读取数据刷新页面
    NSArray *jsonArray = [allDic objectForKey:@"rvalue"];
    if (isUp==0) {
        [dataArray removeAllObjects];
    }
    for (NSMutableDictionary *dic in jsonArray) {
        [dataArray addObject:dic];
    }
    
    //dataArray
    
    if ([[allDic objectForKey:@"totalpage"] intValue] <= currPage) {
        self.tableView.footerHidden = YES;
    }
}






#pragma 网络请求
//散标列表
-(void)san__startRequest:(int)isUp{
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/sbtz/list.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    if (isUp==0) {
        currPage = 1;
    }else{
        currPage++;
    }
    
   [postDic setObject:[NSString stringWithFormat:@"%d",currPage] forKey:@"page"];
   [postDic setObject:bdlx forKey:@"bdlx"];
    
    
    
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"no",@"isshowHUD",
                                           @"no",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   
                                   if (kk==0) {
                                     
                                       //开始刷新页面数据
                                       [self reloadViews:isUp withDic:[data JSONValue]];
                                   }else{
                                       
                                   }
                                
                                   [self.tableView headerEndRefreshing];
                                   [self.tableView footerEndRefreshing];
                                   [self.tableView reloadData];
                                   
                               }];
    
}


//投资体验－－列表
-(void)tiyan__startRequest:(int)isUp{
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/lcty/list.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    
    if (isUp==0) {
        currPage = 1;
    }else{
        currPage++;
    }
    
    [postDic setObject:[NSString stringWithFormat:@"%d",currPage] forKey:@"page"];
    
    
    
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"no",@"isshowHUD",
                                           @"no",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   
                                   if (kk==0) {
                                      
                                       //开始刷新页面数据
                                       [self reloadViews:isUp withDic:[data JSONValue]];
                                   }else{
                                       
                                   }
                                   
                                   [self.tableView headerEndRefreshing];
                                   [self.tableView footerEndRefreshing];
                                   [self.tableView reloadData];
                                   
                               }];
    
}



//债权转让－－列表
-(void)zhaiquan__startRequest:(int)isUp{
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/zqzr/list.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    if (isUp==0) {
        currPage = 1;
    }else{
        currPage++;
    }
    
    [postDic setObject:[NSString stringWithFormat:@"%d",currPage] forKey:@"page"];
    

    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"no",@"isshowHUD",
                                           @"no",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   
                                   if (kk==0) {
                                       
                                     
                                       //开始刷新页面数据
                                       [self reloadViews:isUp withDic:[data JSONValue]];
                                   }else{
                                       
                                   }
                                   
                                   [self.tableView headerEndRefreshing];
                                   [self.tableView footerEndRefreshing];
                                   [self.tableView reloadData];
                                   
                               }];
    
}





@end
