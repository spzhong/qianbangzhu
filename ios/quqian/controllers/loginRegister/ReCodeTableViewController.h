//
//  ReCodeTableViewController.h
//  quqian
//
//  Created by apple on 15/3/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tool.h"
#import "HelpDownloader.h"

@interface ReCodeTableViewController : UITableViewController

@property(nonatomic)int type;//0是设置登录的密码，1是重置提现的密码，2是第一次设置提现密码
@property(nonatomic)int typePop;
@property(nonatomic,retain)NSString *key;//key
@property(nonatomic,retain)NSString *phone;//电话

@end
