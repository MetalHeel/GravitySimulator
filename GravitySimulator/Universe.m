//
//  Universe.m
//  GravitySimulator
//
//  Created by Bram on 11/24/14.
//  Copyright (c) 2014 Digital Hotdogs. All rights reserved.
//

#import "Universe.h"


@implementation Universe

@synthesize bodies;

// Gravitational constant (normally 6.673e-11).
float G = 0.6;
bool simplemode = true;


- (id) init
{
    bodies = [NSMutableArray arrayWithCapacity:10];
    
    return [super init];
}


- (void)addBody:(Body *)b
{
    [bodies addObject:b];
}


- (void)clearBodies
{
    [bodies removeAllObjects];
}


- (void)renderBodies
{
    for(Body* b in bodies)
        [b render];
}


- (void)gravityHappens
{
    // F = G * ((m1 * m2) / pow(r, 2))
    // d = sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2))
    
    NSMutableArray* newforces = [NSMutableArray arrayWithCapacity:bodies.count];
    
    for(Body* b1 in bodies)
    {
        NSMutableArray* forces = [NSMutableArray array];
        
        for(Body* b2 in bodies)
        {
            float d = sqrtf(powf([b2 x] - [b1 x], 2) + powf([b2 y] - [b1 y], 2));
            
            if(d != 0)
            {
                float F = G * (([b1 mass] * [b2 mass]) / powf(d, 2));
                
                Vector* v = [[Vector alloc] init];
                [v setX:([b2 x] - [b1 x])];
                [v setY:([b2 y] - [b1 y])];
                
                DirectionalForce* f = [[DirectionalForce alloc] init];
                [f setMagnitude:F];
                [f setDirection:v];
                
                [forces addObject:f];
            }
            
            if(!simplemode && [b1 doesCollide:b2])
            {
                float perp_x = [b2 x] - [b1 x];
                float perp_y = [b2 y] - [b1 y];
                
                Vector* n = [[Vector alloc] init];
                [n setX:-perp_y];
                [n setY:perp_x];
                [n unitVInSameDirection];
                
                float fx = [[[b1 totalForce] direction] x];
                float fy = [[[b1 totalForce] direction] y];
                
                float dp = (fx * [n x]) + (fy * [n y]);
                
                Vector* r = [[Vector alloc] init];
                [r setX:(2 * dp * [n x] - fx)];
                [r setY:(2 * dp * [n y] - fy)];
                [r unitVInSameDirection];
                
                DirectionalForce* collidef = [[DirectionalForce alloc] init];
                [collidef setMagnitude:[[b1 totalForce] magnitude]];
                [collidef setDirection:r];
                
                [b1 setTotalForce:collidef];
            }
        }
        
        [newforces addObject:[b1 calculateTotalForce:forces]];
    }
    
    int i = 0;
    
    for(Body* b in bodies)
    {
        Vector* oldDirection = [[b totalForce] direction];
        [b setTotalForce:[newforces objectAtIndex:i]];
        i++;
        
        float a = [[b totalForce] magnitude] / [b mass];
        float forcev = a * .1;
        
        float oldv = [b velocity];
        
        float theta = [b angleBetweenVectors:oldDirection :[[b totalForce] direction]];
        float newv = sqrtf(powf(oldv, 2) + powf(forcev, 2) + (2 * oldv * forcev * cosf(theta)));
        
        [b setVelocity:newv];
        
        [b move];
        
        for(Body* collide_b in bodies)
        {
            if([b doesCollide:collide_b])
            {
                float dx = [b x] - [collide_b x];
                float dy = [b y] - [collide_b y];
                
                float d = sqrtf(powf(dx, 2) + powf(dy, 2));
                float fulld = [b radius] + [collide_b radius];
                
                [b setX:([collide_b x] + (fulld / d) * dx)];
                [b setY:([collide_b y] + (fulld / d) * dy)];
                
                if(simplemode)
                    [b setVelocity:0];
            }
        }
    }
}


@end
