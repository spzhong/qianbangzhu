//
//  HelpDownloader.m
//  kong
//
//  Created by ytx on 13-3-28.
//  Copyright (c) 2013年 ytx. All rights reserved.
//

#import "HelpDownloader.h"
#import "MBProgressHUD+Add.h"


@implementation HelpDownloader 
@synthesize pause;
static HelpDownloader *sharedDownloader = nil;

+(HelpDownloader *)shared{
    if (sharedDownloader == nil) {
        sharedDownloader = [[HelpDownloader alloc] init];
    }
    return sharedDownloader;
}

-(id)init{
    self=[super init];
    if (self) {
        pause = NO;
        backDataType = 0;
    }
    return self;
}

- (void) jsonWithGetRequest:(NSString*)urlRequest isNetWorkLonging:(BOOL)yesOrNo completion:(void(^)(id,int))completionWithJSONObject{
    backDataType = 1;
    if (pause) {
        //do nothing
        return;
    }
    [self startRequest:urlRequest withbody:nil isNetWorkLonging:yesOrNo  completion: ^(id data,int kk) {
        completionWithJSONObject(data,kk);
    }];
}
- (void) jsonWithPostRequest:(NSString*)urlRequest body:(NSMutableDictionary*)bodyDic isNetWorkLonging:(BOOL)yesOrNo completion:(void(^)(id,int))completionWithJSONObject{
    backDataType = 1;
    if (pause) {
        //do nothing
        return;
    }
    [self startRequest:urlRequest withbody:bodyDic isNetWorkLonging:yesOrNo completion: ^(id data,int kk) {
        completionWithJSONObject(data,kk);
    }];
}

- (void) xmlWithGetRequest:(NSString*)urlRequest isNetWorkLonging:(BOOL)yesOrNo completion:(void(^)(id,int))completionWithJSONObject{
    backDataType = 0;
    if (pause) {
        //do nothing
        return;
    }
    [self startRequest:urlRequest withbody:nil  isNetWorkLonging:yesOrNo completion: ^(id data,int kk) {
        completionWithJSONObject(data,kk);
    }];
}
- (void) xmlWithPostRequest:(NSString*)urlRequest body:(NSMutableDictionary*)bodyDic isNetWorkLonging:(BOOL)yesOrNo completion:(void(^)(id,int))completionWithJSONObject{
    backDataType = 0;
    if (pause) {
        //do nothing
        return;
    }
    [self startRequest:urlRequest withbody:bodyDic isNetWorkLonging:yesOrNo completion: ^(id data,int kk) {
        completionWithJSONObject(data,kk);
    }];
}


//下载图片
- (void)imageDownLoadWithPath:(NSString *)urlPath  withName:(NSString *)fileNameInstore completion:(void (^)(UIImage *,int))completionWithImageYesIfFromCache{
    //首先读取文件中的数据
    UIImage *img  = nil;
    if (![Tool IsExistfileName:fileNameInstore]) {
        //存在
        img = [UIImage imageWithContentsOfFile:fileNameInstore];
        completionWithImageYesIfFromCache(img,0);
    }
    if (img == nil) {
        ASIHTTPRequest *request;
        request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlPath]];
        [request setDownloadDestinationPath:fileNameInstore];//设置缓存路径
        [request setDidFinishSelector:@selector(finishSelector:)];
        [request setDidFailSelector:@selector(failSelector:)];
        request.completionWithDownloadedDatacope = completionWithImageYesIfFromCache;
        [request setDelegate:self];
        [request startAsynchronous];//异步的下载图片
        
    }
}

//下载图片成功
-(void)finishSelector:(ASIHTTPRequest *)request{
    
    UIImage *img = [UIImage imageWithContentsOfFile:request.downloadDestinationPath];
    if (img != nil) {
        request.completionWithDownloadedDatacope(img,0);
    }else{
        //下载失败
        [self failSelector:request];
    }
    img=nil;
}
//下载图片失败
-(void)failSelector:(ASIHTTPRequest *)request{
    request.completionWithDownloadedDatacope(nil,1);
}

//上传文件或是图片
- (void)imageUpLoadWithPath:(NSString *)urlPath withName:(NSString *)fileName completion:(void (^)(id,int))completionWithImageYesIfFromCache{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString:urlPath]];
    [request setFile:fileName forKey: @"this_is_file"];
    [request buildRequestHeaders];
    [request setTimeOutSeconds:10];
    [request setDidFinishSelector:@selector(upfinishSelector:)];
    [request setDidFailSelector:@selector(upfailSelector:)];
    [request setDelegate:self];
    request.completionWithDownloadedDatacope = completionWithImageYesIfFromCache;
    [request startAsynchronous];//进行异步的上传数据
}   
//上传成功
-(void)upfinishSelector:(ASIFormDataRequest *)request{
    request.completionWithDownloadedDatacope(nil,0);
}
//上传失败
-(void)upfailSelector:(ASIFormDataRequest *)request{
    request.completionWithDownloadedDatacope(nil,1);
}
 

//开始进行网络的请求操作
-(void)startRequest:(NSString*)urlS withbody:(NSMutableDictionary *)bodyDic isType:(NSMutableDictionary *)rqType completion:(void(^)(id,int))completionWithJSONObject{
    
    assistDic = rqType;
    
    
    //是否是检查网络
    if ([[assistDic objectForKey:@"isConnectedToNetwork"] isEqualToString:@"yes"]) {
        
    }
    //是否显示loading效果图
    if ([[assistDic objectForKey:@"isshowHUD"] isEqualToString:@"yes"]) {
        
        if (HUD != nil) {
            [HUD removeFromSuperview];
            HUD = nil;
        }
        
        if (HUD==nil) {
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            HUD = [[MBProgressHUD alloc] initWithView:app.window];
            HUD.alpha = 0.9;
            //HUD.yOffset = -100.f;
            //HUD.delegate = self;
            HUD.labelText = @"加载中...";
            HUD.mode = MBProgressHUDModeIndeterminate;
            [app.window addSubview:HUD];
        }
    }
    //是否锁屏
    if ([[assistDic objectForKey:@"islockscreen"] isEqualToString:@"yes"]) {
        if (HUD==nil) {
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            app.window.userInteractionEnabled = NO;
        }
    }
    
    //请求方式
    if ([[assistDic objectForKey:@"isrequesType"] isEqualToString:@"get"]) {
        NSMutableString *body = [NSMutableString string];
        NSArray *array = [bodyDic allKeys];
        for (int i = 0; i<[array count]; i++) {
            NSString *key = [array objectAtIndex:i];
            id value = [bodyDic objectForKey:key];
            if (i == [array count]-1) {
                [body appendString:[NSString stringWithFormat:@"%@=%@",key,value]];
            }else{
                [body appendString:[NSString stringWithFormat:@"%@=%@&",key,value]];
            }
        }
        NSLog(@"body : %@?%@",urlS,body);
        urlS = [NSString stringWithFormat:@"%@?%@",urlS,body];
    }
    
 
    //开始发送网络的请求
    urlS = [urlS stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURL *url = [NSURL URLWithString:urlS];
	//设置请求的方式
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    //检测网络
//    if (![Tool ConnectedToNetwork]) {
//        request.completionWithDownloadedDatacope(nil,1);
//        return;
//    }
    //设置网络
    [request setTimeOutSeconds:20];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(requestHospitalCommitDone:)];
    [request setDidFailSelector:@selector(requestCommitWrong:)];
    request.completionWithDownloadedDatacope = completionWithJSONObject;
    [request setShouldContinueWhenAppEntersBackground:YES];
    [request setShouldRedirect:YES];
    [request setShouldAttemptPersistentConnection:NO];
    [request setRequestMethod:@"post"];
    
    
    //
//    NSDictionary *properties = [[[NSMutableDictionary alloc] init] autorelease];
//    [properties setValue:[@"Test Value" encodedCookieValue] forKey:NSHTTPCookieValue];
//    [properties setValue:@"ASIHTTPRequestTestCookie" forKey:NSHTTPCookieName];
//    [properties setValue:@".dreamingwish.com" forKey:NSHTTPCookieDomain];
//    [properties setValue:[NSDate dateWithTimeIntervalSinceNow:60*60] forKey:NSHTTPCookieExpires];
//    [properties setValue:@"/asi-http-request/tests" forKey:NSHTTPCookiePath];
//    NSHTTPCookie *cookie = [[[NSHTTPCookie alloc] initWithProperties:properties] autorelease];
//    [request setRequestCookies:[NSMutableArray arrayWithObject:cookie]];
//    //
//    
    
    
    
    if ([[assistDic objectForKey:@"isrequesType"] isEqualToString:@"post"]) {
        NSMutableString *body = [NSMutableString string];
        NSArray *array = [bodyDic allKeys];
        for (int i = 0; i<[array count]; i++) {
            NSString *key = [array objectAtIndex:i];
            id value = nil;
            if ([key hasPrefix:@"pic"]) {
                value = [bodyDic objectForKey:key];
                [request setFile:value forKey:key];
            }else{
                value = [bodyDic objectForKey:key];
                [request setPostValue:value forKey:key];
            }
            if (i == [array count]-1) {
                [body appendString:[NSString stringWithFormat:@"%@=%@",key,value]];
            }else{
                [body appendString:[NSString stringWithFormat:@"%@=%@&",key,value]];
            }
        }
       // NSLog(@"body : %@  %@",urlS,body);
        
        //key vlaue
        NSString *cookieValue = [[NSUserDefaults standardUserDefaults] objectForKey:@"cookieValue"];
        if (cookieValue!=nil) {
            [request setPostValue:cookieValue forKey:@"cookieValue"];
        }
        
        [body appendString:[NSString stringWithFormat:@"%@=%@",cookieValue,cookieValue]];
        
         NSLog(@"body : %@  %@",urlS,body);
        
    }
    
    [request startAsynchronous];
}
//网络请求数据正确相应返回
-(void)requestHospitalCommitDone:(ASIFormDataRequest *)request{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
  
//    NSData *data = [request  responseData];
//    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    NSString*  jsonString = [[NSString alloc] initWithData:data encoding:encoding];//data为NSData类型
//    NSLog(@"song网络数据 %@",jsonString);

    
    [HUD removeFromSuperview];
    
    NSString* jsonString = [request  responseString];
 
    NSLog(@"%@",jsonString);
 
    
        //判断登录的状态
        BOOL authenticated = [[[jsonString JSONValue] objectForKey:@"authenticated"] boolValue];
        
        //超时
        if (!authenticated) {
            
            //需要登录啊
            if ([[[jsonString JSONValue] objectForKey:@"isLogin"] isEqualToString:@"1"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"chaoshidecaozuo" object:nil];
            }
            
        }
     
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:[[jsonString JSONValue] objectForKey:@"cookieValue"] forKey:@"cookieValue"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
     
        //正常的回调
        request.completionWithDownloadedDatacope(jsonString,0);
    
    //修改权限
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.window.userInteractionEnabled = YES;
 
    
}
//网络数据异常
-(void)requestCommitWrong:(ASIFormDataRequest *)request{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    //在这里面一般往往是网络请求时间超时的问题和网络终端，异常
    [HUD removeFromSuperview];
    request.completionWithDownloadedDatacope(nil,1);
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.window.userInteractionEnabled = YES;
    [MBProgressHUD  showError:@"服务器异常,请稍后再试" toView:nil];
}



 @end
