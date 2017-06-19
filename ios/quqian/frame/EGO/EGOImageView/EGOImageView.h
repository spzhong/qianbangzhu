/*
 2014/2/21 王冠晓 加入枚举，用来设置图片的显示格式，目前加入 1､默认格式  2､方形微缩图片模式
 
 */

#import <UIKit/UIKit.h>
#import "EGOImageLoader.h"
#import "Tool.h"

typedef NS_ENUM(NSInteger, EGOImageType) {
    EGOImageTypeDefault,             // 默认
    EGOImageTypeSquare               // 正方形
};

@protocol EGOImageViewDelegate;
@interface EGOImageView : UIImageView<EGOImageLoaderObserver> {
@private
	NSURL* imageURL;
	UIImage* placeholderImage;
	id<EGOImageViewDelegate> delegate;
    NSString *keyString;
    int index;
    EGOImageType egoImageType;
    // 2014/6/23 增加，用来传递字典
    NSDictionary *infoDictionary;
}

- (id)initWithPlaceholderImage:(UIImage*)anImage; // delegate:nil
- (id)initWithPlaceholderImage:(UIImage*)anImage delegate:(id<EGOImageViewDelegate>)aDelegate;

- (void)duqubendiImg:(NSString *)pathImg;

- (void)cancelImageLoad;
@property (nonatomic,retain) NSDictionary *infoDictionary;
@property (nonatomic)EGOImageType egoImageType;
@property(nonatomic) int index;
@property(nonatomic,retain) NSString *keyString;
@property(nonatomic,retain) NSURL* imageURL;
@property(nonatomic,retain) UIImage* placeholderImage;
@property(nonatomic,assign) id<EGOImageViewDelegate> delegate;
@property(nonatomic,retain) NSString *tagString;
@property(nonatomic,retain) NSIndexPath *indexPath;
@end

@protocol EGOImageViewDelegate<NSObject>
@optional
-(void)imageSelectedIndex:(EGOImageView*)imageView withURL:(int)index;
- (void)imageViewLoadedImage:(EGOImageView*)imageView;
- (void)imageViewFailedToLoadImage:(EGOImageView*)imageView error:(NSError*)error;
@end