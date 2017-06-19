//
//  PTWEBViewController.h
//  qianbangzhu
//
//  Created by 宋培众 on 2017/6/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTWEBViewController : UIViewController

@property(nonatomic,retain)NSString *mchnt_cd;
@property(nonatomic,retain)NSString *mchnt_txn_ssn;
@property(nonatomic,retain)NSString *amt;
@property(nonatomic,retain)NSString *login_id;
@property(nonatomic,retain)NSString *page_notify_url;
@property(nonatomic,retain)NSString *back_notify_url;
@property(nonatomic,retain)NSString *signatureStr;
@property(nonatomic,retain)NSString *fyUrl;


@end
