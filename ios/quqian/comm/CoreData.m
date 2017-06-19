//
//  CoreData.m
//  chaping
//
//  Created by apple on 14/12/30.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "CoreData.h"


#define OnePAGE  20


@implementation CoreData




#pragma song new
+(AppDelegate*)getDele
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}


//保存到core data 数据中
+(BOOL)save_coredata{
    NSManagedObjectContext *mang = [CoreData getDele].managedObjectContext;
    NSError *error = nil;
    if (![mang save:&error]) {
        return YES;
    }
    return  NO;
}


//创建一条数据
+(NSManagedObject *)creat_coredata:(NSString *)model withWhere_id:(NSString *)where{
    //判断数据是否存在
    NSManagedObject *oneObject = [CoreData selcet_OneData:model withWhere_id:where];
    if (oneObject==nil) {
        //创建一个user对象
        NSEntityDescription *entity = [NSEntityDescription entityForName:model inManagedObjectContext:[CoreData getDele].managedObjectContext];
        NSManagedObject *newObject = [[NSManagedObject alloc]initWithEntity:entity insertIntoManagedObjectContext:[CoreData getDele].managedObjectContext];
        return newObject;
    }else{
        //进行更新数据
    }
    return oneObject;
}

//删除数据
+(BOOL)delete_Data:(NSString*)model withWhere_id:(NSString*)where
{
    NSMutableArray *mutableFetchResults = [CoreData selcet_ALLData:model withNSPredicate:[CoreData creat_NSPredicate:where] withNSSortDescriptor:nil withPage:0];
    int flag;
    if ([mutableFetchResults count]>0) {
        flag=0;
    }else{
        return YES;
    }
    [[CoreData getDele].managedObjectContext deleteObject:[mutableFetchResults objectAtIndex:flag]];
    return [CoreData save_coredata];
}


//获取一条的数据
+(NSManagedObject *)selcet_OneData:(NSString *)model withWhere_id:(NSString *)where{
    NSMutableArray *allArray = [CoreData selcet_ALLData:model withNSPredicate:[CoreData creat_NSPredicate:where] withNSSortDescriptor:nil withPage:0];
    if ([allArray count]==0) {
        return nil;
    }
    NSManagedObject *obj = [allArray objectAtIndex:0];
    return obj;
}

//获取所有的数据
/*
 * model 表名
 * where 查询条件[Core creat_NSPredicate]
 * sortDescriptor_array 排序数组存放的对象[Core creat_NSSortDescriptor:(NSString*)key withBoo:(BOOL)isAscending]
 * currPage 分页，默认从0开始，小于0获取所有的数据
 */
+(NSMutableArray *)selcet_ALLData:(NSString *)model withNSPredicate:(NSPredicate *)where withNSSortDescriptor:(NSMutableArray *)sortDescriptor_array withPage:(int)currPage{
    
    //创建一个查询的对象
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:model inManagedObjectContext:[CoreData getDele].managedObjectContext];
    [request setEntity:entity];

    
    //查询条件
    if (where != nil) {
        [request setPredicate:where];
    }
    
    //排序方式
    if (sortDescriptor_array != nil) {
        [request setSortDescriptors:sortDescriptor_array];
    }
    
    //进行分页查询
    if (currPage>=0) {
        //进行分页查询
        [request setFetchLimit:OnePAGE];
        [request setFetchOffset:currPage * OnePAGE];
    }//获取所有的数据
    
 
    //执行查询数据
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[[CoreData getDele].managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        //如果结果为空，在这作错误响应
        return nil;
    }
    return mutableFetchResults;
}

//创建一个查询的条件
+(NSPredicate *)creat_NSPredicate:(NSString *)where{
    NSPredicate * qcmd = [NSPredicate predicateWithFormat:where];
    return qcmd;
}
//创建一个排序条件
+(NSSortDescriptor *)creat_NSSortDescriptor:(NSString*)key withBoo:(BOOL)isAscending{
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:key ascending:isAscending];
    return sort;
}



@end
