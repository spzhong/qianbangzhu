//
//  MyWenZhuanViewCell.h
//  quqian
//
//  Created by apple on 15/3/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WenZhuanProject.h"
#import "RCLabel.h"
#import "Tool.h"

@interface MyWenZhuanViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet RCLabel *one;
@property (weak, nonatomic) IBOutlet RCLabel *two;
@property (weak, nonatomic) IBOutlet RCLabel *three;
@property (weak, nonatomic) IBOutlet UIButton *bid;

-(void)initMakeData_0:(WenZhuanProject *)san;
-(void)initMakeData_1:(WenZhuanProject *)san;
-(void)initMakeData_2:(WenZhuanProject *)san;

@end
