//
//  ProjectInfoViewController.h
//  quqian
//
//  Created by apple on 15/3/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"


@interface ProjectInfoViewController : SuperViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic)int projectTag; //0是散标，1是稳赚保，2是债权转让，3是理财体验
@property(nonatomic,retain)NSString *projectId;//项目ID

@property(nonatomic,retain)UITableView *tableView;

@property(nonatomic,retain)NSTimer *myTimer;

@property(nonatomic,retain)NSString *bdlx;


@end
