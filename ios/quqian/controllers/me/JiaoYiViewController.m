//
//  JiaoYiViewController.m
//  quqian
//
//  Created by apple on 15/3/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "JiaoYiViewController.h"
#import "LXActionSheet.h"
#import "DropDownListView.h"
#import "DropDownChooseProtocol.h"
#import "Tool.h"
#import "HelpDownloader.h"



@interface JiaoYiViewController ()<DropDownChooseDelegate,DropDownChooseDataSource>
{
    NSMutableArray *chooseArray;
    NSMutableArray *vlaueArray;
    DropDownListView * dropDownView;
    NSMutableArray *dataArray;
    
    int oneTag;
    int twoTag;
}
@end

@implementation JiaoYiViewController


- (instancetype)initWithStyle:(UITableViewStyle)style{
    return self = [super initWithStyle:UITableViewStyleGrouped];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [dropDownView hideExtendedChooseView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    dataArray = [[NSMutableArray alloc] init];
    
    chooseArray = [[NSMutableArray alloc] init];
    
    vlaueArray = [[NSMutableArray alloc] init];
    
    oneTag = -1;
    twoTag = 0;
    [self jiaoyitype__startRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIView *)headView{
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    [bg setBackgroundColor:[UIColor whiteColor]];
    
    
    dropDownView  = [[DropDownListView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 45) dataSource:self delegate:self];
    dropDownView.mSuperView = [Tool getDele].window;
    [bg addSubview:dropDownView];
   
    return bg;
}


#pragma mark -- dropDownListDelegate
-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index
{
    //NSLog(@"童大爷选了section:%d ,index:%d",section,index);
    if (section==0) {
        oneTag = index;
    }else if (section==1){
        twoTag = index;
    }
    
    [self jiaoyitypeinfo__startRequest];
}

#pragma mark -- dropdownList DataSource
-(NSInteger)numberOfSections
{
    return [chooseArray count];
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSArray *arry =chooseArray[section];
    return [arry count];
}
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index
{
    return chooseArray[section][index];
}
-(NSInteger)defaultShowSection:(NSInteger)section
{
    return 0;
}



#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .5;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count+1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
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
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    NSArray *viewArray = [cell.contentView subviews];
    for (int i = 0; i < [viewArray count]; i++) {
        UIView *view = [viewArray objectAtIndex:i];
        [view removeFromSuperview];view=nil;
    }
    
    
    UILabel *lab1 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(15, 0, [Tool adaptation:100 with6:55 with6p:94], 55) Alignment:NSTextAlignmentLeft  FontFl:14];
    UILabel *lab2 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(0, 0, [Tool adaptation:320 with6:55 with6p:94], 55) Alignment:NSTextAlignmentCenter  FontFl:14];
    UILabel *lab3 = [Tool LablelProductionFunction:@"" Frame:CGRectMake(235, 0, [Tool adaptation:80 with6:55 with6p:94], 55) Alignment:NSTextAlignmentLeft  FontFl:14];
    
    [lab3 setTextColor:[UIColor darkGrayColor]];
    [cell.contentView addSubview:lab1];
    [cell.contentView addSubview:lab2];
    [cell.contentView addSubview:lab3];
    
    
    if (row==0) {
        
        lab1.text = @"交易类型";
        lab1.textColor = [UIColor darkGrayColor];
        
        lab2.text = @"交易金额(元)";
        lab2.textColor = [UIColor darkGrayColor];
        
        lab3.text = @"时间";
        lab3.textColor = [UIColor darkGrayColor];
        
    }else{
        
        NSMutableDictionary *dic = [dataArray objectAtIndex:row-1];
        
        lab1.text = [dic objectForKey:@"jylx"];
        lab2.text = [dic objectForKey:@"jyje"];
        
        lab2.frame = CGRectMake(120, 0, [Tool adaptation:100 with6:55 with6p:94], 55);
        lab2.textAlignment = NSTextAlignmentLeft;
        
        lab2.textColor = [UIColor colorWithRed:234/255.0 green:149/255.0 blue:0 alpha:1.0];
        lab3.text = [dic objectForKey:@"jysj"];
        
        lab3.numberOfLines = 2;// 不可少Label属性之一
        lab3.lineBreakMode = NSLineBreakByCharWrapping;
        
    }

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}






//交易类型
-(void)jiaoyitype__startRequest{
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/user/jyjl/parameters.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"yes",@"isshowHUD",
                                           @"no",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   
                                   if (kk==0) {
                                       
                                       
                                       NSMutableDictionary *dic =  [data JSONValue];
                                       NSArray *array = [dic objectForKey:@"rvalue"];
                                       
                                       NSString *SS = [Tool toString:[dic objectForKey:@"rvalue"]];
                                       
                                       if ([SS isEqualToString:@"<null>"]) {
                                           return;
                                       }
                                       
                                       
                                       
                                       if ([array count]!=2) {
                                           return;
                                       }
                                       NSMutableDictionary *dic1 = [array objectAtIndex:0];
                                       NSMutableDictionary *dic2 = [array objectAtIndex:1];
                                       
                                       
                                       //array1
                                       NSMutableArray *array1 = [[NSMutableArray alloc] init];
                                       [array1 addObject:@"交易类型"];
                                       NSMutableArray *valuearray1 = [[NSMutableArray alloc] init];
                                       [valuearray1 addObject:[NSMutableDictionary dictionary]];
                                       
                                       for (NSMutableDictionary *dic11 in [dic1 objectForKey:@"type"]) {
                                           [array1 addObject:[dic11 objectForKey:@"value"]];
                                           [valuearray1 addObject:dic11];
                                       }
                                       //array2
                                       NSMutableArray *array2 = [[NSMutableArray alloc] init];
                                       NSMutableArray *valuearray2 = [[NSMutableArray alloc] init];
                                       for (NSMutableDictionary *dic22 in [dic2 objectForKey:@"type"]) {
                                           [array2 addObject:[dic22 objectForKey:@"value"]];
                                           [valuearray2 addObject:dic22];
                                       }
                                       [chooseArray addObject:array1];
                                       [chooseArray addObject:array2];
                                       
                                       [vlaueArray addObject:valuearray1];
                                       [vlaueArray addObject:valuearray2];
                                       
                                       
                                       self.tableView.tableHeaderView = [self headView];
                                       oneTag = 0;
                                       //获取交易类型的内容
                                       [self jiaoyitypeinfo__startRequest];
                                   }
                                   
                               }];
    
}




//交易内容
-(void)jiaoyitypeinfo__startRequest{
    
    //进行有效登录确认
    NSString *url =[NSString stringWithFormat:@"%@/user/jyjl/list.htm",BASE_URL];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    //特殊判断
    if ([chooseArray count]!=2) {
        return;
    }
   
    if (oneTag==-1 || oneTag==0) {
        NSMutableDictionary *jysj = [[vlaueArray objectAtIndex:1] objectAtIndex:twoTag];
        [postDic setObject:@"" forKey:@"jylx"];//交易类型
        [postDic setObject:[jysj objectForKey:@"key"] forKey:@"jysj"];//交易时间
    }else{
        NSMutableDictionary *jylx = [[vlaueArray objectAtIndex:0] objectAtIndex:oneTag];
        NSMutableDictionary *jysj = [[vlaueArray objectAtIndex:1] objectAtIndex:twoTag];
        
        [postDic setObject:[jylx objectForKey:@"key"] forKey:@"jylx"];//交易类型
        [postDic setObject:[jysj objectForKey:@"key"] forKey:@"jysj"];//交易时间
    }
    
    
    
    [[HelpDownloader shared] startRequest:url withbody:postDic
                                   isType:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"yes",@"isConnectedToNetwork",
                                           @"yes",@"isshowHUD",
                                           @"no",@"islockscreen",
                                           @"post",@"isrequesType",
                                           nil]
                               completion:^void(id data,int kk){
                                   
                                   if (kk==0) {
                                    
                                       NSMutableDictionary *dic =  [data JSONValue];
                                       NSString *SS = [Tool toString:[dic objectForKey:@"rvalue"]];
                                       if ([SS isEqualToString:@"<null>"]) {
                                           [dataArray removeAllObjects];
                                           [self.tableView reloadData];
                                           return;
                                       }
                                       NSArray *array = [dic objectForKey:@"rvalue"];
                                       
                                       [dataArray removeAllObjects];
                                       [dataArray addObjectsFromArray:array];
                                       [self.tableView reloadData];
                                       
                                   }else{
                                       
                                   }
                                   
                               }];
    
}




@end
