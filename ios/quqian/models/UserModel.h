//
//  UserModel.h
//  quqian
//
//  Created by apple on 15/3/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserModel : NSManagedObject

@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * code;//手势密码
@property (nonatomic, retain) NSString * userKey;
@property (nonatomic, retain) NSString * isEnable;

@property (nonatomic, retain) NSString * keyong_money;//可用余额
@property (nonatomic, retain) NSString * zhuanqu_money;//已赚总额
@property (nonatomic, retain) NSString * zhze;//账户总额
@property (nonatomic,retain) NSString *tyjze;//体验金额总额

@property(nonatomic,retain)NSString *sjsfsz;//手机是否设置
@property(nonatomic,retain)NSString *sfzsfrz;//身份证是否设置
@property(nonatomic,retain)NSString *txmmsfsz;//提现密码是否设置
@property(nonatomic,retain)NSString *yjsfsz;//邮箱否设置

@property(nonatomic,retain)NSString *wdfwm;//我的服务码


@property (nonatomic, retain) NSString * tikuanCode;//提现密码
@property (nonatomic, retain) NSString * trueName;//真实名字
@property (nonatomic, retain) NSString * mobile;//手机号


@property(nonatomic,retain) NSString *birthDay;//生日
@property(nonatomic,retain) NSString *gender;//性别
@property(nonatomic,retain) NSString *nickName;//昵称

@property(nonatomic,retain) NSString *djje;//冻结金额

@property (nonatomic, retain) NSString * cardNum;//身份证

@property (nonatomic,retain) NSString *tongzhiweidu;//通知未读

@property (nonatomic,retain) NSString *codeError;//手势密码错误次数

@property(nonatomic,retain)NSString *fwmlj;

@property(nonatomic,retain)NSString *sfzh; //身份证
@property(nonatomic,retain)NSString *xm;//姓名
@property(nonatomic,retain)NSString *znxwdts;//站内信
@property(nonatomic,retain)NSString *cgkyye;//存管账户可用余额
@property(nonatomic,retain)NSString *cgdjje;//存管账户冻结金额
@property(nonatomic,retain)NSString *cgyzze;//存管账户已赚总额
@property(nonatomic,retain)NSString *cgzhze;//存管账户总额

@property(nonatomic,retain)NSString *iscloseshoushimia;//是否关闭手势密码


-(NSString *)new_cardNum;
-(NSString *)new_mobile;
-(NSString *)new_trueName;


//组装数据
-(void)makeInData:(NSMutableDictionary *)dic;



@end
