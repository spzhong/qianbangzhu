//
//  MyTiYanViewController.m
//  quqian
//
//  Created by apple on 15/3/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MyTiYanViewController.h"
#import "ProjectInfoViewController.h"
#import "TiYanProject.h"
#import "WenZhuanViewCell.h"
#import "OwnSanViewCell.h"
#import "MJRefresh.h"
#import "HelpDownloader.h"
#import "ApplyTiYanViewController.h"

@interface MyTiYanViewController ()
{
    NSMutableArray *dataArray;
    NSInteger segmenteTag;//0申请中",1"参与中",2"已截止
    int currPage;
}
@end


@implementation MyTiYanViewController
@synthesize projectTag;



#pragma mark - Table view data source
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
    dataArray = [[NSMutableArray alloc] init];
 
    
    self.tableView.tableHeaderView = [self headView];
    
    [self setupRefresh];
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
    [self mytiyan__startRequest:0];
}

- (void)footerRereshing
{
    [self mytiyan__startRequest:1];
}






//选择呢
-(void)segmentedPress:(UISegmentedControl *)seg{
    segmenteTag = seg.selectedSegmentIndex;
    [dataArray removeAllObjects];
    [self.tableView reloadData];
    //开始更新
    [self.tableView headerBeginRefreshing];
}


-(UIView*)headView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"申请中",@"参与中",@"已截止", nil]];
    
    seg.selectedSegmentIndex = 0;
    
    [seg addTarget:self action:@selector(segmentedPress:) forControlEvents:UIControlEventValueChanged];
    seg.frame = CGRectMake(15, 15, 290, 30);
    [view addSubview:seg];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{
                                                              NSForegroundColorAttributeName : [UIColor colorWithRed:2/255.0 green:161/255.0 blue:219/255.0 alpha:1.0]
                                                              } forState:UIControlStateNormal];
    [seg setTintColor:[UIColor colorWithRed:2/255.0 green:161/255.0 blue:219/255.0 alpha:1.0]];
    
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Table view data source


//
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.1;
    }
    return 0;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 15;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (segmenteTag!=0) {
        return 85;
    }
    return 106;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //申请中
    if (segmenteTag==0) {
        static NSString *CellIdentifier1 = @"Cell1";
        WenZhuanViewCell *cell = (WenZhuanViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        
        if (cell == nil) {
            NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"WenZhuanViewCell" owner:self options:nil] ;
            cell = [nib objectAtIndex:0];
        }
        NSInteger row = [indexPath row];
        NSMutableDictionary *tiyan = [dataArray objectAtIndex:row];
        [cell initMakeData_tiyan:tiyan withMy:@""];
        
        cell.bid.tag = 100+row;
        [cell.bid addTarget:self action:@selector(bid_SanPress:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }
    
    
    
    ///////////////////////////////////////////////////////////////////
    
    
    static NSString *CellIdentifier = @"Cell";
    OwnSanViewCell *cell = (OwnSanViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"OwnSanViewCell" owner:self options:nil] ;
        cell = [nib objectAtIndex:0];
    }
    
    NSInteger row = [indexPath row];
    NSMutableDictionary *tiyan = [dataArray objectAtIndex:row];
    if (segmenteTag==1){
        [cell tiyan_initMakeData_1:tiyan];
    }else if (segmenteTag==2){
        [cell tiyan_initMakeData_2:tiyan];
    }
    
    return cell;
    
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSMutableDictionary *dic = [dataArray objectAtIndex:row];
    
    ProjectInfoViewController *project = [[ProjectInfoViewController alloc] init];
    project.projectId = [dic objectForKey:@"id"];
    project.projectTag = 3;
    project.title = @"投资体验详情";
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:project animated:YES];
}



//点击
-(void)bid_SanPress:(UIButton *)but{
    
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



//－－列表
-(void)mytiyan__startRequest:(int)isUp{
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/user/lcty/list.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    if (isUp==0) {
        currPage = 1;
    }else{
        currPage++;
    }
    [postDic setObject:[NSString stringWithFormat:@"%d",currPage] forKey:@"page"];
    [postDic setObject:[NSString stringWithFormat:@"%ld",segmenteTag] forKey:@"status"];
    
    
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"no",@"isshowHUD",
                                           @"no",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   
                                   if (kk==0) {
                                       
                                       NSMutableDictionary *allDic = [data JSONValue];
                                       
                                       NSString *SS = [Tool toString:[allDic objectForKey:@"rvalue"]];
                                       
                                       if (![SS isEqualToString:@"<null>"]) {
                                           
                                           //读取数据刷新页面
                                           NSArray *jsonArray = [allDic objectForKey:@"rvalue"];
                                           if (isUp==0) {
                                               [dataArray removeAllObjects];
                                           }
                                           for (NSMutableDictionary *dic in jsonArray) {
                                               [dataArray addObject:dic];
                                           }
                                       }
                                     
                                   }else{
                                       
                                   }
                                   
                                   [self.tableView headerEndRefreshing];
                                   [self.tableView footerEndRefreshing];
                                   [self.tableView reloadData];
                                   
                               }];
    
}



@end
