//
//  JTAppDelegate.h
//  JasonTable
//
//  Created by Mr Ravi Bihani on 28/11/2013.
//  Copyright (c) 2013 Mr Ravi Bihani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface JTAppDelegate : UIResponder <UIApplicationDelegate>
{
UIWindow *window; 

}

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIImageView *splashView;
@property(nonatomic,strong) UIActivityIndicatorView *spinner;
@end
