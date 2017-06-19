//
//  SanProject.h
//  quqian
//
//  Created by apple on 15/3/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"
#import "Tool.h"

@interface SanProject : Project

@property(nonatomic,retain)NSString *title;//标题
@property(nonatomic,retain)NSString *qi; //企
@property(nonatomic,retain)NSString *shi;//实
@property(nonatomic,retain)NSString *jiang;//奖(土豪奖等等)
/*
 详情
 */
@property(nonatomic,retain)NSString *baozhengfangshi;//保障方式
@property(nonatomic,retain)NSString *tiqianhuankuanfeilv;//提前还款费率
@property(nonatomic,retain)NSString *huankuanfangshi;//还款方式
@property(nonatomic,retain)NSString *yuehuanxi;//月还息
@property(nonatomic,retain)NSString *toubiaojiangli;//投标奖励
@property(nonatomic,retain)NSString *touzicishu;//当前累计投资次数
@property(nonatomic,retain)NSString *toubiaoxiane;//投标限额


//获取左边的信息
-(NSMutableArray *)leftInfo;
//进行组装数据
-(void)makeData:(NSMutableDictionary *)dic withArray:(NSMutableArray *)array withBgUrl:(NSMutableArray *)urlArray;


@end
