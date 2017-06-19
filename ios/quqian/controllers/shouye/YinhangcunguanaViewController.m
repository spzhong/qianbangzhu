//
//  YinhangcunguanaViewController.m
//  quqian
//
//  Created by 宋培众 on 2017/6/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YinhangcunguanaViewController.h"
#import "Tool.h"


@interface YinhangcunguanaViewController ()

@end

@implementation YinhangcunguanaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGFloat hy = 30;
    UILabel *shuju = [Tool LablelProductionFunction:@"什么是银行资金存管？" Frame:CGRectMake(0, hy, ScreenWidth, 20) Alignment:NSTextAlignmentCenter  FontFl:18];
    shuju.textColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0 alpha:1.0];
    [_bgscroll addSubview:shuju];
    
    
    hy += 40;
    
    UILabel *info = [Tool LablelProductionFunction:@"银行资金存管，是指投资人、借款人在华兴银行开通实名电子银行账户（即E账户），用户投资和还款均通过银行账户资金划拨完成，钱帮主平台仅进行信息撮合，全程不触碰任何资金。上线资金存管，意味着钱帮主与华兴银行系统对接，确保平台自有资金账户和客户资金账户分离，平台投资人均可通过华兴银行存管系统开设独立的存管账户。用户的充值、投资、提现与划拨等交易类操作，均通过独立存管账户完成，能有效避免网贷平台非法挪用投资人资金，提供银行级别的资金安全保障。根据银监会最新发布的《网络借贷信息中介机构业务活动管理暂行办法》第二十八条，网络借贷信息中介机构应当实行自身资金与出借人和借款人资金的隔离管理，并选择符合条件的银行业金融机构作为出借人与借款人的资金存管机构。" Frame:CGRectMake(15, hy, ScreenWidth-30, 999) Alignment:NSTextAlignmentCenter  FontFl:15];
    info.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1.0];
    info.numberOfLines = 0;
    [info sizeToFit];
    [_bgscroll addSubview:info];
    
    
    hy += info.frame.size.height + 60;
    
    
    
    UILabel *shuju1 = [Tool LablelProductionFunction:@"为什么选择华兴银行进行资金存管？" Frame:CGRectMake(0, hy, ScreenWidth, 20) Alignment:NSTextAlignmentCenter  FontFl:18];
    shuju1.textColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0 alpha:1.0];
    [_bgscroll addSubview:shuju1];
    
    
    hy += 40;
    
    UILabel *info2 = [Tool LablelProductionFunction:@"广东华兴银行是经国务院有关部委批准，于2011年8月依法创新设立的一家混合所有制商业银行，注册资本50亿元，注册地位于汕头经济特区，运营总部设在广州市。\n\n广东华兴银行作为较早上线网贷平台客户资金存管系统的银行，在资金存管、风险把控等方面拥有先进的技术和丰富的经验" Frame:CGRectMake(15, hy, ScreenWidth-30, 999) Alignment:NSTextAlignmentCenter  FontFl:15];
    info2.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1.0];
    info2.numberOfLines = 0;
    [info2 sizeToFit];
    [_bgscroll addSubview:info2];
    
    hy += info2.frame.size.height + 60;
    
    
    
    
    UILabel *shuju3 = [Tool LablelProductionFunction:@"银行存管如何保障资金安全？" Frame:CGRectMake(0, hy, ScreenWidth, 20) Alignment:NSTextAlignmentCenter  FontFl:18];
    shuju3.textColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0 alpha:1.0];
    [_bgscroll addSubview:shuju3];
    
    
    hy += 40;
    
    UILabel *info3 = [Tool LablelProductionFunction:@"用户操作投资的交易信息和资金则在华兴银行系统体现，平台不直接经手客户所有资金，也无权动用客户在银行存管系统的资金。华兴银行会对交易流程进行核查，使借贷双方的债权关系清晰明确，保障您资金安全。" Frame:CGRectMake(15, hy, ScreenWidth-30, 999) Alignment:NSTextAlignmentCenter  FontFl:15];
    info3.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1.0];
    info3.numberOfLines = 0;
    [info3 sizeToFit];
    [_bgscroll addSubview:info3];
    
    hy += info3.frame.size.height + 60;
    
    
    
    UIImageView *ims =  [Tool ImgProductionFunctionFrame:CGRectMake((ScreenWidth-686/2)/2, hy, 686/2, 170) bgImgName:@"银行存管安全模式"];
    [_bgscroll addSubview:ims];
    
    
    
    hy += 170 + 40;
  
    
    UILabel *shuju4 = [Tool LablelProductionFunction:@"银行存管常见问题" Frame:CGRectMake(0, hy, ScreenWidth, 20) Alignment:NSTextAlignmentCenter  FontFl:18];
    shuju4.textColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0 alpha:1.0];
    [_bgscroll addSubview:shuju4];
    
    
    hy += 40;
    
    UILabel *info4 = [Tool LablelProductionFunction:@"1.银行存管平台如何充值？\n方法一：通过E账户充值（实时到账）（需先通过本人银行卡转账至您的华兴银行E账户中，然后进行充值） 官方推荐方法\n方法二：通过已绑定的银行卡充值（T+1工作日到账）\n2.账户资金安全如何保证？\n所有账户均需经要实名认证。华兴银行存管系统采用“同卡进出”原则，即您在该账户内的资金只能提现至您绑定的银行卡中，只有“账户余额”与“待收金额”同时为“0”时，才能更换绑定银行卡，因此，即便您的账户及提现密码同时被不法分子窃取，也无法动用您的资金。\n3.银行存管上线后 提现会有什么影响？\n新注册用户需下载广东华兴银行“投融资平台”APP登录华兴银行E账户进行个人实名信息认证后方可进行提现。" Frame:CGRectMake(15, hy, ScreenWidth-30, 999) Alignment:NSTextAlignmentCenter  FontFl:15];
    info4.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1.0];
    info4.numberOfLines = 0;
    [info4 sizeToFit];
    [_bgscroll addSubview:info4];
    
    hy += info4.frame.size.height;
    
    
    
    _bgscroll.contentSize = CGSizeMake(ScreenWidth, hy+100);
    
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
