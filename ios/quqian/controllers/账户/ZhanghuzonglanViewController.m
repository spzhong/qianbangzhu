//
//  ZhanghuzonglanViewController.m
//  qianbangzhu
//
//  Created by 宋培众 on 2017/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ZhanghuzonglanViewController.h"
#import "Tool.h"
#import "HelpDownloader.h"

@interface ZhanghuzonglanViewController ()
{
    UIButton *cgkaitong_but;
    UIButton *ptkaitong_but;
    UIView *selcteView;
    NSMutableDictionary *alldic;
    NSMutableArray *arraydata;
    UITableView *myTabview;
    int tag;
}
@end

@implementation ZhanghuzonglanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/user/jyjl/zhzl.htm",BASE_URL];
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
                                       alldic = [[data JSONValue][@"rvalue"] mutableCopy];
                                       [self createview];
                                   }
                               }];

  
}

-(void)createview{
    cgkaitong_but = [Tool ButtonProductionFunction:@"存管账户" Frame:CGRectMake(ScreenWidth/2, 0, ScreenWidth/2, 45) bgImgName:nil FontFl:15];
    [cgkaitong_but addTarget:self action:@selector(cgkaitong_but_p) forControlEvents:UIControlEventTouchUpInside];
    [cgkaitong_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [cgkaitong_but setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:cgkaitong_but];
    
    ptkaitong_but = [Tool ButtonProductionFunction:@"普通账户" Frame:CGRectMake(0, 0, ScreenWidth/2, 45) bgImgName:nil FontFl:15];
    [ptkaitong_but addTarget:self action:@selector(ptkaitong_but_p) forControlEvents:UIControlEventTouchUpInside];
    [ptkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [ptkaitong_but setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:ptkaitong_but];
    
    selcteView = [[UIView alloc] initWithFrame:CGRectZero];
    [selcteView setBackgroundColor:KTHCOLOR];
    [self.view addSubview:selcteView];
    
    myTabview = [Tool TableProductionFunction:self Frame:CGRectMake(0, 50, ScreenWidth, ScreenHeight-64-50)];
    [self.view addSubview:myTabview];
    [myTabview setBackgroundColor:RGB(242, 242, 242)];
    
    [self ptkaitong_but_p];
    
    
    
    UILabel *lab = [Tool LablelProductionFunction:@"您的资金由广东华兴银行直接存管" Frame:CGRectMake(0, 0, ScreenWidth, 50) Alignment:NSTextAlignmentCenter FontFl:12];
    [lab sizeToFit];
    lab.textColor = [UIColor whiteColor];
    lab.frame = CGRectMake((ScreenWidth-lab.frame.size.width)/2, ScreenHeight-64-30, lab.frame.size.width, lab.frame.size.height);
    
    
    UIImageView *logoicn2 = [Tool ImgProductionFunctionFrame:CGRectMake(-20, 0, 16, 16) bgImgName:@"广东华兴银行LOGO2"];
    [lab addSubview:logoicn2];
    
    
    [self.view addSubview:lab];
    lab.textColor = [UIColor whiteColor];
}

-(void)cgkaitong_but_p{
    selcteView.frame = CGRectMake(ScreenWidth/2,43, ScreenWidth/2, 2);
    [cgkaitong_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [ptkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    tag = 0;
    [myTabview reloadData];
}


-(void)ptkaitong_but_p{
    selcteView.frame = CGRectMake(0,43, ScreenWidth/2, 2);
    [ptkaitong_but setTitleColor:KTHCOLOR forState:UIControlStateNormal];
    [cgkaitong_but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    tag = 1;
    [myTabview reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    }
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
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
    
    UILabel *lab1  = [Tool LablelProductionFunction:@"" Frame:CGRectMake(15, 0, 160, 44) Alignment:NSTextAlignmentLeft  FontFl:15];
    [cell.contentView addSubview:lab1];
    
    UILabel *lab2 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(50, 0, ScreenWidth-65, 44) Alignment:NSTextAlignmentRight  FontFl:15];
    lab2.textColor = KTHCOLOR;
    [cell.contentView addSubview:lab2];
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            lab1.text = @"可用余额";
            if (tag==0) {
                lab2.text = [NSString stringWithFormat:@"%@元",alldic[@"cgkyye"]];
            }else{
                lab2.text = [NSString stringWithFormat:@"%@元",alldic[@"kyye"]];
            }
        }else if (indexPath.row==1) {
            lab1.text = @"冻结金额";
            if (tag==0) {
                lab2.text = [NSString stringWithFormat:@"%@元",alldic[@"cgdjje"]];
            }else{
                lab2.text = [NSString stringWithFormat:@"%@元",alldic[@"djje"]];
            }
        }else if (indexPath.row==2) {
            lab1.text = @"账户总额";
            if (tag==0) {
                lab2.text = [NSString stringWithFormat:@"%@元",alldic[@"cgzhze"]];
            }else{
                lab2.text = [NSString stringWithFormat:@"%@元",alldic[@"zhze"]];
            }
        }
    }else if (indexPath.section==1){
        
        if (indexPath.row==0) {
            lab1.text = @"已赚收益";
            if (tag==0) {
                lab2.text = [NSString stringWithFormat:@"%@元",alldic[@"cgyzsy"]];
            }else{
                lab2.text = [NSString stringWithFormat:@"%@元",alldic[@"yzsy"]];
            }

        }else if (indexPath.row==1) {
            lab1.text = @"待收本金";
            if (tag==0) {
                lab2.text = [NSString stringWithFormat:@"%@元",alldic[@"cgdsbj"]];
            }else{
                lab2.text = [NSString stringWithFormat:@"%@元",alldic[@"dsbj"]];
            }
        }else if (indexPath.row==2) {
            lab1.text = @"待收利息";
            if (tag==0) {
                lab2.text = [NSString stringWithFormat:@"%@元",alldic[@"cgdslx"]];
            }else{
                lab2.text = [NSString stringWithFormat:@"%@元",alldic[@"dslx"]];
            }
        }else if (indexPath.row==3) {
            lab1.text = @"累计投资";
            if (tag==0) {
                lab2.text = [NSString stringWithFormat:@"%@元",alldic[@"cgtzlj"]];
            }else{
                lab2.text = [NSString stringWithFormat:@"%@元",alldic[@"tzlj"]];
            }

        }
    }else if (indexPath.section==2){
        if (indexPath.row==0) {
            lab1.text = @"累计借款";
            if (tag==0) {
                lab2.text = [NSString stringWithFormat:@"%@元",alldic[@"cgljjk"]];
            }else{
                lab2.text = [NSString stringWithFormat:@"%@元",alldic[@"ljjk"]];
            }
        }else if (indexPath.row==1) {
            lab1.text = @"待还本金";
            if (tag==0) {
                lab2.text = [NSString stringWithFormat:@"%@元",alldic[@"cgdhbj"]];
            }else{
                lab2.text = [NSString stringWithFormat:@"%@元",alldic[@"dhbj"]];
            }
        }else if (indexPath.row==2) {
            lab1.text = @"待还利息";
            if (tag==0) {
                lab2.text = [NSString stringWithFormat:@"%@元",alldic[@"cgdhlx"]];
            }else{
                lab2.text = [NSString stringWithFormat:@"%@元",alldic[@"dhlx"]];
            }
        }else if (indexPath.row==3) {
            lab1.text = @"待还管理费";
            if (tag==0) {
                lab2.text = [NSString stringWithFormat:@"%@元",alldic[@"cgdhglf"]];
            }else{
                lab2.text = [NSString stringWithFormat:@"%@元",alldic[@"dhglf"]];
            }
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
