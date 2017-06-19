//
//  ZhaiQuanProject.h
//  quqian
//
//  Created by apple on 15/3/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"

@interface ZhaiQuanProject : Project

@property(nonatomic,retain)NSString *title;//标题
@property(nonatomic,retain)NSString *qi; //企
@property(nonatomic,retain)NSString *shi;//实
@property(nonatomic,retain)NSString *zhaiquanJiaZhi;//债权价值（100.00元/份）
@property(nonatomic,retain)NSString *zhuanrangJiaZhi;//转让价格（100.00元/份）
@property(nonatomic,retain)NSString *lastFenShu;//剩余份数

//获取左边的信息
-(NSMutableArray *)leftInfo;
//创建一个model
-(void)inputDataToThisObject:(NSMutableDictionary *)dic;
//进行组装数据
-(void)makeData:(NSMutableDictionary *)dic withArray1:(NSMutableArray *)array1 withArray2:(NSMutableArray *)array2 withBgUrl:(NSMutableArray *)urlArray;

@end
