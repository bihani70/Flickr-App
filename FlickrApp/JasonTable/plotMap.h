//
//  myAnnotation.h
//  MapView
//
//  Created by dev27 on 5/30/13.
//  Copyright (c) 2013 codigator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

//3.1
@interface plotMap : NSObject <MKAnnotation>

@property (copy, nonatomic) NSString *title;
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;

//method to take cordinate nad title for the map point
-(id) initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title;
@end
