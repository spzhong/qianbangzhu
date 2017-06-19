//
//  MyWenZhuanViewController.m
//  quqian
//
//  Created by apple on 15/3/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MyWenZhuanViewController.h"
#import "WenZhuanProject.h"
#import "ProjectInfoViewController.h"
#import "MyWenZhuanViewCell.h"



@interface MyWenZhuanViewController ()
{
    
    NSMutableArray *dataArray;
    NSInteger segmenteTag;//0预定中",1"持有中",2"已退出
}
@end

@implementation MyWenZhuanViewController
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
    
    //初始化数据
    [self initData_wen:nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyWenZhuanViewCell" bundle:nil] forCellReuseIdentifier:@"Cell2"];
    
    self.tableView.tableHeaderView = [self headView];
}




//选择呢
-(void)segmentedPress:(UISegmentedControl *)seg{
    segmenteTag = seg.selectedSegmentIndex;
    [self.tableView reloadData];
}


-(UIView*)headView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"预定中",@"持有中",@"已退出", nil]];
    
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


//稳赚宝
-(void)initData_wen:(NSMutableArray *)dicArray{
    
    for (int i = 0; i < 10; i++) {
        //转化成数据对象
        WenZhuanProject *wenPro = [[WenZhuanProject alloc] init];
        [wenPro  inputDataToThisObject:nil];
        
        wenPro.title = @"稳赚保W21235";
        wenPro.jindu = @"11%";
        wenPro.type = [NSString stringWithFormat:@"%d",i];
        wenPro.yearliLv = @"16";
        wenPro.planAllMoney = @"20.0";
        wenPro.repaymentPeriod = @"6";
        
        [dataArray addObject:wenPro];
    }
    
    
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
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell2";
    MyWenZhuanViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   
    
    NSInteger row = [indexPath row];
    WenZhuanProject *wen = [dataArray objectAtIndex:row];
    
    
    if (segmenteTag==0) {
        [cell initMakeData_0:wen];
    }else if (segmenteTag==1){
        [cell initMakeData_1:wen];
    }else if (segmenteTag==2){
        [cell initMakeData_2:wen];
    }
    
    //cell.bid.tag = 100+row;
    //[cell.bid addTarget:self action:@selector(bid_WenzhuanPress:) forControlEvents:UIControlEventTouchUpInside];
 
    return cell;
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    
    ProjectInfoViewController *project = [[ProjectInfoViewController alloc] init];
    project.projectId = @"";
    project.projectTag = projectTag;
    project.title = @"借款详情";
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:project animated:YES];
}


//按钮点击操作
-(void)bid_WenzhuanPress:(UIButton *)but{

}
 


@end
