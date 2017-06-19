//
//  ZhaiQuanProject.m
//  quqian
//
//  Created by apple on 15/3/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ZhaiQuanProject.h"
#import "Tool.h"
#import "SanProject.h"

@implementation ZhaiQuanProject

//获取左边的信息
-(NSMutableArray *)leftInfo_0{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"剩余期限" forKey:@"key"];
    [dic setObject:@"1/18个月" forKey:@"value"];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setObject:@"转让价格" forKey:@"key"];
    [dic1 setObject:@"50.30" forKey:@"value"];
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    [dic2 setObject:@"待收本息" forKey:@"key"];
    [dic2 setObject:@"50.40" forKey:@"value"];
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    [dic3 setObject:@"下一还款日" forKey:@"key"];
    [dic3 setObject:@"2014年3月6日" forKey:@"value"];
    NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
    [dic4 setObject:@"原始投资金额" forKey:@"key"];
    [dic4 setObject:@"600.00元（3份）" forKey:@"value"];
    NSMutableDictionary *dic5 = [NSMutableDictionary dictionary];
    [dic5 setObject:@"逾期情况" forKey:@"key"];
    [dic5 setObject:@"未发生逾期" forKey:@"value"];
    
    [array addObject:dic];
    [array addObject:dic1];
    [array addObject:dic2];
    [array addObject:dic3];
    [array addObject:dic4];
    [array addObject:dic5];
    
    return array;
}

//右边的信息
-(NSString *)rightInfo_0:(NSString *)left withValue:(NSString *)vlaue{
    if ([left isEqualToString:@"剩余期限"]) {
          return [NSString stringWithFormat:@"<p align=left><font size=14>%@</font></p>",vlaue];
    }else if ([left isEqualToString:@"转让价格"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14 color='#F08F00'>%@</font><font size=14>元/份</font></p>",vlaue];
    }else if ([left isEqualToString:@"待收本息"]){
         return [NSString stringWithFormat:@"<p align=left><font size=14 color='#F08F00'>%@</font><font size=14>元/份</font></p>",vlaue];
    }else if ([left isEqualToString:@"下一还款日"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14>%@</font></p>",vlaue];
    }else if ([left isEqualToString:@"原始投资金额"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14>%@</font></p>",vlaue];
    }else if ([left isEqualToString:@"逾期情况"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14>%@</font></p>",vlaue];
    }
    return @"";
}






//获取左边的信息
-(NSMutableArray *)leftInfo{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"标的总额" forKey:@"key"];
    [dic setObject:@"10000000.00" forKey:@"value"];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setObject:@"年利率" forKey:@"key"];
    [dic1 setObject:@"12%" forKey:@"value"];
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    [dic2 setObject:@"还款期限" forKey:@"key"];
    [dic2 setObject:@"1个月" forKey:@"value"];
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    [dic3 setObject:@"保障方式" forKey:@"key"];
    [dic3 setObject:@"本息" forKey:@"value"];
    NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
    [dic4 setObject:@"提前还款费率" forKey:@"key"];
    [dic4 setObject:@"1.0%" forKey:@"value"];
    NSMutableDictionary *dic5 = [NSMutableDictionary dictionary];
    [dic5 setObject:@"还款方式" forKey:@"key"];
    [dic5 setObject:@"等额本息" forKey:@"value"];
    NSMutableDictionary *dic6 = [NSMutableDictionary dictionary];
    [dic6 setObject:@"月还本息" forKey:@"key"];
    [dic6 setObject:@"100100.00" forKey:@"value"];
    NSMutableDictionary *dic7 = [NSMutableDictionary dictionary];
    [dic7 setObject:@"投标进度" forKey:@"key"];
    [dic7 setObject:@"50" forKey:@"value"];
    NSMutableDictionary *dic8 = [NSMutableDictionary dictionary];
    [dic8 setObject:@"投标奖励" forKey:@"key"];
    [dic8 setObject:@"1.0％" forKey:@"value"];
    NSMutableDictionary *dic9 = [NSMutableDictionary dictionary];
    [dic9 setObject:@"累计投标次数" forKey:@"key"];
    [dic9 setObject:@"0次" forKey:@"value"];
    NSMutableDictionary *dic10 = [NSMutableDictionary dictionary];
    [dic10 setObject:@"剩余时间" forKey:@"key"];
    [dic10 setObject:@"6天6时5分" forKey:@"value"];
    NSMutableDictionary *dic11 = [NSMutableDictionary dictionary];
    [dic11 setObject:@"投标限额" forKey:@"key"];
    [dic11 setObject:@"不限" forKey:@"value"];
    
    [array addObject:dic];
    [array addObject:dic1];
    [array addObject:dic2];
    [array addObject:dic3];
    [array addObject:dic4];
    [array addObject:dic5];
    [array addObject:dic6];
    [array addObject:dic7];
    [array addObject:dic8];
    [array addObject:dic9];
    [array addObject:dic10];
    [array addObject:dic11];
    return array;
}



//右边的信息
-(NSString *)rightInfo:(NSString *)left withValue:(NSString *)vlaue{
    if ([left isEqualToString:@"标的总额"]) {
        return [NSString stringWithFormat:@"<p align=left><font size=14 color='#F08F00'>%@</font><font size=14 >元</font></p>",vlaue];
    }else if ([left isEqualToString:@"年利率"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14 color='#F08F00'>%@</font></p>",vlaue];
    }else if ([left isEqualToString:@"还款期限"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14>%@</font></p>",vlaue];
    }else if ([left isEqualToString:@"保障方式"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14>%@</font></p>",vlaue];
    }else if ([left isEqualToString:@"提前还款费率"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14>%@</font></p>",vlaue];
    }else if ([left isEqualToString:@"还款方式"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14>%@</font></p>",vlaue];
    }else if ([left isEqualToString:@"月还本息"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14>%@</font></p>",vlaue];
    }else if ([left isEqualToString:@"投标进度"]){
        return vlaue;
    }else if ([left isEqualToString:@"投标奖励"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14 color='#F08F00'>%@</font><font size=16 >幸运奖</font></p>",vlaue];
    }else if ([left isEqualToString:@"累计投标次数"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14 color='#F08F00'>%@</font></p>",vlaue];
    }else if ([left isEqualToString:@"剩余时间"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14>%@</font></p>",vlaue];
    }else if ([left isEqualToString:@"投标限额"]){
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
    
    self.title = [Tool toString:[dic objectForKey:@""]];//标题
    self.qi = [Tool toString:[dic objectForKey:@""]];//企
    self.shi = [Tool toString:[dic objectForKey:@""]];//实
    self.zhaiquanJiaZhi = [Tool toString:[dic objectForKey:@""]];//债权价值（100.00元/份）
    self.zhuanrangJiaZhi = [Tool toString:[dic objectForKey:@""]];//转让价格（100.00元/份）
    self.lastFenShu = [Tool toString:[dic objectForKey:@""]];//剩余份数
}






//进行组装数据
-(void)makeData:(NSMutableDictionary *)dic withArray1:(NSMutableArray *)array1 withArray2:(NSMutableArray *)array2 withBgUrl:(NSMutableArray *)urlArray{
    
    
    //转让信息
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setObject:@"剩余期限" forKey:@"left"];
    [dic1 setObject:[self reLabWith:[NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"syqs"],[dic objectForKey:@"jkqx"]] withValue:@"个月"] forKey:@"right"];
    if (![[Tool toString:[dic objectForKey:@"syqs"]] isEqualToString:@"-1"]) {
        [array1 addObject:dic1];
    }
    
    //
//    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
//    [dic2 setObject:@"总期数" forKey:@"left"];
//    [dic2 setObject:[self reLabWith:[dic objectForKey:@"zqs"]] forKey:@"right"];
//    if (![[Tool toString:[dic objectForKey:@"zqs"]] isEqualToString:@"-1"]) {
//        [array1 addObject:dic2];
//    }
//    
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    [dic3 setObject:@"转让价格" forKey:@"left"];
    [dic3 setObject:[self reLabWith:[NSString stringWithFormat:@"%@",[dic objectForKey:@"zqjg"]]withValue:@"元/份"] forKey:@"right"];
    if (![[Tool toString:[dic objectForKey:@"zqjg"]] isEqualToString:@"-1"]) {
        [array1 addObject:dic3];
    }
    
    NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
    [dic4 setObject:@"待收本息" forKey:@"left"];
    if (![[Tool toString:[dic objectForKey:@"dsbx"]] isEqualToString:@"-1"]) {
        [dic4 setObject:[NSString stringWithFormat:@"%@元/份",[dic objectForKey:@"dsbx"]] forKey:@"right"];
        [array1 addObject:dic4];
    }
    
    //
    NSMutableDictionary *dic5 = [NSMutableDictionary dictionary];
    [dic5 setObject:@"下一还款日" forKey:@"left"];
    [dic5 setObject:[self reLabWith:[dic objectForKey:@"xyhkr"]] forKey:@"right"];
    if (![[Tool toString:[dic objectForKey:@"xyhkr"]] isEqualToString:@"-1"]) {
        [array1 addObject:dic5];
    }
    
    //
    NSMutableDictionary *dic6 = [NSMutableDictionary dictionary];
    [dic6 setObject:@"原始投资金额" forKey:@"left"];
    [dic6 setObject:[self reLabWith:[NSString stringWithFormat:@"%@元",[dic objectForKey:@"ystzje"]]] forKey:@"right"];
    if (![[Tool toString:[dic objectForKey:@"ystzje"]] isEqualToString:@"-1"]) {
        [array1 addObject:dic6];
    }
    
    NSMutableDictionary *dic7 = [NSMutableDictionary dictionary];
    [dic7 setObject:@"逾期情况" forKey:@"left"];
    //逾期情况，0未发生逾期、1逾期、2严重逾期
    NSString *tyepYQQK = @"";
    if ([[dic objectForKey:@"yqqk"] isEqualToString:@"0"]) {
        tyepYQQK = @"未发生逾期";
    }else if ([[dic objectForKey:@"yqqk"] isEqualToString:@"1"]){
        tyepYQQK = @"逾期";
    }else if ([[dic objectForKey:@"yqqk"] isEqualToString:@"2"]){
        tyepYQQK = @"严重逾期";
    }
    [dic7 setObject:[self reLabWith:tyepYQQK] forKey:@"right"];
    if (![[Tool toString:[dic objectForKey:@"yqqk"]] isEqualToString:@"-1"]) {
        [array1 addObject:dic7];
    }
    
    
    
    
    //标的信息
    SanProject *san = [[SanProject alloc] init];
    [san makeData:[dic objectForKey:@"bddx"] withArray:array2 withBgUrl:urlArray];
   
    
}




-(NSString *)reLabWith:(NSString *)vlaue{
    return [NSString stringWithFormat:@"<p align=left><font size=14>%@</font></p>",vlaue];
}

-(NSString *)reLabWith:(NSString *)string withValue:(NSString *)value{
    return [NSString stringWithFormat:@"<p align=left><font size=14 color='#F08F00'>%@</font><font size=14 >%@</font></p>",string,value];
}






@end
