//
//  FC.m
//  trail
//
//  Created by Ravi Bihani on 29/11/13.
//  Copyright (c) 2013 Ravi Bihani. All rights reserved.
//

#import "FC.h"

@implementation FC

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void) prepareForReuse {
    
    self.myImage.image = nil;
   
}

@end
