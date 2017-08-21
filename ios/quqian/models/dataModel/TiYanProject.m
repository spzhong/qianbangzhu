//
//  TiYanProject.m
//  quqian
//
//  Created by apple on 15/3/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "TiYanProject.h"
#import "Tool.h"


@implementation TiYanProject

@synthesize proDate;
@synthesize touzifanghsi;//投资方式
@synthesize licaishuming;//投资说明
@synthesize jihuazhuangtai;//计划状态
@synthesize suodingqixian;//锁定期限
@synthesize suodingjieshu;//锁定结束
@synthesize shouyichuli;//收益处理
@synthesize feilvshuoming;//费率说明

@synthesize jihuajieshao;//计划介绍


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
    [dic2 setObject:@"投资方式" forKey:@"key"];
    [dic2 setObject:@"体验金" forKey:@"value"];
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    [dic3 setObject:@"投资说明" forKey:@"key"];
    [dic3 setObject:@"《投资体验说明书》" forKey:@"value"];
    NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
    [dic4 setObject:@"计划状态" forKey:@"key"];
    [dic4 setObject:@"预售中" forKey:@"value"];
    NSMutableDictionary *dic5 = [NSMutableDictionary dictionary];
    [dic5 setObject:@"距离发售" forKey:@"key"];
    [dic5 setObject:@"12天23小时18分" forKey:@"value"];
    NSMutableDictionary *dic6 = [NSMutableDictionary dictionary];
    [dic6 setObject:@"锁定期限" forKey:@"key"];
    [dic6 setObject:@"1个月" forKey:@"value"];
    NSMutableDictionary *dic7 = [NSMutableDictionary dictionary];
    [dic7 setObject:@"锁定结束" forKey:@"key"];
    [dic7 setObject:@"2014年9月20日" forKey:@"value"];
    NSMutableDictionary *dic8 = [NSMutableDictionary dictionary];
    [dic8 setObject:@"每月还息" forKey:@"key"];
    [dic8 setObject:@"2014年9月20日" forKey:@"value"];
    NSMutableDictionary *dic9 = [NSMutableDictionary dictionary];
    [dic9 setObject:@"费率说明" forKey:@"key"];
    [dic9 setObject:@"体验活动收取任何费用" forKey:@"value"];
    
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
    
    return array;
}



//右边的信息
-(NSString *)rightInfo:(NSString *)left withValue:(NSString *)vlaue{
    if ([left isEqualToString:@"计划金额"]) {
        return [NSString stringWithFormat:@"<p align=left><font size=14 color='#F08F00'>%@</font><font size=15 >元</font></p>",vlaue];
    }else if ([left isEqualToString:@"预期收益"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14 color='#F08F00'>%@</font><font size=15 >每年</font></p>",vlaue];
    }else if ([left isEqualToString:@"投资方式"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14>%@</font></p>",vlaue];
    }else if ([left isEqualToString:@"投资说明"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14 color='#0082B6'>%@</font></p>",vlaue];
    }else if ([left isEqualToString:@"计划状态"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14 >%@</font></p>",vlaue];
    }else if ([left isEqualToString:@"距离发售"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14>%@</font></p>",vlaue];
    }else if ([left isEqualToString:@"锁定期限"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14>%@</font></p>",vlaue];
    }else if ([left isEqualToString:@"锁定结束"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14 color='#F08F00'>%@</font></p>",vlaue];
    }else if ([left isEqualToString:@"每月还息"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14>%@</font></p>",vlaue];
    }else if ([left isEqualToString:@"费率说明"]){
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
    
    
    self.proDate = [Tool toString:[dic objectForKey:@""]];//项目期数
    self.touzifanghsi = [Tool toString:[dic objectForKey:@""]];//投资方式
    self.licaishuming = [Tool toString:[dic objectForKey:@""]];//投资说明
    self.jihuazhuangtai = [Tool toString:[dic objectForKey:@""]];//计划状态
    self.suodingqixian = [Tool toString:[dic objectForKey:@""]];//锁定年限
    self.suodingjieshu = [Tool toString:[dic objectForKey:@""]];//锁定结束
    self.shouyichuli = [Tool toString:[dic objectForKey:@""]];//收益处理
    self.feilvshuoming = [Tool toString:[dic objectForKey:@""]];//费率说明
    
    self.jihuajieshao = [Tool toString:[dic objectForKey:@""]];//计划介绍
}




//进行组装数据
-(void)makeData:(NSMutableDictionary *)dic withArray:(NSMutableArray *)array withBgUrl:(NSMutableArray *)urlArray{
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setObject:@"计划金额" forKey:@"left"];
    [dic1 setObject:[self reLabWith:[dic objectForKey:@"jhje"] withValue:@"元"] forKey:@"right"];
    if (![[Tool toString:[dic objectForKey:@"jhje"]] isEqualToString:@"-1"]) {
        [array addObject:dic1];
    }
    
    //
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    [dic2 setObject:@"预期收益" forKey:@"left"];
    [dic2 setObject:[self reLabWith:[NSString stringWithFormat:@"%@%%",[dic objectForKey:@"nll"]]] forKey:@"right"];
    if (![[Tool toString:[dic objectForKey:@"nll"]] isEqualToString:@"-1"]) {
        [array addObject:dic2];
    }
    
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    [dic3 setObject:@"投资方式" forKey:@"left"];
    if ([[dic objectForKey:@"tzfs"] isEqualToString:@"0"]) {
        [dic3 setObject:[self reLabWith:@"体验金"] forKey:@"right"];
    }else if ([[dic objectForKey:@"tzfs"] isEqualToString:@"1"]){
        [dic3 setObject:[self reLabWith:@"现金"] forKey:@"right"];
    }
    if (![[Tool toString:[dic objectForKey:@"tzfs"]] isEqualToString:@"-1"]) {
        [array addObject:dic3];
    }
    
    NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
    [dic4 setObject:@"投资说明" forKey:@"left"];
    if (![[Tool toString:[dic objectForKey:@"lcsm_url"]] isEqualToString:@"-1"]) {
        [dic4 setObject:[self reLabWith:@"《投资体验说明书》" withValue:@""] forKey:@"right"];
        [array addObject:dic4];
    }
     
    
    NSMutableDictionary *dic5 = [NSMutableDictionary dictionary];
    [dic5 setObject:@"计划状态" forKey:@"left"];
    if ([[dic objectForKey:@"zt"] isEqualToString:@"0"]) {
        [dic5 setObject:[self reLabWith:@"预售中"] forKey:@"right"];
    }else if ([[dic objectForKey:@"zt"] isEqualToString:@"1"]){
        [dic5 setObject:[self reLabWith:@"申请中"] forKey:@"right"];
    }else if ([[dic objectForKey:@"zt"] isEqualToString:@"2"]){
        [dic5 setObject:[self reLabWith:@"已满额"] forKey:@"right"];
    }else if ([[dic objectForKey:@"zt"] isEqualToString:@"3"]){
        [dic5 setObject:[self reLabWith:@"已截止"] forKey:@"right"];
    }
    if (![[Tool toString:[dic objectForKey:@"zt"]] isEqualToString:@"-1"]) {
        [array addObject:dic5];
    }
    
    //距离发售
    //距离截止
    //满额用时
    NSMutableDictionary *dic6 = [NSMutableDictionary dictionary];
    [dic6 setObject:@"距离截止" forKey:@"left"];
    [dic6 setObject:[self reLabWith:[dic objectForKey:@"ckqx"]] forKey:@"right"];
    if (![[Tool toString:[dic objectForKey:@"ckqx"]] isEqualToString:@"-1"]) {
        [array addObject:dic6];
    }
    NSMutableDictionary *dic6_0 = [NSMutableDictionary dictionary];
    [dic6_0 setObject:@"距离发售" forKey:@"left"];
    [dic6_0 setObject:[self reLabWith:[dic objectForKey:@"fbsj"]] forKey:@"right"];
    if (![[Tool toString:[dic objectForKey:@"fbsj"]] isEqualToString:@"-1"]) {
        [array addObject:dic6_0];
    }
    NSMutableDictionary *dic6_1 = [NSMutableDictionary dictionary];
    [dic6_1 setObject:@"满额用时" forKey:@"left"];
    [dic6_1 setObject:[self reLabWith:[dic objectForKey:@"meys"]] forKey:@"right"];
    if (![[Tool toString:[dic objectForKey:@"meys"]] isEqualToString:@"-1"]) {
        [array addObject:dic6_1];
    }
    //距离发售
    //距离截止
    //满额用时
    
    
    
    NSMutableDictionary *dic7 = [NSMutableDictionary dictionary];
    [dic7 setObject:@"锁定期限" forKey:@"left"];
    [dic7 setObject:[self reLabWith:[NSString stringWithFormat:@"%@个月",[dic objectForKey:@"sdqx"]]] forKey:@"right"];
    if (![[Tool toString:[dic objectForKey:@"sdqx"]] isEqualToString:@"-1"]) {
        [array addObject:dic7];
    }
    
    NSMutableDictionary *dic8 = [NSMutableDictionary dictionary];
    [dic8 setObject:@"锁定结束" forKey:@"left"];
    [dic8 setObject:[dic objectForKey:@"sdjssj"] forKey:@"right"];
    if (![[Tool toString:[dic objectForKey:@"sdjssj"]] isEqualToString:@"-1"]) {
        [array addObject:dic8];
    }
    
    NSMutableDictionary *dic9 = [NSMutableDictionary dictionary];
    [dic9 setObject:@"收益处理" forKey:@"left"];
    if ([[dic objectForKey:@"sycl"] isEqualToString:@"0"]) {
        [dic9 setObject:[self reLabWith:@"每月还息"] forKey:@"right"];
    }else if ([[dic objectForKey:@"sycl"] isEqualToString:@"1"]) {
        [dic9 setObject:[self reLabWith:@"到期一次清付清"] forKey:@"right"];
    }else if ([[dic objectForKey:@"sycl"] isEqualToString:@"2"]) {
        [dic9 setObject:[self reLabWith:@"等额本息"] forKey:@"right"];
    }
    if (![[Tool toString:[dic objectForKey:@"sycl"]] isEqualToString:@"-1"]) {
        [array addObject:dic9];
    }

    NSMutableDictionary *dic10 = [NSMutableDictionary dictionary];
    [dic10 setObject:@"费率说明" forKey:@"left"];
    [dic10 setObject:@"体验活动不收取任何费用" forKey:@"right"];
    [array addObject:dic10];
//    if (![[Tool toString:[dic objectForKey:@"flcl"]] isEqualToString:@"-1"]) {
//        [array addObject:dic10];
//    }
     
    
    /////////////////////////////////////////////////
    NSMutableDictionary *dic14 = [NSMutableDictionary dictionary];
    [dic14 setObject:@"介绍说明" forKey:@"left"];
    if (![[Tool toString:[dic objectForKey:@"jhjs"]] isEqualToString:@"-1"]) {
        [dic14 setObject:[dic objectForKey:@"jhjs"] forKey:@"right"];
        [urlArray addObject:dic14];
    }
 
    
}




-(NSString *)reLabWith:(NSString *)vlaue{
    return [NSString stringWithFormat:@"<p align=left><font size=14>%@</font></p>",vlaue];
}

-(NSString *)reLabWith:(NSString *)string withValue:(NSString *)value{
    return [NSString stringWithFormat:@"<p align=left><font size=14 color='#F08F00'>%@</font><font size=14 >%@</font></p>",string,value];
}






@end
