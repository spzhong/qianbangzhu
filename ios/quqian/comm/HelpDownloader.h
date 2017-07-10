//
//  HelpDownloader.h
//  kong
//
//  Created by ytx on 13-3-28.
//  Copyright (c) 2013年 ytx. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "AsyncSocket.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "Tool.h"
#import "MBProgressHUD.h"

#define currVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:kCFBundleVersionKey]


//#define BASE_URL_head @"http://192.168.1.131"

#define BASE_URL_head @"http://test.qbzvip.com"


#define BASE_URL [NSString stringWithFormat:@"%@/app",BASE_URL_head]

#define web_URL @"http://test.qbzvip.com"






@interface HelpDownloader : NSObject
{
    BOOL pause;//暂停网络
    int backDataType;//0是XML，1是JSON
    NSString *hostStr;
    short portshot;
    MBProgressHUD *HUD;
    NSMutableDictionary *assistDic;//辅助字典信息
}
@property (nonatomic, assign) BOOL pause;
@property BOOL needLoading;

+ (HelpDownloader *) shared;

//http网络数据请求

-(void)startRequest:(NSString*)urlS withbody:(NSMutableDictionary *)bodyDic isType:(NSMutableDictionary *)rqType completion:(void(^)(id,int))completionWithJSONObject;


- (void) jsonWithGetRequest:(NSString*)urlRequest isNetWorkLonging:(BOOL)yesOrNo completion:(void(^)(id,int))completionWithJSONObject;
- (void) jsonWithPostRequest:(NSString*)urlRequest body:(NSMutableDictionary*)bodyDic isNetWorkLonging:(BOOL)yesOrNo completion:(void(^)(id,int))completionWithJSONObject;
- (void) xmlWithGetRequest:(NSString*)urlRequest isNetWorkLonging:(BOOL)yesOrNo completion:(void(^)(id,int))completionWithJSONObject;
- (void) xmlWithPostRequest:(NSString*)urlRequest body:(NSMutableDictionary*)bodyDic isNetWorkLonging:(BOOL)yesOrNo completion:(void(^)(id,int))completionWithJSONObject;
//下载和上传图片或是文件
- (void)imageDownLoadWithPath:(NSString *)urlPath  withName:(NSString *)fileNameInstore completion:(void (^)(UIImage *, int))completionWithImageYesIfFromCache;
- (void)imageUpLoadWithPath:(NSString *)urlPath  withName:(NSString *)fileName completion:(void (^)(id,int))completionWithImageYesIfFromCache;



@end
