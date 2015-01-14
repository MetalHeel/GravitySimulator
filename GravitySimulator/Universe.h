//
//  Universe.h
//  GravitySimulator
//
//  Created by Bram on 11/24/14.
//  Copyright (c) 2014 Digital Hotdogs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Body.h"

@interface Universe : NSObject

@property (readonly) NSMutableArray* bodies;

- (void)addBody:(Body*)b;
- (void)clearBodies;
- (void)renderBodies;
- (void)gravityHappens;

@end
