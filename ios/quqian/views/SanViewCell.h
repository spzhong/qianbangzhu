//
//  SanViewCell.h
//  quqian
//
//  Created by apple on 15/3/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCLabel.h"
#import "SanProject.h"

@interface SanViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *qi;
@property (weak, nonatomic) IBOutlet UIImageView *shi;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *jiang;
@property (weak, nonatomic) IBOutlet UILabel *qiLab;
@property (weak, nonatomic) IBOutlet UILabel *shiLab;
@property (weak, nonatomic) IBOutlet UILabel *jiangxiang;

@property (weak, nonatomic) IBOutlet UIButton *bid;
@property (weak, nonatomic) IBOutlet RCLabel *planAllMoney;
@property (weak, nonatomic) IBOutlet RCLabel *yearlilv;
@property (weak, nonatomic) IBOutlet RCLabel *lastTime;
@property (weak, nonatomic) IBOutlet UILabel *jindu;
@property (weak, nonatomic) IBOutlet UIImageView *jinduBg;
@property (weak, nonatomic) IBOutlet UIView *showjindu;

-(void)initMakeData:(NSMutableDictionary *)san;
-(void)initMakeData:(NSMutableDictionary *)san withisMy:(NSString *)ismy;

@end
