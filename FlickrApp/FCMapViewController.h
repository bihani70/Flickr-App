//
//  FCMapViewController.h
//  FlickrAPP
//
//  Created by Ravi Bihani on 09/12/13.
//  Copyright (c) 2013 Mr Ravi Bihani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface FCMapViewController : UIViewController<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *MapApp;
@property(strong,nonatomic)NSString *receiveMapTitle;
@property(strong,nonatomic)NSString *receiveLongitude;
@property(strong,nonatomic)NSString *receiveLatitute;

@end
