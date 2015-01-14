//
//  Body.m
//  GravitySimulator
//
//  Created by Bram on 11/23/14.
//  Copyright (c) 2014 Digital Hotdogs. All rights reserved.
//

#import "Body.h"

@implementation Body

@synthesize mass;
@synthesize velocity;
@synthesize totalForce;

@synthesize red;
@synthesize green;
@synthesize blue;

@synthesize x;
@synthesize y;
@synthesize radius;

GLfloat theta = 18 * (M_PI / 180);


- (id) init
{
    mass = 0;
    velocity = 0;
    totalForce = [[DirectionalForce alloc] init];
    
    red = 0;
    green = 0;
    blue = 0;
    
    x = 0;
    y = 0;
    radius = 0;
    
    return [super init];
}


- (void) render
{
    GLubyte colors[88];
    
    for(int i = 0; i < 88; i += 4)
    {
        colors[i] = red;
        colors[i + 1] = green;
        colors[i + 2] = blue;
        colors[i + 3] = 255;
    }
    
    GLfloat vertices[66];
    
    GLfloat oldx = x;
    GLfloat oldy = y + radius;
    
    vertices[0] = x;
    vertices[1] = y;
    vertices[2] = 0;
    
    vertices[3] = oldx;
    vertices[4] = oldy;
    vertices[5] = 0;
    
    for(int i = 6; i < 63; i += 3)
    {
        vertices[i] = cos(theta) * (oldx - x) - sin(theta) * (oldy - y) + x;
        vertices[i + 1] = sin(theta) * (oldx - x) + cos(theta) * (oldy - y) + y;
        vertices[i + 2] = 0;
        
        oldx = vertices[i];
        oldy = vertices[i + 1];
    }
    
    vertices[63] = x;
    vertices[64] = y + radius;
    vertices[65] = 0;
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribColor);
    
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 0, vertices);
    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_UNSIGNED_BYTE, GL_TRUE, 0, colors);
    
    glDrawArrays(GL_TRIANGLE_FAN, 0, 22);
    
    glDisableVertexAttribArray(GLKVertexAttribPosition);
    glDisableVertexAttribArray(GLKVertexAttribColor);
}


- (DirectionalForce*)calculateTotalForce:(NSMutableArray*) forces
{
    DirectionalForce* result = totalForce;
    
    for(DirectionalForce* f in forces)
    {
        float theta = [self angleBetweenVectors:[result direction] :[f direction]];
        
        float P = [result magnitude];
        float Q = [f magnitude];
        
        float R = sqrtf(powf(P, 2) + powf(Q, 2) + (2 * P * Q * cosf(theta)));
        
        float newx = [[result direction] x] + [[f direction] x];
        float newy = [[result direction] y] + [[f direction] y];
        
        Vector* newv = [[Vector alloc] init];
        [newv setX:newx];
        [newv setY:newy];
        
        [result setDirection:newv];
        
        [result setMagnitude:R];
    }
    
    [[result direction] unitVInSameDirection];
    
    return result;
}


- (float)angleBetweenVectors:(Vector*) u:(Vector*) v
{
    if(([u x] == 0 && [u y] == 0) || ([v x] == 0 && [v y] == 0))
        return 0;
    
    float theta = [u x] * [v x] + [u y] * [v y];
    float asqrt = sqrtf(powf([u x], 2) + powf([u y], 2));
    float bsqrt = sqrtf(powf([v x], 2) + powf([v y], 2));
    
    theta = theta / (asqrt * bsqrt);
    theta = acosf(theta);
    
    if(isnan(theta))
        return 0;
    
    return theta;
}


- (void)move
{
    x += [[totalForce direction] x] * velocity;
    y += [[totalForce direction] y] * velocity;
    
    if(x - radius <= 0)
        x = radius;
    if(x + radius >= 320)
        x = 320 - radius;
    if(y + radius >= 480)
        y = 480 - radius;
    if(y - radius <= 0)
        y = radius;
}


- (bool)doesCollide:(Body*) b
{
    float d = sqrtf(powf([b x] - x, 2) + powf([b y] - y, 2));
    
    if(d <= radius + [b radius] && d != 0)
        return true;
    
    return false;
}


@end
