//
//  InputGeneralViewController.h
//  wqkj
//
//  Created by Chenjhao on 1/26/14.
//  Copyright (c) 2014 WANGGUANXIAO. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InputGeneralViewControllerDelegate <NSObject>
-(void)saveMessage:(NSString *)str withTag:(int)tag;
@end


@interface InputGeneralViewController : UIViewController<UITextViewDelegate>
{
    UITextView *ntextView;//内容信息
}

@property(nonatomic)int tag;//标示
@property(nonatomic,assign)id<InputGeneralViewControllerDelegate> delegate;
@property(nonatomic)int allCount;//字数限制
@property(nonatomic)int lines;//行数
@property(nonatomic,retain)NSString *titleName;//标题
@property(nonatomic,retain)NSString *text;//内容
@property(nonatomic)UIKeyboardType keyBorad;
@property(nonatomic,retain)NSString *explain;//内容说明
@property(nonatomic,retain)NSString *warning;//警告

@end
