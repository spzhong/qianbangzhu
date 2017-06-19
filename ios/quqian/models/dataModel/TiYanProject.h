//
//  TiYanProject.h
//  quqian
//
//  Created by apple on 15/3/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"

@interface TiYanProject : Project

@property(nonatomic,retain)NSString *proDate;//项目期数

/*
 详情
 */
@property(nonatomic,retain)NSString *touzifanghsi;//投资方式
@property(nonatomic,retain)NSString *licaishuming;//理财说明
@property(nonatomic,retain)NSString *jihuazhuangtai;//计划状态
@property(nonatomic,retain)NSString *suodingqixian;//锁定期限
@property(nonatomic,retain)NSString *suodingjieshu;//锁定结束
@property(nonatomic,retain)NSString *shouyichuli;//收益处理
@property(nonatomic,retain)NSString *feilvshuoming;//费率说明

@property(nonatomic,retain)NSString *jihuajieshao;//计划介绍


//获取左边的信息
-(NSMutableArray *)leftInfo;
//创建一个model
-(void)inputDataToThisObject:(NSMutableDictionary *)dic;

//进行组装数据
-(void)makeData:(NSMutableDictionary *)dic withArray:(NSMutableArray *)array withBgUrl:(NSMutableArray *)urlArray;

@end
