//
//  OwnSanViewCell.h
//  quqian
//
//  Created by apple on 15/3/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RCLabel.h"
#import "SanProject.h"
#import "TiYanProject.h"
#import "Tool.h"


@interface OwnSanViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *qi;
@property (weak, nonatomic) IBOutlet UIImageView *shi;
@property (weak, nonatomic) IBOutlet UILabel *qiLab;
@property (weak, nonatomic) IBOutlet UILabel *shiLab;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet RCLabel *one;
@property (weak, nonatomic) IBOutlet RCLabel *two;
@property (weak, nonatomic) IBOutlet RCLabel *four;
@property (weak, nonatomic) IBOutlet RCLabel *three;

-(void)initMakeData_0:(NSMutableDictionary *)san;
-(void)initMakeData_2:(NSMutableDictionary *)san;
-(void)initMakeData_3:(NSMutableDictionary *)san;


-(void)tiyan_initMakeData_1:(NSMutableDictionary *)tiyan;
-(void)tiyan_initMakeData_2:(NSMutableDictionary *)tiyan;



@end
