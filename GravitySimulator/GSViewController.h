//
//  GSViewController.h
//  GravitySimulator
//
//  Created by Bram on 11/22/14.
//  Copyright (c) 2014 Digital Hotdogs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "Universe.h"

@interface GSViewController : GLKViewController <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *pause;

@property int currentMass;
@property int currentRadius;
@property GLubyte currentRed;
@property GLubyte currentGreen;
@property GLubyte currentBlue;
@property Universe* universe;
@property BOOL universe_paused;

- (void) doPauseToggle;

@end
