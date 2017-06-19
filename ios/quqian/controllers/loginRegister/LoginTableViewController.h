//
//  LoginTableViewController.h
//  quqian
//
//  Created by apple on 15/3/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tool.h"
#import "DemoViewController.h"

@protocol LoginViewControllerDelegate <NSObject>

//登录成功的回调
-(void)loginSuccess;
//登录失败的回调
-(void)loginCanel;

@end


@interface LoginTableViewController : UITableViewController<DemoViewControllerDeleagete>

@property(nonatomic,assign)id <LoginViewControllerDelegate >delagete;


@end
