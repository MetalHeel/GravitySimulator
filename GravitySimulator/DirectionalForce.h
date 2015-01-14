//
//  DirectionalForce.h
//  GravitySimulator
//
//  Created by Bram on 11/24/14.
//  Copyright (c) 2014 Digital Hotdogs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector.h"

@interface DirectionalForce : NSObject

@property float magnitude;
@property Vector* direction;

@end
