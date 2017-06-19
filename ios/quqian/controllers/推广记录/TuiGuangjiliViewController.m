//
//  TuiGuangjiliViewController.m
//  qianbangzhu
//
//  Created by 宋培众 on 2017/6/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TuiGuangjiliViewController.h"
#import "Tool.h"
#import "HelpDownloader.h"
#import "MJRefresh.h"

@interface TuiGuangjiliViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    int page;
    int type;
    NSMutableArray *dataArray;
}

@property(nonatomic,retain)UITableView *tableView;

@end

@implementation TuiGuangjiliViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setupRefresh];
    
    
    dataArray = [[NSMutableArray alloc] init];
    page = 1;
    [self.tableView headerBeginRefreshing];
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
    [self getData];
}

- (void)footerRereshing
{
    page++;
    [self getData];
}





-(void)getData{
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/user/tggl/list.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
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
        lab1.text = @"好友手机号";
        lab2.text = @"注册时间";
        lab3.text = @"存管状态";
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
