//
//  SuperViewController.m
//  chaping
//
//  Created by apple on 14/12/12.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "SuperViewController.h"
#import "ZBarScanWGXViewController.h"
#import "JSON.h"

@interface SuperViewController ()
{
    int tag;
}
@end

@implementation SuperViewController





//初始化
- (instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}


 

//设置导航栏
-(void) setNavBarItemDIY{
//    UIColor *kTitleBarColor = [UIColor colorWithRed:221/255.0 green:56/255.0 blue:108/255.0 alpha:1];
//    if([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
//        [self.navigationController.navigationBar setValue:kTitleBarColor forKey:@"barTintColor"];
//    } else {
//        self.navigationController.navigationBar.tintColor = kTitleBarColor;
//    }
}



//设置状态栏
- (void) setTabBarItemDIY:(NSString *)normal withSeclect:(NSString *)selected
{
    UIImage* imageNormal = [UIImage imageNamed:normal];
    UIImage* imageSelected = [UIImage imageNamed:selected];
    imageSelected = [imageSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIColor *kTitleBarColor = [UIColor colorWithRed:18/255.0 green:141/255.0 blue:211/255.0 alpha:1];
    [self.navigationController.tabBarItem setTitleTextAttributes:[NSMutableDictionary dictionaryWithObjectsAndKeys: kTitleBarColor,UITextAttributeTextColor,nil]  forState:UIControlStateHighlighted];
    [self.navigationController.tabBarItem setTitleTextAttributes:[NSMutableDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHue:221/255.0 saturation:56/255.0 brightness:108/255.0 alpha:1.0],UITextAttributeTextColor,nil]  forState:UIControlStateNormal];
    [self.navigationController.tabBarItem setFinishedSelectedImage:imageSelected withFinishedUnselectedImage:imageNormal];
}


//设置所有的状态栏目
-(void)setInitAllBar:(NSMutableArray*)arrayImg{

    NSArray *array = self.tabBarController.childViewControllers;
    
    for (int i = 0 ; i < [array count]; i++) {
        NSMutableDictionary *dic = [arrayImg objectAtIndex:i];
        UINavigationController *na = [array objectAtIndex:i];
        SuperViewController *superView = (SuperViewController *)na.topViewController;
        //设置状态栏
        [superView setTabBarItemDIY:[dic objectForKey:@"normal"] withSeclect:[dic objectForKey:@"selected"]];
        [superView setNavBarItemDIY];
        na.tabBarItem.title = [dic objectForKey:@"title"];
        //[superView setleftNaBarItem:@"+"];
        
    }
    
}



//设置右边的状态栏目
-(void)setleftNaBarItem:(NSString *)string{
    
 
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search)];
    //NSArray *buttonItemArray1 = [NSArray arrayWithObjects:rightBtnItem, nil];
    //self.navigationItem.leftBarButtonItems=buttonItemArray1;
    
    UIColor *kTitleBarColor = [UIColor colorWithRed:221/255.0 green:56/255.0 blue:108/255.0 alpha:1];
    
    
    //UIColor *kTitleBarColor = [UIColor colorWithRed:221/255.0 green:56/255.0 blue:108/255.0 alpha:1];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:string forState:UIControlStateNormal];
    [button setTitleColor:kTitleBarColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addGodBadRewview) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 32, 44);
    button.titleLabel.font = [UIFont systemFontOfSize:32];
    
    
    UIBarButtonItem *rightBtnItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGodBadRewview)];
    NSArray *buttonItemArray = [NSArray arrayWithObjects:rightBtnItem1, nil];
   self.navigationItem.rightBarButtonItems=buttonItemArray;
    
    //[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin)];
     //[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}

//添加差评
-(void)addGodBadRewview{
    tag = 0;
    LXActionSheet *actionSheet = [[LXActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"扫一扫",@"我要差评"]];
    [actionSheet showInView:self.view];
}

- (void)didClickOnButtonIndex:(NSInteger *)buttonIndex{
    
    if (tag==0) {
        if (buttonIndex==0) {
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resultOfScanHereMake:) name:@"GoToZbarBackToMakeTheResult" object:nil];
            ZBarScanWGXViewController *zbar = [[ZBarScanWGXViewController alloc] init];
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:zbar animated:YES];
            self.hidesBottomBarWhenPushed=NO;
            
        }else if (buttonIndex==1) {
            
            
            
        }else if (buttonIndex==2) {
        
            
            
        }
    }else if(tag==1){
     
       
    }
    
}


//搜素
-(void)search{
    tag =1;
    LXActionSheet *actionSheet = [[LXActionSheet alloc]initWithTitle:@"搜索" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"搜索维权组"]];
    [actionSheet showInView:self.view];
}







// 扫描二维码搜索结果处理办事处
-(void)resultOfScanHereMake:(NSNotification*)object
{
    NSString *resultStr = [object object];
    NSLog(@"扫描结果：%@",resultStr);
    NSArray *arrayStr = [resultStr componentsSeparatedByString:@"f="];
    if ([arrayStr count]==0) {
        return;
    }
    resultStr = [arrayStr objectAtIndex:1];
    NSMutableDictionary *dic = [resultStr JSONValue];
    NSString *typeCode = [dic objectForKey:@"c"];
    if ([typeCode intValue] == 1) {
        [self performSelector:@selector(doStirng:) onThread:[NSThread mainThread] withObject:dic waitUntilDone:YES];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GoToZbarBackToMakeTheResult" object:nil];
    
}

//做一些事情
-(void)doStirng:(NSMutableDictionary *)dic{
    
}






@end
