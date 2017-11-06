//
//  YaoqinghaoyuViewController.m
//  qianbangzhu
//
//  Created by 宋培众 on 2017/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YaoqinghaoyuViewController.h"
#import "Tool.h"
#import "UserModel.h"
#import "UtilityUI.h"
#import "EGOImageView.h"
#import "HelpDownloader.h"

@interface YaoqinghaoyuViewController ()
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

@implementation YaoqinghaoyuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 
    
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/user/tggl/wytg.htm",BASE_URL];
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
    
    float allH = 10;
    [self creatViewOne:@"方式一" withName:@" 二维码邀请" withValue:@"http" with:245 withy:allH];
    allH+=255;
    [self creatViewOne:@"方式二" withName:@" 服务码邀请" withValue:@"fwm" with:150 withy:allH];
    
    allH+=160;
    [self creatViewOne:@"方式三" withName:@" 服务码邀请" withValue:@"" with:150 withy:allH];
    
    
    [self.bgscorll setContentSize:CGSizeMake(ScreenWidth, allH+30+150)];
    return;
    
    
    
    UIView *bg1 = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 50+140)];
    [bg1 setBackgroundColor:[UIColor whiteColor]];
    [self.bgscorll addSubview:bg1];
    
    UILabel *lab1 = [Tool LablelProductionFunction:@"方式一" Frame:CGRectMake(-70+ScreenWidth/2, allH-5, 60, 25) Alignment:NSTextAlignmentCenter FontFl:13];
    [self.bgscorll addSubview:lab1];
    [UtilityUI setBorderOnView:lab1 borderColor:RGB(253, 153, 0) borderWidth:1 cornerRadius:3];
    [lab1 setTextColor:RGB(253, 153, 0)];
    
    UILabel *lab2 = [Tool LablelProductionFunction:@"二维码邀请" Frame:CGRectMake(10+ScreenWidth/2, allH, 100, 15) Alignment:NSTextAlignmentLeft FontFl:15];
    [self.bgscorll addSubview:lab2];
    lab2.textColor = RGB(51, 51, 51);
    
    EGOImageView*imgView =[[EGOImageView alloc] init];
    imgView.frame = CGRectMake((ScreenWidth-180)/2, 60, 180, 180);
    imgView.imageURL = [NSURL URLWithString:alldic[@"ewm"]];
    [self.bgscorll addSubview:imgView];
    
    allH += 170;
    
    UIView *bg2 = [[UIView alloc] initWithFrame:CGRectMake(0, allH, ScreenWidth, 50+80)];
    [bg2 setBackgroundColor:[UIColor whiteColor]];
    [self.bgscorll addSubview:bg2];
    
    allH+=15;
    
    UILabel *lab21 = [Tool LablelProductionFunction:@"方式二" Frame:CGRectMake(-70+ScreenWidth/2, allH-5, 60, 25) Alignment:NSTextAlignmentCenter FontFl:13];
    [self.bgscorll addSubview:lab21];
    [UtilityUI setBorderOnView:lab21 borderColor:RGB(253, 153, 0) borderWidth:1 cornerRadius:3];
    [lab21 setTextColor:RGB(253, 153, 0)];
    
    UILabel *lab22 = [Tool LablelProductionFunction:@"服务码邀请" Frame:CGRectMake(10+ScreenWidth/2, allH, 100, 15) Alignment:NSTextAlignmentLeft FontFl:15];
    [self.bgscorll addSubview:lab22];
    lab22.textColor = RGB(51, 51, 51);

    allH+=35;
    
    UILabel *lab23 = [Tool LablelProductionFunction:alldic[@"fwm"] Frame:CGRectMake(0, allH, ScreenWidth, 35) Alignment:NSTextAlignmentCenter FontFl:30];
    [self.bgscorll addSubview:lab23];
    
    allH+=60;
    
    UILabel *lab24 = [Tool LablelProductionFunction:@"邀请好友注册时填写该服务码" Frame:CGRectMake(0, allH, ScreenWidth, 12) Alignment:NSTextAlignmentCenter FontFl:12];
    [self.bgscorll addSubview:lab24];
    
    
    allH+=30;
    
    UIView *bg3 = [[UIView alloc] initWithFrame:CGRectMake(0, allH, ScreenWidth, 50+40)];
    [bg3 setBackgroundColor:[UIColor whiteColor]];
    [self.bgscorll addSubview:bg3];
    
    allH+=10;
    
    UILabel *lab31 = [Tool LablelProductionFunction:@"方式三" Frame:CGRectMake(-70+ScreenWidth/2, allH-5, 60, 25) Alignment:NSTextAlignmentCenter FontFl:13];
    [self.bgscorll addSubview:lab31];
    [UtilityUI setBorderOnView:lab31 borderColor:RGB(253, 153, 0) borderWidth:1 cornerRadius:3];
    [lab31 setTextColor:RGB(253, 153, 0)];
    
    UILabel *lab32 = [Tool LablelProductionFunction:@"链接邀请" Frame:CGRectMake(10+ScreenWidth/2, allH, 100, 15) Alignment:NSTextAlignmentLeft FontFl:15];
    [self.bgscorll addSubview:lab32];
    lab32.textColor = RGB(51, 51, 51);
    
    allH+=30;

    
    UITextView *lab33 = [Tool TextViewProductionFunction:alldic[@"url"] Frame:CGRectMake(0, allH, ScreenWidth, 45) FontFl:15];
    [self.bgscorll addSubview:lab33];
    [lab33 setTextAlignment:NSTextAlignmentCenter];
    
    
    [self.bgscorll setContentSize:CGSizeMake(ScreenWidth, allH+30)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)creatViewOne:(NSString *)title withName:(NSString *)name withValue:(NSString *)value with:(CGFloat)allH withy:(CGFloat)y{
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, y, ScreenWidth,allH)];
    [bg setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lab1 = [Tool LablelProductionFunction:title Frame:CGRectMake(-75+ScreenWidth/2, 20, 60, 25) Alignment:NSTextAlignmentCenter FontFl:13];
    [bg addSubview:lab1];
    [UtilityUI setBorderOnView:lab1 borderColor:RGB(253, 153, 0) borderWidth:1 cornerRadius:3];
    [lab1 setTextColor:RGB(253, 153, 0)];
    
    UILabel *lab2 = [Tool LablelProductionFunction:name Frame:CGRectMake(10+ScreenWidth/2, 20, 100, 25) Alignment:NSTextAlignmentLeft FontFl:15];
    [bg addSubview:lab2];
    lab2.textColor = RGB(51, 51, 51);
    
    if ([value hasPrefix:@"http"]) {
        EGOImageView*imgView =[[EGOImageView alloc] init];
        imgView.frame = CGRectMake(5+(ScreenWidth-200)/2, 45, 200, 200);
        imgView.imageURL = [NSURL URLWithString:alldic[@"ewm"]];
        [bg addSubview:imgView];
    }else if ([value hasPrefix:@"fwm"]) {
        UILabel *lab23 = [Tool LablelProductionFunction:alldic[@"fwm"] Frame:CGRectMake(0, 55, ScreenWidth, 60) Alignment:NSTextAlignmentCenter FontFl:30];
        [bg addSubview:lab23];
        lab23.textColor = KTHCOLOR;
        
        UILabel *lab32 = [Tool LablelProductionFunction:@"邀请好友注册时填写该服务码" Frame:CGRectMake(0, 120, ScreenWidth, 15) Alignment:NSTextAlignmentCenter FontFl:12];
        [bg addSubview:lab32];
        lab32.textColor = RGB(151, 151, 151);

    }else {
        UILabel *lab23 = [Tool LablelProductionFunction:alldic[@"url"] Frame:CGRectMake(0, 55, ScreenWidth, 60) Alignment:NSTextAlignmentCenter FontFl:12];
        [bg addSubview:lab23];
        lab23.textColor = RGB(151, 151, 151);
        
        UILabel *lab32 = [Tool LablelProductionFunction:@"复制该链接发送给朋友" Frame:CGRectMake(0, 120, ScreenWidth, 15) Alignment:NSTextAlignmentCenter FontFl:12];
        [bg addSubview:lab32];
        lab32.textColor = RGB(151, 151, 151);
        
    }
    
    
    
    
    [self.bgscorll addSubview:bg];
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
