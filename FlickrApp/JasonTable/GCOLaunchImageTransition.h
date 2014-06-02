//  GCOLaunchImageTransition.h
//  FK
//
//  Created by Ravi Bihani on 29/11/13.
//  Copyright (c) 2013 Mr Ravi Bihani. All rights reserved.
//
#import <UIKit/UIKit.h>

#define GCOLaunchImageTransitionNearInfiniteDelay DBL_MAX

extern NSString* const GCOLaunchImageTransitionHideNotification;

typedef enum GCOLaunchImageTransitionAnimationStyle_
{
   GCOLaunchImageTransitionAnimationStyleFade,
   GCOLaunchImageTransitionAnimationStyleZoomOut,
   GCOLaunchImageTransitionAnimationStyleZoomIn
} GCOLaunchImageTransitionAnimationStyle;

@interface GCOLaunchImageTransition : NSObject

// Create transition with a given style that begins immediately

+ (void)transitionWithDuration:(NSTimeInterval)duration style:(GCOLaunchImageTransitionAnimationStyle)style;



+ (void)transitionWithInfiniteDelayAndDuration:(NSTimeInterval)duration style:(GCOLaunchImageTransitionAnimationStyle)style;


+ (void)transitionWithDelay:(NSTimeInterval)delay duration:(NSTimeInterval)duration style:(GCOLaunchImageTransitionAnimationStyle)style activityIndicatorPosition:(CGPoint)activityIndicatorPosition activityIndicatorStyle:(UIActivityIndicatorViewStyle)activityIndicatorStyle;

@end
