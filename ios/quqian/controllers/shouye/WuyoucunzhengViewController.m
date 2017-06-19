//
//  WuyoucunzhengViewController.m
//  quqian
//
//  Created by 宋培众 on 2017/6/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WuyoucunzhengViewController.h"
#import "Tool.h"


@interface WuyoucunzhengViewController ()

@end

@implementation WuyoucunzhengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGFloat hy = 30;
    UILabel *shuju = [Tool LablelProductionFunction:@"什么是无忧存证？" Frame:CGRectMake(0, hy, ScreenWidth, 20) Alignment:NSTextAlignmentCenter  FontFl:18];
    shuju.textColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0 alpha:1.0];
    [_bgScorll addSubview:shuju];
 
    
    hy += 40;
    
    UILabel *info = [Tool LablelProductionFunction:@"无忧存证是安存科技联合公证机构共同推出，以“增强互联网金融用户交易安全”为核心的全球首个一站式互联网金融公证保全解决方案。当用户通过互联网发生交易行为的同时，将交易数据实时同步至安存金融级数据保全云。所保全数据严格满足证据的真实性、合法性、相关性要求，必要时可以依法申请出具公证书，真正做到一站式公证保全。安存无忧电子数据保全平台已跟全国28个省、直辖市、自治区公证处签约合作，其证明力获得人民法院的认可。一旦出现纠纷，投资者可以通过后台提交公证申请，维护自身合法权益。" Frame:CGRectMake(15, hy, ScreenWidth-30, 999) Alignment:NSTextAlignmentCenter  FontFl:15];
    info.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1.0];
    info.numberOfLines = 0;
    [info sizeToFit];
    [_bgScorll addSubview:info];
    
    
    hy += info.frame.size.height + 60;
    
    
    UILabel *shuju2 = [Tool LablelProductionFunction:@"什么是全电子数据生命周期？" Frame:CGRectMake(0, hy, ScreenWidth, 20) Alignment:NSTextAlignmentCenter  FontFl:18];
    shuju2.textColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0 alpha:1.0];
    [_bgScorll addSubview:shuju2];
    

    hy += 40;
    
    UILabel *info2 = [Tool LablelProductionFunction:@"2013年1月1日实施的《中华人民共和国民事诉讼法》第63条已经明确将电子数据列为单一证据类别——电子数据证据成为法定证据。但与其它传统证据形式相比，电子数据证据有着海量、脆弱、易变易改、不易保存原始数据等特点，普通电子数据证据证明力通常不受司法认可。\n\n钱帮主联手无忧存证，采取全电子数据生命周期存证模式，即从数据的生成和创建——数据的存储和传输——数据的取得，全方位确保所保全的电子数据的真实性、完整性、安全性。在无忧存证中保全的电子数据，能通过后台申请公正机关公证，证明力获人民法院认可。" Frame:CGRectMake(15, hy, ScreenWidth-30, 999) Alignment:NSTextAlignmentCenter  FontFl:15];
    info2.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1.0];
    info2.numberOfLines = 0;
    [info2 sizeToFit];
    [_bgScorll addSubview:info2];
    
    
    hy += info2.frame.size.height + 60;
    
    
    
    
    UILabel *shuju3 = [Tool LablelProductionFunction:@"交易完成出具保全证书" Frame:CGRectMake(0, hy, ScreenWidth, 20) Alignment:NSTextAlignmentCenter  FontFl:18];
    shuju3.textColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0 alpha:1.0];
    [_bgScorll addSubview:shuju3];
    
    
    hy += 40;
    
    UILabel *info3 = [Tool LablelProductionFunction:@"用户在钱帮主整个投资过程的电子数据，用第三方保全的办法记录事实真相，明确主体的权利与义务，有效防范法律风险。平台信息更透明，投资人利益有所保障。\n\n保全数据包括：项目信息、交易信息、充值信息、提现信息、用户信息。" Frame:CGRectMake(15, hy, ScreenWidth-30, 999) Alignment:NSTextAlignmentCenter  FontFl:15];
    info3.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1.0];
    info3.numberOfLines = 0;
    [info3 sizeToFit];
    [_bgScorll addSubview:info3];
    

    
    hy += 40 + info3.frame.size.height;
    
    
    [self create:@"项目信息" rect:CGRectMake(ScreenWidth/2-60-30, hy, 60, 60) title:@"项目信息"];

    [self create:@"交易信息" rect:CGRectMake(ScreenWidth/2+60-30, hy, 60, 60) title:@"交易信息"];
 
    
    hy += 140;
    
    
    [self create:@"充值信息" rect:CGRectMake(ScreenWidth/2-60-70, hy, 60, 60) title:@"充值信息"];
    [self create:@"提现信息" rect:CGRectMake(ScreenWidth/2-30, hy, 60, 60) title:@"提现信息"];
    [self create:@"用户信息" rect:CGRectMake(ScreenWidth/2+70, hy, 60, 60) title:@"用户信息"];
    
    
    hy += 140;
    
    UILabel *shuju45 = [Tool LablelProductionFunction:@"电子交易数据保全证书（示例）" Frame:CGRectMake(0, hy, ScreenWidth, 20) Alignment:NSTextAlignmentCenter  FontFl:18];
    shuju45.textColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0 alpha:1.0];
    [_bgScorll addSubview:shuju45];
    
    
    hy += 30;
    
    
    UIImageView *img = [Tool ImgProductionFunctionFrame:CGRectMake((ScreenWidth-300)/2, hy, 300, 845/2) bgImgName:@"保全证书"];
    [_bgScorll addSubview:img];
    
    
    hy += 845/2;
    _bgScorll.contentSize = CGSizeMake(ScreenWidth, hy+100);
}


-(void)create:(NSString *)imgN rect:(CGRect)rect title:(NSString *)title{
 
    UIImageView *img = [Tool ImgProductionFunctionFrame:rect bgImgName:imgN];
    [_bgScorll addSubview:img];
    UILabel *shuju3 = [Tool LablelProductionFunction:title Frame:CGRectMake(-10, 70, 80, 30) Alignment:NSTextAlignmentCenter  FontFl:15];
    shuju3.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1.0];
    [img addSubview:shuju3];
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
