//
//  Vector.h
//  GravitySimulator
//
//  Created by Bram on 11/24/14.
//  Copyright (c) 2014 Digital Hotdogs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vector : NSObject

@property float x;
@property float y;

- (void) unitVInSameDirection;

@end
