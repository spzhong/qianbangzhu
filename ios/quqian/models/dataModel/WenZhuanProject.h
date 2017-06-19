//
//  WenZhuanProject.h
//  quqian
//
//  Created by apple on 15/3/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"

@interface WenZhuanProject : Project

//获取左边的信息
-(NSMutableArray *)leftInfo;
//创建一个model
-(void)inputDataToThisObject:(NSMutableDictionary *)dic;

-(NSString *)rightInfo:(NSString *)left withValue:(NSString *)vlaue;


@end
