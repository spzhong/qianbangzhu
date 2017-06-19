//
//  OwnSanViewCell.m
//  quqian
//
//  Created by apple on 15/3/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "OwnSanViewCell.h"

@implementation OwnSanViewCell

- (void)awakeFromNib {
    // Initialization code
    
    for (int i = 1; i < 4; i++) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(80*i,44.5, 1, 28)];
        img.image = [UIImage imageNamed:@"line2-56.png"];
        img.tag = 10000+i;
        [self addSubview:img];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)initMakeData_0:(NSMutableDictionary *)san{
    
    
    //修改中间的间距
    self.one.frame = CGRectMake(self.one.frame.origin.x, self.one.frame.origin.y, 95, self.one.frame.size.height);
    self.two.frame = CGRectMake(95, self.two.frame.origin.y, 85, self.two.frame.size.height);
    self.three.frame = CGRectMake(180, self.three.frame.origin.y, 60, self.three.frame.size.height);
    self.four.frame = CGRectMake(240, self.four.frame.origin.y, 80, self.four.frame.size.height);
    
    UIView *img = [self viewWithTag:10001];
    img.frame = CGRectMake(95,44.5, 1, 28);
    UIView *img1 = [self viewWithTag:10002];
    img1.frame = CGRectMake(182,44.5, 1, 28);
    UIView *img2 = [self viewWithTag:10003];
    img2.frame = CGRectMake(242,44.5, 1, 28);
    
    
    
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
    
    
    
    
    self.title.text = [san objectForKey:@"bdbt"];
    self.title.font = FOUR_CONTROL_FONT;
    
    
     self.two.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%@",[san objectForKey:@"dsbx"]] withName:@"待收本息"]];
    
//    
//    if ([[san objectForKey:@"jllx"] isEqualToString:@"无奖励"]) {
//        self.two.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%@",[san objectForKey:@"dsbx"]] withName:@"待收本息"]];
//        
//    }else{
//        if ([[san objectForKey:@"jlje"] isEqualToString:@"0"]) {
//            
//            self.two.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%@",[san objectForKey:@"dsbx"]] withName:@"待收本息"]];
//            
//        }else{
//            self.two.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%@+%@",[san objectForKey:@"dsbx"],[san objectForKey:@"jlje"]] withName:@"待收本息"]];
//        }
//    }
//
    
//    if ([[san objectForKey:@"jllx"] isEqualToString:@"无奖励"]) {
//        self.one.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%@%%",[san objectForKey:@"nll"]] withName:@"年利率"]];
//    }else{
//        self.one.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%@%%+%@",[san objectForKey:@"nll"],[san objectForKey:@"jllx"]] withName:@"年利率"]];
//        
//    }
    
    self.one.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%@",[san objectForKey:@"nll"]] withName:@"年利率"]];
    
    self.three.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[san objectForKey:@"syqs"] withName:@"剩余期数"]];
    self.four.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[[san objectForKey:@"xyhkr"] substringToIndex:11] withName:@"下个还款日"]];
    
    
  
    
}

-(void)initMakeData_2:(NSMutableDictionary *)san{
    
    //修改中间的间距
    self.one.frame = CGRectMake(self.one.frame.origin.x, self.one.frame.origin.y, 95, self.one.frame.size.height);
    self.two.frame = CGRectMake(95, self.two.frame.origin.y, 60, self.two.frame.size.height);
    self.three.frame = CGRectMake(155, self.three.frame.origin.y, 85, self.three.frame.size.height);
    self.four.frame = CGRectMake(240, self.four.frame.origin.y, 80, self.four.frame.size.height);
    
    UIView *img = [self viewWithTag:10001];
    img.frame = CGRectMake(95,44.5, 1, 28);
    UIView *img1 = [self viewWithTag:10002];
    img1.frame = CGRectMake(155,44.5, 1, 28);
    UIView *img2 = [self viewWithTag:10003];
    img2.frame = CGRectMake(242,44.5, 1, 28);
    
    
    
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
    
    
    
    
    self.title.text = [san objectForKey:@"bdbt"];
    self.title.font = FOUR_CONTROL_FONT;
    
    self.two.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[san objectForKey:@"tzje"] withName:@"投资金额"]];
    self.one.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%@",[san objectForKey:@"nll"]] withName:@"年利率"]];
    self.three.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[san objectForKey:@"yzje"] withName:@"已赚金额"]];
    
    if ([[san objectForKey:@"jqrq"] length]>10) {
        self.four.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[[san objectForKey:@"jqrq"] substringToIndex:11] withName:@"结清日期"]];
    }else{
        self.four.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[san objectForKey:@"jqrq"] withName:@"结清日期"]];

    }
}

-(void)initMakeData_3:(NSMutableDictionary *)san{
    
    
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
    
    
    
    self.title.text = [san objectForKey:@"bdbt"];
    self.title.font = FOUR_CONTROL_FONT;
    
    
    self.one.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[san objectForKey:@"zccjfs"] withName:@"成交份数"]];
    self.two.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[san objectForKey:@"zcsjsr"] withName:@"实际收入"]];
    self.three.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[san objectForKey:@"zcjyfy"] withName:@"交易费用"]];
    self.four.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[san objectForKey:@"zczryk"] withName:@"转让盈亏"]];
}


//转换
-(NSString *)exchage:(NSString *)string withName:(NSString *)name{
    return [NSString stringWithFormat:@"<p align=center><font size=12 face='HelveticaNeue'>%@</font>\n<font size =11 color='#8B8B8B' face='HelveticaNeue'>%@</font></p>",string,name];
}



 
-(void)tiyan_initMakeData_1:(NSMutableDictionary *)tiyan{
    self.qiLab.hidden = YES;
    self.shiLab.hidden = YES;
    self.qi.hidden = YES;
    self.shi.hidden = YES;
    self.title.text = [tiyan objectForKey:@"bt"];
    self.title.frame = CGRectMake(10, 7, 160, 20);
    self.title.font = FOUR_CONTROL_FONT;
    
    self.one.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[tiyan objectForKey:@"dssy"] withName:@"待收收益"]];
    self.two.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%@%%",[tiyan objectForKey:@"nll"]] withName:@"年利率"]];
    self.three.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%@/%@",[tiyan objectForKey:@"syqs"],[tiyan objectForKey:@"zqs"]] withName:@"剩余期数"]];
    
//    
//    if ([[tiyan objectForKey:@"jzrq"] length]>10) {
//        self.four.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[[tiyan objectForKey:@"xyghkr"] substringToIndex:11] withName:@"下个回款日"]];
//    }else{
//        self.four.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:@"" withName:@"下个回款日"]];
//    }
    
    self.four.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[tiyan objectForKey:@"xyghkr"] withName:@"下个回款日"]];
}
-(void)tiyan_initMakeData_2:(NSMutableDictionary *)tiyan{
    self.qiLab.hidden = YES;
    self.shiLab.hidden = YES;
    self.qi.hidden = YES;
    self.shi.hidden = YES;
    self.title.text =[tiyan objectForKey:@"bt"];
    self.title.font = FOUR_CONTROL_FONT;
    self.title.frame = CGRectMake(10, 7, 160, 20);
    
    self.one.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[tiyan objectForKey:@"jrje"] withName:@"加入金额"]];
    self.two.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%@%%",[tiyan objectForKey:@"nll"]]  withName:@"年利率"]];
    self.three.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[tiyan objectForKey:@"yzje"] withName:@"已赚金额"]];
    
    if ([[tiyan objectForKey:@"jzrq"] length]>10) {
        self.four.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[[tiyan objectForKey:@"jzrq"] substringToIndex:11] withName:@"截止日期"]];
    }else{
        self.four.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:@"" withName:@"截止日期"]];
    }
}




@end
