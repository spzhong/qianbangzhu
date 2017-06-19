//
//  NoticeInfoViewController.h
//  quqian
//
//  Created by apple on 15/4/2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoticeModel.h"

@interface NoticeInfoViewController : UITableViewController

@property(nonatomic,retain)NoticeModel *notice;
@property(nonatomic,assign)NSMutableDictionary *noticeDic;

@end
