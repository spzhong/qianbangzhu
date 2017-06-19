//
//  DemoViewController.h
//  手势锁
//
//  Created by chenai on 14-8-3.
//  Copyright (c) 2014年 com. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DemoViewControllerDeleagete <NSObject>

-(void)Success:(NSString *)doting;
-(void)Failure:(NSString *)doting;

@end


@interface DemoViewController : UIViewController


@property(nonatomic)int type;//0是设置密码，1是确认密码，2是输入密码直接退出做一些事情
@property(nonatomic,retain)NSString *code;//密码
@property(nonatomic,retain)id<DemoViewControllerDeleagete> deleagete;

@property(nonatomic,retain)NSString *doting;

@end
