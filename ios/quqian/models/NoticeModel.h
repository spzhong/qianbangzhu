//
//  NoticeModel.h
//  quqian
//
//  Created by apple on 15/4/2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NoticeModel : NSManagedObject

@property (nonatomic, retain) NSString * noticeId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSString * isRead;
@property (nonatomic, retain) NSString * content;

@end
