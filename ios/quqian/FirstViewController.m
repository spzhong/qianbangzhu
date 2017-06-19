//
//  FirstViewController.m
//  quqian
//
//  Created by apple on 15/3/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "FirstViewController.h"
#import "HelpDownloader.h"
#import "EGOImageView.h"
#import "KVNMaskedPageControl.h"
#import "UserModel.h"
#import "ProjectViewController.h"
#import "LoginTableViewController.h"
#import "RegisterTableViewController.h"
#import "ZijinMangerViewController.h"
#import "STAlertView.h"
#import "RCLabel.h"
#import "MBProgressHUD+Add.h"
#import "WebController.h"
#import "YunyinghsujuViewController.h"
#import "YinhangcunguanaViewController.h"
#import "WuyoucunzhengViewController.h"
#import "WoyaojiekuanViewController.h"





@interface FirstViewController ()<EGOImageViewDelegate>
{
    UserModel *user;
    NSMutableArray *dataArray;
}
@end

@implementation FirstViewController
@synthesize pageControl;



- (instancetype)initWithStyle:(UITableViewStyle)style{
    return self = [super initWithStyle:UITableViewStyleGrouped];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    user = [Tool getUser];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView * centerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 9, 158/2, 52/2)];
    centerView.image = [UIImage imageNamed:@"logo"];
    self.navigationItem.titleView = centerView;
    
    
    dataArray = [[NSMutableArray alloc] init];
    user = (UserModel*)[Tool getUser];
    
    //登录后进行切换账户
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginAfterDoSometing) name:@"loginAfterDoSometing" object:nil];
    //登录后输入密码
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputCode) name:@"inputCode" object:nil];
    
    //超时
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chaoshidecaozuo) name:@"chaoshidecaozuo" object:nil];
    //超时
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dengluquxiaotongzhi) name:@"dengluquxiaotongzhi" object:nil];
    
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]];
    
 
    //获取导航条
    [self banner__startRequest];
}



//超时的操作
-(void)chaoshidecaozuo{
    
    //如果超时了全部回到首页
    NSArray *arrayCon = self.tabBarController.viewControllers;
    for (UINavigationController *na in arrayCon) {
        [na popToRootViewControllerAnimated:NO];
    }
    [self.tabBarController setSelectedIndex:0];
    //清空本地的数据
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"curLoginUserId"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"cookieValue"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tableView reloadData];
    
    //进行登录
    LoginTableViewController *loginView = [[LoginTableViewController alloc] init];
    loginView.title = @"登录";
    UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:loginView];
    [self.tabBarController presentViewController:na animated:YES completion:NULL];
    
}


//取消通知
-(void)dengluquxiaotongzhi{
    //如果超时了全部回到首页
    NSArray *arrayCon = self.tabBarController.viewControllers;
    for (UINavigationController *na in arrayCon) {
        [na popToRootViewControllerAnimated:NO];
    }
    [self.tabBarController setSelectedIndex:0];
    //清空本地的数据
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"curLoginUserId"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"cookieValue"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tableView reloadData];
}





//登录成功后的操作
-(void)loginAfterDoSometing{
    [self.tableView reloadData];
}


//提醒输入的密码
-(void)inputCode{
    //判断是否是登录的状态
    //UserModel *user = (UserModel*)[Tool getUser];
    //数据为空－－－需要登录啊
    
    //更新用户的信息
    [self userInfo__startRequest:1];
}


-(void)Success:(NSString *)doting{
    
    UIView *view = [[Tool getDele].window viewWithTag:10099];
    [view removeFromSuperview];
    
}
-(void)Failure:(NSString *)doting{
    
    
    //忘记了手势密码
    if ([doting isEqualToString:@"wangjishoushimima"]) {
    
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"忘记手势密码或用其他账号登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil ];
        alertView.tag = 100;
        [alertView show];
 
    }else if ([doting isEqualToString:@"shoushimimacuowuchaoguo5ci"]){
        //忘记登录手势操作
        [self wangjimimajinxingdenglu];
    }
    
}




//点击banner的图标
-(void)imageSelectedIndex:(EGOImageView*)imageView withURL:(int)index{

    NSMutableDictionary *dic = [dataArray objectAtIndex:index];
    
    WebController *web = [[WebController alloc] init];
    web.urlString = [dic objectForKey:@"linkUrl"];
    web.title = [dic objectForKey:@"title"];
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:web animated:YES];
    self.hidesBottomBarWhenPushed=NO;
    
    
}


- (void)createPages:(NSInteger)pages withScr:(UIScrollView *)scrollView {
    for (int i = 0; i < pages; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(scrollView.bounds) * i, 0, CGRectGetWidth(scrollView.bounds), CGRectGetHeight(scrollView.bounds))];
        
        NSMutableDictionary *dic = [dataArray objectAtIndex:i];
        
        
        EGOImageView *imgView = [[EGOImageView alloc] init];
        imgView.frame = CGRectMake(0, 0, view.frame.size.width,view.frame.size.height);
        imgView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",web_URL,[dic objectForKey:@"pictureUrl"]]];
        imgView.delegate = self;
        imgView.index = i;
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.userInteractionEnabled = YES;
        [view addSubview:imgView];
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




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0 || section==1) {
        return 0.01;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 0.01;
    }
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==2) {
        return 3;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section]==0) {
        return 126;
    }
    if ([indexPath section]==1) {
        return 110;
    }
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    NSArray *viewArray = [cell.contentView subviews];
    for (int i = 0; i < [viewArray count]; i++) {
        UIView *view = [viewArray objectAtIndex:i];
        [view removeFromSuperview];view=nil;
    }

    EGOImageView*imgView =[[EGOImageView alloc] init];
    imgView.frame = CGRectMake(15, 10, 40, 40);
    UILabel *lab123 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(70, 0, [Tool adaptation:200 with6:55 with6p:94], 40) Alignment:NSTextAlignmentLeft  FontFl:15];
    lab123.font = FOUR_CONTROL_FONT;
    UILabel *lab1234 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(70, 35, [Tool adaptation:200 with6:55 with6p:94], 30) Alignment:NSTextAlignmentLeft  FontFl:12];
    [cell.contentView addSubview:lab123];
    [cell.contentView addSubview:lab1234];
    [cell.contentView addSubview:imgView];
    [lab1234 setTextColor:[UIColor darkGrayColor]];
    
    
    UILabel *lab12345 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(100, 0, [Tool adaptation:200 with6:55 with6p:94], 60) Alignment:NSTextAlignmentRight  FontFl:13];
    [cell.contentView addSubview:lab12345];
    [lab1234 setTextColor:[UIColor darkGrayColor]];
    
    

    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    if (section==0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        
        NSInteger pages = [dataArray count];
        
        //滚动
        UIScrollView *scroll = [Tool ScrollProductionFunction:self Frame:CGRectMake(0, 0, ScreenWidth, 126) contentSize:CGSizeMake(ScreenWidth*pages, 126)];
        scroll.tag = 1001;
        
        KVNMaskedPageControl *pageControl1 = [[KVNMaskedPageControl alloc] init];
        [pageControl1 setNumberOfPages:pages];
        [pageControl1 setCenter:CGPointMake(CGRectGetMidX(scroll.bounds), 115)];
        [pageControl1 setDataSource:self];
        [pageControl1 setHidesForSinglePage:YES];
        [pageControl1 setNumberOfPages:pages];
        
        [cell.contentView addSubview:scroll];
        
        self.pageControl = pageControl1;
        
        [self createPages:pages withScr:scroll];
        
        [cell.contentView addSubview:pageControl1];
        
        [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        
        
    }else if (section==1) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        float wsize = (self.view.frame.size.width-150) / 4;
        
        UIButton *but0 = [UIButton buttonWithType:UIButtonTypeCustom];
        but0.frame = CGRectMake(wsize-20, 18, 50, 50);
        [but0 setBackgroundImage:[UIImage imageNamed:@"yunyinghsuju"] forState:UIControlStateNormal];
        [but0 addTarget:self action:@selector(yunyinghsuju) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:but0];
        UILabel *lab1 = [Tool LablelProductionFunction:@"运营数据" Frame:CGRectMake(-10,60,70,15) Alignment:NSTextAlignmentCenter  FontFl:12];
        [but0 addSubview:lab1];
        lab1.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1.0];
        
        UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
        but1.frame = CGRectMake((wsize)* 2+50, 18, 50, 50);
        [but1 setBackgroundImage:[UIImage imageNamed:@"yinhangcunguana"] forState:UIControlStateNormal];
        [but1 addTarget:self action:@selector(yinhangcunguana) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:but1];
        UILabel *lab2 = [Tool LablelProductionFunction:@"银行存管" Frame:CGRectMake(-10,60,70,15) Alignment:NSTextAlignmentCenter  FontFl:12];
        [but1 addSubview:lab2];
        lab2.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1.0];
        
        
        UIButton *but2 = [UIButton buttonWithType:UIButtonTypeCustom];
        but2.frame = CGRectMake((wsize)* 3 + 120, 18, 50, 50);
        [but2 setBackgroundImage:[UIImage imageNamed:@"wuyoucunzheng"] forState:UIControlStateNormal];
        [but2 addTarget:self action:@selector(wuyoucunzheng) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:but2];
        UILabel *lab3 = [Tool LablelProductionFunction:@"无忧存证" Frame:CGRectMake(-10,60,70,15) Alignment:NSTextAlignmentCenter  FontFl:12];
        [but2 addSubview:lab3];
        lab3.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1.0];
        
        
    }else if (section==2) {
        
        if (row==0){
        
            
            imgView.image = [UIImage imageNamed:@"jingxuanlicai.png"];
        
            lab123.text = @"精选理财";
            lab1234.text = @"周期短 投资灵活";
            
            //lab12345.text = @"去投资";
            
        }else if (row==1){
            
            imgView.image = [UIImage imageNamed:@"cunguanlicai.png"];
            
            lab123.text = @"存管理财";
            lab1234.text = @"华兴银行资金存管";
            
 
        }else if (row==2){
            
            imgView.image = [UIImage imageNamed:@"woyaojiekuan.png"];
            
            lab123.text = @"我要借款";
            lab1234.text = @"安全、快捷、高效";
            
            
        }
        
    }
    
    lab1234.numberOfLines = 2;
    [lab1234 sizeToFit];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    
    if ([indexPath section]==1) {
        
        //数据为空－－－需要登录啊
        if (user!=nil) {
            ZijinMangerViewController *manger = [[ZijinMangerViewController alloc] init];
            manger.title = @"资金管理";
            //返回
            UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
            backItem.title=@"返回";
            self.navigationItem.backBarButtonItem=backItem;
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:manger animated:YES];
            self.hidesBottomBarWhenPushed=NO;
        }
    }
    
    if ([indexPath section]==2) {
        if (row==0) {
        
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"projectTag"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self.tabBarController setSelectedIndex:1];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:nil];

        }else if (row==1){
            
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"projectTag"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self.tabBarController setSelectedIndex:1];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:nil];
            
        }else if (row==2){
            
            WoyaojiekuanViewController *view = [[WoyaojiekuanViewController alloc] init];
            view.title = @"我要借款";
            //返回
            UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
            backItem.title=@"返回";
            self.navigationItem.backBarButtonItem=backItem;
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:view animated:YES];
            self.hidesBottomBarWhenPushed=NO;
            
        }
    }else if ([indexPath section]==3){
        
    }
    
}




//按钮点击
-(void)buttonprees:(UIButton*)but{
    
    //登录
    if (but.tag==100) {
        LoginTableViewController *loginView = [[LoginTableViewController alloc] init];
        loginView.title = @"登录";
        UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:loginView];
        [self presentViewController:na animated:YES completion:NULL];

    }else if (but.tag==101){//注册
        RegisterTableViewController *regist = [[RegisterTableViewController alloc] init];
        regist.from = @"FirstViewController";
        regist.title = @"注册";
        UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:regist];
        [self presentViewController:na animated:YES completion:NULL];

    }
}


//领取体验金
-(void)lingqutiyanjin{
    
    //判断是否登录
    //UserModel *user = (UserModel*)[Tool getUser];
    
    //数据为空－－－需要登录啊
    if (user==nil) {
        LoginTableViewController *loginView = [[LoginTableViewController alloc] init];
        loginView.title = @"登录";
        UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:loginView];
        [self presentViewController:na animated:YES completion:NULL];
        return;
    }
    
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"获取体验金" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil ];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[alertView textFieldAtIndex:0] setPlaceholder:@"请输入体验金券号"];
    [[alertView textFieldAtIndex:0] setText:@""];
    [alertView show];
    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        if (alertView.tag==100) {
            //忘记密码
            [self wangjimimajinxingdenglu];
        }else{
            //输入体验金额
            
            NSString *text = [alertView textFieldAtIndex:0].text;
            
            if (text.length==0) {
                [Tool myalter:@"请输入券号"];
                return;
            }
            
            [self performSelector:@selector(addtiYanQuan__startRequest:) withObject:text afterDelay:0.5];
            //[self addtiYanQuan__startRequest:text];
        }
    }
}










//用户信息
-(void)userInfo__startRequest:(int)isQidong{
    
    if (user==nil) {
        return;
    }
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/getUser.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"yes",@"isshowHUD",
                                           @"no",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   
                                   if (kk==0) {
                                       
                                       NSMutableDictionary *dic = [data JSONValue];
                                       
                                       
                                       if ([[dic objectForKey:@"code"] intValue] == 0) {
                                           
                                           NSString *authenticated = [dic objectForKey:@"authenticated"];
                                           if ([[Tool toString:authenticated] isEqualToString:@"false"]) {
                                               //do nothing
                                               
                                           }else{
                                               
                                               NSString *SS = [Tool toString:[dic objectForKey:@"rvalue"]];
                                               if ([SS isEqualToString:@"<null>"]) {
                                                   return;
                                               }
                                               
                                               
                                               [self doSameThing:[dic objectForKey:@"rvalue"]];
                                               //刚刚启动
                                               if (isQidong==1) {
                                                   [self jinrushuorushoushimima];
                                               }
                                           }
                                           
                                           
                                       }else{
                                           
                                           
                                           //判断是否进行登录
                                           if ([dic objectForKey:@"authenticated"]) {
                                               //清空本地的数据
                                               [[NSUserDefaults standardUserDefaults] synchronize];
                                               [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"curLoginUserId"];
                                               [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"cookieValue"];
                                               [[NSUserDefaults standardUserDefaults] synchronize];
                                               [self.tableView reloadData];
                                               
                                               //进行登录
                                               LoginTableViewController *loginView = [[LoginTableViewController alloc] init];
                                               loginView.title = @"登录";
                                               UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:loginView];
                                               [self presentViewController:na animated:YES completion:NULL];
                                           }
                                           
                                           [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:nil];
                                       }
                                       
                                   }else{
                                       
                                       //网络异常的时候－－让他重新登录
                                       //清空本地的数据
                                       [[NSUserDefaults standardUserDefaults] synchronize];
                                       [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"curLoginUserId"];
                                       [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"cookieValue"];
                                       [[NSUserDefaults standardUserDefaults] synchronize];
                                       [self.tableView reloadData];
                                       
                                       //进行登录
                                       LoginTableViewController *loginView = [[LoginTableViewController alloc] init];
                                       loginView.title = @"登录";
                                       UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:loginView];
                                       [self presentViewController:na animated:YES completion:NULL];
                                    
                                   }
                               }];
}





//进入输入手势密码的操作
-(void)jinrushuorushoushimima{
    
    //判断用户是否设置了手势的密码
    
    if ([Tool getUser] == nil) {
        return;
    }
    
    //设置了手势密码
    if (user.code.length>0) {
        
        //已经登录的用户
        DemoViewController *demo = [[DemoViewController alloc] init];
        demo.title = @"输入密码";
        demo.type = 2;
        demo.doting = @"chCode";
        demo.deleagete = self;
        demo.view.tag = 10099;
        [[Tool getDele].window addSubview:demo.view];
        
        
    }else{
        
        
        [self wangjimimajinxingdenglu];
        
        
    }
  
}


//忘记密码
-(void)wangjimimajinxingdenglu{
    
    UIView *view = [[Tool getDele].window viewWithTag:10099];
    [view removeFromSuperview];
    
    
    //清空本地的手势密码
    user.code = @"";
    [Tool savecoredata];
    
    
    //清空本地的数据
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"curLoginUserId"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"cookieValue"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tableView reloadData];
    
    //进行登录
    LoginTableViewController *loginView = [[LoginTableViewController alloc] init];
    loginView.title = @"登录";
    UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:loginView];
    [self.tabBarController presentViewController:na animated:YES completion:NULL];
    
 
}





//网络请求后的操作
-(void)doSameThing:(NSMutableDictionary *)dic{
    
    if (dic==nil) {
        return;
    }
    
    NSString *where = [NSString stringWithFormat:@"userId='%@'",[dic objectForKey:@"yhzh"]];
    UserModel *newUser = [Tool selcetOneData:@"UserModel" withWhere:where];
    
    if (newUser==nil) {
        //创建一个user对象
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserModel"inManagedObjectContext:[Tool getDele].managedObjectContext];
        UserModel *userM = [[UserModel alloc]initWithEntity:entity insertIntoManagedObjectContext:[Tool getDele].managedObjectContext];
        //进行赋予值
        [userM makeInData:dic];
        
    }else{
        //进行更新数据
        [newUser makeInData:dic];
    }
    
    
    [Tool savecoredata];
    
    [self.tableView reloadData];
     
}




//获取体验券列表
-(void)addtiYanQuan__startRequest:(NSString *)result{
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/lcty/hq.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:result forKey:@"qh"];
    
    
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"yes",@"isshowHUD",
                                           @"yes",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   
                                   if (kk==0) {
                                       
                                       
                                       if ([[[data JSONValue] objectForKey:@"code"] intValue]==0) {
                                       
                                           
                                           [MBProgressHUD showSuccess:[[data JSONValue] objectForKey:@"msg"] toView:nil];
                                       
                                           
                                       }else{
                                           
                                           [MBProgressHUD showError:[[data JSONValue] objectForKey:@"msg"] toView:nil];
                                           
                                       }
                                       
                                   }else{
                                       
                                   }
                                   
                               }];
    
}










//获取导航条信息
-(void)banner__startRequest{
    
   
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/bannerBox.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"no",@"isshowHUD",
                                           @"no",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   
                                   if (kk==0) {
                                       
                                       NSMutableDictionary *dic = [data JSONValue];
                                       
                                       if ([[dic objectForKey:@"code"] intValue] == 0) {
                                           
                                           
                                           NSString *SS = [Tool toString:[dic objectForKey:@"rvalue"]];
                                           if ([SS isEqualToString:@"<null>"]) {
                                               return;
                                           }
                                           //加入数组中
                                           [dataArray addObjectsFromArray:[dic objectForKey:@"rvalue"]];
                                           [self.tableView reloadData];
                                           
                                       }else{
                                          
                                       }
                                       
                                   }else{
                                       
                                       
                                   }
                               }];
}




//运营数据
- (void)yunyinghsuju {
    YunyinghsujuViewController *view = [[YunyinghsujuViewController alloc] init];
    view.title = @"运营数据";
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:view animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

//银行存管
- (void)yinhangcunguana {

    YinhangcunguanaViewController *view = [[YinhangcunguanaViewController alloc] init];
    view.title = @"银行存管";
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:view animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

//无忧存症
- (void)wuyoucunzheng {
    
    WuyoucunzhengViewController *view = [[WuyoucunzhengViewController alloc] init];
    view.title = @"无忧存症";
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:view animated:YES];
    self.hidesBottomBarWhenPushed=NO;

}

@end
