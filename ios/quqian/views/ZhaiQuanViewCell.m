//
//  ZhaiQuanViewCell.m
//  quqian
//
//  Created by apple on 15/3/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ZhaiQuanViewCell.h"
#import "Tool.h"

@implementation ZhaiQuanViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.showjindu.layer setCornerRadius:2.0];
    [self.showjindu.layer setMasksToBounds:YES];
    
    for (int i = 1; i < 5; i++) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(64*i+1.5,67.5, 1, 28)];
        img.image = [UIImage imageNamed:@"line2-56.png"];
        [self addSubview:img];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

//进行赋值
-(void)initMakeData:(NSMutableDictionary *)zhai{
    
    self.title.text = [zhai objectForKey:@"bt"];
    self.title.font = FOUR_CONTROL_FONT;
    self.jindu.text = [NSString stringWithFormat:@"%@％",[zhai objectForKey:@"nll"]];
    
    
    //判断图标
    NSMutableArray *tuArray = [zhai objectForKey:@"tb"];
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
            self.qi.hidden = NO;
            self.qiLab.hidden = NO;
            self.qiLab.text = @"企";
        }else if ([two isEqualToString:@"1"]) {
            self.qi.hidden = NO;
            self.qiLab.hidden = NO;
            self.qiLab.text = @"保";
        }else if ([two isEqualToString:@"2"]) {
            self.qi.hidden = NO;
            self.qiLab.hidden = NO;
            self.qiLab.text = @"信";
        }else if ([two isEqualToString:@"3"]) {
            self.qi.hidden = NO;
            self.qiLab.hidden = NO;
            self.qiLab.text = @"实";
        }
        
        
    }else{
        self.qi.hidden = YES;
        self.qiLab.hidden = YES;
        self.shi.hidden = YES;
        self.shiLab.hidden= YES;
        self.title.frame = CGRectMake(15, self.title.frame.origin.y, self.title.frame.size.width, self.title.frame.size.height);
        
    }
    
    
    
//    self.showjindu.frame = CGRectMake(self.showjindu.frame.origin.x, self.showjindu.frame.origin.y,0, self.showjindu.frame.size.height);;
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDelay:2.0];
//    self.showjindu.frame = CGRectMake(self.showjindu.frame.origin.x, self.showjindu.frame.origin.y,([[zhai objectForKey:@"nll"] intValue]/100.0) * 160, self.showjindu.frame.size.height);
//    [UIView commitAnimations];
    
    
    //年利率
    self.yearlilv.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[zhai objectForKey:@"nll"] withDanwei:@"%" withName:@"年利率"]];
    
    
    //剩余期限
    self.shengyuqixian.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[zhai objectForKey:@"syqs"] withDanwei:@"个月" withName:@"剩余期限"]];
    //债权价值
    self.zhaiquanjiazhi.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[zhai objectForKey:@"zqjz"]  withDanwei:@"元/份" withName:@"债权价值"]];
    //转让价格
    self.zhuanrang.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[zhai objectForKey:@"zqjg"]  withDanwei:@"元/份" withName:@"转让价格"]];
    //剩余份数
    self.shengyu.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[zhai objectForKey:@"syfs"] withDanwei:@"" withName:@"剩余份数"]];
    
    //按钮的选项
 
        self.bid.enabled = YES;
    //[self.bid setTitle:[zhai objectForKey:@"zt"] forState:UIControlStateNormal];
    [self.bid setTitle:@"立即购买" forState:UIControlStateNormal];
        [self.bid setTitleColor:[UIColor colorWithRed:18/255.0 green:141/255.0 blue:211/255.0 alpha:1] forState:UIControlStateNormal];
        [self.bid setBackgroundImage:[UIImage imageNamed:@"button4.png"] forState:UIControlStateNormal];
 
}




//转换
-(NSString *)exchage:(NSString *)string withDanwei:(NSString *)danwei withName:(NSString *)name{
    return [NSString stringWithFormat:@"<p align=center><font size=11 face='HelveticaNeue'>%@</font><font size=9 face='HelveticaNeue'>%@</font>\n<font size =10 color='#8B8B8B' face='HelveticaNeue'>%@</font></p>",string,danwei,name];
}



//状态--投资体验
-(NSMutableDictionary *)exchange_type_tiyan:(int)type{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (type==0) {
        [dic setObject:@"立即购买" forKey:@"type"];
        [dic setObject:@"no" forKey:@"isTouch"];
    }
    return dic;
}



@end
