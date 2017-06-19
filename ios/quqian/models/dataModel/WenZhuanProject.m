//
//  WenZhuanProject.m
//  quqian
//
//  Created by apple on 15/3/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "WenZhuanProject.h"
#import "Tool.h"

@implementation WenZhuanProject

//获取左边的信息
-(NSMutableArray *)leftInfo{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"计划金额" forKey:@"key"];
    [dic setObject:@"10000000.00" forKey:@"value"];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setObject:@"预期收益" forKey:@"key"];
    [dic1 setObject:@"12%" forKey:@"value"];
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    [dic2 setObject:@"锁定期限" forKey:@"key"];
    [dic2 setObject:@"1个月" forKey:@"value"];
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    [dic3 setObject:@"计划状态" forKey:@"key"];
    [dic3 setObject:@"预定中" forKey:@"value"];
    NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
    [dic4 setObject:@"退出日期" forKey:@"key"];
    [dic4 setObject:@"2014年9月30日" forKey:@"value"];
    NSMutableDictionary *dic5 = [NSMutableDictionary dictionary];
    [dic5 setObject:@"保障方式" forKey:@"key"];
    [dic5 setObject:@"小贷回购＋保险承若" forKey:@"value"];
    NSMutableDictionary *dic6 = [NSMutableDictionary dictionary];
    [dic6 setObject:@"还款方式" forKey:@"key"];
    [dic6 setObject:@"每月还息" forKey:@"value"];
    NSMutableDictionary *dic7 = [NSMutableDictionary dictionary];
    [dic7 setObject:@"购买条件" forKey:@"key"];
    [dic7 setObject:@"1000.00元" forKey:@"value"];
    
    [array addObject:dic];
    [array addObject:dic1];
    [array addObject:dic2];
    [array addObject:dic3];
    [array addObject:dic4];
    [array addObject:dic5];
    [array addObject:dic6];
    [array addObject:dic7];
    
    return array;
}


//右边的信息
-(NSString *)rightInfo:(NSString *)left withValue:(NSString *)vlaue{
    if ([left isEqualToString:@"计划金额"]) {
        return [NSString stringWithFormat:@"<p align=left><font size=14 color='#F08F00'>%@</font><font size=14 >元</font></p>",vlaue];
    }else if ([left isEqualToString:@"预期收益"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14 color='#F08F00'>%@</font><font size=14 >每年</font></p>",vlaue];
    }else if ([left isEqualToString:@"锁定期限"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14>%@</font></p>",vlaue];
    }else if ([left isEqualToString:@"计划状态"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14>%@</font></p>",vlaue];
    }else if ([left isEqualToString:@"退出日期"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14 color='#F08F00'>%@</font></p>",vlaue];
    }else if ([left isEqualToString:@"保障方式"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14>%@</font></p>",vlaue];
    }else if ([left isEqualToString:@"还款方式"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14>%@</font></p>",vlaue];
    }else if ([left isEqualToString:@"购买条件"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14>%@</font></p>",vlaue];
    }
    return @"";
}



//创建一个model
-(void)inputDataToThisObject:(NSMutableDictionary *)dic{
    self.jindu = [Tool toString:[dic objectForKey:@""]];//进度
    self.chengxindu = [Tool toString:[dic objectForKey:@""]];//诚信度
    self.type = [Tool toString:[dic objectForKey:@""]];//类型
    self.yearliLv = [Tool toString:[dic objectForKey:@""]];//年利率
    self.planAllMoney = [Tool toString:[dic objectForKey:@""]];//标的总额
    self.repaymentPeriod = [Tool toString:[dic objectForKey:@""]];//剩余的期限
    self.touLastTime = [Tool toString:[dic objectForKey:@""]];//距离开始投标时间
    
}

@end
