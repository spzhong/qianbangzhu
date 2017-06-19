//
//  RegisterTableViewController.h
//  quqian
//
//  Created by apple on 15/3/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tool.h"
#import "HelpDownloader.h"


@interface RegisterTableViewController : UITableViewController
{
    BOOL isHuoqu;
    NSTimer *myTimer;
    int count;
}

@property(nonatomic,retain)NSTimer *myTimer;

@property(nonatomic,retain)NSString *from;

@end
