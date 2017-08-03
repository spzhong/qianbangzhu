//
//  AppDelegate.m
//  quqian
//
//  Created by apple on 15/3/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "Tool.h"
#import "HelpDownloader.h"
#import "MBProgressHUD+Add.h"
#import "TouziViewController.h"
#import "ProjectViewController.h"


@interface AppDelegate () 

@end

@implementation AppDelegate
@synthesize managedObjectContext,managedObjectModel,persistentStoreCoordinator;
@synthesize pageControl;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch
    
    
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    //加载状态栏目－－－new
    FirstViewController *new1 = [[FirstViewController alloc] initWithStyle:UITableViewStyleGrouped];
    new1.title = @"钱帮主";
    ProjectViewController *touzi = [[ProjectViewController alloc] initWithStyle:UITableViewStyleGrouped];
    touzi.title = @"投资";
    
    SecondViewController *new2 = [[SecondViewController alloc] initWithStyle:UITableViewStyleGrouped];
    new2.title = @"我的账户";
    ThirdViewController *new3 = [[ThirdViewController alloc] initWithStyle:UITableViewStyleGrouped];
    new3.title = @"更多";
    
    
    UINavigationController *na1 = [[UINavigationController alloc] initWithRootViewController:new1];
    UINavigationController *na20 = [[UINavigationController alloc] initWithRootViewController:touzi];
    UINavigationController *na2 = [[UINavigationController alloc] initWithRootViewController:new2];
    UINavigationController *na3 = [[UINavigationController alloc] initWithRootViewController:new3];

    
    [array addObject:na1];
    [array addObject:na20];
    [array addObject:na2];
    [array addObject:na3];
     
    
    //加载状态栏目－－－ new
    UITabBarController *barController = [[UITabBarController alloc] init];
    [barController setViewControllers:array];
    self.window.rootViewController = barController;
    
    
    
    NSMutableArray *arrayBar = [NSMutableArray arrayWithObjects:
                             [NSMutableDictionary dictionaryWithObjectsAndKeys:@"icon5-1",@"normal",@"icon5-2",@"selected", @"首页" ,@"title",nil],
                             [NSMutableDictionary dictionaryWithObjectsAndKeys:@"icon6-1",@"normal",@"icon6-2",@"selected",@"投资" ,@"title", nil],
                            [NSMutableDictionary dictionaryWithObjectsAndKeys:@"icon7-1",@"normal",@"icon7-2",@"selected",@"账户" ,@"title", nil],
                             [NSMutableDictionary dictionaryWithObjectsAndKeys:@"moreicon",@"normal",@"moreselect",@"selected",@"更多" ,@"title", nil],
                             nil];
    NSArray *arrayCon = barController.childViewControllers;
    for (int i = 0 ; i < [arrayCon count]; i++) {
        NSMutableDictionary *dic = [arrayBar objectAtIndex:i];
        UINavigationController *na = [array objectAtIndex:i];
        SuperViewController *superView = (SuperViewController *)na.topViewController;
        //设置状态栏
        [superView setTabBarItemDIY:[dic objectForKey:@"normal"] withSeclect:[dic objectForKey:@"selected"]];
        [superView setNavBarItemDIY];
        na.tabBarItem.title = [dic objectForKey:@"title"];
        
    }
    
    
    
    UINavigationBar *navigationBar =  [UINavigationBar appearance];
    [navigationBar setTranslucent:NO];
    [navigationBar setBarTintColor:[UIColor colorWithRed:60/255.0 green:154/255.0 blue:235/255.0 alpha:1]]; // 统一设置导航栏颜色
    [navigationBar setTintColor:[UIColor whiteColor]]; // 统一设置导航栏按钮等颜色
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                            NSFontAttributeName : [UIFont boldSystemFontOfSize:18]}]; // 设置标题
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    //是否显示引导页
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"yindaoye"] != nil) {
        return YES;
    }
    
    NSInteger pages = 3;
    
    //滚动
    UIScrollView *scroll = [Tool ScrollProductionFunction:self Frame:CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height) contentSize:CGSizeMake(self.window.frame.size.width*pages, self.window.frame.size.height)];
    scroll.tag = 100001;
    
    [scroll setBackgroundColor:[UIColor whiteColor]];
    
    KVNMaskedPageControl *pageControl1 = [[KVNMaskedPageControl alloc] init];
    [pageControl1 setNumberOfPages:pages];
    [pageControl1 setCenter:CGPointMake(CGRectGetMidX(scroll.bounds), self.window.frame.size.height-20)];
    [pageControl1 setDataSource:self];
    [pageControl1 setHidesForSinglePage:YES];
    [pageControl1 setNumberOfPages:pages];
    pageControl1.tag = 100002;
    
    [self.window.rootViewController.view addSubview:scroll];
    
    self.pageControl = pageControl1;
    
    [self createPages:pages withScr:scroll];
    
    [self.window.rootViewController.view addSubview:pageControl1];
    
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
  
    return YES;
}






- (void)createPages:(NSInteger)pages withScr:(UIScrollView *)scrollView {
    for (int i = 0; i < pages; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(scrollView.bounds) * i, 0, CGRectGetWidth(scrollView.bounds), CGRectGetHeight(scrollView.bounds))];

        //img
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width,view.frame.size.height)];
        img.image = [UIImage imageNamed:[NSString stringWithFormat:@"qidongpic%d.jpg",i+1]];
        [view addSubview:img];
        
        
        //最后一页
        if (pages-1 == i) {
 
            UIControl *con = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
            [view addSubview:con];
            [con addTarget:self action:@selector(tiaoguo) forControlEvents:UIControlEventTouchUpInside];
            
        }
        [scrollView addSubview:view];
    }
    
    [scrollView setContentSize:CGSizeMake(CGRectGetWidth(scrollView.bounds) * pages, CGRectGetHeight(scrollView.bounds))];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.pageControl maskEventWithOffset:scrollView.contentOffset.x frame:scrollView.frame];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page =  floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    [self.pageControl setCurrentPage:page];
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page =  floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    [self.pageControl setCurrentPage:page];
    
}

#pragma mark - IBActions
- (void)changePage:(KVNMaskedPageControl *)sender {
    self.pageControl.currentPage = sender.currentPage;
    UIScrollView *scrollView =  (UIScrollView *)[sender.superview viewWithTag:1001];
    
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * (self.pageControl.currentPage+1);
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
}

#pragma mark - KVNMaskedPageControlDataSource
- (UIColor *)pageControl:(KVNMaskedPageControl *)control pageIndicatorTintColorForIndex:(NSInteger)index {
    if (index % 2 == 0) {
        return [UIColor colorWithWhite:1.0 alpha:.6];
    } else {
        return [UIColor colorWithWhite:0 alpha:.5];
    }
}

- (UIColor *)pageControl:(KVNMaskedPageControl *)control currentPageIndicatorTintColorForIndex:(NSInteger)index {
    if (index % 2 == 0) {
        return nil; // nil just sets the default UIPageControl color or respects UIAppearance setting.
    } else {
        return [UIColor colorWithWhite:0 alpha:.8];
        
    }
}


//跳过
-(void)tiaoguo{
    
    [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"yindaoye"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[self.window.rootViewController.view viewWithTag:100001] removeFromSuperview];
    [[self.window.rootViewController.view viewWithTag:100002] removeFromSuperview];
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    UserModel *user = [Tool getUser];
    if (user) {
        if ([user.iscloseshoushimia isEqualToString:@"y"]) {
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"inputCode" object:nil];
        }
    }
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}







#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.


- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}



- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"chaping.sqlite"];
    
    
    NSError *error = nil;
    
    // 持久化存储调度器由托管对象模型初始化
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    
    // 设置数据存储方式为SQLlite
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error  .
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         abort() 这个方法是开发的时候打印log用的，提交商店的时候可以把这个方法删除。
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        
        NSLog(@"(AppDelegate.m)不可解决的错误%@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return url;
}


// 程序退出前保存数据
- (BOOL)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"(AppDelegate.m-()saveContext)Unresolved error %@, %@", error, [error userInfo]);
            abort();
            return NO;
        } else {
            NSLog(@"(AppDelegate.m-()saveContext)数据成功插入");
            return YES;
        }
    }
    return YES;
}






- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSURL *surl = request.URL;
    NSString *host = [surl host];
    
    
    NSLog(@"\n================");
    NSLog(@"scheme: %@",surl.scheme);
    NSLog(@"host: %@",host);
    NSLog(@"resourceSpecifier: %@",surl.resourceSpecifier);
    NSLog(@"parameterString: %@",surl.parameterString);
    NSLog(@"================\n");
    
    
    //sendCode
    
    
     
    return YES;
}





@end
