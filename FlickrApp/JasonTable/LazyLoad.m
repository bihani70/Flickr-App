//  LazyLoad.m
//  FK
//
//  Created by Ravi Bihani on 29/11/13.
//  Copyright (c) 2013 Mr Ravi Bihani. All rights reserved.
//

#import "LazyLoad.h"
#import "ImageCacheObject.h"
#import "ImageCache.h"

static ImageCache *imageCache = nil;
@implementation LazyLoad

-(id)init{
    if (self==[super init]) {
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:self.frame];
        //imageView.backgroundColor=[UIColor blueColor];
        [self addSubview:imageView];
    }
    return self;
}

- (void)loadImageFromURL:(NSURL*)url
{
	
    if (imageCache == nil) // lazily create image cache
        imageCache = [[ImageCache alloc] initWithMaxSize:2*1024*1024];  // 2 MB Image cache
    
    urlString = [[url absoluteString] copy];
    UIImage *cachedImage = [imageCache imageForKey:urlString];
    if (cachedImage != nil) {
        if ([[self subviews] count] > 0) {
            [[[self subviews] objectAtIndex:0] removeFromSuperview];
        }
        UIImageView *imageView = [[UIImageView alloc] initWithImage:cachedImage];
        imageView.contentMode = UIViewContentModeScaleAspectFit;

        [self addSubview:imageView];
        return;
    }
    
#define IMAGE_LAUCNH 4444
   // cell.myImage.image=[UIImage imageNamed:@"app.png"];
    UIImageView *imagelaunch=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AppIcon76x76.png"]];
    imagelaunch.tag=IMAGE_LAUCNH;
    [self addSubview:imagelaunch];
   // [imagelaunch.im]
    
#define SPINNY_TAG 5555
        
        UIActivityIndicatorView *spinny = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinny.tag = SPINNY_TAG;
        spinny.color=[UIColor blackColor];
        spinny.center = CGPointMake(39,38);
        [spinny startAnimating];
        [self addSubview:spinny];

    NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
	if (data==nil) { data = [[NSMutableData alloc] initWithCapacity:2048]; }
	[data appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection 
{
    connection = nil;
    UIView *imagelaunch=[self viewWithTag:IMAGE_LAUCNH];
    [imagelaunch removeFromSuperview];
    
    UIView *spinny = [self viewWithTag:SPINNY_TAG];
    [spinny removeFromSuperview];
	
	if ([[self subviews] count]>0) 
     {
        [[[self subviews] objectAtIndex:0] removeFromSuperview];
     }
    
	
	UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:data]] ;
    UIImage *image = [UIImage imageWithData:data];
    UIImageView *newImg=nil;
     [imageCache insertImage:image withSize:[data length] forKey:urlString];
	//imageView.contentMode = UIViewContentModeScaleAspectFit;

imageView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight );
	[self addSubview:newImg];
    [self addSubview:imageView];
	//[imageView setFrame:CGRectMake(0, 0, 83, 85)];
	[imageView setNeedsLayout];
	[self setNeedsLayout];
    
	data=nil;
}

@end
