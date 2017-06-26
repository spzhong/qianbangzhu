//
//  WotoubiaoViewController.m
//  qianbangzhu
//
//  Created by 宋培众 on 2017/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WotoubiaoViewController.h"
#import "Tool.h"
#import "HelpDownloader.h"
#import "MJRefresh.h"
#import "RCLabel.h"
#import "UtilityUI.h"
#import "WebController.h"
#import "BuyZhaiquanViewController.h"

@interface WotoubiaoViewController ()
{
    UIButton *cgkaitong_but;
    UIButton *ptkaitong_but;
    UIButton *other_but;
    UIView *selcteView;
    NSMutableDictionary *alldic;
    NSMutableArray *arraydata;
    UITableView *myTabview;
    int tag;
    int curPage;
}
@end

@implementation WotoubiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    curPage = 1;
    arraydata = [NSMutableArray arrayWithCapacity:0];
    [self createview];
}

-(void)createview{
    cgkaitong_but = [Tool ButtonProductionFunction:@"回收中" Frame:CGRectMake(0, 0, ScreenWidth/3, 45) bgImgName:nil FontFl:15];
    [cgkaitong_but addTarget:self action:@selector(cgkaitong_but_p) forControlEvents:UIControlEventTouchUpInside];
    [cgkaitong_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [cgkaitong_but setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:cgkaitong_but];
    
    ptkaitong_but = [Tool ButtonProductionFunction:@"投标中" Frame:CGRectMake(ScreenWidth/3, 0, ScreenWidth/3, 45) bgImgName:nil FontFl:15];
    [ptkaitong_but addTarget:self action:@selector(ptkaitong_but_p) forControlEvents:UIControlEventTouchUpInside];
    [ptkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [ptkaitong_but setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:ptkaitong_but];
    
    other_but = [Tool ButtonProductionFunction:@"已结清" Frame:CGRectMake(2*ScreenWidth/3, 0, ScreenWidth/3, 45) bgImgName:nil FontFl:15];
    [other_but addTarget:self action:@selector(other_but_p) forControlEvents:UIControlEventTouchUpInside];
    [other_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [other_but setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:other_but];
    
    
    
    selcteView = [[UIView alloc] initWithFrame:CGRectZero];
    [selcteView setBackgroundColor:KTHCOLOR];
    [self.view addSubview:selcteView];
    
    myTabview = [Tool TableProductionFunction:self Frame:CGRectMake(0, 50, ScreenWidth, ScreenHeight-64-50)];
    [self.view addSubview:myTabview];
    [myTabview setBackgroundColor:RGB(242, 242, 242)];
    
    [self cgkaitong_but_p];
    
    [self setupRefresh];
}



/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [myTabview addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    //[self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [myTabview addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    myTabview.headerPullToRefreshText = @"下拉可以刷新了";
    myTabview.headerReleaseToRefreshText = @"松开马上刷新了";
    myTabview.headerRefreshingText = @"钱帮主正在刷新中";
    
    myTabview.footerPullToRefreshText = @"上拉可以加载更多数据了";
    myTabview.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    myTabview.footerRefreshingText = @"钱帮主正在加载中";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    curPage=1;
    if (tag==0) {
        [self networkload:@"0"];
    }else if (tag==1){
        [self networkload:@"1"];
    }else if (tag==2){
        [self networkload:@"2"];
    }
}

- (void)footerRereshing
{
    curPage++;
    if (tag==0) {
        [self networkload:@"0"];
    }else if (tag==1){
        [self networkload:@"1"];
    }else if (tag==2){
        [self networkload:@"2"];
    }
}



-(void)cgkaitong_but_p{
    selcteView.frame = CGRectMake(0,43, ScreenWidth/3, 2);
    [cgkaitong_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [ptkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [other_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    tag = 0;
    curPage = 1;
    [self networkload:@"0"];
}


-(void)ptkaitong_but_p{
    selcteView.frame = CGRectMake(ScreenWidth/3,43, ScreenWidth/3, 2);
    [ptkaitong_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [cgkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [other_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    tag = 1;
    curPage = 1;
    [self networkload:@"1"];
}

-(void)other_but_p{
    selcteView.frame = CGRectMake(2*ScreenWidth/3,43, ScreenWidth/3, 2);
    [other_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [ptkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [cgkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    tag = 2;
    curPage = 1;
    [self networkload:@"2"];
}

-(void)networkload:(NSString *)ss{
    NSString *url =[NSString stringWithFormat:@"%@/user/sbtz/list.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    [postDic setObject:ss forKey:@"status"];
    [postDic setObject:[NSString stringWithFormat:@"%d",curPage] forKey:@"page"];
    
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"no",@"isshowHUD",
                                           @"no",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   if (kk==0) {
                                       if (kk==0) {
                                           if (curPage==1) {
                                               [arraydata removeAllObjects];
                                           }
                                           NSMutableDictionary *dic = [data JSONValue];
                                           if (![dic[@"rvalue"] isKindOfClass:[NSNull class]]) {
                                               [arraydata addObjectsFromArray:[data JSONValue][@"rvalue"]];
                                           }else{
                                               [Tool myalter:@"暂无数据"];
                                           }
                                       }
                                       [myTabview headerEndRefreshing];
                                       [myTabview footerEndRefreshing];
                                       [myTabview reloadData];
                                   }
                               }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arraydata.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dicOne = arraydata[indexPath.row];
    if (dicOne[@"cellH"]==nil) {
        return 60;
    }
    return [dicOne[@"cellH"] floatValue];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    NSArray *viewArray = [cell.contentView subviews];
    for (int i = 0; i < [viewArray count]; i++) {
        UIView *view = [viewArray objectAtIndex:i];
        [view removeFromSuperview];view=nil;
    }
    
    
    RCLabel *planAllMoney = [[RCLabel alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth/3, 60)];
    [cell.contentView addSubview:planAllMoney];
    
    RCLabel *yearlilv = [[RCLabel alloc] initWithFrame:CGRectMake(ScreenWidth/3, 10, ScreenWidth/3, 60)];
    [cell.contentView addSubview:yearlilv];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/3, 10, 0.5, 40)];
    [line1 setBackgroundColor:RGB(238, 238, 238)];
    [cell.contentView addSubview:line1];
    
    RCLabel *lastTime = [[RCLabel alloc] initWithFrame:CGRectMake(2*ScreenWidth/3,10, ScreenWidth/3, 60)];
    [cell.contentView addSubview:lastTime];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(2*ScreenWidth/3, 10, 0.5, 40)];
    [line2 setBackgroundColor:RGB(238, 238, 238)];
    [cell.contentView addSubview:line2];
    
    NSMutableDictionary *dicdata = [arraydata objectAtIndex:indexPath.row];
    
    
    //标的总额
    if ([[dicdata objectForKey:@"tzje"] doubleValue] < 10000) {
        planAllMoney.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[dicdata objectForKey:@"tzje"] withDanwei:@"元" withName:@"投标金额"]];
        
    }else if ([[dicdata objectForKey:@"tzje"] doubleValue] > 1000000000){
        
        NSString *bdze = [dicdata objectForKey:@"tzje"];
        double zonge = [bdze doubleValue]/1000000000;
        planAllMoney.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%0.2lf",zonge] withDanwei:@"亿" withName:@"投标金额"]];
    }else{
        NSString *bdze = [dicdata objectForKey:@"tzje"];
        double zonge = [bdze doubleValue]/10000;
        planAllMoney.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%0.2lf",zonge] withDanwei:@"万" withName:@"投标金额"]];
    }
    
    yearlilv.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:dicdata[@"nll"]  withDanwei:@"%" withName:@"预期年化收益"]];
    
    if(tag==0){
        lastTime.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:dicdata[@"dsbx"]  withDanwei:@"" withName:@"待收本息"]];
   
        if ([dicdata[@"isopen"] isEqualToString:@"y"]) {
            
            RCLabel *bdlx = [[RCLabel alloc] initWithFrame:CGRectMake(15, 60, ScreenWidth-30, 40)];
            [cell.contentView addSubview:bdlx];
            if ([dicdata[@"bdlx"] isEqualToString:@"1"]) {
                bdlx.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage2:@"标的类型" withName:@"存管标"]];
            }else{
                bdlx.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage2:@"标的类型" withName:@"普通标"]];
            }
            
            RCLabel *jiekuanbiaoti = [[RCLabel alloc] initWithFrame:CGRectMake(15, 60+40, ScreenWidth-30, 40)];
            [cell.contentView addSubview:jiekuanbiaoti];
            jiekuanbiaoti.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage2:@"借款标题" withName:dicdata[@"bdbt"]]];
            
            RCLabel *shengyuqishu = [[RCLabel alloc] initWithFrame:CGRectMake(15, 60+80, ScreenWidth-30, 40)];
            [cell.contentView addSubview:shengyuqishu];
            shengyuqishu.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage2:@"剩余期数" withName:[NSString stringWithFormat:@"%@",dicdata[@"syqs"]]]];
            
            RCLabel *kaishijixishijian = [[RCLabel alloc] initWithFrame:CGRectMake(15, 180, ScreenWidth-30, 40)];
            [cell.contentView addSubview:kaishijixishijian];
            kaishijixishijian.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage2:@"开始时间" withName:[NSString stringWithFormat:@"%@",dicdata[@"ksjxsj"]]]];
            
            RCLabel *xiayigehuankuanri = [[RCLabel alloc] initWithFrame:CGRectMake(15, 220, ScreenWidth-30, 40)];
            [cell.contentView addSubview:xiayigehuankuanri];
            xiayigehuankuanri.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage2:@"下个还款日" withName:[NSString stringWithFormat:@"%@",dicdata[@"xyhkr"]]]];
            
            RCLabel *huankuanzhuangtai = [[RCLabel alloc] initWithFrame:CGRectMake(15, 260, ScreenWidth-30, 40)];
            [cell.contentView addSubview:huankuanzhuangtai];
            huankuanzhuangtai.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage2:@"还款状态" withName:[NSString stringWithFormat:@"%@",dicdata[@"hkzt"]]]];
            
            
            if (dicdata[@"jyczurl"] == nil || [dicdata[@"jyczurl"] isEqualToString:@""]) {
                
                if (dicdata[@"xmczur"]== nil || [dicdata[@"xmczur"] isEqualToString:@""]) {
                    
                }else{
                    UIButton *but1 =  [Tool ButtonProductionFunction:@"项目存证" Frame:CGRectMake(15, 300, 90, 30) bgImgName:nil FontFl:15];
                    [but1 addTarget:self action:@selector(xiangmucunzheng:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:but1];
                    [but1 setBackgroundColor:[UIColor whiteColor]];
                    [but1 setTitleColor:KTHCOLOR forState:UIControlStateNormal];
                    [UtilityUI setBorderOnView:but1 borderColor:KTHCOLOR borderWidth:1 cornerRadius:15];
                    but1.tag = 100+indexPath.row;
                }
                
            }else{
            
                UIButton *but1 =  [Tool ButtonProductionFunction:@"交易存证" Frame:CGRectMake(15, 300, 90, 30) bgImgName:nil FontFl:15];
                [but1 addTarget:self action:@selector(jiaoyoyicunzh:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:but1];
                [but1 setBackgroundColor:[UIColor whiteColor]];
                [but1 setTitleColor:KTHCOLOR forState:UIControlStateNormal];
                [UtilityUI setBorderOnView:but1 borderColor:KTHCOLOR borderWidth:1 cornerRadius:15];
                but1.tag = 100+indexPath.row;
                
                if (dicdata[@"xmczur"]== nil || [dicdata[@"xmczur"] isEqualToString:@""]) {
                    
                }else{
                    UIButton *but1 =  [Tool ButtonProductionFunction:@"项目存证" Frame:CGRectMake(120, 340, 90, 30) bgImgName:nil FontFl:15];
                    [but1 addTarget:self action:@selector(xiangmucunzheng:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:but1];
                    [but1 setBackgroundColor:[UIColor whiteColor]];
                    [but1 setTitleColor:KTHCOLOR forState:UIControlStateNormal];
                    [UtilityUI setBorderOnView:but1 borderColor:KTHCOLOR borderWidth:1 cornerRadius:15];
                    but1.tag = 100+indexPath.row;
                }
                
            }
            
            
            
            
            
        }else{
        
        }
    
    }else if (tag==1){
        lastTime.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:[NSString stringWithFormat:@"%@",dicdata[@"jkqx"]]  withDanwei:@"" withName:@"期限"]];
    
        if ([dicdata[@"isopen"] isEqualToString:@"y"]) {
            
            RCLabel *bdlx = [[RCLabel alloc] initWithFrame:CGRectMake(15, 60, ScreenWidth-30, 40)];
            [cell.contentView addSubview:bdlx];
            if ([dicdata[@"bdlx"] isEqualToString:@"1"]) {
                bdlx.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage2:@"标的类型" withName:@"存管标"]];
            }else{
                bdlx.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage2:@"标的类型" withName:@"普通标"]];
            }
            
            RCLabel *jiekuanbiaoti = [[RCLabel alloc] initWithFrame:CGRectMake(15, 60+40, ScreenWidth-30, 40)];
            [cell.contentView addSubview:jiekuanbiaoti];
            jiekuanbiaoti.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage2:@"借款标题" withName:dicdata[@"bdbt"]]];
            
            
            RCLabel *shengyuketou = [[RCLabel alloc] initWithFrame:CGRectMake(15, 60+80, ScreenWidth-30, 40)];
            [cell.contentView addSubview:shengyuketou];
            shengyuketou.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage2:@"剩余可投" withName:[NSString stringWithFormat:@"%@元",dicdata[@"syje"]]]];
            
            
            RCLabel *toubiaojindu = [[RCLabel alloc] initWithFrame:CGRectMake(15, 60+120, ScreenWidth-30, 40)];
            [cell.contentView addSubview:toubiaojindu];
            toubiaojindu.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage2:@"投标进度" withName:[NSString stringWithFormat:@"%@%%",dicdata[@"rzjd"]]]];
            
            RCLabel *toubiaoshijian = [[RCLabel alloc] initWithFrame:CGRectMake(15, 60+160, ScreenWidth-30, 40)];
            [cell.contentView addSubview:toubiaoshijian];
            toubiaoshijian.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage2:@"投标时间" withName:[NSString stringWithFormat:@"%@",dicdata[@"tbsj"]]]];
            
            if ([dicdata[@"bdzt"] isEqualToString:@"0"]) {
                
                UIButton *but1 =  [Tool ButtonProductionFunction:@"继续投标" Frame:CGRectMake(15, 260, 90, 30) bgImgName:nil FontFl:15];
                [but1 addTarget:self action:@selector(jixutuobiao:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:but1];
                [but1 setBackgroundColor:[UIColor whiteColor]];
                [but1 setTitleColor:KTHCOLOR forState:UIControlStateNormal];
                [UtilityUI setBorderOnView:but1 borderColor:KTHCOLOR borderWidth:1 cornerRadius:15];
                but1.tag = 100+indexPath.row;
 
                if (dicdata[@"xmczurl"] == nil || [dicdata[@"xmczurl"] isEqualToString:@""]) {
                }else{
                    
                    UIButton *but1 =  [Tool ButtonProductionFunction:@"项目存证" Frame:CGRectMake(120, 260, 90, 30) bgImgName:nil FontFl:15];
                    [but1 addTarget:self action:@selector(xiangmucunzheng:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:but1];
                    [but1 setBackgroundColor:[UIColor whiteColor]];
                    [but1 setTitleColor:KTHCOLOR forState:UIControlStateNormal];
                    [UtilityUI setBorderOnView:but1 borderColor:KTHCOLOR borderWidth:1 cornerRadius:15];
                    but1.tag = 100+indexPath.row;
                    
                }

                
            }else{
                if (dicdata[@"xmczurl"] == nil || [dicdata[@"xmczurl"] isEqualToString:@""]) {
                }else{
                    
                    UIButton *but1 =  [Tool ButtonProductionFunction:@"项目存证" Frame:CGRectMake(15, 260, 90, 30) bgImgName:nil FontFl:15];
                    [but1 addTarget:self action:@selector(xiangmucunzheng:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:but1];
                    [but1 setBackgroundColor:[UIColor whiteColor]];
                    [but1 setTitleColor:KTHCOLOR forState:UIControlStateNormal];
                    [UtilityUI setBorderOnView:but1 borderColor:KTHCOLOR borderWidth:1 cornerRadius:15];
                    but1.tag = 100+indexPath.row;
                    
                }

            }
            
           
            
        }else{
            
        }
    
    
    }else if (tag==2){
        lastTime.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage:dicdata[@"hsje"]  withDanwei:@"" withName:@"回收金额"]];
        
        if ([dicdata[@"isopen"] isEqualToString:@"y"]) {
            
            RCLabel *bdlx = [[RCLabel alloc] initWithFrame:CGRectMake(15, 60, ScreenWidth-30, 40)];
            [cell.contentView addSubview:bdlx];
            if ([dicdata[@"bdlx"] isEqualToString:@"1"]) {
                bdlx.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage2:@"标的类型" withName:@"存管标"]];
            }else{
                bdlx.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage2:@"标的类型" withName:@"普通标"]];
            }
            
            RCLabel *jiekuanbiaoti = [[RCLabel alloc] initWithFrame:CGRectMake(15, 60+40, ScreenWidth-30, 40)];
            [cell.contentView addSubview:jiekuanbiaoti];
            jiekuanbiaoti.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage2:@"借款标题" withName:dicdata[@"bdbt"]]];
            
            RCLabel *yizhuanjine = [[RCLabel alloc] initWithFrame:CGRectMake(15, 60+80, ScreenWidth-30, 40)];
            [cell.contentView addSubview:yizhuanjine];
            yizhuanjine.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage2:@"已赚金额" withName:[NSString stringWithFormat:@"%@元",dicdata[@"yzje"]]]];
            
            RCLabel *jieqingriqi = [[RCLabel alloc] initWithFrame:CGRectMake(15, 60+120, ScreenWidth-30, 40)];
            [cell.contentView addSubview:jieqingriqi];
            jieqingriqi.componentsAndPlainText = [RCLabel extractTextStyle:[self exchage2:@"结清日期" withName:dicdata[@"jqrq"]]];
             
            if (dicdata[@"xmczurl"] == nil || [dicdata[@"xmczurl"] isEqualToString:@""]) {
            }else{
            
                UIButton *but1 =  [Tool ButtonProductionFunction:@"项目存证" Frame:CGRectMake(15, 100+120, 90, 30) bgImgName:nil FontFl:15];
                [but1 addTarget:self action:@selector(xiangmucunzheng:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:but1];
                [but1 setBackgroundColor:[UIColor whiteColor]];
                [but1 setTitleColor:KTHCOLOR forState:UIControlStateNormal];
                [UtilityUI setBorderOnView:but1 borderColor:KTHCOLOR borderWidth:1 cornerRadius:15];
                but1.tag = 100+indexPath.row;
                
            }
        }else{
            
        }
    
    
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableDictionary *dicdata = [arraydata objectAtIndex:indexPath.row];
    if ([dicdata[@"isopen"] isEqualToString:@"y"]) {
        [dicdata setObject:@"n" forKey:@"isopen"];
        [dicdata setObject:@"60" forKey:@"cellH"];
    }else{
        //需要打开
        [dicdata setObject:@"y" forKey:@"isopen"];
        
        if (tag==2) {
            
            if (dicdata[@"xmczurl"] == nil || [dicdata[@"xmczurl"] isEqualToString:@""]) {
                [dicdata setObject:[NSString stringWithFormat:@"%d",120+100] forKey:@"cellH"];
            }else{
                [dicdata setObject:[NSString stringWithFormat:@"%d",120+60+80] forKey:@"cellH"];
            }
        }else if (tag==1){
            
            if (dicdata[@"xmczurl"] == nil || [dicdata[@"xmczurl"] isEqualToString:@""]) {
                [dicdata setObject:[NSString stringWithFormat:@"%d",260] forKey:@"cellH"];
                if ([dicdata[@"bdzt"] isEqualToString:@"0"]) {
                    [dicdata setObject:[NSString stringWithFormat:@"%d",300] forKey:@"cellH"];
                }else{
                    [dicdata setObject:[NSString stringWithFormat:@"%d",260] forKey:@"cellH"];
                }
            }else{
                [dicdata setObject:[NSString stringWithFormat:@"%d",300] forKey:@"cellH"];
            }
        }else{
            
            if (dicdata[@"jyczurl"] == nil || [dicdata[@"jyczurl"] isEqualToString:@""]) {
                
                if (dicdata[@"xmczur"]== nil || [dicdata[@"xmczur"] isEqualToString:@""]) {
                    
                    [dicdata setObject:[NSString stringWithFormat:@"%d",340] forKey:@"cellH"];
                }else{
                     [dicdata setObject:[NSString stringWithFormat:@"%d",300] forKey:@"cellH"];
                }
            
            }else{
                [dicdata setObject:[NSString stringWithFormat:@"%d",340] forKey:@"cellH"];
            } 
        }
        
    }
    [tableView reloadData];
    
}

//转换
-(NSString *)exchage:(NSString *)string withDanwei:(NSString *)danwei withName:(NSString *)name{
    return [NSString stringWithFormat:@"<p align=center><font size=15 face='HelveticaNeue'>%@</font><font size=12 face='HelveticaNeue'>%@</font>\n<font size =11 color='#8B8B8B' face='HelveticaNeue'>%@</font></p>",string,danwei,name];
}

//转换
-(NSString *)exchage2:(NSString *)string withName:(NSString *)name{
    
    if ([string isEqualToString:@"标的类型"]) {
        return [NSString stringWithFormat:@"<p align=left><font size=15 face='HelveticaNeue'>%@</font><font color='#3C9AEB' size=15 face='HelveticaNeue'>   %@</font></p>",string,name];
    }
    if ([string isEqualToString:@"借款标题"]) {
        return [NSString stringWithFormat:@"<p align=left><font size=15 face='HelveticaNeue'>%@</font><font size=15 color='#FD9622' face='HelveticaNeue'>   %@</font></p>",string,name];
    }
    
    return [NSString stringWithFormat:@"<p align=left><font size=15 face='HelveticaNeue'>%@</font><font size=15 face='HelveticaNeue'>   %@</font></p>",string,name];
}


-(void)xiangmucunzheng:(UIButton *)but{
    NSMutableDictionary *dicdata = [arraydata objectAtIndex:but.tag-100];
    
    
    WebController *web = [[WebController alloc] init];
    web.urlString = dicdata[@"xmczurl"];
    web.title = @"项目存证";
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:web animated:YES];
 
}

-(void)jixutuobiao:(UIButton *)but{
    NSMutableDictionary *dicdata = [arraydata objectAtIndex:but.tag-100];
 
    BuyZhaiquanViewController *buy = [[BuyZhaiquanViewController alloc] init];
    buy.title = @"立即投标";
    buy.allDic = dicdata;
    buy.typeTag = @"1";
    if ([dicdata[@"bdlx"] isEqualToString:@"0"]) {
        buy.iscunguan = 0;
    }else{
        buy.iscunguan = 1;
    }
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:buy animated:YES];
}

-(void)jiaoyoyicunzh:(UIButton *)but{
    NSMutableDictionary *dicdata = [arraydata objectAtIndex:but.tag-100];
    
    WebController *web = [[WebController alloc] init];
    web.urlString = dicdata[@"xmczurl"];
    web.title = @"交易存证";
    //返回
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
    backItem.title=@"返回";
    self.navigationItem.backBarButtonItem=backItem;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:web animated:YES];
}

@end
