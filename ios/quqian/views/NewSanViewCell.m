//
//  NewSanViewCell.m
//  qianbangzhu
//
//  Created by 宋培众 on 2017/6/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NewSanViewCell.h"

@implementation NewSanViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.planAllMoney = [[RCLabel alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth/3, 60)];
    [self addSubview:self.planAllMoney];
    
    self.yearlilv = [[RCLabel alloc] initWithFrame:CGRectMake(ScreenWidth/3, 50, ScreenWidth/3, 60)];
    [self addSubview:self.yearlilv];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/3, 50, 0.5, 50)];
    [line1 setBackgroundColor:RGB(238, 238, 238)];
    [self addSubview:line1];
    
    self.lastTime = [[RCLabel alloc] initWithFrame:CGRectMake(2*ScreenWidth/3, 50, ScreenWidth/3, 60)];
    [self addSubview:self.lastTime];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(2*ScreenWidth/3, 50, 0.5, 50)];
    [line2 setBackgroundColor:RGB(238, 238, 238)];
    [self addSubview:line2];
    
    
    self.xin.layer.borderColor =  [UIColor colorWithRed:60/255.0 green:154/255.0 blue:235/255.0 alpha:1].CGColor;
    self.xin.layer.borderWidth = 1;
    self.xin.layer.cornerRadius = 8;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



//我的散标
-(void)initMakeData:(NSMutableDictionary *)san withisMy:(NSString *)ismy withType:(NSString *)type{
    
    [self initMakeData:san withType:type];
    
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
-(void)initMakeData:(NSMutableDictionary *)san withType:(NSString *)type{
    
    self.title.text = [san objectForKey:@"bdbt"];
    self.title.font = FOUR_CONTROL_FONT;
    
    if ([type isEqualToString:@"0"]) {
        self.xin.text = @"信";
    }else{
        self.xin.text = @"存";
    }
    
    //标的总额
    if ([[san objectForKey:@"bdze"] doubleValue] < 10000) {
        self.planAllMoney.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[san objectForKey:@"bdze"] withDanwei:@"元" withName:@"标的总额"]];
    }else if ([[san objectForKey:@"bdze"] doubleValue] > 1000000000){
        
        NSString *bdze = [san objectForKey:@"bdze"];
        double zonge = [bdze doubleValue]/1000000000;
        self.planAllMoney.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%0.2lf",zonge] withDanwei:@"亿" withName:@"借款金额"]];
    }else{
        
        NSString *bdze = [san objectForKey:@"bdze"];
        double zonge = [bdze doubleValue]/10000;
        self.planAllMoney.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%0.2lf",zonge] withDanwei:@"万" withName:@"借款金额"]];
    }
    
    
    //年利率
    //无奖励
    self.yearlilv.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%@",[san objectForKey:@"nll"]] withDanwei:@"" withName:@"预期年化利率"]];
    
    
    
    //剩余还款期限 public String hkqx; // 还款期限
    self.lastTime.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[san objectForKey:@"hkqx"] withDanwei:[self huankuanfangshi:[san objectForKey:@"jkfs"]] withName:@"借款期限"]];
    
    
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
