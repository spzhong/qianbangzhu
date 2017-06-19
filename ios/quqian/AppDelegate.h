//
//  AppDelegate.h
//  quqian
//
//  Created by apple on 15/3/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "KVNMaskedPageControl.h"
#import "MAThemeKit.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,KVNMaskedPageControlDataSource,UIScrollViewDelegate>
{
    NSManagedObjectContext *_managedObjectContext;
    NSManagedObjectModel *_managedObjectModel;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
   
    KVNMaskedPageControl*pageControl;
}

@property(nonatomic,retain)KVNMaskedPageControl*pageControl;

@property (strong, nonatomic) UIWindow *window;
@property (readonly, retain, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, retain, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, retain, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


- (BOOL)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

