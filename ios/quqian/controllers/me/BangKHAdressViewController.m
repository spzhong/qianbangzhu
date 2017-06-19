//
//  BangKHAdressViewController.m
//  quqian
//
//  Created by apple on 15/5/12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BangKHAdressViewController.h"
#import "Tool.h"
#import "HelpDownloader.h"


@implementation BangKHAdressViewController
@synthesize dataArray;
@synthesize typeString;
@synthesize sheng;
@synthesize shi;
@synthesize quxian;
@synthesize cityId;
@synthesize shengId;


- (instancetype)initWithStyle:(UITableViewStyle)style{
    return self = [super initWithStyle:UITableViewStyleGrouped];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
    return [self.dataArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
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
    UILabel *lab123 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(16.5, 0, [Tool adaptation:200 with6:55 with6p:94], 45) Alignment:NSTextAlignmentLeft  FontFl:15];
    lab123.font = FOUR_CONTROL_FONT;
    [cell.contentView addSubview:lab123];
    
    NSMutableDictionary *dic = [self.dataArray objectAtIndex:row];
    
    
    lab123.text = [dic objectForKey:@"name"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;

    NSMutableDictionary *dicone = [self.dataArray objectAtIndex:row];
    NSString *name = [dicone objectForKey:@"name"];
    
    if ([self.typeString intValue] == 0) {
        
        
        //进行有效登录确认
        NSString *url =[NSString stringWithFormat:@"%@/user/bankcard/androidRegion.htm",BASE_URL];
        NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
        [postDic setObject:@"1" forKey:@"level"];
        [postDic setObject:dicone[@"id"] forKey:@"id"];
        
        [[HelpDownloader shared] startRequest:url withbody:postDic
                                       isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                               @"yes",@"isConnectedToNetwork",
                                               @"yes",@"isshowHUD",
                                               @"no",@"islockscreen",
                                               @"post",@"isrequesType",
                                               nil]
                                   completion:^void(id data,int kk){
                                       
                                       if (kk==0) {
                                           NSMutableDictionary *dic = [data JSONValue];
                                           if ([[dic objectForKey:@"code"] intValue]  == 0) {
                                               
                                               
                                               BangKHAdressViewController *bang = [[BangKHAdressViewController alloc] init];
                                               bang.title = @"选择城市";
                                               bang.sheng = name;
                                               bang.shengId = dicone[@"id"];
                                               bang.typeString = @"1";
                                               bang.dataArray = [dic objectForKey:@"rvalue"];
                                               UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
                                               backItem.title=@"返回";
                                               self.navigationItem.backBarButtonItem=backItem;
                                               self.hidesBottomBarWhenPushed=YES;
                                               [self.navigationController pushViewController:bang animated:YES];
                                               
                                           }else{
                                               
                                               
                                           }
                                       }
                                   }];
        
        
        
        
    }else if ([self.typeString intValue] == 1) {
        
        //进行有效登录确认
        NSString *url =[NSString stringWithFormat:@"%@/user/bankcard/androidRegion.htm",BASE_URL];
        NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
        [postDic setObject:@"2" forKey:@"level"];
        [postDic setObject:dicone[@"id"] forKey:@"id"];
        
        [[HelpDownloader shared] startRequest:url withbody:postDic
                                       isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                               @"yes",@"isConnectedToNetwork",
                                               @"yes",@"isshowHUD",
                                               @"no",@"islockscreen",
                                               @"post",@"isrequesType",
                                               nil]
                                   completion:^void(id data,int kk){
                                       
                                       if (kk==0) {
                                           NSMutableDictionary *dic = [data JSONValue];
                                           if ([[dic objectForKey:@"code"] intValue]  == 0) {
                                               
                                               
                                               BangKHAdressViewController *bang = [[BangKHAdressViewController alloc] init];
                                               bang.title = @"选择区县";
                                               bang.sheng = self.sheng;
                                               bang.shengId = self.shengId;
                                               bang.shi = name;
                                               bang.cityId = dicone[@"id"];
                                               bang.typeString = @"2";
                                               bang.dataArray = [dic objectForKey:@"rvalue"];
                                               UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
                                               backItem.title=@"返回";
                                               self.navigationItem.backBarButtonItem=backItem;
                                               self.hidesBottomBarWhenPushed=YES;
                                               [self.navigationController pushViewController:bang animated:YES];
                                               
                                           }else{
                                               
                                               
                                           }
                                       }
                                   }];
        
        
    }else{
    
        self.quxian = name;
        NSMutableDictionary *dicNew = [[NSMutableDictionary alloc] init];
        
        [dicNew setObject:[NSString stringWithFormat:@"%@ %@ %@",self.sheng,self.shi,self.quxian] forKey:@"title"];
        [dicNew setObject:self.cityId forKey:@"cityId"];
        [dicNew setObject:self.shengId forKey:@"shengId"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"xuanzekaihudi" object:nil userInfo:dicNew];
        
        NSArray *array = self.navigationController.viewControllers;
        UIViewController *con = [array objectAtIndex:[array count]-4];
        [self.navigationController popToViewController:con animated:YES];
        
    }
    
}


@end
