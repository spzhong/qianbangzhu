//
//  SanProject.m
//  quqian
//
//  Created by apple on 15/3/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SanProject.h"

@implementation SanProject

@synthesize title;//标题
@synthesize qi; //企
@synthesize shi;//实
@synthesize jiang;//奖(土豪奖等等)

/*
 详情
 */
@synthesize baozhengfangshi;//保障方式
@synthesize tiqianhuankuanfeilv;//提前还款费率
@synthesize huankuanfangshi;//还款方式
@synthesize yuehuanxi;//月还息
@synthesize toubiaojiangli;//投标奖励
@synthesize touzicishu;//当前累计投资次数
@synthesize toubiaoxiane;//投标限额


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
        return [NSString stringWithFormat:@"<p align=left><font size=14>%@元</font></p>",vlaue];
    }else if ([left isEqualToString:@"投标进度"]){
        return vlaue;
    }else if ([left isEqualToString:@"投标奖励"]){
        return [NSString stringWithFormat:@"<p align=left><font size=14 color='#F08F00'>%@</font><font size=14 >幸运奖</font></p>",vlaue];
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
-(void)inputDataList:(NSMutableDictionary *)dic{
    
}


//创建一个model
-(void)inputDataListInfo:(NSMutableDictionary *)dic{
    
}



//创建一个model
-(void)inputData_myList:(NSMutableDictionary *)dic{
    
}




//进行组装数据
-(void)makeData:(NSMutableDictionary *)dic withArray:(NSMutableArray *)array withBgUrl:(NSMutableArray *)urlArray{
   
    
    if ([dic[@"zt"] isEqualToString:@"还款中"]) {
        
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
        [dic1 setObject:@"还款方式" forKey:@"left"];
        [dic1 setObject:[self reLabWith:[dic objectForKey:@"hkfs"] withValue:@""] forKey:@"right"];
        
        NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
        [dic2 setObject:@"剩余期数" forKey:@"left"];
        [dic2 setObject:[self reLabWith:[NSString stringWithFormat:@"%@",[dic objectForKey:@"syqs"]]] forKey:@"right"];
        
        NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
        [dic3 setObject:@"待还本金总额" forKey:@"left"];
        [dic3 setObject:[self reLabWith:[NSString stringWithFormat:@"%@",[dic objectForKey:@"dhbj"]]] forKey:@"right"];
        
        NSString *xiayigehuikuanri = @"";
        if ([dic[@"xyhkr"] length] > 11) {
            xiayigehuikuanri = [dic[@"hkr"] substringToIndex:11];
        } else {
            xiayigehuikuanri = dic[@"hkr"];
        }
        NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
        [dic4 setObject:@"下个还款日" forKey:@"left"];
        [dic4 setObject:[self reLabWith:xiayigehuikuanri ] forKey:@"right"];
        
 
         NSMutableDictionary *dic5 = [NSMutableDictionary dictionary];
         [dic5 setObject:@"满标用时" forKey:@"left"];
         [dic5 setObject:[self reLabWith:[NSString stringWithFormat:@"%@",[dic objectForKey:@"mbsj"]]] forKey:@"right"];
        
        
        [array addObject:dic1];
        [array addObject:dic2];
        [array addObject:dic3];
        [array addObject:dic4];
        [array addObject:dic5];
        
    }else if ([dic[@"zt"] isEqualToString:@"已满标"]) {
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
        [dic1 setObject:@"还款方式" forKey:@"left"];
        [dic1 setObject:[self reLabWith:[dic objectForKey:@"hkfs"] withValue:@""] forKey:@"right"];
        
        NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
        [dic2 setObject:@"月还本息" forKey:@"left"];
        [dic2 setObject:[self reLabWith:[dic objectForKey:@"yhbx"] withValue:@""] forKey:@"right"];
        
        NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
        [dic3 setObject:@"投标限额" forKey:@"left"];
        [dic3 setObject:[self reLabWith:[dic objectForKey:@"tbxe"] withValue:@""] forKey:@"right"];
        
        NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
        [dic4 setObject:@"满标用时" forKey:@"left"];
        [dic4 setObject:[self reLabWith:[dic objectForKey:@"mbsj"] withValue:@""] forKey:@"right"];
        
        [array addObject:dic1];
        [array addObject:dic2];
        [array addObject:dic3];
        [array addObject:dic4];
        
        
    }else if ([dic[@"zt"] isEqualToString:@"已经结清"]) {
        
        
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
        [dic1 setObject:@"还款方式" forKey:@"left"];
        [dic1 setObject:[self reLabWith:[dic objectForKey:@"hkfs"] withValue:@""] forKey:@"right"];
        
        NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
        [dic2 setObject:@"剩余期数" forKey:@"left"];
        [dic2 setObject:[self reLabWith:[NSString stringWithFormat:@"%@",[dic objectForKey:@"syqs"]]] forKey:@"right"];
        
        NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
        [dic3 setObject:@"已还本金总额" forKey:@"left"];
        [dic3 setObject:[self reLabWith:[NSString stringWithFormat:@"%@",[dic objectForKey:@"yhbj"]]] forKey:@"right"];
        
        NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
        [dic4 setObject:@"结清日期" forKey:@"left"];
        [dic4 setObject:[self reLabWith:[NSString stringWithFormat:@"%@",[dic objectForKey:@"jqrq"]]] forKey:@"right"];
      
        NSMutableDictionary *dic5 = [NSMutableDictionary dictionary];
        [dic5 setObject:@"满标用时" forKey:@"left"];
        [dic5 setObject:[self reLabWith:[NSString stringWithFormat:@"%@",[dic objectForKey:@"mbsj"]]] forKey:@"right"];
        
        [array addObject:dic1];
        [array addObject:dic2];
        [array addObject:dic3];
        [array addObject:dic4];
        [array addObject:dic5];
        
    } else {
        
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
        [dic1 setObject:@"还款方式" forKey:@"left"];
        [dic1 setObject:[self reLabWith:[dic objectForKey:@"hkfs"] withValue:@""] forKey:@"right"];
        
        NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
        [dic2 setObject:@"月还本息" forKey:@"left"];
        [dic2 setObject:[self reLabWith:[NSString stringWithFormat:@"%@",[dic objectForKey:@"yhbx"]]] forKey:@"right"];
        
        NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
        [dic3 setObject:@"月还本息" forKey:@"left"];
        [dic3 setObject:[self reLabWith:[NSString stringWithFormat:@"%@元",[dic objectForKey:@"yhbx"]]] forKey:@"right"];
        
        NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
        [dic4 setObject:@"投标限额" forKey:@"left"];
        [dic4 setObject:[self reLabWith:[NSString stringWithFormat:@"%@元",[dic objectForKey:@"tbxe"]]] forKey:@"right"];
        
        NSMutableDictionary *dic5 = [NSMutableDictionary dictionary];
        [dic5 setObject:@"满标后当日计息" forKey:@"left"];
        [dic5 setObject:[self reLabWith:@"满标后当日计息"] forKey:@"right"];
        
        NSMutableDictionary *dic6 = [NSMutableDictionary dictionary];
        [dic6 setObject:@"剩余时间" forKey:@"left"];
        [dic6 setObject:[self reLabWith:dic[@"rzsysj"]] forKey:@"right"];
        
        [array addObject:dic1];
        [array addObject:dic2];
        [array addObject:dic3];
        [array addObject:dic4];
        [array addObject:dic5];
        [array addObject:dic6];
    }
    
    
    
    if ([dic[@"zt"] isEqualToString:@"立即投标"] || [dic[@"zt"] isEqualToString:@"已满标"] || [dic[@"zt"] isEqualToString:@"已流标"]) {
        
        NSMutableDictionary *dic14 = [NSMutableDictionary dictionary];
        [dic14 setObject:@"标的详情" forKey:@"left"];
        if (![[Tool toString:[dic objectForKey:@"bdxq_url"]] isEqualToString:@"-1"]) {
            [dic14 setObject:[dic objectForKey:@"bdxq_url"] forKey:@"right"];
            [urlArray addObject:dic14];
        }
        NSMutableDictionary *dic15 = [NSMutableDictionary dictionary];
        [dic15 setObject:@"相关资料" forKey:@"left"];
        if (![[Tool toString:[dic objectForKey:@"xgzl_url"]] isEqualToString:@"-1"]) {
            [dic15 setObject:[dic objectForKey:@"xgzl_url"] forKey:@"right"];
            [urlArray addObject:dic15];
        }
        NSMutableDictionary *dic17 = [NSMutableDictionary dictionary];
        [dic17 setObject:@"投标记录" forKey:@"left"];
        if (![[Tool toString:[dic objectForKey:@"tbjl_url"]] isEqualToString:@"-1"]) {
            [dic17 setObject:[dic objectForKey:@"tbjl_url"] forKey:@"right"];
            [urlArray addObject:dic17];
        }
        NSMutableDictionary *dic18 = [NSMutableDictionary dictionary];
        [dic18 setObject:@"借款协议" forKey:@"left"];
        if (![[Tool toString:[dic objectForKey:@"jkxy_url"]] isEqualToString:@"-1"]) {
            [dic18 setObject:[dic objectForKey:@"jkxy_url"] forKey:@"right"];
            [urlArray addObject:dic18];
        }
        
    }else{
        NSMutableDictionary *dic14 = [NSMutableDictionary dictionary];
        [dic14 setObject:@"标的详情" forKey:@"left"];
        if (![[Tool toString:[dic objectForKey:@"bdxq_url"]] isEqualToString:@"-1"]) {
            [dic14 setObject:[dic objectForKey:@"bdxq_url"] forKey:@"right"];
            [urlArray addObject:dic14];
        }
        NSMutableDictionary *dic15 = [NSMutableDictionary dictionary];
        [dic15 setObject:@"相关资料" forKey:@"left"];
        if (![[Tool toString:[dic objectForKey:@"xgzl_url"]] isEqualToString:@"-1"]) {
            [dic15 setObject:[dic objectForKey:@"xgzl_url"] forKey:@"right"];
            [urlArray addObject:dic15];
        }
        NSMutableDictionary *dic17 = [NSMutableDictionary dictionary];
        [dic17 setObject:@"投标记录" forKey:@"left"];
        if (![[Tool toString:[dic objectForKey:@"tbjl_url"]] isEqualToString:@"-1"]) {
            [dic17 setObject:[dic objectForKey:@"tbjl_url"] forKey:@"right"];
            [urlArray addObject:dic17];
        }
        NSMutableDictionary *dic18 = [NSMutableDictionary dictionary];
        [dic18 setObject:@"还款记录" forKey:@"left"];
        if (![[Tool toString:[dic objectForKey:@"hkjl_url"]] isEqualToString:@"-1"]) {
            [dic18 setObject:[dic objectForKey:@"hkjl_url"] forKey:@"right"];
            [urlArray addObject:dic18];
        }
        NSMutableDictionary *dic19 = [NSMutableDictionary dictionary];
        [dic19 setObject:@"债权信息" forKey:@"left"];
        if (![[Tool toString:[dic objectForKey:@"zqxx_url"]] isEqualToString:@"-1"]) {
            [dic19 setObject:[dic objectForKey:@"zqxx_url"] forKey:@"right"];
            [urlArray addObject:dic19];
        }
        NSMutableDictionary *dic20 = [NSMutableDictionary dictionary];
        [dic20 setObject:@"借款协议" forKey:@"left"];
        if (![[Tool toString:[dic objectForKey:@"jkxy_url"]] isEqualToString:@"-1"]) {
            [dic20 setObject:[dic objectForKey:@"jkxy_url"] forKey:@"right"];
            [urlArray addObject:dic20];
        }
 
    }
    
}




-(NSString *)reLabWith:(NSString *)vlaue{
    return [NSString stringWithFormat:@"<p align=left><font size=14>%@</font></p>",vlaue];
}

-(NSString *)reLabWith:(NSString *)string withValue:(NSString *)value{
    return [NSString stringWithFormat:@"<p align=left><font size=14 color='#F08F00'>%@</font><font size=14 >%@</font></p>",string,value];
}



-(NSString *)huankuanfangshi:(NSString *)type{
    
    if ([type isEqualToString:@"0"]) {
        return @"个月";
    }else if ([type isEqualToString:@"1"]){
        return @"天";
    }else if ([type isEqualToString:@"2"]){
        return @"秒标";
    }
    return @"";
}




//算法
-(double)suanfa:(NSMutableDictionary *)dic withFenshu:(int)fenshu withType:(int)type{
    
    double value = 0.00;
    
    double nian = 0.00;
    double yue = 0.00;
    double tian = 0.00;
    
    if (type==0) {
        nian = [[dic objectForKey:@"nll"] doubleValue] / 100;
        yue = [[dic objectForKey:@"nll"] doubleValue]/100/12;
        tian = [[dic objectForKey:@"nll"] doubleValue]/100/360;
    }else if(type==1){
        nian = [[dic objectForKey:@"jlll"] doubleValue]/100;
        yue = [[dic objectForKey:@"jlll"] doubleValue]/100/12;
        tian = [[dic objectForKey:@"jlll"] doubleValue]/100/360;
    }
    
    if (nian <= 0.00) {
        return 0.00;
    }
    
    
    int hkqx = [[dic objectForKey:@"hkqx"] doubleValue];
    
    
    //月标
    if ([[dic objectForKey:@"jkfs"] intValue]==0) {
        
        if ([[dic objectForKey:@"hkfs"] isEqualToString:@"每月还息不扣首期利息"] || [[dic objectForKey:@"hkfs"] isEqualToString:@"每月还息扣首期利息"]) {
            
            NSString *ss = [NSString stringWithFormat:@"%.2lf",100*yue];
            value = fenshu * ([ss doubleValue]) * [[dic objectForKey:@"hkqx"] intValue];
            
        }
        
        if ([[dic objectForKey:@"hkfs"] isEqualToString:@"等额本息"]) {
            //每份每月还款额
            double a1 = 100 * (yue * pow(1+yue,hkqx)) / pow((1+yue),hkqx-1);
            NSString *sa1 = [NSString stringWithFormat:@"%.2lf",a1];
            //每月还款额
            double a2 = fenshu * [sa1 doubleValue];
            //每份的总利息
            double a3 = ((fenshu * 100)*yue-a2) * pow(1+yue,hkqx-1) / yue + hkqx * a2;
            NSString *sa3 = [NSString stringWithFormat:@"%.2lf",a3];
            value = fenshu * [sa3 doubleValue];
        }
        

    }else if ([[dic objectForKey:@"jkfs"] intValue]==1){//天标
        NSString *ss = [NSString stringWithFormat:@"%.2lf",100*tian];
        value = fenshu * ([ss doubleValue]) * [[dic objectForKey:@"hkqx"] intValue];
    }else if ([[dic objectForKey:@"jkfs"] intValue]==2){//秒标
        NSString *ss = [NSString stringWithFormat:@"%.2lf",100*nian];
        value = fenshu * ([ss doubleValue]) * [[dic objectForKey:@"hkqx"] intValue];
    }
    
    return value;
}





-(NSString *)jisuan:(NSString *)cur withEnd:(NSString *)end{
    
    NSString *dateContent = @"";
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *  senddate=[dateFormatter dateFromString:cur];
    //结束时间
    NSDate *endDate = [dateFormatter dateFromString:end];
    //当前时间
    NSDate *senderDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:senddate]];
    //得到相差秒数
    NSTimeInterval time=[endDate timeIntervalSinceDate:senderDate];
    
    int days = ((int)time)/(3600*24);
    int hours = ((int)time)%(3600*24)/3600;
    int minute = ((int)time)%(3600*24)/3600/60;
    
    if (days <= 0 &&hours<= 0&&minute<= 0)
        dateContent=@"0天0小时0分钟";
    else
        dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时%i分钟",days,hours,minute];
    
    return dateContent;
}




@end
