//
//  DirectionalForce.m
//  GravitySimulator
//
//  Created by Bram on 11/24/14.
//  Copyright (c) 2014 Digital Hotdogs. All rights reserved.
//

#import "DirectionalForce.h"

@implementation DirectionalForce

@synthesize magnitude;
@synthesize direction;


- (id) init
{
    magnitude = 0;
    direction = [[Vector alloc] init];
    [direction setX:0];
    [direction setY:0];
    
    return [super init];
}


@end
