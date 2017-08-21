//
//  WenZhuanViewCell.m
//  quqian
//
//  Created by apple on 15/3/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "WenZhuanViewCell.h"
#import "Tool.h"

@implementation WenZhuanViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.showjindu.layer setCornerRadius:2.0];
    [self.showjindu.layer setMasksToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//进行赋值--稳赚保
-(void)initMakeData:(WenZhuanProject *)wen{
    self.title.text = wen.title;
    self.title.font = FOUR_CONTROL_FONT;
    self.jindu.text = [NSString stringWithFormat:@"%@％",wen.jindu];
    
    self.showjindu.frame = CGRectMake(self.showjindu.frame.origin.x, self.showjindu.frame.origin.y,0, self.showjindu.frame.size.height);;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:2.0];
    self.showjindu.frame = CGRectMake(self.showjindu.frame.origin.x, self.showjindu.frame.origin.y,([wen.jindu intValue]/100.0) * 160, self.showjindu.frame.size.height);
    [UIView commitAnimations];
    
    //标的总额
    self.planAllMoney.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:@"21.02" withDanwei:@"万" withName:@"计划金额"]];
    
    //年利率
    self.yearlilv.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:@"20" withDanwei:@"%" withName:@"年利率"]];
    
    //剩余还款期限
    self.lastTime.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:@"1" withDanwei:@"个月" withName:@"锁定期限"]];
    
    
    
    //按钮的选项
    [self.bid setTitle:[[self exchange_type:[wen.type intValue]] objectForKey:@"type"] forState:UIControlStateNormal];
    if ([[[self exchange_type:[wen.type intValue]] objectForKey:@"isTouch"] isEqualToString:@"no"]) {
        self.bid.enabled = NO;
        [self.bid setTitleColor:[UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1] forState:UIControlStateNormal];
        [self.bid setBackgroundImage:[UIImage imageNamed:@"button3.png"] forState:UIControlStateNormal];
    }else{
        self.bid.enabled = YES;
        [self.bid setTitleColor:[UIColor colorWithRed:18/255.0 green:141/255.0 blue:211/255.0 alpha:1] forState:UIControlStateNormal];
        [self.bid setBackgroundImage:[UIImage imageNamed:@"button4.png"] forState:UIControlStateNormal];
    }
 
    
}


//我的投资体验
-(void)initMakeData_tiyan:(NSMutableDictionary *)tiyan withMy:(NSString *)my{
    
    [self initMakeData_tiyan:tiyan];
    
    
    //加入金额
    if ([[tiyan objectForKey:@"jrje"] doubleValue] < 10000) {
        self.planAllMoney.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[tiyan objectForKey:@"jrje"] withDanwei:@"元" withName:@"加入金额"]];
    }else if ([[tiyan objectForKey:@"jrje"] doubleValue] > 1000000000){
        
        NSString *bdze = [tiyan objectForKey:@"jrje"];
        double zonge = [bdze doubleValue]/1000000000;
        self.planAllMoney.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%0.2lf",zonge] withDanwei:@"亿" withName:@"加入金额"]];
    }else{
        
        NSString *bdze = [tiyan objectForKey:@"jrje"];
        double zonge = [bdze doubleValue]/10000;
        self.planAllMoney.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%0.2lf",zonge] withDanwei:@"万" withName:@"加入金额"]];
    }
    
 
    
    self.bid.enabled = YES;
    [self.bid setTitleColor:[UIColor colorWithRed:18/255.0 green:141/255.0 blue:211/255.0 alpha:1] forState:UIControlStateNormal];
    [self.bid setBackgroundImage:[UIImage imageNamed:@"button4.png"] forState:UIControlStateNormal];
    [self.bid setTitle:@"继续申请" forState:UIControlStateNormal];
}




//投资体验
-(void)initMakeData_tiyan:(NSMutableDictionary *)tiyan{
    self.title.text = [tiyan objectForKey:@"bt"];
    self.title.font = FOUR_CONTROL_FONT;
    self.jindu.text = [NSString stringWithFormat:@"%@％",[tiyan objectForKey:@"rzjd"]];
    
    
    self.showjindu.frame = CGRectMake(self.showjindu.frame.origin.x, self.showjindu.frame.origin.y,0, self.showjindu.frame.size.height);;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:2.0];
    self.showjindu.frame = CGRectMake(self.showjindu.frame.origin.x, self.showjindu.frame.origin.y,([[tiyan objectForKey:@"rzjd"] intValue]/100.0) * 160, self.showjindu.frame.size.height);
    [UIView commitAnimations];
    
    
    //投资金额
    if ([[tiyan objectForKey:@"jhje"] doubleValue] < 10000) {
        
        self.planAllMoney.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[tiyan objectForKey:@"jhje"] withDanwei:@"元" withName:@"标的总额"]];
        
    }else if ([[tiyan objectForKey:@"jhje"] doubleValue] > 1000000000){
        
        NSString *bdze = [tiyan objectForKey:@"jhje"];
        double zonge = [bdze doubleValue]/1000000000;
        self.planAllMoney.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%0.2lf",zonge] withDanwei:@"亿" withName:@"标的总额"]];
    }else{
        
        NSString *bdze = [tiyan objectForKey:@"jhje"];
        double zonge = [bdze doubleValue]/10000;
        self.planAllMoney.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%0.2lf",zonge] withDanwei:@"万" withName:@"标的总额"]];
    }
    
   
    
    //年利率
    self.yearlilv.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[tiyan objectForKey:@"nll"] withDanwei:@"%" withName:@"年利率"]];
    
    //剩余还款期限
    self.lastTime.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[tiyan objectForKey:@"sdqx"] withDanwei:@"个月" withName:@"锁定期限"]];
    
    
    //按钮的选项
    [self.bid setTitle:[[self exchange_type_tiyan:[tiyan objectForKey:@"zt"]] objectForKey:@"type"] forState:UIControlStateNormal];
    if ([[[self exchange_type_tiyan:[tiyan objectForKey:@"zt"]] objectForKey:@"isTouch"] isEqualToString:@"no"]) {
        self.bid.enabled = NO;
        [self.bid setTitleColor:[UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1] forState:UIControlStateNormal];
        [self.bid setBackgroundImage:[UIImage imageNamed:@"button3.png"] forState:UIControlStateNormal];
    }else{
        self.bid.enabled = YES;
        [self.bid setTitleColor:[UIColor colorWithRed:18/255.0 green:141/255.0 blue:211/255.0 alpha:1] forState:UIControlStateNormal];
        [self.bid setBackgroundImage:[UIImage imageNamed:@"button4.png"] forState:UIControlStateNormal];
    }
}



//转换
-(NSString *)exchage:(NSString *)string withDanwei:(NSString *)danwei withName:(NSString *)name{
    return [NSString stringWithFormat:@"<p align=center><font size=15 face='HelveticaNeue'>%@</font><font size=12 face='HelveticaNeue'>%@</font>\n<font size =11 color='#8B8B8B' face='HelveticaNeue'>%@</font></p>",string,danwei,name];
}

 


//状态--稳赚保
-(NSMutableDictionary *)exchange_type:(int)type{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (type==0) {
        [dic setObject:@"即将预定" forKey:@"type"];
        [dic setObject:@"no" forKey:@"isTouch"];
    }else if (type==1){
        [dic setObject:@"预定中" forKey:@"type"];
        [dic setObject:@"yes" forKey:@"isTouch"];
    }else if (type==2){
        [dic setObject:@"预定满额" forKey:@"type"];
        [dic setObject:@"no" forKey:@"isTouch"];
    }else if (type==3){
        [dic setObject:@"等待开发" forKey:@"type"];
        [dic setObject:@"no" forKey:@"isTouch"];
    }else if (type==4){
        [dic setObject:@"立即加入" forKey:@"type"];
        [dic setObject:@"no" forKey:@"isTouch"];
    }else if (type==5){
        [dic setObject:@"已满额" forKey:@"type"];
        [dic setObject:@"no" forKey:@"isTouch"];
    }else if (type==6){
        [dic setObject:@"收益中" forKey:@"type"];
        [dic setObject:@"no" forKey:@"isTouch"];
    }else {
        [dic setObject:@"已到期" forKey:@"type"];
        [dic setObject:@"no" forKey:@"isTouch"];
    }
    return dic;
}



//状态--投资体验
-(NSMutableDictionary *)exchange_type_tiyan:(NSString *)type{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([type isEqualToString:@"敬请期待"]) {
        [dic setObject:@"敬请期待" forKey:@"type"];
        [dic setObject:@"no" forKey:@"isTouch"];
    }else if ([type isEqualToString:@"立即申请"]){
        [dic setObject:@"立即申请" forKey:@"type"];
        [dic setObject:@"yes" forKey:@"isTouch"];
    }else if ([type isEqualToString:@"已满额"]){
        [dic setObject:@"已满额" forKey:@"type"];
        [dic setObject:@"no" forKey:@"isTouch"];
    }else if ([type isEqualToString:@"已截止"]){
        [dic setObject:@"已截止" forKey:@"type"];
        [dic setObject:@"no" forKey:@"isTouch"];
    }
    return dic;
}



@end
