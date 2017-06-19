//
//  OkTiXianTableViewController.h
//  quqian
//
//  Created by apple on 15/4/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OkTiXianTableViewController : UITableViewController


@property(nonatomic,retain)NSString *bankNameAndAdress;//银行卡名称和卡号

@property(nonatomic,retain)NSString *bankCardId;//银行卡信息
@property(nonatomic,retain)NSString *amount;//金额
@property(nonatomic,retain)NSString *password;//体现密码
@property(nonatomic,retain)NSString *shouxufei;//体现手续费
@property(nonatomic,retain)NSString *shijikouchujine;//实际扣除金额

@end
