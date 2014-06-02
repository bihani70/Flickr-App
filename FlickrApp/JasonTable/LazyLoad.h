//  LazyLoad.h
//  FK
//
//  Created by Ravi Bihani on 29/11/13.
//  Copyright (c) 2013 Mr Ravi Bihani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LazyLoad : UIView
{
	NSURLConnection* connection; 
	NSMutableData* data;
    NSString *urlString; 
}
- (void)loadImageFromURL:(NSURL*)url;

@end