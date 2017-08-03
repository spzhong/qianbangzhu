//
//  ChongZhiTableViewController.m
//  quqian
//
//  Created by apple on 15/4/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ChongZhiTableViewController.h"
#import "UserModel.h"
#import "Tool.h"
#import "EGOImageView.h"
 
#import "JSONKit.h"
#import "JSON.h"
#import "HelpDownloader.h"


@interface ChongZhiTableViewController ()
{
    UserModel *user;
    NSString *money;
    NSString *code;
    NSString *bankNumber;
    NSString *bankAndNumber;
    NSString *shijizhifujine;
}
@end

@implementation ChongZhiTableViewController



- (instancetype)initWithStyle:(UITableViewStyle)style{
    return self = [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
 

@end
