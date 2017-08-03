//
//  ChongZhiTableViewController.h
//  quqian
//
//  Created by apple on 15/4/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "LLPaySdk.h"

typedef enum LLVerifyPayState{
    kLLQuickPay = 0, //快捷支付
    kLLVerifyPay = 1,  //认证支付
    kLLPreAuthorizePay = 2 //预授权
}LLVerifyPayState;

@interface ChongZhiTableViewController : UITableViewController 

@property(nonatomic,retain)NSMutableDictionary *dic;

@property (nonatomic, assign) LLVerifyPayState  bLLPayState;
@property (nonatomic, assign) BOOL  bTestServer;


@end
