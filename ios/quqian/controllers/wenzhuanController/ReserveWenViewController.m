//
//  ReserveWenViewController.m
//  quqian
//
//  Created by apple on 15/3/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ReserveWenViewController.h"
#import "RCLabel.h"
#import "Tool.h"


@interface ReserveWenViewController ()

@end

@implementation ReserveWenViewController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    return self = [super initWithStyle:UITableViewStyleGrouped];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==2) {
        return 30;
    }
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }else if (section==1){
        return 1;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}



 


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==2) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    
        RCLabel *rcLab = [[RCLabel alloc] initWithFrame:CGRectMake(13, 0, 250, 45)];
        [bgView addSubview:rcLab];
        rcLab.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=left><font size=15>应付定金：</font><font size=15 color='#EA9500'>%@</font><font size=15>元</font></p>",@"100,000.00"]];
        
        return  bgView;
    }else{
        return nil;
    }
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
    
    
    UILabel *lab123 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(16.5, 0, [Tool adaptation:200 with6:55 with6p:94], 45) Alignment:NSTextAlignmentLeft  FontFl:15];
    lab123.font = FOUR_CONTROL_FONT;
    [cell.contentView addSubview:lab123];
    
    //右边
    RCLabel *rcLab = [[RCLabel alloc] initWithFrame:CGRectMake(50, 15, 250, 20)];
    [cell.contentView addSubview:rcLab];
    
    
    if (section==0) {
        
        if (row==0) {
            lab123.text = @"剩余金额";
            rcLab.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=right><font size=15 color='#EA9500'>%@</font><font size=15>元</font></p>",@"100,000.00"]];
        }else if (row==1){
            lab123.text = @"可用金额";
            rcLab.componentsAndPlainText = [RCLabel extractTextStyle:[NSString stringWithFormat:@"<p align=right><font size=15 color='#EA9500'>%@</font><font size=15>元</font></p>",@"10,000.00"]];
        }
        
    }else if (section==1) {
        
        lab123.text = @"购买金额";
   
        //输入框
        UITextField *textField = [Tool TextFiledProductionFunction:@"" Delegate:self Frame:CGRectZero FontFl:15 backgroundImg:nil UIKeyboardType:UIKeyboardTypeNumberPad];
        [cell.contentView addSubview:textField];
        textField.frame = CGRectMake(100,0, [Tool adaptation:150 with6:55 with6p:94], 45);
        textField.tag = 100;
        textField.textAlignment = NSTextAlignmentCenter;
        textField.placeholder = @"请输入购买金额";
        
        
    }else if (section==2) {
        
        lab123.text = @"立即预定";
        lab123.frame = CGRectMake(0, 0, [Tool adaptation:320 with6:55 with6p:94], 45);
        lab123.textAlignment = NSTextAlignmentCenter;
        lab123.textColor = [UIColor whiteColor];
        [lab123 setBackgroundColor:[UIColor colorWithRed:2/255.0 green:160/255.0 blue:219/255.0 alpha:1]];
        
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    
    
}





@end
