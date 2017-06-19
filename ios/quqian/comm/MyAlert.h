//
//  MyAlert.h
//  quqian
//
//  Created by apple on 15/4/10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "RCLabel.h"
#import <UIKit/UIKit.h>
@protocol JKCustomAlertDelegate <NSObject>
@optional
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end

@interface MyAlert : UIAlertView {
    UIImage *backgroundImage;
    UIImage *contentImage;
    NSMutableArray *_buttonArrays;
    
}

@property(readwrite, retain) UIImage *backgroundImage;
@property(readwrite, retain) UIImage *contentImage;
@property(nonatomic, assign) id<JKCustomAlertDelegate> JKdelegate;
- (id)initWithImage:(UIImage *)image contentImage:(UIImage *)content;
-(void) addButtonWithUIButton:(UIButton *) btn;
@property(nonatomic,retain)RCLabel *rclab;

@end

