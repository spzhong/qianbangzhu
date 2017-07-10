//
//  FilteredProtocol.m
//  qianbangzhu
//
//  Created by 宋培众 on 2017/6/30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FilteredProtocol.h"

@implementation FilteredProtocol

//
//+ (BOOL)canInitWithRequest:(NSURLRequest *)request
//{
//    NSLog(@"request.URL.absoluteString = %@",request.URL.absoluteString);
//    //只处理http和https请求
//    NSString *scheme = [[request URL] scheme];
//    if ( ([scheme caseInsensitiveCompare:@"http"]  == NSOrderedSame ||
//          [scheme caseInsensitiveCompare:@"https"] == NSOrderedSame ))
//    {
//        //看看是否已经处理过了，防止无限循环
//        if ([NSURLProtocol propertyForKey:FilteredCssKey inRequest:request])
//            return NO;
//        
//        return YES;
//    }
//    return NO;
//}
//1
//2
//3
//4
//5
//6
//7
//8
//9
//10
//11
//+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
//{
//    NSMutableURLRequest *mutableReqeust = [request mutableCopy];
//    //截取重定向
//    if ([request.URL.absoluteString isEqualToString:sourUrl])
//    {
//        NSURL* url1 = [NSURL URLWithString:localUrl];
//        mutableReqeust = [NSMutableURLRequest requestWithURL:url1];
//    }
//    return mutableReqeust;
//}
//1
//2
//3
//4
//+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b
//{
//    return [super requestIsCacheEquivalent:a toRequest:b];
//}
//1
//2
//3
//4
//5
//6
//7
//8
//9
//10
//11
//12
//13
//14
//15
//16
//17
//18
//19
//20
//21
//22
//23
//24
//25
//26
//27
//- (void)startLoading
//{
//    NSMutableURLRequest *mutableReqeust = [[self request] mutableCopy];
//    //给我们处理过的请求设置一个标识符, 防止无限循环,
//    [NSURLProtocol setProperty:@YES forKey:FilteredCssKey inRequest:mutableReqeust];
//    
//    BOOL enableDebug = NO;
//    //这里最好加上缓存判断
//    if (enableDebug)
//    {
//        NSString *str = @"写代码是一门艺术";
//        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
//        NSURLResponse *response = [[NSURLResponse alloc] initWithURL:mutableReqeust.URL
//                                                            MIMEType:@"text/plain"
//                                               expectedContentLength:data.length
//                                                    textEncodingName:nil];
//        [self.client URLProtocol:self
//              didReceiveResponse:response
//              cacheStoragePolicy:NSURLCacheStorageNotAllowed];
//        [self.client URLProtocol:self didLoadData:data];
//        [self.client URLProtocolDidFinishLoading:self];
//    }
//    else
//    {
//        self.connection = [NSURLConnection connectionWithRequest:mutableReqeust delegate:self];
//    }
//}
//1
//2
//3
//4
//5
//6
//7
//8
//- (void)stopLoading
//{
//    if (self.connection != nil)
//    {
//        [self.connection cancel];
//        self.connection = nil;
//    }
//}
//1
//2
//3
//4
//5
//6
//7
//8
//9
//10
//11
//12
//13
//14
//15
//16
//17
//18
//19
//20
//21
//22
//23
//#pragma mark- NSURLConnectionDelegate
//
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
//    [self.client URLProtocol:self didFailWithError:error];
//}
//
//#pragma mark - NSURLConnectionDataDelegate
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//{
//    self.responseData = [[NSMutableData alloc] init];
//    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//    [self.responseData appendData:data];
//    [self.client URLProtocol:self didLoadData:data];
//}
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    [self.client URLProtocolDidFinishLoading:self];
//}

@end
