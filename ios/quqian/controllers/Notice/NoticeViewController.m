//
//  NoticeViewController.m
//  quqian
//
//  Created by apple on 15/3/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NoticeViewController.h"
#import "Tool.h"
#import "RCLabel.h"
#import "EGOImageView.h"
#import "NoticeInfoViewController.h"
#import "HelpDownloader.h"
#import "MJRefresh.h"
#import "UserModel.h"


@interface NoticeViewController (){
    NSMutableArray *dataArray;
    int allCount;
    int reCount;
    int unreadNumble;
    int currPage;
    UserModel *user;
}

@end

@implementation NoticeViewController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    return self = [super initWithStyle:UITableViewStyleGrouped];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if (user.tongzhiweidu != nil) {
        self.tableView.tableHeaderView = [self headView];
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    user = [Tool getUser];
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    dataArray = [[NSMutableArray alloc] init];
    //集成下拉刷新的动画
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
    [self tognzhi__startRequest:0];
}

- (void)footerRereshing
{
    [self tognzhi__startRequest:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIView *)headView{
    
    RCLabel *head = [[RCLabel alloc] initWithFrame:CGRectMake(20, 0, 300, 40)];
    
    head.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=left>\n<font size=14 >  %d</font><font  size=14 >条站内消息，</font><font size=14 color='#EA9500'>%@</font><font size=14>条未读</font></p>",allCount,user.tongzhiweidu]];
    head.frame = CGRectMake(15, 0, 300, 45);
    return head;
}



#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .5;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
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
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    NSArray *viewArray = [cell.contentView subviews];
    for (int i = 0; i < [viewArray count]; i++) {
        UIView *view = [viewArray objectAtIndex:i];
        [view removeFromSuperview];view=nil;
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    EGOImageView*imgView =[[EGOImageView alloc] init];
    imgView.frame = CGRectMake(15, 15, 15, 15);
    [cell.contentView addSubview:imgView];
    
    UILabel *lab1 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(45, 0, [Tool adaptation:100 with6:55 with6p:94], 45) Alignment:NSTextAlignmentLeft  FontFl:14];
    UILabel *lab2 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(0, 0, [Tool adaptation:290 with6:55 with6p:94], 45) Alignment:NSTextAlignmentRight  FontFl:14];
    [lab2 setTextColor:[UIColor darkGrayColor]];
    [cell.contentView addSubview:lab1];
    [cell.contentView addSubview:lab2];
    
    NSMutableDictionary *dic = [dataArray objectAtIndex:row];
    
    
    lab1.text = [dic objectForKey:@"title"];
    lab2.text = [dic objectForKey:@"sendTime"];
    
    //未读
    if ([[dic objectForKey:@"status"] isEqualToString:@"0"]) {
        imgView.image = [UIImage imageNamed:@"icon26-2.png"];
    }else{
        imgView.image = [UIImage imageNamed:@"icon26-1.png"];
        lab1.textColor = [UIColor grayColor];
        lab2.textColor = [UIColor grayColor];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NoticeInfoViewController *info = [[NoticeInfoViewController alloc] init];
    info.title = @"消息详情";
    info.noticeDic = [dataArray objectAtIndex:indexPath.row];
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:info animated:YES];
}




//通知－－列表
-(void)tognzhi__startRequest:(int)isUp{
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/user/xxgl/list.htm",BASE_URL];
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
                                       
                                       NSMutableDictionary *allDic = [data JSONValue];
                                       NSString *SS = [Tool toString:[allDic objectForKey:@"rvalue"]];
                                       if ([SS isEqualToString:@"<null>"]) {
                                           return;
                                       }
                                       
                                       unreadNumble = [[[allDic objectForKey:@"rvalue"] objectForKey:@"unreadNumber"] intValue];
                                       allCount = [[[allDic objectForKey:@"rvalue"] objectForKey:@"toalNumber"] intValue];
                                       
                                       // 保存未读
                                       user.tongzhiweidu = [[allDic objectForKey:@"rvalue"] objectForKey:@"unreadNumber"];
                                       [Tool savecoredata];
                                       
                                    
                                       //读取数据刷新页面
                                       NSArray *jsonArray = [[allDic objectForKey:@"rvalue"] objectForKey:@"lists"];
                                       if (isUp==0) {
                                           [dataArray removeAllObjects];
                                       }
                                       for (NSMutableDictionary *dic in jsonArray) {
                                           [dataArray addObject:dic];
                                       }
                                       
                                       
                                       if ([[allDic objectForKey:@"totalpage"] intValue] <= currPage) {
                                           self.tableView.footerHidden = YES;
                                       }
                                       
                                       
                                       self.tableView.tableHeaderView = [self headView];
                                      
                                   }else{
                                       
                                   }
                                   
                                   [self.tableView headerEndRefreshing];
                                   [self.tableView footerEndRefreshing];
                                   [self.tableView reloadData];
                                   
                                   
                               }];
    
}




@end
