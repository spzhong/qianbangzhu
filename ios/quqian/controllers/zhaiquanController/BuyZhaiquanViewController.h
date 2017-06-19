//
//  BuyZhaiquanViewController.h
//  quqian
//
//  Created by apple on 15/3/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyZhaiquanViewController : UITableViewController

@property(nonatomic,retain)NSString *typeTag;//0是债权转让，1是散标投资
@property(nonatomic,retain)NSMutableDictionary *allDic;//所有的数据

@property(nonatomic)int iscunguan;//0默认是普通，1是存管投标

@end
