//
//  BangKHAdressViewController.h
//  quqian
//
//  Created by apple on 15/5/12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BangKHAdressViewController : UITableViewController
@property(nonatomic,retain)NSMutableArray *dataArray;
@property(nonatomic,retain)NSString *typeString;


@property(nonatomic,retain)NSString *sheng;
@property(nonatomic,retain)NSString *shi;
@property(nonatomic,retain)NSString *quxian;

@property(nonatomic,retain)NSString *cityId;
@property(nonatomic,retain)NSString *shengId;

@end
