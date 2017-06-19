//
//  NewSanViewCell.h
//  qianbangzhu
//
//  Created by 宋培众 on 2017/6/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCLabel.h"
#import "SanProject.h"

@interface NewSanViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *xin;
@property (weak, nonatomic) IBOutlet UIButton *bid;

@property (nonatomic,retain) RCLabel *planAllMoney;
@property (retain, nonatomic) IBOutlet RCLabel *yearlilv;
@property (retain, nonatomic) IBOutlet RCLabel *lastTime;

-(void)initMakeData:(NSMutableDictionary *)san withType:(NSString *)type;

@end
