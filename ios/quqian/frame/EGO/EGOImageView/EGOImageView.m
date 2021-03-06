//
//  EGOImageView.m
//  EGOImageLoading
//
//  Created by Shaun Harrison on 9/15/09.
//  Copyright (c) 2009-2010 enormego
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "EGOImageView.h"
#import "EGOImageLoader.h"

@implementation EGOImageView
@synthesize imageURL, placeholderImage, delegate,keyString,index;
@synthesize tagString;
@synthesize egoImageType;
@synthesize indexPath;
@synthesize infoDictionary;

- (id)initWithPlaceholderImage:(UIImage*)anImage {
    //self.egoImageType=EGOImageTypeDefault;
    
	return [self initWithPlaceholderImage:anImage delegate:nil];	
}

- (id)initWithPlaceholderImage:(UIImage*)anImage delegate:(id<EGOImageViewDelegate>)aDelegate {
	if((self = [super initWithImage:anImage])) {
        self.userInteractionEnabled=YES;
        self.placeholderImage = anImage;
		self.delegate = aDelegate;
	}
	
	return self;
}




//读取本地的IMG
- (void)duqubendiImg:(NSString *)pathImg{
    //[NSThread detachNewThreadSelector:@selector(jiazaitupian:) toTarget:self withObject:pathImg];
    UIImage *img = [UIImage imageWithContentsOfFile:pathImg];
    self.image = img;
}

//本地图片
-(void)jiazaitupian:(NSString *)pathImg{
    
}
//网络图片
-(void)jiazaitupian2:(NSURL *)aURL{
    if(imageURL) {
		[[EGOImageLoader sharedImageLoader] removeObserver:self forURL:imageURL];
		[imageURL release];
		imageURL = nil;
	}
	if(!aURL) {
		self.image = self.placeholderImage;
		imageURL = nil;
		return;
	} else {
		imageURL = [aURL retain];
	}
    
	[[EGOImageLoader sharedImageLoader] removeObserver:self];
	UIImage* anImage = [[EGOImageLoader sharedImageLoader] imageForURL:aURL shouldLoadWithObserver:self];
	
	if(anImage) {
		self.image = anImage;
        
		// trigger the delegate callback if the image was found in the cache
		if([self.delegate respondsToSelector:@selector(imageViewLoadedImage:)]) {
			[self.delegate imageViewLoadedImage:self];
		}
	} else {
		self.image = self.placeholderImage;
	}

}

- (void)setImageURL:(NSURL *)aURL {
    
    //[NSThread detachNewThreadSelector:@selector(jiazaitupian2:) toTarget:self withObject:aURL];
    
    if (self.image!=nil) {
        if (egoImageType==EGOImageTypeSquare) {
            self.image = [Tool ImageFangImage:self.image withHeight:100];
        }
       // return;
    }
    
    if(imageURL) {
		[[EGOImageLoader sharedImageLoader] removeObserver:self forURL:imageURL];
		[imageURL release];
		imageURL = nil;
	}
	if(!aURL) {
		self.image = self.placeholderImage;
        if (egoImageType==EGOImageTypeSquare) {
            self.image = [Tool ImageFangImage:self.image withHeight:100];
        }
		imageURL = nil;
		return;
	} else {
		imageURL = [aURL retain];
	}
    
	[[EGOImageLoader sharedImageLoader] removeObserver:self];
	UIImage* anImage = [[EGOImageLoader sharedImageLoader] imageForURL:aURL shouldLoadWithObserver:self];
	if (egoImageType==EGOImageTypeSquare) {
        anImage = [Tool ImageFangImage:anImage withHeight:100];
    }
	if(anImage) {
		self.image = anImage;
        
		// trigger the delegate callback if the image was found in the cache
		if([self.delegate respondsToSelector:@selector(imageViewLoadedImage:)]) {
			[self.delegate imageViewLoadedImage:self];
		}
	} else {
		//self.image = self.placeholderImage;
        if([self.delegate respondsToSelector:@selector(imageViewLoadedImage:)]) {
            [self.delegate imageViewLoadedImage:self];
        }
	}
}

#pragma mark -
#pragma mark Image loading

- (void)cancelImageLoad {
	[[EGOImageLoader sharedImageLoader] cancelLoadForURL:self.imageURL];
	[[EGOImageLoader sharedImageLoader] removeObserver:self forURL:self.imageURL];
}

- (void)imageLoaderDidLoad:(NSNotification*)notification {
	if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.imageURL]) return;

	UIImage* anImage = [[notification userInfo] objectForKey:@"image"];
	self.image = anImage;
	[self setNeedsDisplay];
	
//    if (self.delegate!=nil) {
//        if([self.delegate respondsToSelector:@selector(imageViewLoadedImage:)]) {
//            [self.delegate imageViewLoadedImage:self];
//        }
//    }
}

- (void)imageLoaderDidFailToLoad:(NSNotification*)notification {
    return;
	if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.imageURL]) return;
	if([self.delegate respondsToSelector:@selector(imageViewFailedToLoadImage:error:)]) {
		[self.delegate imageViewFailedToLoadImage:self error:[[notification userInfo] objectForKey:@"error"]];
	}
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
 
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate imageSelectedIndex:self withURL:self.index];
}
#pragma mark -
- (void)dealloc {
	[[EGOImageLoader sharedImageLoader] removeObserver:self];
	self.delegate = nil;
	self.imageURL = nil;
	self.placeholderImage = nil;
    [super dealloc];
}

@end
