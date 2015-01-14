//
//  CreateBodyViewController.m
//  GravitySimulator
//
//  Created by Bram on 11/25/14.
//  Copyright (c) 2014 Digital Hotdogs. All rights reserved.
//

#import "CreateBodyViewController.h"
#import "GSViewController.h"

@interface CreateBodyViewController ()

@end


@implementation CreateBodyViewController

@synthesize massField;
@synthesize radiusField;
@synthesize color;
@synthesize redChooser;
@synthesize greenChooser;
@synthesize blueChooser;
@synthesize mass;
@synthesize radius;
@synthesize red;
@synthesize green;
@synthesize blue;
@synthesize universe;
@synthesize paused;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    massField.text = [NSString stringWithFormat:@"%d", mass];
    radiusField.text = [NSString stringWithFormat:@"%d", radius];
    
    [redChooser setValue:red];
    [greenChooser setValue:green];
    [blueChooser setValue:blue];
    
    [self updateColor];
    
    UITapGestureRecognizer* tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGR.delegate = self;
    [self.view addGestureRecognizer:tapGR];
}


- (void)viewDidUnload
{
    [self setMassField:nil];
    [self setRadiusField:nil];
    
    [self setRedChooser:nil];
    [self setGreenChooser:nil];
    [self setBlueChooser:nil];
    
    [self setColor:nil];
    
    [super viewDidUnload];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    GSViewController* gsv = (GSViewController*)[segue destinationViewController];
    
    mass = massField.text.intValue;
    radius = radiusField.text.intValue;
    
    gsv.currentMass = mass;
    gsv.currentRadius = radius;
    
    int r = red;
    int g = green;
    int b = blue;
    
    gsv.currentRed = r;
    gsv.currentGreen = g;
    gsv.currentBlue = b;
    
    gsv.universe = universe;
    gsv.universe_paused = paused;
}


- (IBAction)redChanged:(id)sender
{
    red = [redChooser value];
    [self updateColor];
}


- (IBAction)greenChanged:(id)sender
{
    green = [greenChooser value];
    [self updateColor];
}


- (IBAction)blueChanged:(id)sender
{
    blue = [blueChooser value];
    [self updateColor];
}


- (void)updateColor
{
    float r = red / 255;
    float g = green / 255;
    float b = blue / 255;
    
    [color setBackgroundColor:[UIColor colorWithRed:r green:g blue:b alpha:1]];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch
{
    CGPoint hit = [touch locationInView:self.view];
    
    if(hit.y < 44)
        return false;
    
    return true;
}


- (void) handleTap:(UIGestureRecognizer*)gestureRecognizer
{
    [massField resignFirstResponder];
    [radiusField resignFirstResponder];
}


@end
