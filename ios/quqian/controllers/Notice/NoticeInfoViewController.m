//
//  NoticeInfoViewController.m
//  quqian
//
//  Created by apple on 15/4/2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NoticeInfoViewController.h"
#import "Tool.h"
#import "HelpDownloader.h"
#import "UserModel.h"

@interface NoticeInfoViewController ()
{
    double cellHeight;
    NSString *title;
    NSString *time;
    NSString *content;
}
@end

@implementation NoticeInfoViewController
@synthesize notice;
@synthesize noticeDic;

- (instancetype)initWithStyle:(UITableViewStyle)style{
    return self = [super initWithStyle:UITableViewStyleGrouped];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
 
    [self.tableView setSeparatorColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]];
    
    UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(15, 15, 290, 45)];
    text.text = [noticeDic objectForKey:@"content"];
    text.font = [UIFont systemFontOfSize:15];
    CGSize constraintSize = CGSizeMake(text.frame.size.width, MAXFLOAT);
    CGSize size = [text sizeThatFits:constraintSize];
    cellHeight =  size.height;

    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //详情
    [self xiangqing__startRequest];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row]==2) {
        return cellHeight+20;
    }
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
    
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    UILabel *lab1 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(15, 0, [Tool adaptation:120 with6:55 with6p:94], 45) Alignment:NSTextAlignmentLeft  FontFl:14];
    UILabel *lab2 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(55, 0, [Tool adaptation:260 with6:55 with6p:94], 45) Alignment:NSTextAlignmentLeft  FontFl:14];
    [lab1 setTextColor:[UIColor darkGrayColor]];
    [cell.contentView addSubview:lab1];
    [cell.contentView addSubview:lab2];
    
    if (row==0) {
        lab1.text = @"标题：";
        lab2.text = [noticeDic objectForKey:@"title"];
    }else if (row==1){
        lab1.text = @"时间：";
        lab2.text = [noticeDic objectForKey:@"sendTime"];
    }else if (row==2){
        lab1.text = @"内容：";
        UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(50, 7, 260, cellHeight)];
        text.text = [noticeDic objectForKey:@"content"];
        text.font = [UIFont systemFontOfSize:15];
        text.frame = CGRectMake(50, 7, 260, text.contentSize.height);
        [cell.contentView addSubview:text];
        text.userInteractionEnabled = NO;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



//通知－－列表
-(void)xiangqing__startRequest{
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/user/xxgl/updateStatus.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:[noticeDic objectForKey:@"id"] forKey:@"id"];
    
    
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
                                       if ([[dic objectForKey:@"code"] intValue] == 0) {
                                           
                                           [noticeDic setObject:@"1" forKey:@"status"];
                                           
                                           UserModel *user = [Tool getUser];
                                           user.tongzhiweidu = [NSString stringWithFormat:@"%d",[user.tongzhiweidu intValue]-1];
                                           [Tool savecoredata];
                                           
                                       }else{
                                           
                                       }
                                   }else{
                                       
                                   }
                                   
                               }];
    
}




@end
