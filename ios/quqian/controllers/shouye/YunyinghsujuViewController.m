//
//  YunyinghsujuViewController.m
//  quqian
//
//  Created by 宋培众 on 2017/6/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YunyinghsujuViewController.h"
#import "Tool.h"
#import "HelpDownloader.h"


@interface YunyinghsujuViewController ()
{
    UILabel *anquanyinig_v;
    UILabel *wanchengjiekuan_v;
    UILabel *jikeuanren_v;
    UILabel *lijichengjiao_v;
    UILabel *zhuanqushoyyi_v;
    UILabel *daishoubenji_v;
    UILabel *touzhirendaishoufbenji_v;
    
}
@end

@implementation YunyinghsujuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *url =[NSString stringWithFormat:@"%@/yysjCount.htm",BASE_URL];
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
                                       
                                      NSMutableDictionary *dic = [data JSONValue][@"rvalue"];
                                       
                                       anquanyinig_v.text = [NSString stringWithFormat:@"%@天",dic[@"yysj"]];
                                       wanchengjiekuan_v.text = [NSString stringWithFormat:@"%@笔",dic[@"jkbs"]];
                                       jikeuanren_v.text = [NSString stringWithFormat:@"%@人",dic[@"zcrs"]];
                                       lijichengjiao_v.text = [NSString stringWithFormat:@"%@元",dic[@"ljcj"]];
                                       zhuanqushoyyi_v.text = [NSString stringWithFormat:@"%@元",dic[@"tzrljsy"]];
                                       daishoubenji_v.text = [NSString stringWithFormat:@"%@元",dic[@"dhbj"]];
                                       touzhirendaishoufbenji_v.text = [NSString stringWithFormat:@"%@元",dic[@"tzrdhsy"]];
                                   }
                                }];
    
    
    
    
    
    CGFloat hy = 30;
    UILabel *shuju = [Tool LablelProductionFunction:@"数据总览" Frame:CGRectMake(0, hy, ScreenWidth, 20) Alignment:NSTextAlignmentCenter  FontFl:15];
    shuju.textColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0 alpha:1.0];
    [_bgScorll addSubview:shuju];
    
    
    hy += 30;
    
    UILabel *jizhi = [Tool LablelProductionFunction:@"统计时间截至昨日" Frame:CGRectMake(0, hy, ScreenWidth, 15) Alignment:NSTextAlignmentCenter  FontFl:12];
    jizhi.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1.0];
    [_bgScorll addSubview:jizhi];
    
    
    hy += 65;
    
    UIImageView *img = [Tool ImgProductionFunctionFrame:CGRectMake(ScreenWidth/2-218/2, hy, 218/2, 218/2) bgImgName:@"安全运营时间"];
    [_bgScorll addSubview:img];
    
    UILabel *anquanyinig = [Tool LablelProductionFunction:@"安全运营时间" Frame:CGRectMake(ScreenWidth/2, hy+218/4-15, ScreenWidth/2, 15) Alignment:NSTextAlignmentCenter  FontFl:12];
    anquanyinig.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1.0];
    [_bgScorll addSubview:anquanyinig];
    anquanyinig_v = [Tool LablelProductionFunction:@"天" Frame:CGRectMake(ScreenWidth/2, 10+hy+218/4, ScreenWidth/2, 20) Alignment:NSTextAlignmentCenter  FontFl:15];
    anquanyinig_v.textColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0 alpha:1.0];
    [_bgScorll addSubview:anquanyinig_v];
    
    
    hy += 218/2+60;
    
    
    UIImageView *img1 = [Tool ImgProductionFunctionFrame:CGRectMake(30, hy, 140, 140) bgImgName:@"完成借款"];
    [_bgScorll addSubview:img1];
    
    UILabel *wanchengjiekuan = [Tool LablelProductionFunction:@"完成借款" Frame:CGRectMake(0, 160, 140, 15) Alignment:NSTextAlignmentCenter  FontFl:12];
    wanchengjiekuan.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1.0];
    [img1 addSubview:wanchengjiekuan];
    wanchengjiekuan_v = [Tool LablelProductionFunction:@"笔" Frame:CGRectMake(0, 170+15, 140, 20) Alignment:NSTextAlignmentCenter  FontFl:15];
    wanchengjiekuan_v.textColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0 alpha:1.0];
    [img1 addSubview:wanchengjiekuan_v];
    
    
    UIImageView *img2 = [Tool ImgProductionFunctionFrame:CGRectMake(ScreenWidth-170, hy, 140, 140) bgImgName:@"注册人数"];
    [_bgScorll addSubview:img2];
    UILabel *jikeuanren = [Tool LablelProductionFunction:@"注册人数" Frame:CGRectMake(0, 160, 140, 15) Alignment:NSTextAlignmentCenter  FontFl:12];
    jikeuanren.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1.0];
    [img2 addSubview:jikeuanren];
    jikeuanren_v = [Tool LablelProductionFunction:@"人" Frame:CGRectMake(0, 170+15, 140, 20) Alignment:NSTextAlignmentCenter  FontFl:15];
    jikeuanren_v.textColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0 alpha:1.0];
    [img2 addSubview:jikeuanren_v];
    
    
    hy += 218/2+60+80;
    
    UIImageView *img3 = [Tool ImgProductionFunctionFrame:CGRectMake(30, hy, 140, 140) bgImgName:@"累计成交"];
    [_bgScorll addSubview:img3];
    
    UILabel *lijichengjiao = [Tool LablelProductionFunction:@"累积成交" Frame:CGRectMake(0, 160, 140, 15) Alignment:NSTextAlignmentCenter  FontFl:12];
    lijichengjiao.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1.0];
    [img3 addSubview:lijichengjiao];
    lijichengjiao_v = [Tool LablelProductionFunction:@"元" Frame:CGRectMake(0, 170+15, 140, 20) Alignment:NSTextAlignmentCenter  FontFl:15];
    lijichengjiao_v.textColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0 alpha:1.0];
    [img3 addSubview:lijichengjiao_v];
    
    
    UIImageView *img4 = [Tool ImgProductionFunctionFrame:CGRectMake(ScreenWidth-170, hy, 140, 140) bgImgName:@"累计投资收益"];
    [_bgScorll addSubview:img4];
    UILabel *zhuanqushoyyi = [Tool LablelProductionFunction:@"投资人累计赚取收益" Frame:CGRectMake(0, 160, 140, 15) Alignment:NSTextAlignmentCenter  FontFl:12];
    zhuanqushoyyi.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1.0];
    [img4 addSubview:zhuanqushoyyi];
    zhuanqushoyyi_v = [Tool LablelProductionFunction:@"元" Frame:CGRectMake(0, 170+15, 140, 20) Alignment:NSTextAlignmentCenter  FontFl:15];
    zhuanqushoyyi_v.textColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0 alpha:1.0];
    [img4 addSubview:zhuanqushoyyi_v];
    
    
    hy += 218/2+60+80;
    
    
    UIImageView *img5 = [Tool ImgProductionFunctionFrame:CGRectMake(30, hy, 140, 140) bgImgName:@"待还本金"];
    [_bgScorll addSubview:img5];
    
    UILabel *daishoubenji = [Tool LablelProductionFunction:@"待还本金" Frame:CGRectMake(0, 160, 140, 15) Alignment:NSTextAlignmentCenter  FontFl:12];
    daishoubenji.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1.0];
    [img5 addSubview:daishoubenji];
    daishoubenji_v = [Tool LablelProductionFunction:@"元" Frame:CGRectMake(0, 170+15, 140, 20) Alignment:NSTextAlignmentCenter  FontFl:15];
    daishoubenji_v.textColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0 alpha:1.0];
    [img5 addSubview:daishoubenji_v];
    
    
    UIImageView *img6 = [Tool ImgProductionFunctionFrame:CGRectMake(ScreenWidth-170, hy, 140, 140) bgImgName:@"待赚取收益"];
    [_bgScorll addSubview:img6];
    UILabel *touzhirendaishoufbenji = [Tool LablelProductionFunction:@"投资人待赚取收益" Frame:CGRectMake(0, 160, 140, 15) Alignment:NSTextAlignmentCenter  FontFl:12];
    touzhirendaishoufbenji.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1.0];
    [img6 addSubview:touzhirendaishoufbenji];
    touzhirendaishoufbenji_v = [Tool LablelProductionFunction:@"元" Frame:CGRectMake(0, 170+15, 140, 20) Alignment:NSTextAlignmentCenter  FontFl:15];
    touzhirendaishoufbenji_v.textColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0 alpha:1.0];
    [img6 addSubview:touzhirendaishoufbenji_v];
    
    
    
    
    hy += 218/2+30;
    
    _bgScorll.contentSize = CGSizeMake(ScreenWidth, hy+180);
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
