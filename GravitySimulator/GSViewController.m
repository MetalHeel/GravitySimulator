//
//  GSViewController.m
//  GravitySimulator
//
//  Created by Bram on 11/22/14.
//  Copyright (c) 2014 Digital Hotdogs. All rights reserved.
//

#import "stdlib.h"
#import "GSViewController.h"
#import "Body.h"
#import "CreateBodyViewController.h"


@interface GSViewController ()

@property (strong, nonatomic) EAGLContext* context;
@property (strong) GLKBaseEffect* effect;

@end

@implementation GSViewController

@synthesize context = _context;
@synthesize effect = _effect;

@synthesize pause;
@synthesize currentMass;
@synthesize currentRadius;
@synthesize currentRed;
@synthesize currentGreen;
@synthesize currentBlue;
@synthesize universe;
@synthesize universe_paused;


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.context = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if(!self.context)
        NSLog(@"Failed to create ES context");
    
    GLKView* view = (GLKView*)self.view;
    view.context = self.context;
    
    view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    view.drawableStencilFormat = GLKViewDrawableStencilFormat8;
    view.drawableMultisample = GLKViewDrawableMultisample4X;
    
    UITapGestureRecognizer* tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGR.delegate = self;
    [self.view addGestureRecognizer:tapGR];
    
    [self setupGL];
    
    if(universe == nil)
    {
        universe = [[Universe alloc] init];
    
        currentMass = 0;
        currentRadius = 0;
        currentRed = 0;
        currentGreen = 255;
        currentBlue = 0;
        
        universe_paused = FALSE;
    }
    
    [self performSelector:@selector(doPauseToggle) withObject:nil afterDelay:0.0];
}


- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];
    
    self.effect = [[GLKBaseEffect alloc] init];
    
    GLKMatrix4 projectionMatrix = GLKMatrix4MakeOrtho(0, 320, 0, 480, -1024, 1024);
    self.effect.transform.projectionMatrix = projectionMatrix;
    
    glClearColor(1, 1, 1, 1);
}


- (void)glkView:(GLKView*)view drawInRect:(CGRect)rect
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    [self.effect prepareToDraw];
    
    [universe renderBodies];
}


- (void)update
{
    if(!universe_paused)
        [universe gravityHappens];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch
{
    if([touch.view isKindOfClass:[UIControl class]])
        return false;
        
    return true;
}


- (void) handleTap:(UIGestureRecognizer*)gestureRecognizer
{
    if(currentMass > 0 && currentRadius > 0)
    {
        CGPoint p = [gestureRecognizer locationInView:self.view];
    
        Body* new_body = [[Body alloc] init];
        [new_body setMass:currentMass];
        [new_body setRed:currentRed];
        [new_body setGreen:currentGreen];
        [new_body setBlue:currentBlue];
        [new_body setX:p.x];
        [new_body setY:(480 - p.y)];
        [new_body setRadius:currentRadius];
    
        [universe addBody:new_body];
    }
}


- (IBAction) clearAllClicked
{
    [universe clearBodies];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CreateBodyViewController* cb = (CreateBodyViewController*)[segue destinationViewController];
    
    if(currentMass > 0)
        cb.mass = currentMass;
    else
        cb.mass = 10;
    
    if(currentRadius > 0)
        cb.radius = currentRadius;
    else
        cb.radius = 20;
    
    cb.red = currentRed;
    cb.green = currentGreen;
    cb.blue = currentBlue;
    
    cb.universe = universe;
    cb.paused = universe_paused;
}


- (void)viewDidUnload
{
    [self setPause:nil];
    [super viewDidUnload];
}


- (IBAction)pauseToggle:(id)sender
{
    universe_paused = !universe_paused;
    [self performSelector:@selector(doPauseToggle) withObject:nil afterDelay:0.0];
}


- (void) doPauseToggle
{
    [pause setHighlighted:universe_paused];
    [pause setSelected:universe_paused];
}


@end
