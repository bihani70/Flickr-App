//
//  ImageCacheObject.m
//  FK
//
//  Created by Ravi Bihani on 29/11/13.
//  Copyright (c) 2013 Mr Ravi Bihani. All rights reserved.
//

#import "ImageCacheObject.h"

@implementation ImageCacheObject

@synthesize size;
@synthesize timeStamp;
@synthesize image;

-(id)initWithSize:(NSUInteger)sz Image:(UIImage*)anImage{
    if (self = [super init]) {
        size = sz;
        timeStamp = [NSDate date];
        image = anImage ;
    }
    return self;
}

-(void)resetTimeStamp {
    timeStamp = [NSDate date];
}


@end
