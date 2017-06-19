//
//  InputGeneralViewController.m
//  wqkj
//
//  Created by Chenjhao on 1/26/14.
//  Copyright (c) 2014 WANGGUANXIAO. All rights reserved.
//

#import "InputGeneralViewController.h"
#import "Tool.h"

@interface InputGeneralViewController ()

@end

@implementation InputGeneralViewController

@synthesize tag;
@synthesize delegate;
@synthesize lines;//行数
@synthesize text;//内容
@synthesize titleName;//标题
@synthesize explain;//内容说明
@synthesize keyBorad;
@synthesize allCount;//字数限制--默认是160
@synthesize warning;//警告


//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:YES];
//    UIColor *kTitleBarColor = [UIColor colorWithRed:221/255.0 green:56/255.0 blue:108/255.0 alpha:1];
//    if([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
//        [self.navigationController.navigationBar setValue:kTitleBarColor forKey:@"barTintColor"];
//    } else {
//        self.navigationController.navigationBar.tintColor = kTitleBarColor;
//    }
//    self.navigationController.navigationBar.titleTextAttributes = [NSMutableDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:21],UITextAttributeFont, [UIColor whiteColor],UITextAttributeTextColor,nil];
//}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)backNavigationItemTouch{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)rightNavigationItemTouch{
    //取消空格和换行
    ntextView.text = [ntextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //键盘下去
    [ntextView resignFirstResponder];
    
    
    
    //特殊的处理
    if([titleName isEqualToString:@"邮箱"]){
        if (![Tool isValidateEmail:ntextView.text]) {
            return;
        }
    }else if([titleName isEqualToString:@"手机"]){
        if (![Tool isMobilePhone:ntextView.text]) {
            return;
        }
    }else if ([titleName isEqualToString:@"微信"]) {
        NSInteger length = [ntextView.text length];
        for (int i=0; i<length; ++i)
        {
            NSRange range = NSMakeRange(i, 1);
            NSString *subString = [ntextView.text substringWithRange:range];
            const char *cString = [subString UTF8String];
            if (strlen(cString) == 3)
            {
                [Tool myalter:@"微信号只能是字母、数字"];
                return;
            }
        }
    }
    
    
    
    
    
    //字符截取
    if (ntextView.text.length>allCount) {
        ///ntextView.text = [ntextView.text substringToIndex:allCount];
        
        [Tool myalter:@"你输入的信息过长"];
        return;
    }
    
    
    [delegate saveMessage:ntextView.text withTag:self.tag];
    
    [self backNavigationItemTouch];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
 
    self.title = titleName;
    
    //导航返回按钮
    UIBarButtonItem *leftB = [[UIBarButtonItem alloc] initWithTitle:@" 取消" style:UIBarButtonItemStylePlain target:self action:@selector(backNavigationItemTouch)];
    self.navigationItem.leftBarButtonItem = leftB;

    
    if ([self.titleName isEqualToString:@"意见反馈"]) {
        UIBarButtonItem *leftA = [[UIBarButtonItem alloc] initWithTitle:@"提交 " style:UIBarButtonItemStylePlain target:self action:@selector(rightNavigationItemTouch)];
        self.navigationItem.rightBarButtonItem = leftA;
    }else{
        UIBarButtonItem *leftA = [[UIBarButtonItem alloc] initWithTitle:@"确认 " style:UIBarButtonItemStylePlain target:self action:@selector(rightNavigationItemTouch)];
        self.navigationItem.rightBarButtonItem = leftA;
    }
    
    
    int y = 10+64;
    //警告处理
    if ([self.warning length]!=0) {
        y+=20;
        UILabel *warningLab = [Tool LablelProductionFunction:self.warning Frame:CGRectMake(10, 68, 300, 20) Alignment:NSTextAlignmentCenter FontFl:12];
        warningLab.textColor = [UIColor redColor];
        [self.view addSubview:warningLab];
    }
    
    if (lines==0) {
        lines = 1;
    }
    if (allCount==0) {
        allCount=160;
    } 
    ntextView = [[UITextView alloc] initWithFrame:CGRectMake(10, y, 300, 30*lines)];
    [ntextView setBackgroundColor:[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:239.0/255.0 alpha:1.0]];
    [self.view addSubview:ntextView];
    //[textView becomeFirstResponder];
    if (keyBorad==0) {
        ntextView.keyboardType = UIKeyboardTypeDefault;
    }else{
        ntextView.keyboardType = keyBorad;
    }
    ntextView.text = self.text;
    
  
    //详细信息说明
    if ([self.explain length] != 0) {
        UILabel *explainLab = [Tool LablelProductionFunction:self.explain Frame:CGRectMake(10, ntextView.frame.origin.y+ntextView.frame.size.height, 300, 30) Alignment:NSTextAlignmentLeft FontFl:12];
        explainLab.textColor = [UIColor  grayColor];
        [self.view addSubview:explainLab];
    }
     
    //判断联系地址定位信息---特殊的处理
    if ([self.titleName isEqualToString:@"联系地址"]) {
        [self contactAddressSpecialTreatment:ntextView.frame.origin.y+ntextView.frame.size.height];
    }
    
    ntextView = [[UITextView alloc] initWithFrame:CGRectMake(10, y, 300, 30*lines)];
    [ntextView setBackgroundColor:[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:239.0/255.0 alpha:1.0]];
    [self.view addSubview:ntextView];
    ntextView.delegate = self;
    [ntextView becomeFirstResponder];
    if (keyBorad==0) {
        ntextView.keyboardType = UIKeyboardTypeDefault;
    }else{
        ntextView.keyboardType = keyBorad;
    }
    ntextView.text = self.text;
    
    if (allCount==0) {
        allCount = 50;
    }
    
    
}

//电话

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([titleName isEqualToString:@"电话"]) {
        return [self panduanshudianhua:text];
    }
    return YES;
}


//判断
-(BOOL)panduanshudianhua:(NSString *)string{
    if ([string isEqualToString:@""]) {
        return YES;
    }
    NSString *ss = @"0,1,2,3,4,5,6,7,8,9,-";
    NSArray *ssArray = [ss componentsSeparatedByString:@","];
    for (int i = 0; i < [ssArray count]; i++) {
        if ([[ssArray objectAtIndex:i] isEqualToString:string]) {
            return YES;
        }
    }
    return NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//联系地址的特殊的处理----添加自己定位信息
-(void)contactAddressSpecialTreatment:(int)y{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, y+10, 60, 30);
    //[self.view addSubview:button];
    [button setTitle:@"开始定位" forState:UIControlStateNormal];
}
 
@end
