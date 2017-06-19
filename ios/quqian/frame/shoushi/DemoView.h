//
//  DemoView.h
//  手势锁
//
//  Created by chenai on 14-8-3.
//  Copyright (c) 2014年 com. All rights reserved.
//
@class DemoView;
@protocol YYLockViewDelegate <NSObject>
//自定义一个协议
//协议方法，把当前视图作为参数
-(void)LockViewDidClick:(DemoView *)lockView andPwd:(NSString *)pwd;
@end

#import <UIKit/UIKit.h>

@interface DemoView : UIView

@property(nonatomic,retain)id<YYLockViewDelegate>delegate;

-(void)reload;


@end
