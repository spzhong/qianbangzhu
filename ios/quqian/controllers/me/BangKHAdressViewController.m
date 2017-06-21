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
    
    if ([self.typeString isEqualToString:@"0"]) {
        lab123.text = [dic objectForKey:@"shengName"];
    }else{
        lab123.text = [dic objectForKey:@"shiName"];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
 
    NSMutableDictionary *dicone = [self.dataArray objectAtIndex:row];
   
    NSString *name = @"";
    if ([self.typeString isEqualToString:@"0"]) {
         name = [dicone objectForKey:@"shengName"];
    }else{
        name = [dicone objectForKey:@"shiName"];
    }
    
   
    
    if ([self.typeString intValue] == 0) {
        
        BangKHAdressViewController *bang = [[BangKHAdressViewController alloc] init];
        bang.title = @"选择城市";
        bang.sheng = name;
        bang.shengId = dicone[@"shengId"];
        bang.typeString = @"1";
        bang.dataArray = [dicone objectForKey:@"city"];
        UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
        backItem.title=@"返回";
        self.navigationItem.backBarButtonItem=backItem;
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:bang animated:YES];
        
        
        
    }else if ([self.typeString intValue] == 1) {
        
        self.quxian = name;
        NSMutableDictionary *dicNew = [[NSMutableDictionary alloc] init];
        
        [dicNew setObject:[NSString stringWithFormat:@"%@ %@",self.sheng,dicone[@"shiName"]] forKey:@"title"];
        [dicNew setObject:dicone[@"shiId"] forKey:@"cityId"];
        [dicNew setObject:self.shengId forKey:@"shengId"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"xuanzekaihudi" object:nil userInfo:dicNew];
        
        
        NSArray *array = self.navigationController.viewControllers;
        UIViewController *con = [array objectAtIndex:[array count]-3];
        [self.navigationController popToViewController:con animated:YES];
        
    }
}


@end
