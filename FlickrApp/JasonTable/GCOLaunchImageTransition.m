//  GCOLaunchImageTransitionm
//  FK
//
//  Created by Ravi Bihani on 29/11/13.
//  Copyright (c) 2013 Mr Ravi Bihani. All rights reserved.
//

#import "GCOLaunchImageTransition.h"

NSString* const GCOLaunchImageTransitionHideNotification = @"GCOLaunchImageTransitionHideNotification";

@interface GCOLaunchImageTransition ()

@property( nonatomic, assign ) NSTimeInterval delay;
@property( nonatomic, assign ) NSTimeInterval duration;
@property( nonatomic, assign ) GCOLaunchImageTransitionAnimationStyle style;

@property( nonatomic, strong ) UIImageView* imageView;
@property( nonatomic, strong ) UIActivityIndicatorView* activityIndicatorView;

@end

@implementation GCOLaunchImageTransition

+ (void)transitionWithDuration:(NSTimeInterval)duration style:(GCOLaunchImageTransitionAnimationStyle)style
{
   [self transitionWithDelay:0.0 duration:duration style:style activityIndicatorPosition:CGPointZero activityIndicatorStyle:0];
}

+ (void)transitionWithInfiniteDelayAndDuration:(NSTimeInterval)duration style:(GCOLaunchImageTransitionAnimationStyle)style
{
   [self transitionWithDelay:GCOLaunchImageTransitionNearInfiniteDelay duration:duration style:style activityIndicatorPosition:CGPointZero activityIndicatorStyle:0];
}

+ (void)transitionWithDelay:(NSTimeInterval)delay duration:(NSTimeInterval)duration style:(GCOLaunchImageTransitionAnimationStyle)style activityIndicatorPosition:(CGPoint)activityIndicatorPosition activityIndicatorStyle:(UIActivityIndicatorViewStyle)activityIndicatorStyle
{
   static dispatch_once_t onceToken;
   
   dispatch_once( &onceToken, ^
                 {
                    UIWindow* window = [UIApplication sharedApplication].keyWindow;
                    GCOLaunchImageTransition* transitionView = [[self alloc] initWithAnimationDelay:delay animationDuration:duration style:style activityIndicatorPosition:activityIndicatorPosition activityIndicatorStyle:activityIndicatorStyle];
                    
                    [window addSubview:transitionView.imageView];
                 });
}

#pragma mark - Object life cycle

- (id)initWithAnimationDelay:(NSTimeInterval)delay animationDuration:(NSTimeInterval)duration style:(GCOLaunchImageTransitionAnimationStyle)style activityIndicatorPosition:(CGPoint)activityIndicatorPosition activityIndicatorStyle:(UIActivityIndicatorViewStyle)activityIndicatorStyle
{
   self = [super init];

   if( self )
   {
      self.delay = delay;
      self.duration = duration;
      self.style = style;
      
      // Assign launch image
      self.imageView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
      self.imageView.image = [self launchImageForOrientation:[UIApplication sharedApplication].statusBarOrientation];

      // Register for receiving notifications
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleHideNotification:) name:GCOLaunchImageTransitionHideNotification object:nil];
      
      // Add activity indicator view
      if( !CGPointEqualToPoint( activityIndicatorPosition, CGPointZero) )
      {
         self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:activityIndicatorStyle];
         
         CGSize size = self.imageView.bounds.size;
         self.activityIndicatorView.center = CGPointMake( size.width * activityIndicatorPosition.x,( size.height * activityIndicatorPosition.y )+30);
         
         [self.imageView addSubview:self.activityIndicatorView];
         
         [self.activityIndicatorView startAnimating];
      }
      
      // Start transition animation with given delay
      [self performSelector:@selector(performViewAnimations) withObject:nil afterDelay:self.delay];
   }
   
   return self;
}

- (void)dealloc
{
   [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - View animations

- (void)performViewAnimations
{
   if( self.activityIndicatorView )
   {
      [self.activityIndicatorView stopAnimating];
   }
   
   [UIView animateWithDuration:self.duration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^
    {
       self.imageView.alpha = 0.0;
       
       if( self.style == GCOLaunchImageTransitionAnimationStyleZoomIn )
       {
          self.imageView.transform = CGAffineTransformMakeScale( 2.0, 2.0 );
       }
       else if( self.style == GCOLaunchImageTransitionAnimationStyleZoomOut )
       {
          self.imageView.transform = CGAffineTransformMakeScale( 0.1, 0.1 );
       }
    } completion:
    ^( BOOL finished )
    {
       [self.imageView removeFromSuperview];
    }];
}

#pragma mark - Handle notifications

- (void)handleHideNotification:(NSNotification*)notification
{
   if( [notification.name isEqualToString:GCOLaunchImageTransitionHideNotification] )
   {
      // Start transition animation immediately
      [self performViewAnimations];
      
      // Cancel still running previous perform request
      [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(performViewAnimations) object:nil];
   }
}

#pragma mark - Compute device specific launch image

- (UIImage*)launchImageForOrientation:(UIInterfaceOrientation)orientation
{
   UIImage* launchImage = nil;
   
   if( [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone )
   {
      // Use Retina 4 launch image
      if( [UIScreen mainScreen].bounds.size.height == 568.0 )
      {
         launchImage = [UIImage imageNamed:@"Default-568h@2x.png"];
      }
      // Use Retina 3.5 launch image
      else
      {
         launchImage = [UIImage imageNamed:@"Default.png"];
      }
   }
   else if( [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad )
   {
      // Start with images for special orientations
      if( orientation == UIInterfaceOrientationPortraitUpsideDown )
      {
         launchImage = [UIImage imageNamed:@"Default-PortraitUpsideDown.png"];
      }
      else if( orientation == UIInterfaceOrientationLandscapeLeft )
      {
         launchImage = [UIImage imageNamed:@"Default-LandscapeLeft.png"];
      }
      else if( orientation == UIInterfaceOrientationLandscapeRight )
      {
         launchImage = [UIImage imageNamed:@"Default-LandscapeRight.png"];
      }
      
      // Use iPad default launch images if nothing found yet
      if( launchImage == nil )
      {
         if( UIInterfaceOrientationIsPortrait( orientation ) )
         {
            launchImage = [UIImage imageNamed:@"Default-Portrait.png"];
         }
         else
         {
            launchImage = [UIImage imageNamed:@"Default-Landscape.png"];
         }
      }
      
      // No launch image found so far, fall back to default
      if( launchImage == nil )
      {
         launchImage = [UIImage imageNamed:@"Default.png"];
      }
   }
   
   // As a last resort try to read the launch image from the app's Info.plist
   if( launchImage == nil )
   {
      NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
      NSString* launchImageName = [infoDict valueForKey:@"UILaunchImageFile"];
      
      launchImage = [UIImage imageNamed:launchImageName];
   }
   
   return launchImage;
}

@end
