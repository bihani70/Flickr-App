//
//  FCMapViewController.m
//  FlickrAPP
//
//  Created by Ravi Bihani on 09/12/13.
//  Copyright (c) 2013 Mr Ravi Bihani. All rights reserved.
//

#import "FCMapViewController.h"
#import "plotMap.h"
#define METERS_PER_MILE 1609.344

@interface FCMapViewController ()
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@end

@implementation FCMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //declaration of map cordinate
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [self.receiveLatitute doubleValue];
    zoomLocation.longitude= [self.receiveLongitude doubleValue];
    
    //sign map loading area
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 20*METERS_PER_MILE, 20*METERS_PER_MILE);
    //loading map with cordinate
    [self.MapApp setRegion:viewRegion animated:YES];
}

//polting the point on the map
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
   
    if([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    static NSString *identifier = @"plotMap";
    MKPinAnnotationView * annotationView = (MKPinAnnotationView*)[self.MapApp dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annotationView)
    {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.pinColor = MKPinAnnotationColorPurple;
        annotationView.animatesDrop = YES;
        annotationView.canShowCallout = YES;
    }else {
        annotationView.annotation = annotation;
    }
   // UIImageView *imagelaunch=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app.png"]];
 //   annotationView.leftCalloutAccessoryView=imagelaunch;
  //  annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return annotationView;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.MapApp.delegate= self;
    
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [self.receiveLatitute doubleValue];
    zoomLocation.longitude= [self.receiveLongitude doubleValue];;
    
    plotMap *plotmap=[[plotMap alloc]initWithCoordinate:zoomLocation title:self.receiveMapTitle];
    
    [self.MapApp addAnnotation:plotmap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
