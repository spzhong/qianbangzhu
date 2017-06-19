//
//  ZhaiQuanViewCell.h
//  quqian
//
//  Created by apple on 15/3/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCLabel.h"
#import "ZhaiQuanProject.h"

@interface ZhaiQuanViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *qi;
@property (weak, nonatomic) IBOutlet UIImageView *shi;
@property (weak, nonatomic) IBOutlet UILabel *qiLab;
@property (weak, nonatomic) IBOutlet UILabel *shiLab;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *jinduBg;
@property (weak, nonatomic) IBOutlet UIView *showjindu;

@property (weak, nonatomic) IBOutlet UILabel *jindu;
@property (weak, nonatomic) IBOutlet UIButton *bid;
@property (weak, nonatomic) IBOutlet RCLabel *yearlilv;
@property (weak, nonatomic) IBOutlet RCLabel *shengyuqixian;
@property (weak, nonatomic) IBOutlet RCLabel *zhaiquanjiazhi;
@property (weak, nonatomic) IBOutlet RCLabel *zhuanrang;
@property (weak, nonatomic) IBOutlet RCLabel *shengyu;

//进行赋值
-(void)initMakeData:(NSMutableDictionary *)zhai;

@end
