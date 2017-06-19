//
//  CoreData.h
//  chaping
//
//  Created by apple on 14/12/30.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface CoreData : NSObject

//保存到core data 数据中
+(BOOL)save_coredata;
//创建一条数据
+(NSManagedObject *)creat_coredata:(NSString *)model withWhere_id:(NSString *)where;
//删除数据
+(BOOL)delete_Data:(NSString*)model withWhere_id:(NSString*)where;
//获取一条的数据
+(NSManagedObject *)selcet_OneData:(NSString *)model withWhere_id:(NSString *)where;
//获取所有的数据
/*
 * model 表名
 * where 查询条件[Core creat_NSPredicate]
 * sortDescriptor_array 排序数组存放的对象[Core creat_NSSortDescriptor:(NSString*)key withBoo:(BOOL)isAscending]
 * currPage 分页，默认从0开始，小于0获取所有的数据
 */
+(NSMutableArray *)selcet_ALLData:(NSString *)model withNSPredicate:(NSPredicate *)where withNSSortDescriptor:(NSMutableArray *)sortDescriptor_array withPage:(int)currPage;
//创建一个查询的条件
+(NSPredicate *)creat_NSPredicate:(NSString *)where;
//创建一个排序条件
+(NSSortDescriptor *)creat_NSSortDescriptor:(NSString*)key withBoo:(BOOL)isAscending;

    
@end
