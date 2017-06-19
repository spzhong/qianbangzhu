//
//  MyWenZhuanViewCell.m
//  quqian
//
//  Created by apple on 15/3/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MyWenZhuanViewCell.h"

@implementation MyWenZhuanViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)initMakeData_0:(WenZhuanProject *)san{
    self.title.text = san.title;
    self.title.font = FOUR_CONTROL_FONT;
    
    self.one.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:@"10.00万" withName:@"加入金额             "]];
    self.two.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:@"1000.00元" withName:@"已付定金             "]];
    self.three.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:@"2015-12-12 12:12" withName:@"支付截止时间      "]];
    
    //按钮的选项
    [self.bid setTitle:[[self exchange_type:[san.type intValue]] objectForKey:@"type"] forState:UIControlStateNormal];
    if ([[[self exchange_type:[san.type intValue]] objectForKey:@"isTouch"] isEqualToString:@"no"]) {
        self.bid.enabled = NO;
        [self.bid setTitleColor:[UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1] forState:UIControlStateNormal];
        [self.bid setBackgroundImage:[UIImage imageNamed:@"button3.png"] forState:UIControlStateNormal];
    }else{
        self.bid.enabled = YES;
        [self.bid setTitleColor:[UIColor colorWithRed:18/255.0 green:141/255.0 blue:211/255.0 alpha:1] forState:UIControlStateNormal];
        [self.bid setBackgroundImage:[UIImage imageNamed:@"button4.png"] forState:UIControlStateNormal];
    }
    
    
}
-(void)initMakeData_1:(WenZhuanProject *)san{
    self.title.text = san.title;
    self.title.font = FOUR_CONTROL_FONT;
    
    self.one.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:@"10.00万" withName:@"加入金额             "]];
    self.two.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:@"200.00" withName:@"预计总收益          "]];
    self.three.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:@"2015-12-12" withName:@"项目到期时间      "]];
    
    //按钮的选项
    [self.bid setTitle:[[self exchange_type:[san.type intValue]] objectForKey:@"type"] forState:UIControlStateNormal];
    if ([[[self exchange_type:[san.type intValue]] objectForKey:@"isTouch"] isEqualToString:@"no"]) {
        self.bid.enabled = NO;
        [self.bid setTitleColor:[UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1] forState:UIControlStateNormal];
        [self.bid setBackgroundImage:[UIImage imageNamed:@"button3.png"] forState:UIControlStateNormal];
    }else{
        self.bid.enabled = YES;
        [self.bid setTitleColor:[UIColor colorWithRed:18/255.0 green:141/255.0 blue:211/255.0 alpha:1] forState:UIControlStateNormal];
        [self.bid setBackgroundImage:[UIImage imageNamed:@"button4.png"] forState:UIControlStateNormal];
    }
}
-(void)initMakeData_2:(WenZhuanProject *)san{
    
    self.title.text = san.title;
    self.title.font = FOUR_CONTROL_FONT;
    
    self.one.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:@"10.00万" withName:@"加入金额             "]];
    self.two.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:@"200.00" withName:@"已获总收益          "]];
    self.three.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:@"2015-12-12" withName:@"项目到期时间      "]];
    //按钮的选项
    [self.bid setTitle:[[self exchange_type:[san.type intValue]] objectForKey:@"type"] forState:UIControlStateNormal];
    if ([[[self exchange_type:[san.type intValue]] objectForKey:@"isTouch"] isEqualToString:@"no"]) {
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
-(NSString *)exchage:(NSString *)string withName:(NSString *)name{
    if ([string isEqualToString:@"支付截止"]) {
        return [NSString stringWithFormat:@"<p align=left><font size=14 color='#8B8B8B'>%@</font><font size =14>%@</font></p>",name,string];
    }
    return [NSString stringWithFormat:@"<p align=left><font size=14 color='#8B8B8B'>%@</font><font size =14 color='#EA9500'>%@</font></p>",name,string];
}


//状态--散标投资
-(NSMutableDictionary *)exchange_type:(int)type{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (type==0) {
        [dic setObject:@"支付余额" forKey:@"type"];
        [dic setObject:@"yes" forKey:@"isTouch"];
    }else if (type==1){
        [dic setObject:@"已支付" forKey:@"type"];
        [dic setObject:@"no" forKey:@"isTouch"];
    }else if (type==2){
        [dic setObject:@"已满标" forKey:@"type"];
        [dic setObject:@"no" forKey:@"isTouch"];
    }else if (type==3){
        [dic setObject:@"还款中" forKey:@"type"];
        [dic setObject:@"no" forKey:@"isTouch"];
    }else{
        [dic setObject:@"测试" forKey:@"type"];
        [dic setObject:@"no" forKey:@"isTouch"];
    }
    return dic;
}



@end
