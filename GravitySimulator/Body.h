//
//  Body.h
//  GravitySimulator
//
//  Created by Bram on 11/23/14.
//  Copyright (c) 2014 Digital Hotdogs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "DirectionalForce.h"

@interface Body : NSObject

@property float mass;
@property float velocity;
@property DirectionalForce* totalForce;

@property GLubyte red;
@property GLubyte green;
@property GLubyte blue;

@property float x;
@property float y;
@property float radius;

- (void)render;
- (DirectionalForce*)calculateTotalForce:(NSMutableArray*) forces;
- (float)angleBetweenVectors:(Vector*) u:(Vector*) v;
- (void)move;
- (bool)doesCollide:(Body*) b;

@end
