//
//  JTAppDelegate.m
//  JasonTable
//
//  Created by Mr Ravi Bihani on 28/11/2013.
//  Copyright (c) 2013 Mr Ravi Bihani. All rights reserved.
//

#import "JTAppDelegate.h"
#import "GCOLaunchImageTransition.h"

@implementation JTAppDelegate
@synthesize window=_window;


//api used for launch image with activity indicator
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    NSUInteger demo = 3;
    switch( demo )
    {
        default:
        case 1:
        {
            // Create transition with given type
            [GCOLaunchImageTransition transitionWithDuration:0.5 style:GCOLaunchImageTransitionAnimationStyleZoomIn];
            
            break;
        }
        case 2:
        {
           // Create transition with given type
            [GCOLaunchImageTransition transitionWithInfiniteDelayAndDuration:0.5 style:GCOLaunchImageTransitionAnimationStyleFade];
            //delay in image load
            [self performSelector:@selector(finishLaunchImageTransitionNow) withObject:nil afterDelay:3.0];
            break;
        }
            
        case 3:
        {
            // Create transition with given type
            [GCOLaunchImageTransition transitionWithDelay:5.0 duration:0.5 style:GCOLaunchImageTransitionAnimationStyleZoomOut activityIndicatorPosition:CGPointMake( 0.5, 0.9 ) activityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
            break;
        }
    }
}

- (void)finishLaunchImageTransitionNow
{
    [[NSNotificationCenter defaultCenter] postNotificationName:GCOLaunchImageTransitionHideNotification object:self];
}

@end