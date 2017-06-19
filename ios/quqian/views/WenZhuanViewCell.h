//
//  WenZhuanViewCell.h
//  quqian
//
//  Created by apple on 15/3/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCLabel.h"
#import "WenZhuanProject.h"
#import "TiYanProject.h"

@interface WenZhuanViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *jinduBg;
@property (weak, nonatomic) IBOutlet UIView *showjindu;
@property (weak, nonatomic) IBOutlet UILabel *jindu;
@property (weak, nonatomic) IBOutlet UIButton *bid;
@property (weak, nonatomic) IBOutlet RCLabel *planAllMoney;
@property (weak, nonatomic) IBOutlet RCLabel *yearlilv;
@property (weak, nonatomic) IBOutlet RCLabel *lastTime;

//进行赋值
-(void)initMakeData:(WenZhuanProject *)wen;

//进行赋值
-(void)initMakeData_tiyan:(NSMutableDictionary *)tiyan;

-(void)initMakeData_tiyan:(NSMutableDictionary *)tiyan withMy:(NSString *)my;

 

@end
