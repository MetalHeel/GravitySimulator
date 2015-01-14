//
//  Vector.m
//  GravitySimulator
//
//  Created by Bram on 11/24/14.
//  Copyright (c) 2014 Digital Hotdogs. All rights reserved.
//

#import "Vector.h"

@implementation Vector

@synthesize x;
@synthesize y;


- (void) unitVInSameDirection
{
    float L = sqrtf(powf(x, 2) + powf(y, 2));
    
    if(L != 0)
    {
        x = x / L;
        y = y / L;
    }
}


@end
