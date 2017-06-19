//
//  ChangeMoblieViewController.h
//  quqian
//
//  Created by apple on 15/3/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeMoblieViewController : UITableViewController

@property(nonatomic)int type;//0是修改手机号码，1是找回提现密码

@property(nonatomic)NSTimer *myTimer;

@end
