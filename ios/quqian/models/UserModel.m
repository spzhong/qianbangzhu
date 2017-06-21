//
//  UserModel.m
//  quqian
//
//  Created by apple on 15/3/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UserModel.h"
#import "Tool.h"


@implementation UserModel

@dynamic userId;
@dynamic name;
@dynamic code;
@dynamic userKey;
@dynamic isEnable;

@dynamic keyong_money;//可用余额
@dynamic zhuanqu_money;//已赚总额

@dynamic tikuanCode;//提现密码
@dynamic trueName;//真实名字
@dynamic mobile;//手机号
@dynamic cardNum;//身份证

@dynamic birthDay;//生日
@dynamic gender;//性别
@dynamic nickName;//昵称

@dynamic djje;//冻结金额

@dynamic codeError;

@dynamic zhze;//账户总额
@dynamic tyjze;//体验金总额
@dynamic sjsfsz;//手机是否设置
@dynamic sfzsfrz;//身份证是否设置
@dynamic txmmsfsz;//提现密码是否设置
@dynamic yjsfsz;//邮箱否设置
@dynamic wdfwm;//我的服务码

@dynamic tongzhiweidu;

@dynamic fwmlj;


@dynamic sfzh; //身份证
@dynamic xm;//姓名
@dynamic znxwdts;//站内信
@dynamic cgkyye;//存管账户可用余额
@dynamic cgdjje;//存管账户冻结金额
@dynamic cgyzze;//存管账户已赚总额
@dynamic cgzhze;//存管账户总额
 


- (instancetype)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context{
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    
//    self.name = @"";
//    self.nickName = @"";
//    self.gender = @"0";
//    self.birthDay = @"";
//    self.keyong_money = @"0.00";
//    self.zhuanqu_money = @"0.00";
    
    return self;
}


//组装数据
-(void)makeInData:(NSMutableDictionary *)dic{
    
    self.name =  [dic objectForKey:@"xm"];
    self.userId = [dic objectForKey:@"yhzh"];
    self.keyong_money = [dic objectForKey:@"kyye"];
    //self.trueName = [Tool toString:[dic objectForKey:@"djje"]];
    self.djje = [Tool toString:[dic objectForKey:@"djje"]];
    self.zhuanqu_money  = [Tool toString:[dic objectForKey:@"yzze"]];
    self.zhze = [Tool toString:[dic objectForKey:@"zhze"]];
    self.tyjze = [Tool toString:[dic objectForKey:@"tyjze"]];
    self.nickName = [dic objectForKey:@"nc"];
    self.gender= [dic objectForKey:@"xb"];
    self.birthDay= [dic objectForKey:@"csrq"];
    self.wdfwm = [dic objectForKey:@"wdfwm"];
    self.mobile = [dic objectForKey:@"sjh"];
    self.sjsfsz = [dic objectForKey:@"sjsfsz"];
    self.sfzsfrz = [dic objectForKey:@"sfzsfrz"];
    self.txmmsfsz = [dic objectForKey:@"txmmsfsz"];
    self.yjsfsz = [dic objectForKey:@"yjsfsz"];
    
    self.cardNum = [dic objectForKey:@"sfzh"];
    self.trueName = [dic objectForKey:@"xm"];
    self.tongzhiweidu = [Tool toString:[dic objectForKey:@"znxwdts"]];
    self.fwmlj = [dic objectForKey:@"fwmlj"];
 
    self.sfzh = [Tool toString:[dic objectForKey:@"sfzh"]];
    self.xm = [Tool toString:[dic objectForKey:@"xm"]];
    self.znxwdts = [Tool toString:[dic objectForKey:@"znxwdts"]];
    self.cgkyye = [Tool toString:[dic objectForKey:@"cgkyye"]];
    self.cgdjje = [Tool toString:[dic objectForKey:@"cgdjje"]];
    self.cgyzze = [Tool toString:[dic objectForKey:@"cgyzze"]];
    self.cgzhze = [Tool toString:[dic objectForKey:@"cgzhze"]];

    [Tool savecoredata];
}



-(NSString *)new_cardNum{
    
    return self.cardNum;
    
//    NSMutableString *string = [NSMutableString string];
//    if (self.cardNum.length>10) {
//        [string appendString:[self.cardNum substringToIndex:2]];
//        [string appendString:@"************"];
//    }else{
//        return self.cardNum;
//    }
//    return string;
}
-(NSString *)new_mobile{
    NSMutableString *string = [NSMutableString string];
    if (self.mobile.length==11) {
        [string appendString:[self.mobile substringToIndex:3]];
        [string appendString:@"****"];
        [string appendString:[self.mobile substringFromIndex:[self.mobile length]-4]];
    }else{
        return self.mobile;
    }
    return string;
}
-(NSString *)new_trueName{
    
    return self.trueName;
    
//    NSMutableString *string = [NSMutableString string];
//    if (self.trueName.length>1) {
//        [string appendString:[self.trueName substringToIndex:1]];
//        [string appendString:@"*"];
//    }else{
//        return self.trueName;
//    }
//    return string;
}

@end
