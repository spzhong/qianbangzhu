//
//  SanViewCell.m
//  quqian
//
//  Created by apple on 15/3/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SanViewCell.h"

@implementation SanViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.showjindu.layer setCornerRadius:2.0];
    [self.showjindu.layer setMasksToBounds:YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//我的散标
-(void)initMakeData:(NSMutableDictionary *)san withisMy:(NSString *)ismy{
    
    [self initMakeData:san];
  
    //投资金额
    if ([[san objectForKey:@"tzje"] doubleValue] < 10000) {
        
        self.planAllMoney.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[san objectForKey:@"tzje"] withDanwei:@"元" withName:@"投资金额"]];
        
    }else if ([[san objectForKey:@"tzje"] doubleValue] > 1000000000){
        
        NSString *bdze = [san objectForKey:@"tzje"];
        double zonge = [bdze doubleValue]/1000000000;
        self.planAllMoney.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%0.2lf",zonge] withDanwei:@"亿" withName:@"投资金额"]];
    }else{
        
        NSString *bdze = [san objectForKey:@"tzje"];
        double zonge = [bdze doubleValue]/10000;
        self.planAllMoney.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%0.2lf",zonge] withDanwei:@"万" withName:@"投资金额"]];
    }
    
    
    self.bid.enabled = YES;
    [self.bid setTitleColor:[UIColor colorWithRed:18/255.0 green:141/255.0 blue:211/255.0 alpha:1] forState:UIControlStateNormal];
    [self.bid setBackgroundImage:[UIImage imageNamed:@"button4.png"] forState:UIControlStateNormal];
    [self.bid setTitle:@"继续投标" forState:UIControlStateNormal];
}




//进行赋值
-(void)initMakeData:(NSMutableDictionary *)san{
    
    self.title.text = [san objectForKey:@"bdbt"];
    self.title.font = FOUR_CONTROL_FONT;
    self.jindu.text = [NSString stringWithFormat:@"%@％",[san objectForKey:@"rzjd"]];
    self.jiangxiang.text = [san objectForKey:@"jllx"];
    
    self.qi.hidden = YES;
    self.qiLab.hidden = YES;
    self.shi.hidden = YES;
    self.shiLab.hidden= YES;
    self.title.frame = CGRectMake(62, self.title.frame.origin.y, self.title.frame.size.width, self.title.frame.size.height);
    
   
    
    //判断图标
    NSMutableArray *tuArray = [san objectForKey:@"tb"];
    if ([tuArray count]==2) {
        NSString *one = [tuArray objectAtIndex:0];
        NSString *two = [tuArray objectAtIndex:1];
        if ([one isEqualToString:@""]) {
            self.qi.hidden = YES;
            self.qiLab.hidden = YES;
        }
        if ([two isEqualToString:@""]) {
            self.shi.hidden = YES;
            self.shiLab.hidden= YES;
            self.title.frame = CGRectMake(40, self.title.frame.origin.y, self.title.frame.size.width, self.title.frame.size.height);
        }
        
        if ([one isEqualToString:@"0"]) {
            self.qi.hidden = NO;
            self.qiLab.hidden = NO;
            self.qiLab.text = @"企";
        }else if ([one isEqualToString:@"1"]) {
            self.qi.hidden = NO;
            self.qiLab.hidden = NO;
            self.qiLab.text = @"保";
        }else if ([one isEqualToString:@"2"]) {
            self.qi.hidden = NO;
            self.qiLab.hidden = NO;
            self.qiLab.text = @"信";
        }else if ([one isEqualToString:@"3"]) {
            self.qi.hidden = NO;
            self.qiLab.hidden = NO;
            self.qiLab.text = @"实";
        }
        
        if ([two isEqualToString:@"0"]) {
            self.shi.hidden = NO;
            self.shiLab.hidden = NO;
            self.shiLab.text = @"企";
        }else if ([two isEqualToString:@"1"]) {
            self.shi.hidden = NO;
            self.shiLab.hidden = NO;
            self.shiLab.text = @"保";
        }else if ([two isEqualToString:@"2"]) {
            self.shi.hidden = NO;
            self.shiLab.hidden = NO;
            self.shiLab.text = @"信";
        }else if ([two isEqualToString:@"3"]) {
            self.shi.hidden = NO;
            self.shiLab.hidden = NO;
            self.shiLab.text = @"实";
        }
 
        
    }else{
        self.qi.hidden = YES;
        self.qiLab.hidden = YES;
        self.shi.hidden = YES;
        self.shiLab.hidden= YES;
        self.title.frame = CGRectMake(15, self.title.frame.origin.y, self.title.frame.size.width, self.title.frame.size.height);
        
    }
    
    
    
    self.showjindu.frame = CGRectMake(self.showjindu.frame.origin.x, self.showjindu.frame.origin.y,0, self.showjindu.frame.size.height);;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:2.0];
    self.showjindu.frame = CGRectMake(self.showjindu.frame.origin.x, self.showjindu.frame.origin.y,([[san objectForKey:@"rzjd"] intValue]/100.0) * 160, self.showjindu.frame.size.height);
    [UIView commitAnimations];
    
    
    //标的总额
    if ([[san objectForKey:@"bdze"] doubleValue] < 10000) {
        self.planAllMoney.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[san objectForKey:@"bdze"] withDanwei:@"元" withName:@"标的总额"]];
    }else if ([[san objectForKey:@"bdze"] doubleValue] > 1000000000){
        
        NSString *bdze = [san objectForKey:@"bdze"];
        double zonge = [bdze doubleValue]/1000000000;
        self.planAllMoney.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%0.2lf",zonge] withDanwei:@"亿" withName:@"标的总额"]];
    }else{
        
        NSString *bdze = [san objectForKey:@"bdze"];
        double zonge = [bdze doubleValue]/10000;
        self.planAllMoney.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%0.2lf",zonge] withDanwei:@"万" withName:@"标的总额"]];
    }
    
    
    //年利率
    //无奖励
    if ([[san objectForKey:@"jlll"] isEqualToString:@"-1"]) {
        self.yearlilv.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%@%%",[san objectForKey:@"nll"]] withDanwei:@"" withName:@"年利率"]];
    }else{
        self.yearlilv.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%@％+",[san objectForKey:@"nll"]] withDanwei:[NSString stringWithFormat:@"%@％",[san objectForKey:@"jlll"]] withName:@"年利率"]];
    }
    
    
    
    
    //剩余还款期限 public String hkqx; // 还款期限
    self.lastTime.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[san objectForKey:@"hkqx"] withDanwei:[self huankuanfangshi:[san objectForKey:@"jkfs"]] withName:@"还款期限"]];
    
    
    //按钮的选项
    [self.bid setTitle:[[self exchange_type_tiyan:[san objectForKey:@"zt"]] objectForKey:@"type"] forState:UIControlStateNormal];
    if ([[[self exchange_type_tiyan:[san objectForKey:@"zt"]] objectForKey:@"isTouch"] isEqualToString:@"no"]) {
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
    
    if ([name isEqualToString:@"年利率"]) {
        return [NSString stringWithFormat:@"<p align=center><font size=15 face='HelveticaNeue'>%@</font><font size=12 color='#F2B008' face='HelveticaNeue'>%@</font>\n<font size =11 color='#8B8B8B' face='HelveticaNeue'>%@</font></p>",string,danwei,name];
    }
    
    return [NSString stringWithFormat:@"<p align=center><font size=15 face='HelveticaNeue'>%@</font><font size=12 face='HelveticaNeue'>%@</font>\n<font size =11 color='#8B8B8B' face='HelveticaNeue'>%@</font></p>",string,danwei,name];
}







//状态--散标投资
-(NSMutableDictionary *)exchange_type_tiyan:(NSString *)type{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([type isEqualToString:@"敬请期待"]) {
        [dic setObject:@"敬请期待" forKey:@"type"];
        [dic setObject:@"no" forKey:@"isTouch"];
    }else if ([type isEqualToString:@"立即投标"]){
        [dic setObject:@"立即投标" forKey:@"type"];
        [dic setObject:@"yes" forKey:@"isTouch"];
    }else if ([type isEqualToString:@"已满标"]){
        [dic setObject:@"已满标" forKey:@"type"];
        [dic setObject:@"no" forKey:@"isTouch"];
    }else if ([type isEqualToString:@"还款中"]){
        [dic setObject:@"还款中" forKey:@"type"];
        [dic setObject:@"no" forKey:@"isTouch"];
    }else if ([type isEqualToString:@"已流标"]){
        [dic setObject:@"已流标" forKey:@"type"];
        [dic setObject:@"no" forKey:@"isTouch"];
    }else if ([type isEqualToString:@"已结清"]){
        [dic setObject:@"已结清" forKey:@"type"];
        [dic setObject:@"no" forKey:@"isTouch"];
    }
    return dic;
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


@end
