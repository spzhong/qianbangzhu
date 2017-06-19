//
//  SuperViewController.h
//  chaping
//
//  Created by apple on 14/12/12.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXActionSheet.h"

@interface SuperViewController : UITableViewController<LXActionSheetDelegate>


//设置状态栏目
- (void) setTabBarItemDIY:(NSString *)normal withSeclect:(NSString *)selected;
- (void) setInitAllBar:(NSMutableArray*)arrayImg;

-(void) setNavBarItemDIY;

@end
