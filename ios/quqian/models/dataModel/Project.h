//
//  Project.h
//  quqian
//
//  Created by apple on 15/3/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Project : NSObject

@property(nonatomic,retain)NSString *title;//标题
@property(nonatomic,retain)NSString *jindu;//进度
@property(nonatomic,retain)NSString *chengxindu;//诚信度
@property(nonatomic,retain)NSString *type;//类型
@property(nonatomic,retain)NSString *yearliLv;//年利率
@property(nonatomic,retain)NSString *fudongyearliLv;//浮动年利率
@property(nonatomic,retain)NSString *planAllMoney;//标的总额
@property(nonatomic,retain)NSString *repaymentPeriod;//剩余还款期限

@property(nonatomic,retain)NSString *touLastTime;//距离开始投标时间



//获取左边的信息
-(NSMutableArray *)leftInfo;
-(NSMutableArray *)leftInfo_0;

-(NSString *)rightInfo_0:(NSString *)left withValue:(NSString *)vlaue;
-(NSString *)rightInfo:(NSString *)left withValue:(NSString *)vlaue;


@end
