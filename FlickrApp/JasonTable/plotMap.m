//
//  myAnnotation.m
//  MapView
//
//  Created by dev27 on 5/30/13.
//  Copyright (c) 2013 codigator. All rights reserved.
//

#import "plotMap.h"

@implementation plotMap


-(id) initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title1 {
  if ((self = [super init])) {
    self.coordinate =coordinate;
    self.title = title1;
  }
  return self;
}

@end
