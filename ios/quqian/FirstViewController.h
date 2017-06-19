//
//  FirstViewController.h
//  quqian
//
//  Created by apple on 15/3/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"
#import "KVNMaskedPageControl.h"
#import "DemoViewController.h"
#import "MJRefresh.h"

@interface FirstViewController : SuperViewController<KVNMaskedPageControlDataSource,UIScrollViewDelegate,DemoViewControllerDeleagete>
{
    KVNMaskedPageControl*pageControl;
}
@property(nonatomic,retain)KVNMaskedPageControl*pageControl;
@end

