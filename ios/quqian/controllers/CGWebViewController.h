//
//  WebViewController.h
//  qianbangzhu
//
//  Created by 宋培众 on 2017/6/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGWebViewController : UIViewController

@property(nonatomic)int tag;
@property(nonatomic,retain)NSString *sendUrl;
@property(nonatomic,retain)NSString *sendStr;
@property(nonatomic,retain)NSString *transCode;
@property(nonatomic,retain)NSString *seqNum;

@end
