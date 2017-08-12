//
//  DemoViewController.m
//  手势锁
//
//  Created by chenai on 14-8-3.
//  Copyright (c) 2014年 com. All rights reserved.
//

#import "DemoViewController.h"
#import "DemoView.h"
#import "MBProgressHUD+Add.h"
#import "UserModel.h"
#import "Tool.h"

@interface DemoViewController ()<YYLockViewDelegate>

@end

@implementation DemoViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    DemoView *view  = (DemoView *)[self.view viewWithTag:1001];
    if (view!=nil) {
        [view reload];
    }
    
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

 

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.view setBackgroundColor:[UIColor blackColor]];

    //UIImageView *img = [[UIImageView alloc] initWithFrame:self.view.frame];
    //[self.view addSubview:img];
    //img.image = [UIImage imageNamed:@"ptbg.png"];
    
    [self.view setBackgroundColor:RGB(17, 101, 151)];
    
    
    DemoView *view = [[DemoView alloc] initWithFrame:CGRectMake(0,(self.view.frame.size.height-90*3)/2, self.view.frame.size.width, 90*3)];
    view.delegate = self;
    [self.view addSubview:view];
    view.tag  = 1001;
    [view setBackgroundColor:[UIColor clearColor]];
    
  
    if (self.type==0) {
        
        UILabel *la = [Tool LablelProductionFunction:@"设置手势密码" Frame:CGRectMake(0, (self.view.frame.size.height-90*3)/3-35, self.view.frame.size.width, 30) Alignment:NSTextAlignmentCenter FontFl:18];
        la.textColor = [UIColor whiteColor];
        [self.view addSubview:la];
        
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"设置手势密码图标"]];
        img.frame = CGRectMake((ScreenWidth-40)/2, (self.view.frame.size.height-90*3)/3-20+30, 40, 40);
        [self.view addSubview:img];
        
        
        UIButton *but = [Tool ButtonProductionFunction:@"手势密码将在您开启程序时启动" Frame:CGRectMake(0,self.view.frame.size.height- (iPhone4 ? 50:80),ScreenWidth,30) bgImgName:nil FontFl:12];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:but];
        //[but addTarget:self action:@selector(wangjishoushimima) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (self.type==1){
        
        UILabel *la = [Tool LablelProductionFunction:@"请确认手势密码" Frame:CGRectMake(0, (self.view.frame.size.height-90*3)/3-35, self.view.frame.size.width, 30) Alignment:NSTextAlignmentCenter FontFl:18];
        la.textColor = [UIColor whiteColor];
        [self.view addSubview:la];

        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"设置手势密码图标"]];
        img.frame = CGRectMake((ScreenWidth-40)/2, (self.view.frame.size.height-90*3)/3-20+30, 40, 40);
        [self.view addSubview:img];
        
        
        UIButton *but = [Tool ButtonProductionFunction:@"重设手势密码" Frame:CGRectMake(0,self.view.frame.size.height-(iPhone4 ? 30:80),ScreenWidth,30) bgImgName:nil FontFl:12];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:but];
        [but addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
        
        
    }else if (self.type==2){
        
        if (![self.doting isEqualToString:@"yinchang"]) {
            UserModel *user = [Tool getUser];
            UILabel *la = [Tool LablelProductionFunction:[NSString stringWithFormat:@"您好,%@",[user.name length] == 0 ? user.userId : user.name] Frame:CGRectMake(0, (self.view.frame.size.height-90*3)/3-35, self.view.frame.size.width, 30) Alignment:NSTextAlignmentCenter FontFl:18];
            la.textColor = [UIColor whiteColor];
            [self.view addSubview:la];
            UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"设置手势密码图标"]];
            img.frame = CGRectMake((ScreenWidth-40)/2, (self.view.frame.size.height-90*3)/3-20+30, 40, 40);
            [self.view addSubview:img];
            
      
            //输入的密码
            UIButton *but = [Tool ButtonProductionFunction:@"忘记手势密码" Frame:CGRectMake(20,self.view.frame.size.height-(iPhone4 ? 30:80),100,30) bgImgName:nil FontFl:12];
            [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.view addSubview:but];
            [but addTarget:self action:@selector(wangjishoushimima) forControlEvents:UIControlEventTouchUpInside];
            
            //输入的密码
            UIButton *but1 = [Tool ButtonProductionFunction:@"用其他账号登录" Frame:CGRectMake(self.view.frame.size.width-120 ,self.view.frame.size.height-(iPhone4 ? 30:80),100,30) bgImgName:nil FontFl:12];
            [but1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.view addSubview:but1];
            [but1 addTarget:self action:@selector(wangjishoushimima) forControlEvents:UIControlEventTouchUpInside];
            
            
    
        }else{
            
            
            UILabel *la = [Tool LablelProductionFunction:@"输入手势密码" Frame:CGRectMake(0, (self.view.frame.size.height-90*3)/3-35, self.view.frame.size.width, 30) Alignment:NSTextAlignmentCenter FontFl:18];
            la.textColor = [UIColor whiteColor];
            [self.view addSubview:la];
            
            UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"设置手势密码图标"]];
            img.frame = CGRectMake((ScreenWidth-40)/2, (self.view.frame.size.height-90*3)/3-20+30, 40, 40);
            [self.view addSubview:img];
            
            UIButton *but = [Tool ButtonProductionFunction:@"取消修改手势密码" Frame:CGRectMake(0,self.view.frame.size.height-(iPhone4 ? 30:80),ScreenWidth,30) bgImgName:nil FontFl:12];
            [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [but addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:but];
        }

    }
    
}
-(void)LockViewDidClick:(DemoView *)lockView andPwd:(NSString *)pwd
{
    NSLog(@"----  密码=%@",pwd);
    
    if (pwd.length<4) {
        [lockView reload];
        [MBProgressHUD showSuccess:@"手势密码太短了" toView:nil];
        return;
    }
    
    
    //设置密码
    if (self.type==0) {
        
        DemoViewController *demo = [[DemoViewController alloc] init];
        demo.title = @"确认新的密码";
        demo.code = pwd;
        demo.type = 1;
        demo.deleagete = self.deleagete;
        UIBarButtonItem*backItem=[[UIBarButtonItem alloc] init];
        backItem.title=@"返回";
        self.navigationItem.backBarButtonItem=backItem;
        [self.navigationController pushViewController:demo animated:YES];
        
        
    }else if (self.type==1){
        
        if ([self.code isEqualToString:pwd]) {
            
            //保存密码
            UserModel *user = [Tool getUser];
            user.code = pwd;
            user.codeError = @"0";
            [Tool savecoredata];
            //返回
            [MBProgressHUD showSuccess:@"设置手势密码成功" toView:nil];
            
            [self.deleagete Success:@"shezhichenggongle"];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }else{
            [lockView reload];
            [MBProgressHUD showSuccess:@"两次手势不一致" toView:nil];
            [self.deleagete Failure:self.doting];
        }
        
    }else if (self.type==2){
        
        //判断密码是否正确
        UserModel *user = [Tool getUser];
        if ([user.code isEqualToString:pwd] ) {
            
            user.codeError = @"0";
            [Tool savecoredata];

            //成功后的回调
            [self.navigationController popViewControllerAnimated:NO];
            [self.deleagete Success:self.doting];
            
        }else{
            
            int codeError = [user.codeError intValue];
            if (codeError >= 4) {
                //提示让他去登录
                
                [self.deleagete Failure:@"shoushimimacuowuchaoguo5ci"];
                
            }else{
                [lockView reload];
                [MBProgressHUD showError:[NSString stringWithFormat:@"密码错误,你还可以输入%d次",4-codeError] toView:nil];
                [self.deleagete Failure:self.doting];
            }
            
            //记录输入手势密码错误的次数
            codeError++;
            user.codeError = [NSString stringWithFormat:@"%d",codeError];
            [Tool savecoredata];
            
        } 
    }
    
}


//返回
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

//忘记了手势密码
-(void)wangjishoushimima{
    [self.deleagete Failure:@"wangjishoushimima"];
}


-(void)reset{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
