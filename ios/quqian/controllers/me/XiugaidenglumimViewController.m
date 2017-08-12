//
//  XiugaidenglumimViewController.m
//  qianbangzhu
//
//  Created by 宋培众 on 2017/7/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XiugaidenglumimViewController.h"
#import "Tool.h"
#import "HelpDownloader.h"

@interface XiugaidenglumimViewController ()
{
    UITextField *oldtextField;
    UITextField *newtextField;
    UITextField *retextField;
}
@end

@implementation XiugaidenglumimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:RGB(242, 242, 242)];
    
    
    UILabel *lab1 = [Tool LablelProductionFunction:@"原始登录密码" Frame:CGRectMake(20, 0, ScreenWidth,  40) Alignment:NSTextAlignmentLeft FontFl:15];
    [self.view addSubview:lab1];
    
    oldtextField = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(20, 40, ScreenWidth-40, 40)  FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeDefault];
    [self.view addSubview:oldtextField];
    [oldtextField setBackgroundColor:[UIColor whiteColor]];
    oldtextField.secureTextEntry = YES;
    oldtextField.placeholder = @" 输入原始密码";
    
    
    UILabel *lab2 = [Tool LablelProductionFunction:@"新登录密码" Frame:CGRectMake(20, 80+20, ScreenWidth,  40) Alignment:NSTextAlignmentLeft FontFl:15];
    [self.view addSubview:lab2];
    
    newtextField = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(20, 140, ScreenWidth-40, 40)  FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeDefault];
    [self.view addSubview:newtextField];
    [newtextField setBackgroundColor:[UIColor whiteColor]];
    newtextField.secureTextEntry = YES;
    newtextField.placeholder = @" 输入新登录密码";
        
    
   //UILabel *lab3 = [Tool LablelProductionFunction:@"原始登录密码" Frame:CGRectMake(20, 180, ScreenWidth,  40) Alignment:NSTextAlignmentLeft FontFl:15];
    //[self.view addSubview:lab3];
    
    retextField = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectMake(20, 220, ScreenWidth-40, 40)  FontFl:14 backgroundImg:nil UIKeyboardType:UIKeyboardTypeDefault];
    [self.view addSubview:retextField];
    [retextField setBackgroundColor:[UIColor whiteColor]];
    retextField.secureTextEntry = YES;
    retextField.placeholder = @" 确认新登录密码";

    
    
    UIButton *butong = [Tool ButtonProductionFunction:@"确认修改" Frame:CGRectMake(20, 280, ScreenWidth-40, 40) bgImgName:nil FontFl:15];
    [butong setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [butong addTarget:self action:@selector(ok) forControlEvents:UIControlEventTouchUpInside];
    [butong setBackgroundColor:KTHCOLOR];
    [self.view addSubview:butong];
}

-(void)ok{
    
    
    
    if (oldtextField.text.length==0) {
        [Tool myalter:@"请输入原密码"];
        return;
    }
    if (newtextField.text.length==0) {
        [Tool myalter:@"请输入新密码"];
        return;
    }
    if (retextField.text.length==0) {
        [Tool myalter:@"请输入确认密码"];
        return;
    }
    
    
    if ([newtextField.text length] < 6 || [newtextField.text length] > 16) {
        [Tool myalter:@"密码长度为6-16个字符"];
        return;
    }
    if (![newtextField.text isEqualToString:newtextField.text]) {
        [Tool myalter:@"你两次输入的密码不一致"];
        return;
    }

    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/xgmmSet.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:oldtextField.text forKey:@"old"];
    [postDic setObject:newtextField.text forKey:@"new"];
    [postDic setObject:newtextField.text forKey:@"news"];
    
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
                                       if ([dic[@"code"] isEqualToString:@"0"]) {
                                        [Tool myalters:@"修改成功"];
                                           [self.navigationController popViewControllerAnimated:YES];
                                       }else{
                                           [Tool myalter:dic[@"msg"]];
                                       }
                                   }
                               }];
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
